#!/usr/bin/env bash
# smart-lint.sh - Intelligent project-aware code quality checks for Claude Code
#
# SYNOPSIS
#   smart-lint.sh [options]
#
# DESCRIPTION
#   Automatically detects project type and runs quality checks with incremental linting.
#   By default, only checks modified/staged files for faster performance.
#   Every issue found is blocking - code must be 100% clean to proceed.
#
# OPTIONS
#   --debug       Enable debug output and performance timing
#   --fast        Skip slow checks (import cycles, security scans)
#   --full        Force full project scan (disable incremental linting)
#   --help        Show usage information
#
# EXIT CODES
#   0 - Success (all checks passed - everything is ✅ GREEN)
#   1 - General error (missing dependencies, etc.)
#   2 - ANY issues found - ALL must be fixed
#
# CONFIGURATION
#   Project-specific overrides can be placed in .claude-hooks-config.sh
#   See inline documentation for all available options.

# Don't use set -e - we need to control exit codes carefully
set +e

# ============================================================================
# COLOR DEFINITIONS AND UTILITIES
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Debug mode
CLAUDE_HOOKS_DEBUG="${CLAUDE_HOOKS_DEBUG:-0}"

# Logging functions
log_debug() {
    [[ "$CLAUDE_HOOKS_DEBUG" == "1" ]] && echo -e "${CYAN}[DEBUG]${NC} $*" >&2
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $*" >&2
}

# Performance timing
time_start() {
    if [[ "$CLAUDE_HOOKS_DEBUG" == "1" ]]; then
        echo $(($(date +%s%N)/1000000))
    fi
}

time_end() {
    if [[ "$CLAUDE_HOOKS_DEBUG" == "1" ]]; then
        local start=$1
        local end=$(($(date +%s%N)/1000000))
        local duration=$((end - start))
        log_debug "Execution time: ${duration}ms"
    fi
}

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# ============================================================================
# PROJECT DETECTION
# ============================================================================

detect_project_type() {
    local project_type="unknown"
    local types=()
    
    # Go project
    if [[ -f "go.mod" ]] || [[ -f "go.sum" ]] || [[ -n "$(find . -maxdepth 3 -name "*.go" -type f -print -quit 2>/dev/null)" ]]; then
        types+=("go")
    fi
    
    # Python project
    if [[ -f "pyproject.toml" ]] || [[ -f "setup.py" ]] || [[ -f "requirements.txt" ]] || [[ -n "$(find . -maxdepth 3 -name "*.py" -type f -print -quit 2>/dev/null)" ]]; then
        types+=("python")
    fi
    
    # JavaScript/TypeScript project
    if [[ -f "package.json" ]] || [[ -f "tsconfig.json" ]] || [[ -n "$(find . -maxdepth 3 \( -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" \) -type f -print -quit 2>/dev/null)" ]]; then
        types+=("javascript")
    fi
    
    # Rust project
    if [[ -f "Cargo.toml" ]] || [[ -n "$(find . -maxdepth 3 -name "*.rs" -type f -print -quit 2>/dev/null)" ]]; then
        types+=("rust")
    fi
    
    # Nix project
    if [[ -f "flake.nix" ]] || [[ -f "default.nix" ]] || [[ -f "shell.nix" ]]; then
        types+=("nix")
    fi
    
    # Return primary type or "mixed" if multiple
    if [[ ${#types[@]} -eq 1 ]]; then
        project_type="${types[0]}"
    elif [[ ${#types[@]} -gt 1 ]]; then
        project_type="mixed:$(IFS=,; echo "${types[*]}")"
    fi
    
    log_debug "Detected project type: $project_type"
    echo "$project_type"
}

# Get list of modified files (if available from git)
get_modified_files() {
    local files=()
    
    if [[ -d .git ]] && command_exists git; then
        # Get currently staged files
        while IFS= read -r file; do
            [[ -n "$file" && -f "$file" ]] && files+=("$file")
        done < <(git diff --cached --name-only --diff-filter=ACMR 2>/dev/null || true)
        
        # Get modified but unstaged files
        while IFS= read -r file; do
            [[ -n "$file" && -f "$file" ]] && files+=("$file")
        done < <(git diff --name-only --diff-filter=ACMR 2>/dev/null || true)
        
        # Get untracked files that aren't ignored
        while IFS= read -r file; do
            [[ -n "$file" && -f "$file" ]] && files+=("$file")
        done < <(git ls-files --others --exclude-standard 2>/dev/null || true)
        
        # Remove duplicates and return
        printf '%s\n' "${files[@]}" | sort -u
    fi
}

# Filter files by language/extension
filter_files_by_language() {
    local language="$1"
    shift
    local files=("$@")
    
    case "$language" in
        "go")
            printf '%s\n' "${files[@]}" | grep -E '\.(go)$' || true
            ;;
        "python")
            printf '%s\n' "${files[@]}" | grep -E '\.(py|pyi)$' || true
            ;;
        "javascript")
            printf '%s\n' "${files[@]}" | grep -E '\.(js|jsx|ts|tsx|mjs|cjs)$' || true
            ;;
        "rust")
            printf '%s\n' "${files[@]}" | grep -E '\.(rs)$' || true
            ;;
        "nix")
            printf '%s\n' "${files[@]}" | grep -E '\.(nix)$' || true
            ;;
        *)
            printf '%s\n' "${files[@]}"
            ;;
    esac
}

# Check if we should skip a file
should_skip_file() {
    local file="$1"
    
    # Check .claude-hooks-ignore if it exists
    if [[ -f ".claude-hooks-ignore" ]]; then
        while IFS= read -r pattern; do
            # Skip comments and empty lines
            [[ -z "$pattern" || "$pattern" =~ ^[[:space:]]*# ]] && continue
            
            # Check if file matches pattern
            if [[ "$file" == $pattern ]]; then
                log_debug "Skipping $file due to .claude-hooks-ignore pattern: $pattern"
                return 0
            fi
        done < ".claude-hooks-ignore"
    fi
    
    # Check for inline skip comments
    if [[ -f "$file" ]] && head -n 5 "$file" 2>/dev/null | grep -q "claude-hooks-disable"; then
        log_debug "Skipping $file due to inline claude-hooks-disable comment"
        return 0
    fi
    
    return 1
}

# ============================================================================
# ERROR TRACKING
# ============================================================================

declare -a CLAUDE_HOOKS_SUMMARY=()
declare -i CLAUDE_HOOKS_ERROR_COUNT=0

add_error() {
    local message="$1"
    CLAUDE_HOOKS_ERROR_COUNT+=1
    CLAUDE_HOOKS_SUMMARY+=("${RED}❌${NC} $message")
}

print_summary() {
    if [[ $CLAUDE_HOOKS_ERROR_COUNT -gt 0 ]]; then
        # Only show failures when there are errors
        echo -e "\n${BLUE}═══ Summary ═══${NC}" >&2
        for item in "${CLAUDE_HOOKS_SUMMARY[@]}"; do
            echo -e "$item" >&2
        done
        
        echo -e "\n${RED}Found $CLAUDE_HOOKS_ERROR_COUNT issue(s) that MUST be fixed!${NC}" >&2
        echo -e "${RED}════════════════════════════════════════════${NC}" >&2
        echo -e "${RED}❌ ALL ISSUES ARE BLOCKING ❌${NC}" >&2
        echo -e "${RED}════════════════════════════════════════════${NC}" >&2
        echo -e "${RED}Fix EVERYTHING above until all checks are ✅ GREEN${NC}" >&2
    fi
}

# ============================================================================
# CONFIGURATION LOADING
# ============================================================================

load_config() {
    # Default configuration
    export CLAUDE_HOOKS_ENABLED="${CLAUDE_HOOKS_ENABLED:-true}"
    export CLAUDE_HOOKS_FAIL_FAST="${CLAUDE_HOOKS_FAIL_FAST:-false}"
    export CLAUDE_HOOKS_SHOW_TIMING="${CLAUDE_HOOKS_SHOW_TIMING:-false}"
    
    # Language enables
    export CLAUDE_HOOKS_GO_ENABLED="${CLAUDE_HOOKS_GO_ENABLED:-true}"
    export CLAUDE_HOOKS_PYTHON_ENABLED="${CLAUDE_HOOKS_PYTHON_ENABLED:-true}"
    export CLAUDE_HOOKS_JS_ENABLED="${CLAUDE_HOOKS_JS_ENABLED:-true}"
    export CLAUDE_HOOKS_RUST_ENABLED="${CLAUDE_HOOKS_RUST_ENABLED:-true}"
    export CLAUDE_HOOKS_NIX_ENABLED="${CLAUDE_HOOKS_NIX_ENABLED:-true}"
    
    # Project-specific overrides
    if [[ -f ".claude-hooks-config.sh" ]]; then
        source ".claude-hooks-config.sh" || {
            log_error "Failed to load .claude-hooks-config.sh"
            exit 2
        }
    fi
    
    # Quick exit if hooks are disabled
    if [[ "$CLAUDE_HOOKS_ENABLED" != "true" ]]; then
        log_info "Claude hooks are disabled"
        exit 0
    fi
}

# ============================================================================
# GO LINTING
# ============================================================================

lint_go() {
    if [[ "${CLAUDE_HOOKS_GO_ENABLED:-true}" != "true" ]]; then
        log_debug "Go linting disabled"
        return 0
    fi
    
    local files=("$@")
    local go_files=()
    
    # If files provided, filter for Go files only
    if [[ ${#files[@]} -gt 0 ]]; then
        while IFS= read -r file; do
            [[ -n "$file" ]] && go_files+=("$file")
        done < <(filter_files_by_language "go" "${files[@]}")
        
        # Skip if no Go files to process
        if [[ ${#go_files[@]} -eq 0 ]]; then
            log_debug "No Go files to lint"
            return 0
        fi
        
        log_info "Running Go formatting and linting on ${#go_files[@]} file(s)..."
    else
        log_info "Running Go formatting and linting on entire project..."
    fi
    
    # Check if Makefile exists with fmt and lint targets
    if [[ -f "Makefile" ]]; then
        local has_fmt=$(grep -E "^fmt:" Makefile 2>/dev/null || echo "")
        local has_lint=$(grep -E "^lint:" Makefile 2>/dev/null || echo "")
        
        if [[ -n "$has_fmt" && -n "$has_lint" ]]; then
            log_info "Using Makefile targets"
            
            local fmt_output
            if ! fmt_output=$(make fmt 2>&1); then
                add_error "Go formatting failed (make fmt)"
                echo "$fmt_output" >&2
            fi
            
            local lint_output
            if ! lint_output=$(make lint 2>&1); then
                add_error "Go linting failed (make lint)"
                echo "$lint_output" >&2
            fi
        else
            # Fallback to direct commands
            log_info "Using direct Go tools"
            
            # Format check
            if [[ ${#go_files[@]} -gt 0 ]]; then
                # Check specific files
                local unformatted_files=$(printf '%s\n' "${go_files[@]}" | xargs gofmt -l 2>/dev/null || true)
                
                if [[ -n "$unformatted_files" ]]; then
                    local fmt_output
                    if ! fmt_output=$(printf '%s\n' "${go_files[@]}" | xargs gofmt -w 2>&1); then
                        add_error "Go formatting failed"
                        echo "$fmt_output" >&2
                    fi
                fi
                
                # Linting specific files
                if command_exists golangci-lint; then
                    local lint_output
                    if ! lint_output=$(golangci-lint run --timeout=2m "${go_files[@]}" 2>&1); then
                        add_error "golangci-lint found issues"
                        echo "$lint_output" >&2
                    fi
                elif command_exists go; then
                    local vet_output
                    if ! vet_output=$(go vet "${go_files[@]}" 2>&1); then
                        add_error "go vet found issues"
                        echo "$vet_output" >&2
                    fi
                else
                    log_error "No Go linting tools available - install golangci-lint or go"
                fi
            else
                # Full project scan
                local unformatted_files=$(gofmt -l . 2>/dev/null | grep -v vendor/ || true)
                
                if [[ -n "$unformatted_files" ]]; then
                    local fmt_output
                    if ! fmt_output=$(gofmt -w . 2>&1); then
                        add_error "Go formatting failed"
                        echo "$fmt_output" >&2
                    fi
                fi
                
                # Linting
                if command_exists golangci-lint; then
                    local lint_output
                    if ! lint_output=$(golangci-lint run --timeout=2m 2>&1); then
                        add_error "golangci-lint found issues"
                        echo "$lint_output" >&2
                    fi
                elif command_exists go; then
                    local vet_output
                    if ! vet_output=$(go vet ./... 2>&1); then
                        add_error "go vet found issues"
                        echo "$vet_output" >&2
                    fi
                else
                    log_error "No Go linting tools available - install golangci-lint or go"
                fi
            fi
        fi
    else
        # No Makefile, use direct commands
        log_info "Using direct Go tools"
        
        # Format check
        if [[ ${#go_files[@]} -gt 0 ]]; then
            # Check specific files
            local unformatted_files=$(printf '%s\n' "${go_files[@]}" | xargs gofmt -l 2>/dev/null || true)
            
            if [[ -n "$unformatted_files" ]]; then
                local fmt_output
                if ! fmt_output=$(printf '%s\n' "${go_files[@]}" | xargs gofmt -w 2>&1); then
                    add_error "Go formatting failed"
                    echo "$fmt_output" >&2
                fi
            fi
            
            # Linting specific files
            if command_exists golangci-lint; then
                local lint_output
                if ! lint_output=$(golangci-lint run --timeout=2m "${go_files[@]}" 2>&1); then
                    add_error "golangci-lint found issues"
                    echo "$lint_output" >&2
                fi
            elif command_exists go; then
                local vet_output
                if ! vet_output=$(go vet "${go_files[@]}" 2>&1); then
                    add_error "go vet found issues"
                    echo "$vet_output" >&2
                fi
            else
                log_error "No Go linting tools available - install golangci-lint or go"
            fi
        else
            # Full project scan
            local unformatted_files=$(gofmt -l . 2>/dev/null | grep -v vendor/ || true)
            
            if [[ -n "$unformatted_files" ]]; then
                local fmt_output
                if ! fmt_output=$(gofmt -w . 2>&1); then
                    add_error "Go formatting failed"
                    echo "$fmt_output" >&2
                fi
            fi
            
            # Linting
            if command_exists golangci-lint; then
                local lint_output
                if ! lint_output=$(golangci-lint run --timeout=2m 2>&1); then
                    add_error "golangci-lint found issues"
                    echo "$lint_output" >&2
                fi
            elif command_exists go; then
                local vet_output
                if ! vet_output=$(go vet ./... 2>&1); then
                    add_error "go vet found issues"
                    echo "$vet_output" >&2
                fi
            else
                log_error "No Go linting tools available - install golangci-lint or go"
            fi
        fi
    fi
}

# ============================================================================
# OTHER LANGUAGE LINTERS
# ============================================================================

lint_python() {
    if [[ "${CLAUDE_HOOKS_PYTHON_ENABLED:-true}" != "true" ]]; then
        log_debug "Python linting disabled"
        return 0
    fi
    
    local files=("$@")
    local python_files=()
    
    # If files provided, filter for Python files only
    if [[ ${#files[@]} -gt 0 ]]; then
        while IFS= read -r file; do
            [[ -n "$file" ]] && python_files+=("$file")
        done < <(filter_files_by_language "python" "${files[@]}")
        
        # Skip if no Python files to process
        if [[ ${#python_files[@]} -eq 0 ]]; then
            log_debug "No Python files to lint"
            return 0
        fi
        
        log_info "Running Python linters on ${#python_files[@]} file(s)..."
    else
        log_info "Running Python linters on entire project..."
    fi
    
    # Black formatting
    if command_exists black; then
        local black_target
        if [[ ${#python_files[@]} -gt 0 ]]; then
            black_target="${python_files[@]}"
        else
            black_target="."
        fi
        
        local black_output
        if ! black_output=$(black $black_target --check 2>&1); then
            # Apply formatting and capture any errors
            local format_output
            if ! format_output=$(black $black_target 2>&1); then
                add_error "Python formatting failed"
                echo "$format_output" >&2
            fi
        fi
    fi
    
    # Linting
    if command_exists ruff; then
        local ruff_target
        if [[ ${#python_files[@]} -gt 0 ]]; then
            ruff_target="${python_files[@]}"
        else
            ruff_target="."
        fi
        
        local ruff_output
        if ! ruff_output=$(ruff check --fix $ruff_target 2>&1); then
            add_error "Ruff found issues"
            echo "$ruff_output" >&2
        fi
    elif command_exists flake8; then
        local flake8_target
        if [[ ${#python_files[@]} -gt 0 ]]; then
            flake8_target="${python_files[@]}"
        else
            flake8_target="."
        fi
        
        local flake8_output
        if ! flake8_output=$(flake8 $flake8_target 2>&1); then
            add_error "Flake8 found issues"
            echo "$flake8_output" >&2
        fi
    fi
    
    return 0
}

lint_javascript() {
    if [[ "${CLAUDE_HOOKS_JS_ENABLED:-true}" != "true" ]]; then
        log_debug "JavaScript linting disabled"
        return 0
    fi
    
    local files=("$@")
    local js_files=()
    
    # If files provided, filter for JavaScript/TypeScript files only
    if [[ ${#files[@]} -gt 0 ]]; then
        while IFS= read -r file; do
            [[ -n "$file" ]] && js_files+=("$file")
        done < <(filter_files_by_language "javascript" "${files[@]}")
        
        # Skip if no JS/TS files to process
        if [[ ${#js_files[@]} -eq 0 ]]; then
            log_debug "No JavaScript/TypeScript files to lint"
            return 0
        fi
        
        log_info "Running JavaScript/TypeScript linters on ${#js_files[@]} file(s)..."
    else
        log_info "Running JavaScript/TypeScript linters on entire project..."
    fi
    
    # Check for ESLint
    if [[ -f "package.json" ]] && grep -q "eslint" package.json 2>/dev/null; then
        if command_exists npm; then
            local eslint_output
            if [[ ${#js_files[@]} -gt 0 ]]; then
                # Run ESLint on specific files
                if ! eslint_output=$(npx eslint "${js_files[@]}" --fix 2>&1); then
                    add_error "ESLint found issues"
                    echo "$eslint_output" >&2
                fi
            else
                # Run ESLint via npm script (entire project)
                if ! eslint_output=$(npm run lint --if-present 2>&1); then
                    add_error "ESLint found issues"
                    echo "$eslint_output" >&2
                fi
            fi
        fi
    fi
    
    # Prettier
    if [[ -f ".prettierrc" ]] || [[ -f "prettier.config.js" ]] || [[ -f ".prettierrc.json" ]]; then
        local prettier_target
        if [[ ${#js_files[@]} -gt 0 ]]; then
            prettier_target="${js_files[@]}"
        else
            prettier_target="."
        fi
        
        if command_exists prettier; then
            local prettier_output
            if ! prettier_output=$(prettier --check $prettier_target 2>&1); then
                # Apply formatting and capture any errors
                local format_output
                if ! format_output=$(prettier --write $prettier_target 2>&1); then
                    add_error "Prettier formatting failed"
                    echo "$format_output" >&2
                fi
            fi
        elif command_exists npx; then
            local prettier_output
            if ! prettier_output=$(npx prettier --check $prettier_target 2>&1); then
                # Apply formatting and capture any errors
                local format_output
                if ! format_output=$(npx prettier --write $prettier_target 2>&1); then
                    add_error "Prettier formatting failed"
                    echo "$format_output" >&2
                fi
            fi
        fi
    fi
    
    return 0
}

lint_rust() {
    if [[ "${CLAUDE_HOOKS_RUST_ENABLED:-true}" != "true" ]]; then
        log_debug "Rust linting disabled"
        return 0
    fi
    
    local files=("$@")
    local rust_files=()
    
    # If files provided, filter for Rust files only
    if [[ ${#files[@]} -gt 0 ]]; then
        while IFS= read -r file; do
            [[ -n "$file" ]] && rust_files+=("$file")
        done < <(filter_files_by_language "rust" "${files[@]}")
        
        # Skip if no Rust files to process
        if [[ ${#rust_files[@]} -eq 0 ]]; then
            log_debug "No Rust files to lint"
            return 0
        fi
        
        log_info "Running Rust linters on ${#rust_files[@]} file(s)..."
    else
        log_info "Running Rust linters on entire project..."
    fi
    
    if command_exists cargo; then
        # Note: cargo fmt and clippy work on the entire Cargo project
        # Individual file targeting is not as straightforward as other languages
        # but we can still log which files triggered the check
        
        local fmt_output
        if ! fmt_output=$(cargo fmt -- --check 2>&1); then
            # Apply formatting and capture any errors
            local format_output
            if ! format_output=$(cargo fmt 2>&1); then
                add_error "Rust formatting failed"
                echo "$format_output" >&2
            fi
        fi
        
        local clippy_output
        if ! clippy_output=$(cargo clippy --quiet -- -D warnings 2>&1); then
            add_error "Clippy found issues"
            echo "$clippy_output" >&2
        fi
    else
        log_info "Cargo not found, skipping Rust checks"
    fi
    
    return 0
}

lint_nix() {
    if [[ "${CLAUDE_HOOKS_NIX_ENABLED:-true}" != "true" ]]; then
        log_debug "Nix linting disabled"
        return 0
    fi
    
    local files=("$@")
    local nix_files=()
    
    # If files provided, filter for Nix files only
    if [[ ${#files[@]} -gt 0 ]]; then
        while IFS= read -r file; do
            [[ -n "$file" ]] && nix_files+=("$file")
        done < <(filter_files_by_language "nix" "${files[@]}")
        
        # Skip if no Nix files to process
        if [[ ${#nix_files[@]} -eq 0 ]]; then
            log_debug "No Nix files to lint"
            return 0
        fi
        
        log_info "Running Nix linters on ${#nix_files[@]} file(s)..."
    else
        log_info "Running Nix linters on entire project..."
        
        # Find all .nix files
        while IFS= read -r file; do
            [[ -n "$file" ]] && nix_files+=("$file")
        done < <(find . -name "*.nix" -type f | grep -v -E "(result/|/nix/store/)" | head -20)
        
        if [[ ${#nix_files[@]} -eq 0 ]]; then
            log_debug "No Nix files found"
            return 0
        fi
    fi
    
    # Check formatting with nixpkgs-fmt or alejandra
    if command_exists nixpkgs-fmt; then
        local fmt_output
        if ! fmt_output=$(printf '%s\n' "${nix_files[@]}" | xargs nixpkgs-fmt --check 2>&1); then
            # Apply formatting and capture any errors
            local format_output
            if ! format_output=$(printf '%s\n' "${nix_files[@]}" | xargs nixpkgs-fmt 2>&1); then
                add_error "Nix formatting failed"
                echo "$format_output" >&2
            fi
        fi
    elif command_exists alejandra; then
        local fmt_output
        if ! fmt_output=$(printf '%s\n' "${nix_files[@]}" | xargs alejandra --check 2>&1); then
            # Apply formatting and capture any errors
            local format_output
            if ! format_output=$(printf '%s\n' "${nix_files[@]}" | xargs alejandra 2>&1); then
                add_error "Nix formatting failed"
                echo "$format_output" >&2
            fi
        fi
    fi
    
    # Static analysis with statix
    if command_exists statix; then
        local statix_output
        if [[ ${#files[@]} -gt 0 ]]; then
            # Run statix on specific files
            if ! statix_output=$(statix check "${nix_files[@]}" 2>&1); then
                add_error "Statix found issues"
                echo "$statix_output" >&2
            fi
        else
            # Run statix on entire project
            if ! statix_output=$(statix check 2>&1); then
                add_error "Statix found issues"
                echo "$statix_output" >&2
            fi
        fi
    fi
    
    return 0
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

# Parse command line options
FAST_MODE=false
FORCE_FULL_SCAN=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --debug)
            export CLAUDE_HOOKS_DEBUG=1
            shift
            ;;
        --fast)
            FAST_MODE=true
            shift
            ;;
        --full)
            FORCE_FULL_SCAN=true
            shift
            ;;
        --help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  --debug    Enable debug output and timing"
            echo "  --fast     Skip slow checks (import cycles, security scans)"
            echo "  --full     Force full project scan (disable incremental linting)"
            echo "  --help     Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            echo "Use --help for usage information"
            exit 2
            ;;
    esac
done

# Print header
echo "" >&2
echo "🔍 Style Check - Validating code formatting..." >&2
echo "────────────────────────────────────────────" >&2

# Load configuration
load_config

# Start timing
START_TIME=$(time_start)

# Detect project type
PROJECT_TYPE=$(detect_project_type)
log_info "Project type: $PROJECT_TYPE"

# Main execution
main() {
    # Get list of modified files for incremental linting
    local modified_files=()
    
    # Check if we should force full scan or do incremental linting
    if [[ "$FORCE_FULL_SCAN" == "true" ]]; then
        log_info "Full project scan forced via --full flag"
    else
        while IFS= read -r file; do
            [[ -n "$file" && ! $(should_skip_file "$file") ]] && modified_files+=("$file")
        done < <(get_modified_files)
        
        # Log incremental vs full project linting
        if [[ ${#modified_files[@]} -gt 0 ]]; then
            log_info "Incremental linting: checking ${#modified_files[@]} modified file(s)"
            log_debug "Files: ${modified_files[*]}"
        else
            log_info "No modified files detected, running full project scan"
        fi
    fi
    
    # Handle mixed project types
    if [[ "$PROJECT_TYPE" == mixed:* ]]; then
        local types="${PROJECT_TYPE#mixed:}"
        IFS=',' read -ra TYPE_ARRAY <<< "$types"
        
        for type in "${TYPE_ARRAY[@]}"; do
            case "$type" in
                "go") lint_go "${modified_files[@]}" ;;
                "python") lint_python "${modified_files[@]}" ;;
                "javascript") lint_javascript "${modified_files[@]}" ;;
                "rust") lint_rust "${modified_files[@]}" ;;
                "nix") lint_nix "${modified_files[@]}" ;;
            esac
            
            # Fail fast if configured
            if [[ "$CLAUDE_HOOKS_FAIL_FAST" == "true" && $CLAUDE_HOOKS_ERROR_COUNT -gt 0 ]]; then
                break
            fi
        done
    else
        # Single project type
        case "$PROJECT_TYPE" in
            "go") lint_go "${modified_files[@]}" ;;
            "python") lint_python "${modified_files[@]}" ;;
            "javascript") lint_javascript "${modified_files[@]}" ;;
            "rust") lint_rust "${modified_files[@]}" ;;
            "nix") lint_nix "${modified_files[@]}" ;;
            "unknown") 
                log_info "No recognized project type, skipping checks"
                ;;
        esac
    fi
    
    # Show timing if enabled
    time_end "$START_TIME"
    
    # Print summary
    print_summary
    
    # Return exit code - any issues mean failure
    if [[ $CLAUDE_HOOKS_ERROR_COUNT -gt 0 ]]; then
        return 2
    else
        return 0
    fi
}

# Run main function
main
exit_code=$?

# Final message and exit
if [[ $exit_code -eq 2 ]]; then
    echo -e "\n${RED}🛑 FAILED - Fix all issues above! 🛑${NC}" >&2
    echo -e "${YELLOW}📋 NEXT STEPS:${NC}" >&2
    echo -e "${YELLOW}  1. Fix the issues listed above${NC}" >&2
    echo -e "${YELLOW}  2. Verify the fix by running the lint command again${NC}" >&2
    echo -e "${YELLOW}  3. Continue with your original task${NC}" >&2
    exit 2
else
    # Always exit with 2 so Claude sees the continuation message
    echo -e "\n${YELLOW}👉 Style clean. Continue with your task.${NC}" >&2
    exit 2
fi