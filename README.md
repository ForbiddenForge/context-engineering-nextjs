# Context Engineering Framework for Next.js

**Supercharge your Claude Code experience with Context Engineering**

This repository provides a comprehensive framework for **Context Engineering** - Instead of relying on clever prompts, we provide AI agents with comprehensive context, structured workflows, and automated quality gates to consistently deliver production-ready code.

## 🚀 Quick Start

### Installation

This framework can be installed into any existing Next.js project. The installation process will add the Context Engineering tools while respecting your existing project structure.

1. **Clone this repository:**
   ```bash
   git clone <repository-url>
   cd prps-agentic-eng-nextjs
   ```

2. **Run the installation script:**
   ```bash
   ./install.sh
   ```

3. **Follow the interactive installation process:**
   - Enter your target project directory
   - Choose how to handle file conflicts:
     - **Ask for each conflict** (recommended) - Review each file individually
     - **Skip all conflicts** - Keep your existing files unchanged
     - **Overwrite all conflicts** - Replace with framework files
   - Choose whether to add installed files to .gitignore:
     - **Recommended: Yes** - Prevents PRPS files from being committed to your repository
     - These files are specific to your local development environment

4. **What gets installed:**
   - `.claude/` directory with commands, hooks, and settings
   - `PROMPTS/` directory for prompt templates
   - `PRPs/` directory for Product Requirements Prompts
   - `CLAUDE.md` with Next.js specific guidelines
   - Example files and templates

### Installation Options

#### Interactive Installation (Default)
```bash
./install.sh
```
The script will guide you through the process and let you choose how to handle conflicts.

#### Non-Interactive Installation

For automated deployments, CI/CD, or when you want to skip all prompts:

**Option 1: Skip conflicts (preserve existing files)**
```bash
# This will install only new files and skip any that already exist
PRPS_TARGET_DIR=/path/to/your/nextjs/project ./install.sh --batch
```

**Option 2: Overwrite all conflicts**
```bash
# This will overwrite any existing files with the framework versions
PRPS_TARGET_DIR=/path/to/your/nextjs/project ./install.sh --overwrite-all
```

**Option 3: Add installed files to .gitignore**
```bash
# Use --add-to-gitignore flag to automatically add the installed files to .gitignore
# This prevents the PRPS files from being tracked in your repository
PRPS_TARGET_DIR=/path/to/your/nextjs/project ./install.sh --batch --add-to-gitignore

# Or in interactive mode
./install.sh --add-to-gitignore
```

**Environment Variables:**
- `PRPS_TARGET_DIR` - Required for non-interactive modes. Must be an absolute path to your target project.

**Command Line Flags:**
- `--batch` - Run in batch mode (skip all prompts, use defaults)
- `--overwrite-all` - Run in batch mode and overwrite all conflicting files
- `--add-to-gitignore` - Automatically add installed files to .gitignore
- `--help` - Show help message

**Examples:**
```bash
# Install to current directory, skip conflicts
PRPS_TARGET_DIR=$(pwd) ./install.sh --batch

# Install to specific project, overwrite everything
PRPS_TARGET_DIR=/home/user/my-nextjs-app ./install.sh --overwrite-all

# Install with gitignore update
PRPS_TARGET_DIR=$(pwd) ./install.sh --batch --add-to-gitignore

# View all available options
./install.sh --help
```

### Post-Installation

After installation, verify everything is working:

```bash
# Check that commands are available
ls .claude/commands/

# Verify hooks are executable
ls -la .claude/hooks/*.sh

# Review the settings
cat .claude/settings.local.json
```

### Example Workflow

Here's the complete workflow for implementing a new feature:

```bash
# 1. Generate a comprehensive prompt (optional - you can skip if you have a simple feature)
/generate-prp-prompt "create a user dashboard with real-time metrics and export functionality"

# 2. Generate detailed PRPs from your prompt or feature description
/generate-prp PROMPTS/dashboard_metrics.md

# 3. Execute the PRP to implement the feature
/execute-prp PRPs/dashboard_metrics_01.md

# 4. Check for and fix any errors
/check-errors

# 5. Security audit and remediation
/check-security

# 6. Optimize API calls and database queries
/check-api-database

# Pro tip: Use /clear between each command to manage Claude's context window
```

## 📁 Repository Structure

```
prps-agentic-eng-nextjs/
├── install.sh                    # Smart installation script
├── .claude/
│   ├── commands/                 # Custom Claude Code commands
│   │   ├── generate-prp-prompt.md    # Generate comprehensive prompts
│   │   ├── generate-prp.md           # Create implementation blueprints
│   │   ├── execute-prp.md            # Execute PRPs with quality gates
│   │   ├── check-errors.md           # Comprehensive error checking/fixing
│   │   ├── check-security.md         # Security audit and remediation
│   │   └── check-api-database.md     # API/database optimization and cost reduction
│   ├── hooks/                    # Automated quality assurance
│   │   ├── smart-lint.sh            # Intelligent linting across languages
│   │   ├── ntfy-notifier.sh         # Push notifications
│   │   └── common-helpers.sh        # Shared utilities
│   ├── documents/                # Reference docs for prompts
│   └── settings.local.json       # Claude permissions and configuration
├── PROMPTS/                      # Generated and template prompts
│   ├── INITIAL.md               # Template for feature requests
│   └── INITIAL_EXAMPLE.md       # Example feature request
├── PRPs/                         # Product Requirements Prompts
│   ├── templates/
│   │   └── prp_base.md          # Base template for PRPs
│   └── EXAMPLE_multi_agent_dashboard_prp.md
├── examples/                     # Example implementations
└── CLAUDE.md                     # Next.js project guidelines
```

## 🎯 Core Concepts

### What is Context Engineering?

Context Engineering is a methodology that provides AI agents with comprehensive context instead of relying on clever prompts. It includes:

- **Complete codebase understanding** through research phases
- **Structured implementation blueprints** (PRPs)
- **Automated quality gates** with zero tolerance for errors
- **Parallel agent spawning** for complex problem-solving
- **Comprehensive validation loops** ensuring production readiness

### Product Requirements Prompts (PRPs)

PRPs are detailed implementation blueprints that contain:

- **Goal, Why, What** - Clear feature definition
- **Complete Context** - Codebase patterns, examples, documentation
- **Implementation Blueprint** - TypeScript types, component structure
- **Validation Gates** - Linting, testing, build requirements
- **Anti-patterns** - What to avoid

## 🛠️ Commands Reference

### Core Workflow Commands

#### `/generate-prp-prompt <description>`
Synthesizes comprehensive prompts by combining templates with your feature description.

**Example:**
```bash
/generate-prp-prompt "user authentication system with social login"
```

**Output:** Creates `PROMPTS/auth_system.md` with complete context.

#### `/generate-prp <prompt-file>`
Generates multiple numbered PRPs from feature descriptions, breaking complex features into manageable, focused implementation chunks.

**Features:**
- One major item per PRP
- Dependency tracking between PRPs
- Confidence scoring for complexity
- Research-based codebase context

**Example:**
```bash
/generate-prp PROMPTS/auth_system.md
```

**Output:** Creates `PRPs/auth_system_01.md`, `PRPs/auth_system_02.md`, etc.

#### `/execute-prp <prp-file>`
Implements features from PRPs with strict quality standards and automated validation.

**Mandatory Workflow:**
1. **Research Phase** - Analyze existing codebase patterns
2. **Planning Phase** - Design architecture and components
3. **Implementation** - Build with real-time validation
4. **Archive** - Move completed PRP to archive folder

**Quality Gates:**
- Zero ESLint warnings
- Zero TypeScript errors
- All tests must pass
- Build must succeed

**Example:**
```bash
/execute-prp PRPs/auth_system_01.md
```

### Quality Assurance Commands

#### `/check-errors`
Comprehensive code quality verification and fixing using parallel agents.

**Approach:** "FIXING task, not reporting task"
- Spawns multiple agents to fix different error types in parallel
- Zero tolerance for warnings or errors
- Re-runs checks until everything is green

**Coverage:**
- ESLint errors and warnings
- TypeScript type errors
- Test failures
- Build errors
- Import/export issues

#### `/check-security`
Security audit and vulnerability remediation using parallel fixing agents.

**Security Checks:**
- Exposed API keys/credentials
- Input validation vulnerabilities
- XSS/CSRF protection gaps
- Authentication/authorization issues
- Dependency vulnerabilities
- Next.js security best practices

**Example:**
```bash
/check-security
```

#### `/check-api-database`
Comprehensive API and database optimization for performance and cost reduction.

**Approach:** "OPTIMIZATION task, not reporting task"
- Spawns multiple agents to optimize different inefficiencies in parallel
- Zero tolerance for redundant calls or slow queries
- Reads API documentation to understand best practices

**Optimization Coverage:**
- Duplicate API call consolidation
- N+1 query problem resolution
- Request batching and caching
- Database query optimization
- API cost reduction strategies
- Payload size minimization

**Example:**
```bash
/check-api-database
```

### Utility Commands

#### `/update-project`
Generates or updates `PROJECT.md` with comprehensive project context including tech stack, architecture, and conventions.

## 🎣 Hooks System

### Automated Quality Assurance

The framework includes intelligent hooks that automatically maintain code quality:

#### `smart-lint.sh`
**Triggers:** After Write/Edit operations
**Features:**
- Auto-detects project type (Go, Python, JS/TS, Rust, Nix)
- Respects project Makefiles and package.json scripts
- Smart file filtering (only processes modified files)
- Zero tolerance - everything must be green

#### `ntfy-notifier.sh`
**Triggers:** Task completion or errors
**Features:**
- Push notifications to your devices
- Terminal context detection (tmux, Terminal, iTerm2)
- Rate limiting to prevent spam
- Configurable via YAML config

### Customizing Hooks

Hooks are located in `.claude/hooks/` and can be customized:

```bash
# Edit the smart linter
vim .claude/hooks/smart-lint.sh

# Configure notifications
vim .claude/hooks/ntfy-notifier.sh
```

## ⚙️ Configuration

### Claude Permissions (`.claude/settings.local.json`)

The framework requires specific permissions to function properly:

```json
{
  "model": "opus",
  "toolPermissions": {
    "bash": {
      "allowedCommands": [
        "npm", "yarn", "pnpm", "bun",
        "git", "gh", "rg", "grep",
        "eslint", "prettier", "tsc",
        "pytest", "go", "cargo",
        "make", "chmod", "find"
      ]
    },
    "webfetch": {
      "allowedHosts": [
        "nextjs.org", "react.dev", "docs.github.com",
        "tailwindcss.com", "typescript.org"
      ]
    }
  },
  "hooks": {
    "postToolUse": {
      "write": [".claude/hooks/smart-lint.sh"],
      "edit": [".claude/hooks/smart-lint.sh"],
      "multiEdit": [".claude/hooks/smart-lint.sh"]
    }
  }
}
```

### Customizing Configuration

**Model Selection:**
- `opus` - Maximum quality for complex implementations
- `sonnet` - Balanced quality and speed
- `haiku` - Fast iterations and simple tasks

**Adding New Commands:**
Edit the `allowedCommands` array to include project-specific tools:

```json
"allowedCommands": [
  "npm", "yarn", "custom-build-tool"
]
```

**Web Fetch Permissions:**
Add documentation sites relevant to your project:

```json
"allowedHosts": [
  "nextjs.org", "your-docs-site.com"
]
```

## 📋 Templates

### PRP Base Template

Located in `PRPs/templates/prp_base.md`, this template provides the structure for all PRPs:

```markdown
# Feature Name PRP

## Goal
What this PRP accomplishes

## Why
Business/technical justification

## What
Detailed implementation requirements

## Context
- Codebase patterns
- Existing components
- Documentation links
- Dependencies

## Implementation Blueprint
- TypeScript interfaces
- Component structure
- File organization
- API design

## Validation Gates
- [ ] ESLint passes
- [ ] TypeScript compiles
- [ ] Tests pass
- [ ] Build succeeds
- [ ] Security audit clean

## Anti-patterns
What to avoid and why
```

### Prompt Templates

**`PROMPTS/INITIAL.md`** - Template for feature requests:
- Feature description
- Examples and references
- Documentation links
- Special considerations

**`PROMPTS/INITIAL_EXAMPLE.md`** - Example of a complete feature request with all necessary context.

## 🔄 Best Practices

### Context Management

**Use `/clear` between commands** to manage Claude's context window and ensure optimal performance.

### PRP Quality

**One major item per PRP** - Break complex features into focused, manageable chunks.

**Include comprehensive context:**
- Existing codebase patterns
- Relevant documentation
- Dependencies and constraints
- Examples and anti-patterns

### Validation Loops

**Zero tolerance for errors** - Everything must be perfect before proceeding:
- ESLint warnings = blocking
- TypeScript errors = blocking
- Test failures = blocking
- Build errors = blocking

### Security First

**Always run security checks** after implementing features:
- Input validation
- Authentication/authorization
- Dependency vulnerabilities
- Data exposure risks

## 🚨 Troubleshooting

### Installation Issues

**Script exits after Step 1:**
- This usually means you're trying to install into the same directory as the source
- Run the script from your project directory: `cd /your/project && /path/to/prps-agentic-eng-nextjs/install.sh`

**"Please enter 1, 2, or 3" infinite loop:**
- This occurs when the script can't read input properly
- Try running with explicit options: `./install.sh --batch` or `./install.sh --overwrite-all`
- Or ensure you're running in a proper terminal (not through a script or pipe)

**Permission denied errors:**
```bash
# Make sure the install script is executable
chmod +x install.sh

# If installing to a protected directory, use sudo (not recommended)
sudo ./install.sh
```

### Common Issues

**Command not found:**
```bash
# Ensure scripts are executable
chmod +x .claude/hooks/*.sh
```

**Linting failures:**
```bash
# Check project configuration
npm run lint
npm run type-check
```

**Permission errors:**
```bash
# Verify Claude permissions in settings.local.json
cat .claude/settings.local.json
```

### Hook Debugging

**Check hook execution:**
```bash
# Manually run hooks
.claude/hooks/smart-lint.sh
```

**View hook logs:**
```bash
# Check recent hook outputs
tail -f /tmp/claude-hooks.log
```


### Adding New Commands

1. Create a new `.md` file in `.claude/commands/`
2. Follow the existing command structure
3. Include comprehensive documentation
4. Test thoroughly before committing

### Improving Templates

1. Update templates in `PRPs/templates/`
2. Ensure backward compatibility
3. Document changes in commit messages
4. Provide migration guide if needed

### Hook Development

1. Add new hooks to `.claude/hooks/`
2. Follow the common helpers pattern
3. Include proper error handling
4. Update `settings.local.json` configuration

## 📚 Advanced Usage

### Multi-Agent Orchestration

The framework supports spawning multiple agents for parallel problem-solving:

```bash
# This command will spawn multiple agents to fix different error types
/check-errors
```

### Custom Validation Gates

Add project-specific validation to PRPs:

```markdown
## Custom Validation Gates
- [ ] API contract tests pass
- [ ] Performance benchmarks meet SLA
- [ ] Accessibility audit scores 95+
- [ ] Bundle size under 250kb
```

### Integration with CI/CD

The framework's quality gates align perfectly with CI/CD pipelines:

```yaml
# .github/workflows/quality.yml
name: Quality Gates
on: [push, pull_request]
jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install dependencies
        run: npm ci
      - name: Lint
        run: npm run lint
      - name: Type check
        run: npm run type-check
      - name: Test
        run: npm run test
      - name: Build
        run: npm run build
```

## 🎯 Philosophy

This framework embodies the philosophy that **context beats cleverness**. Instead of trying to be clever with prompts, we provide comprehensive context that enables AI agents to consistently deliver production-ready code.

**Key Principles:**
- **Context Engineering > Prompt Engineering**
- **Validation Loops > Hope and Pray**
- **Parallel Agents > Sequential Bottlenecks**
- **Zero Tolerance > Good Enough**
- **Production Ready > Proof of Concept**

---
