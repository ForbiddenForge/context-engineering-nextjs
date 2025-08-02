# Generate/Update PROJECT.md

## Purpose: $ARGUMENTS

Generate or update the PROJECT.md file in the .claude directory to establish comprehensive project context for AI assistants. This file serves as the single source of truth for project architecture, goals, conventions, and constraints.

**IMPORTANT**: This is a critical file that will be read at the start of every conversation, so it must be accurate, comprehensive, and well-structured.

## Initial Steps

1. **Check Current State**
   - Read existing .claude/PROJECT.md if it exists
   - Analyze current project structure and architecture
   - Review package.json for dependencies and scripts
   - Check for existing documentation (README.md, docs/)

2. **Gather Project Context**
   - Read CLAUDE.md for any project-specific rules
   - Analyze the project structure and patterns
   - Check for framework/library usage (Next.js version, routing approach)
   - Identify testing frameworks and build tools

3. **Use Specialized Subagents for Deep Analysis**
   - Use the nextjs-specialist subagent to analyze Next.js-specific patterns and best practices
   - Use the backend-architect subagent to document API structure and data flow
   - Use the frontend-developer subagent to analyze component patterns and state management
   - Use the test-writer-fixer subagent to document testing conventions and coverage

## Research Process

1. **Project Structure Analysis**
   - Map out directory structure and purpose of each folder
   - Identify component organization patterns
   - Note API/service patterns
   - Document state management approach
   - Check styling conventions (CSS Modules, Tailwind, styled-components)

2. **Technical Stack Discovery**
   - Framework version (Next.js App Router vs Pages Router)
   - Main dependencies and their purposes
   - Development tools and scripts
   - Testing setup (Jest, React Testing Library, Playwright)
   - Linting and formatting rules

3. **Convention Detection**
   - Naming conventions for files and components
   - Import patterns and module organization
   - TypeScript usage and strictness
   - Error handling patterns
   - Authentication/authorization approach

## PROJECT.md Structure

The generated PROJECT.md should include:

### 1. Project Overview
```markdown
# PROJECT.md - [Project Name]

## Overview
[Brief description of the project, its purpose, and target users]

## Tech Stack
- **Framework**: Next.js [version] with [App/Pages] Router
- **Language**: TypeScript [strict/loose]
- **Styling**: [CSS Modules/Tailwind/styled-components]
- **State Management**: [Context API/Zustand/Redux]
- **Data Fetching**: [SWR/React Query/Server Components]
- **Testing**: [Jest/React Testing Library/Playwright]
- **Package Manager**: [npm/yarn/pnpm]
```

### 2. Project Structure
```markdown
## Project Structure
\`\`\`
src/
├── app/                    # App Router pages and layouts
├── components/             # Reusable UI components
│   ├── common/            # Generic components
│   └── features/          # Feature-specific components
├── lib/                   # Utility functions and helpers
├── hooks/                 # Custom React hooks
├── services/              # API clients and external services
├── types/                 # TypeScript type definitions
├── styles/                # Global styles and themes
└── tests/                 # Test utilities and setup
\`\`\`
```

### 3. Key Conventions
```markdown
## Conventions

### File Naming
- Components: PascalCase (UserProfile.tsx)
- Utilities: camelCase (formatDate.ts)
- Types: PascalCase with .types.ts extension
- Tests: [name].test.tsx or [name].spec.tsx

### Component Patterns
- Server Components by default (App Router)
- Client Components only when needed ('use client')
- Co-locate related files (component + styles + tests)
- Props interfaces named as [Component]Props

### State Management
- [Document the approach: Context, stores, etc.]

### API Patterns
- Server Actions for mutations
- Route Handlers for complex APIs
- Consistent error handling
```

### 4. Development Workflow
```markdown
## Development Workflow

### Available Scripts
- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run lint` - Run ESLint
- `npm run type-check` - TypeScript validation
- `npm test` - Run tests
- `npm run test:e2e` - Run E2E tests

### Git Workflow
- Branch naming: feature/[description], fix/[description]
- Commit style: [conventional commits/other]
- PR requirements: [tests, reviews, etc.]
```

### 5. Architecture Decisions
```markdown
## Architecture Decisions

### Data Flow
[Describe how data flows through the application]

### Authentication
[Document auth approach if applicable]

### Performance Considerations
- [Image optimization strategy]
- [Code splitting approach]
- [Caching strategies]

### Security Considerations
- [Environment variable handling]
- [API security measures]
- [Content Security Policy]
```

### 6. Common Patterns
```markdown
## Common Patterns

### Error Handling
\`\`\`typescript
// Example error boundary usage
\`\`\`

### Data Fetching
\`\`\`typescript
// Example data fetching pattern
\`\`\`

### Form Handling
\`\`\`typescript
// Example form pattern with validation
\`\`\`
```

### 7. Gotchas and Tips
```markdown
## Gotchas and Important Notes

- [Next.js specific quirks]
- [Library-specific considerations]
- [Performance pitfalls to avoid]
- [Common debugging scenarios]
```

## Generation Process

1. **Analyze Existing Code**
   - Use Glob to find key files
   - Read sample components to understand patterns
   - Check test files for testing conventions
   - Review configuration files
   - Use the trend-researcher subagent to identify modern patterns and best practices in use

2. **Document Findings**
   - Be specific about versions and configurations
   - Include code examples from the actual project
   - Note any inconsistencies or technical debt
   - Use the analytics-reporter subagent to analyze code metrics and patterns

3. **Structure for AI Consumption**
   - Make it scannable with clear headings
   - Include executable commands
   - Provide concrete examples
   - Be explicit about dos and don'ts

## Validation

After generating PROJECT.md:

1. **Accuracy Check**
   - Verify all paths exist
   - Confirm script commands work
   - Validate technical stack details

2. **Completeness Check**
   - All major conventions documented
   - Key architectural decisions captured
   - Common patterns included

3. **Usability Check**
   - Clear enough for new AI assistant
   - Examples are representative
   - No contradictions with CLAUDE.md

## Output

Create or update: `.claude/PROJECT.md`

The file should be:
- Comprehensive but concise
- Accurate to the current codebase
- Structured for quick reference
- Include real examples from the project
- Note any areas of uncertainty

Remember: This file is the foundation for all AI assistance on this project. It should enable an AI assistant to understand the project's architecture, follow its conventions, and make appropriate technical decisions.