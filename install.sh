#!/bin/bash

# PRPS Agentic Engineering Installation Script
# This script installs the PRPS Agentic Engineering tools into your existing project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Global variables for batch mode
batch_mode=false
default_action="skip"
interactive_mode=false
conflict_choice=""
add_to_gitignore=false

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to get user input for yes/no questions
ask_yes_no() {
    local question="$1"
    local default="$2"
    local answer
    
    # In batch mode or non-interactive, use default
    if [[ "$batch_mode" == "true" ]] || [[ "$interactive_mode" != "true" ]]; then
        if [[ "$default" == "y" ]]; then
            print_info "$question [Y/n]: Y (batch mode)"
            return 0
        else
            print_info "$question [y/N]: N (batch mode)"
            return 1
        fi
    fi
    
    while true; do
        if [[ "$default" == "y" ]]; then
            read -p "$question [Y/n]: " answer </dev/tty || {
                print_error "Failed to read input. Using default: $default"
                [[ "$default" == "y" ]] && return 0 || return 1
            }
            answer=${answer:-y}
        else
            read -p "$question [y/N]: " answer </dev/tty || {
                print_error "Failed to read input. Using default: $default"
                [[ "$default" == "y" ]] && return 0 || return 1
            }
            answer=${answer:-n}
        fi
        
        case $answer in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to handle file conflicts
handle_file_conflict() {
    local source_file="$1"
    local target_file="$2"
    local relative_path="$3"
    
    print_warning "File conflict detected: $relative_path"
    
    # Check if we're in batch mode or non-interactive
    if [[ "$batch_mode" == "true" ]] || [[ "$interactive_mode" != "true" ]]; then
        local reason=""
        if [[ "$batch_mode" == "true" ]]; then
            reason="batch mode enabled"
        else
            reason="non-interactive terminal"
        fi
        
        if [[ "$default_action" == "overwrite" ]]; then
            print_info "Auto-handling ($reason): Overwriting $target_file"
            cp "$source_file" "$target_file"
            return 0
        else
            print_info "Auto-handling ($reason): Skipping $relative_path"
            return 1
        fi
    fi
    
    echo "  Source: $source_file"
    echo "  Target: $target_file"
    echo ""
    echo "Choose an option:"
    echo "1) Overwrite the existing file"
    echo "2) Keep both (rename new file with _new suffix)"
    echo "3) Skip this file"
    echo ""
    
    while true; do
        # Ensure we're reading from the terminal, not from a pipe
        read -p "Enter your choice [1-3]: " choice </dev/tty || {
            print_error "Failed to read input. Defaulting to skip."
            return 1
        }
        case $choice in
            1)
                print_info "Overwriting $target_file"
                cp "$source_file" "$target_file"
                return 0
                ;;
            2)
                local new_name="${target_file%.*}_new.${target_file##*.}"
                # Handle files without extensions
                if [[ "$target_file" == "$new_name" ]]; then
                    new_name="${target_file}_new"
                fi
                print_info "Copying to $new_name"
                cp "$source_file" "$new_name"
                return 0
                ;;
            3)
                print_info "Skipping $relative_path"
                return 1
                ;;
            *)
                echo "Please enter 1, 2, or 3."
                ;;
        esac
    done
}

# Function to copy specific directories and files with conflict handling
copy_specific_items() {
    local source_dir="$1"
    local target_dir="$2"
    local files_copied=0
    local files_skipped=0
    
    # Define specific items to copy
    local items_to_copy=(".claude" "examples" "PROMPTS" "PRPs" "CLAUDE.md")
    
    for item in "${items_to_copy[@]}"; do
        print_info "Processing item: $item"
        local source_item="$source_dir/$item"
        local target_item="$target_dir/$item"
        
        # Skip if source item doesn't exist
        if [[ ! -e "$source_item" ]]; then
            print_warning "Source item not found: $item"
            continue
        fi
        
        # Handle directories
        if [[ -d "$source_item" ]]; then
            if [[ -d "$target_item" ]]; then
                # Target directory exists, handle conflicts for each file inside
                print_warning "Directory $item already exists in target"
                
                # If we're in batch mode with skip action, skip the entire directory
                if [[ "$batch_mode" == "true" ]] && [[ "$default_action" == "skip" ]]; then
                    print_info "Skipping directory $item (batch mode: skip all)"
                    ((files_skipped++)) || true
                    continue
                fi
                
                # Otherwise, merge the directory and handle individual file conflicts
                print_info "Merging directory $item contents"
                copy_directory_contents "$source_item" "$target_item" "$item"
            else
                # Target directory doesn't exist, copy entire directory
                print_info "Copying directory $item"
                cp -r "$source_item" "$target_item"
                ((files_copied++)) || true
                print_info "Successfully copied directory: $item"
            fi
        # Handle files
        elif [[ -f "$source_item" ]]; then
            if [[ -f "$target_item" ]]; then
                if handle_file_conflict "$source_item" "$target_item" "$item"; then
                    ((files_copied++)) || true
                else
                    ((files_skipped++)) || true
                fi
            else
                print_info "Copying file $item"
                cp "$source_item" "$target_item"
                ((files_copied++)) || true
            fi
        fi
    done
    
    print_success "Items copied: $files_copied"
    if [[ $files_skipped -gt 0 ]]; then
        print_warning "Items skipped: $files_skipped"
    fi
}

# Function to add installed items to .gitignore
add_items_to_gitignore() {
    local target_dir="$1"
    local gitignore_file="$target_dir/.gitignore"
    local items_to_add=(".claude/" "/examples" "PROMPTS/" "PRPs/" "CLAUDE.md")
    local items_added=0
    
    print_info "Adding installed items to .gitignore..."
    
    # Create .gitignore if it doesn't exist
    if [[ ! -f "$gitignore_file" ]]; then
        print_info "Creating .gitignore file"
        touch "$gitignore_file"
    fi
    
    # Add a section header if it doesn't exist
    if ! grep -q "# PRPS Agentic Engineering files" "$gitignore_file" 2>/dev/null; then
        echo "" >> "$gitignore_file"
        echo "# PRPS Agentic Engineering files" >> "$gitignore_file"
        echo "# Added by install.sh - these files are specific to your local development" >> "$gitignore_file"
    fi
    
    # Add each item if it's not already in .gitignore
    for item in "${items_to_add[@]}"; do
        # Check if the item exists in the target directory
        if [[ -e "$target_dir/$item" ]]; then
            # Check if the item is already in .gitignore
            if ! grep -q "^${item}$" "$gitignore_file" 2>/dev/null && \
               ! grep -q "^/${item}$" "$gitignore_file" 2>/dev/null && \
               ! grep -q "^${item}/$" "$gitignore_file" 2>/dev/null && \
               ! grep -q "^/${item}/$" "$gitignore_file" 2>/dev/null; then
                echo "$item" >> "$gitignore_file"
                print_info "Added $item to .gitignore"
                ((items_added++)) || true
            else
                print_info "$item is already in .gitignore"
            fi
        fi
    done
    
    if [[ $items_added -gt 0 ]]; then
        print_success "Added $items_added item(s) to .gitignore"
        print_warning "Remember to commit your updated .gitignore file"
    else
        print_info "All items were already in .gitignore"
    fi
}

# Function to copy directory contents with conflict handling
copy_directory_contents() {
    local source_dir="$1"
    local target_dir="$2"
    local dir_name="$3"
    
    # Ensure target directory exists
    mkdir -p "$target_dir"
    
    # Find all files in source directory
    while IFS= read -r -d '' file; do
        # Get relative path from source directory
        local rel_path="${file#$source_dir/}"
        local target_file="$target_dir/$rel_path"
        local target_parent="$(dirname "$target_file")"
        
        # Create target directory if it doesn't exist
        mkdir -p "$target_parent"
        
        # Check if target file exists
        if [[ -f "$target_file" ]]; then
            if ! handle_file_conflict "$file" "$target_file" "$dir_name/$rel_path"; then
                continue
            fi
        else
            print_info "Copying $dir_name/$rel_path"
            cp "$file" "$target_file"
        fi
    done < <(find "$source_dir" -type f -print0 2>/dev/null) || true
}

# Check if script is running interactively
is_interactive() {
    [[ -t 0 && -t 1 ]]
}

# Print usage information
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --batch             Run in batch mode (skip all prompts, use defaults)"
    echo "  --overwrite-all     Run in batch mode and overwrite all conflicting files"
    echo "  --add-to-gitignore  Automatically add installed files to .gitignore"
    echo "  --help              Show this help message"
    echo ""
    echo "Environment variables:"
    echo "  PRPS_TARGET_DIR  Target directory for installation (required in batch mode)"
    echo ""
    echo "Examples:"
    echo "  $0                                          # Interactive mode"
    echo "  PRPS_TARGET_DIR=/path/to/project $0 --batch       # Batch mode, skip conflicts"
    echo "  PRPS_TARGET_DIR=/path/to/project $0 --overwrite-all  # Batch mode, overwrite"
    echo "  PRPS_TARGET_DIR=/path/to/project $0 --batch --add-to-gitignore  # Batch mode with gitignore"
}

# Main installation function
main() {
    # Check if we're running interactively at the start
    if is_interactive; then
        interactive_mode=true
    fi
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --batch)
                batch_mode=true
                shift
                ;;
            --overwrite-all)
                batch_mode=true
                default_action="overwrite"
                shift
                ;;
            --add-to-gitignore)
                add_to_gitignore=true
                shift
                ;;
            --help|-h)
                usage
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    print_info "PRPS Agentic Engineering (Nextjs) Installation Script"
    print_info "==========================================="
    echo ""
    
    if [[ "$batch_mode" == "true" ]]; then
        print_info "Running in batch mode (default action: $default_action)"
        echo ""
    fi
    
    # Get the directory where this script is located
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Step 1: Make all .sh files executable
    print_info "Step 1: Making all .sh files executable..."
    local sh_files_count=0
    
    while IFS= read -r -d '' file; do
        chmod +x "$file"
        print_info "Made executable: ${file#$SCRIPT_DIR/}"
        ((sh_files_count++)) || true
    done < <(find "$SCRIPT_DIR" -name "*.sh" -type f -print0) || true
    
    if [[ $sh_files_count -eq 0 ]]; then
        print_warning "No .sh files found to make executable"
    else
        print_success "Made $sh_files_count shell script(s) executable"
    fi
    echo ""
    
    # Step 2: Get target directory
    print_info "Step 2: Specify target directory"
    
    # In batch mode, we need the target directory from an environment variable or we exit
    if [[ "$batch_mode" == "true" ]]; then
        if [[ -z "$PRPS_TARGET_DIR" ]]; then
            print_error "In batch mode, you must set PRPS_TARGET_DIR environment variable"
            print_info "Example: PRPS_TARGET_DIR=/path/to/project $0 --batch"
            exit 1
        fi
        target_dir="$PRPS_TARGET_DIR"
        print_info "Using target directory from PRPS_TARGET_DIR: $target_dir"
    else
        echo "Enter the path to your existing project directory where you want to install these tools:"
        echo "(Note: Cannot install into the same directory as this script: $SCRIPT_DIR)"
    fi
    
    while true; do
        if [[ "$batch_mode" != "true" ]]; then
            read -p "Target directory: " target_dir </dev/tty || {
                print_error "Failed to read input"
                exit 1
            }
        fi
        
        # Expand tilde and relative paths
        target_dir="${target_dir/#\~/$HOME}"
        target_dir="$(realpath "$target_dir" 2>/dev/null || echo "$target_dir")"
        
        if [[ -z "$target_dir" ]]; then
            print_error "Please enter a directory path"
            continue
        fi
        
        # Check if target is the same as script directory
        if [[ "$(realpath "$target_dir" 2>/dev/null || echo "$target_dir")" == "$SCRIPT_DIR" ]]; then
            print_error "Cannot install into the same directory as the installation script!"
            print_info "Please choose a different directory"
            continue
        fi
        
        if [[ ! -d "$target_dir" ]]; then
            if ask_yes_no "Directory $target_dir does not exist. Create it?" "n"; then
                mkdir -p "$target_dir"
                print_success "Created directory: $target_dir"
                break
            else
                print_info "Please enter an existing directory path"
                continue
            fi
        else
            print_success "Target directory: $target_dir"
            break
        fi
        
        # In batch mode, exit the loop after one iteration
        if [[ "$batch_mode" == "true" ]]; then
            break
        fi
    done
    echo ""
    
    # Step 3: Confirm installation and conflict handling
    print_info "Step 3: Confirm installation"
    echo "Source directory: $SCRIPT_DIR"
    echo "Target directory: $target_dir"
    echo ""
    
    if ! ask_yes_no "Proceed with installation?" "y"; then
        print_info "Installation cancelled"
        exit 0
    fi
    echo ""
    
    # Ask about conflict handling strategy if interactive
    if [[ "$interactive_mode" == "true" ]] && [[ "$batch_mode" != "true" ]]; then
        print_info "How should file conflicts be handled?"
        echo "1) Ask for each conflict (recommended)"
        echo "2) Skip all conflicts (keep existing files)"
        echo "3) Overwrite all conflicts (replace with new files)"
        echo ""
        
        while true; do
            read -p "Enter your choice [1-3]: " conflict_choice </dev/tty || {
                print_error "Failed to read input"
                exit 1
            }
            
            case $conflict_choice in
                1)
                    print_info "Will ask for each conflict"
                    # Keep default behavior
                    break
                    ;;
                2)
                    print_info "Will skip all conflicts"
                    batch_mode=true
                    default_action="skip"
                    break
                    ;;
                3)
                    print_info "Will overwrite all conflicts"
                    batch_mode=true
                    default_action="overwrite"
                    break
                    ;;
                *)
                    echo "Please enter 1, 2, or 3."
                    conflict_choice=""  # Reset invalid choice
                    ;;
            esac
        done
        echo ""
    fi
    
    # Ask about gitignore if interactive and not already set
    if [[ "$interactive_mode" == "true" ]] && [[ "$add_to_gitignore" != "true" ]]; then
        print_info "Git Repository Configuration"
        echo "The installed files (.claude, PROMPTS, PRPs, etc.) are specific to your local"
        echo "development environment and typically should not be committed to your repository."
        echo ""
        if ask_yes_no "Would you like to add these files to your .gitignore?" "y"; then
            add_to_gitignore=true
        fi
        echo ""
    fi
    
    # Step 4: Copy specific items
    print_info "Step 4: Copying PRPS tools..."
    copy_specific_items "$SCRIPT_DIR" "$target_dir"
    echo ""
    
    # Step 5: Final steps
    print_info "Step 5: Final setup"
    
    # Make shell scripts executable in the target directory as well
    local target_sh_count=0
    while IFS= read -r -d '' file; do
        chmod +x "$file"
        ((target_sh_count++)) || true
    done < <(find "$target_dir" -name "*.sh" -type f -print0 2>/dev/null) || true
    
    if [[ $target_sh_count -gt 0 ]]; then
        print_success "Made $target_sh_count shell script(s) executable in target directory"
    fi
    
    # Add to gitignore if requested
    if [[ "$add_to_gitignore" == "true" ]]; then
        echo ""
        add_items_to_gitignore "$target_dir"
    fi
    
    echo ""
    print_success "Installation completed successfully!"
    print_info "Your PRPS Agentic Engineering tools have been installed to: $target_dir"
    
    # Check for README or setup instructions
    if [[ -f "$target_dir/README.md" ]]; then
        print_info "Please check the README.md file for setup and usage instructions"
    fi
    
    if [[ -f "$target_dir/CLAUDE.md" ]]; then
        print_info "Please check the CLAUDE.md file for Claude-specific instructions"
    fi
}

# Check if script is being run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi