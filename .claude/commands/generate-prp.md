# Create PRPs

## Feature file: $ARGUMENTS

Generate multiple numbered PRPs for feature implementation, breaking down complex tasks into focused, manageable units. Each PRP should handle ONE major item with supporting minor items.

**MANDATORY: USE SPECIALIZED SUB-AGENTS** for comprehensive PRP generation:
- **backend-architect**: Design API structure, data flow architecture, and server-side requirements
- **ui-designer**: Create component hierarchy, design system integration, and user interface specifications
- **database-architect**: Plan data models, query optimization strategies, and database requirements

**Sub-Agent Collaboration Protocol:**
- All agents MUST read `.claude/collab/team_notes.md` before starting PRP generation
- All agents MUST append their architectural findings and design decisions to team_notes.md
- Use standard format with architecture diagrams, component specifications, and technical requirements
- Coordinate to ensure PRPs are cohesive and dependencies are properly managed

**IMPORTANT**: Tasks should be broken down so each PRP is focused and achievable in a single implementation pass. The AI agent only gets the context you provide in each PRP, so make each one self-contained.

## Initial Steps

1. **Check Existing PRPs**
   - List all files in PRPs/ folder
   - List all files in PRPs/archive/ folder  
   - Find the highest number (e.g., if ARCHIVE_01_*, 02_* exist, start with 03_*)

2. **Read Essential Context**
   - Read PRPs/templates/prp_base.md for template structure
   - Read .claude/PROJECT.md for project conventions
   - Read feature file to understand requirements

## Research Process

1. **Codebase Analysis**
   - Search for similar components/patterns in the codebase
   - Identify files to reference in PRPs
   - Note existing conventions to follow
   - Check test patterns for validation approach
   - Review App Router vs Pages Router usage
   - Check package.json for available dependencies

2. **External Research**

   - Search for similar features/patterns online
   - Next.js documentation (include specific URLs for App Router/Pages Router)
   - React documentation for hooks/patterns
   - Library documentation (include specific URLs and version compatibility)
   - Implementation examples (GitHub/StackOverflow/blogs)
   - Best practices and common pitfalls
   - TypeScript patterns for the feature

3. **User Clarification** (if needed)
   - Specific patterns to mirror and where to find them?
   - Integration requirements and where to find them?
   - Performance requirements (SSR/SSG/ISR/Client-side)?
   - Accessibility requirements?

## Task Breakdown Rules

1. **One Major Item Per PRP**: Each PRP focuses on ONE primary deliverable
2. **Supporting Items**: Include 3-5 minor tasks that support the major item
3. **Logical Ordering**: Number PRPs in execution order
4. **Clear Dependencies**: If PRP-03 needs PRP-02, make it explicit

## Naming Convention

```
{NUMBER}_{descriptive_name}.md
```

Examples:
- `01_create_auth_components.md`
- `02_setup_api_routes.md`
- `03_implement_user_dashboard.md`

## PRP Generation

Using PRPs/templates/prp_base.md as template:

### Critical Context to Include and pass to the AI agent as part of the PRP

- **Documentation**: URLs with specific sections (Next.js docs, React docs, library docs)
- **Code Examples**: Real snippets from codebase (components, hooks, API routes)
- **TypeScript Types**: Existing interfaces/types to extend or follow
- **Gotchas**:
  - Server vs Client Component constraints
  - Hydration issues
  - Bundle size considerations
  - Version-specific features
- **Patterns**:
  - State management approach (Context, Zustand, Redux, etc.)
  - Data fetching patterns (SWR, React Query, Server Actions)
  - Styling conventions (CSS Modules, Tailwind, styled-components)

### Implementation Blueprint

- Component hierarchy for this PRP only
- TypeScript interfaces/types specific to this PRP
- Reference real files for patterns
- Error handling strategy
- Tasks for THIS PRP (not the entire feature):
  1. Type definitions
  2. Server/Client component decisions
  3. Core implementation
  4. Supporting items (3-5 tasks)
  5. Tests for this PRP's components
  6. Integration points

### Validation Gates (Must be Executable)

```bash
# TypeScript/Linting
npm run lint && npm run type-check

# Unit/Component Tests
npm test -- --coverage

# Build Validation
npm run build

# Optional: E2E Tests (if configured)
npm run test:e2e
```

**_ CRITICAL AFTER YOU ARE DONE RESEARCHING AND EXPLORING THE CODEBASE BEFORE YOU START WRITING THE PRPs _**

**_ ULTRATHINK ABOUT TASK BREAKDOWN AND HOW TO SPLIT THE FEATURE INTO FOCUSED PRPs _**

## Output

Create multiple files:
- `PRPs/03_first_major_item.md`
- `PRPs/04_second_major_item.md`
- Continue numbering sequentially...

## Quality Checklist (Per PRP)

- [ ] Focused on ONE major deliverable
- [ ] Self-contained with all necessary context
- [ ] Clear dependencies on previous PRPs noted
- [ ] All necessary context included (Next.js version, Router type, dependencies)
- [ ] TypeScript types clearly defined
- [ ] Server/Client component boundaries clear
- [ ] Validation gates are executable by AI
- [ ] References existing patterns in codebase
- [ ] Clear implementation path with component hierarchy
- [ ] Error handling and loading states documented
- [ ] Accessibility considerations included
- [ ] Performance implications noted (bundle size, SSR/SSG)
- [ ] 3-5 supporting tasks included

Score each PRP on a scale of 1-10 (confidence level to succeed in one-pass implementation)

Remember: The goal is one-pass implementation success through comprehensive context. Include specific Next.js patterns like:

- Metadata/SEO setup
- Image optimization approach
- Link usage patterns
- Data fetching strategy
- Environment variable usage

## Complexity Guidelines

- **Simple feature** (1-2 components): 1 PRP
- **Medium feature** (3-5 components): 2-3 PRPs  
- **Complex feature** (6+ components): 3-5 PRPs
- **Full application**: 5+ PRPs

## Final Summary

After creating all PRPs, provide:
1. List of created files with their focus
2. Execution order and dependencies
3. Total complexity assessment
