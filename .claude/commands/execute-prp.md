---
allowed-tools: all
description: Execute production-quality implementation with strict standards for Next.js/React/TypeScript
---

🚨 **CRITICAL WORKFLOW - NO SHORTCUTS!** 🚨

You are tasked with implementing: $ARGUMENTS

**MANDATORY SEQUENCE:**

1. 🔍 **RESEARCH FIRST** - "Let me research the codebase structure and create a plan before implementing"
2. 📋 **PLAN** - Present a detailed plan with component architecture
3. ✅ **IMPLEMENT** - Execute with validation checkpoints
4. 📝 **DOCUMENT** - Update TODO.md and archive PRP file

**YOU MUST SAY:** "Let me research the codebase structure and create a plan before implementing."

For complex features, say: "Let me ultrathink about this architecture and component design before proposing a solution."

**USE MULTIPLE model AGENTS** when the feature has independent parts:
"I'll spawn model agents to tackle different aspects of this feature and output their thinking instead of summarizing. I'll use the Claude Sonnet model for each of these agents"

Consult CLAUDE.md IMMEDIATELY and follow it EXACTLY.

**Critical Requirements:**

🛑 **PRE-COMMIT HOOKS ARE WATCHING** 🛑
The pre-commit hooks will verify EVERYTHING. They will:

- Block commits if ESLint has ANY warnings
- Reject TypeScript errors
- Prevent commits with failing tests
- Force you to fix problems before proceeding

**Completion Standards (NOT NEGOTIABLE):**

- The feature is NOT complete until ESLint passes with zero warnings
- TypeScript must compile with ZERO errors (strict mode)
- ALL tests must pass with meaningful coverage
- The feature must be fully implemented and working in the browser
- No console.logs, TODOs, or "good enough" compromises
- Accessibility must be verified (no violations)

**Reality Checkpoints (MANDATORY):**

- After EVERY component creation: Run ESLint and TypeScript
- After implementing each feature: Test in browser
- Before saying "done": Run FULL test suite and build
- If pre-commit hooks fail: STOP and fix immediately

**Code Evolution Rules:**

- This is a feature branch - implement the NEW solution directly
- DELETE old components when replacing them
- NO legacy prop support or backwards compatibility
- NO versioned component names (e.g., UserCardV2, NewButton)
- When refactoring, replace the existing implementation entirely
- If changing an API or component interface, update ALL usages

**React/Next.js Quality Requirements:**

**Component Architecture:**

- Use functional components with TypeScript
- Proper separation of concerns (components, hooks, utils, services)
- NO business logic in components - use custom hooks
- Follow React Query/SWR patterns for data fetching
- Implement proper error boundaries
- Use Suspense for code splitting where appropriate

**TypeScript Standards:**

- NO `any` types - use `unknown` or proper types
- Define interfaces for all props
- Use discriminated unions for complex state
- Proper generic constraints
- Event handlers must be properly typed
- API responses must have full type definitions
- NO `@ts-ignore` without documented justification

**State Management:**

- Use appropriate state solutions (useState, useReducer, Context, Zustand/Redux)
- NO prop drilling beyond 2 levels
- Derive state when possible instead of syncing
- Proper memoization with useMemo/useCallback
- Avoid unnecessary re-renders

**Styling Requirements:**

- Use CSS Modules or styled-components (no global CSS)
- Follow design system if it exists
- Responsive design with proper breakpoints
- No inline styles unless dynamic
- Proper CSS-in-JS performance considerations
- Theme variables for colors/spacing

**Performance Requirements:**

- Lazy load components and routes
- Optimize images with next/image
- Implement proper loading states
- No blocking operations in render
- Use Web Workers for heavy computations
- Monitor bundle size impact

**Testing Requirements:**

- Unit tests for all utilities and hooks
- Component tests with React Testing Library
- Integration tests for critical paths
- NO testing implementation details
- Test user behavior, not component internals
- Proper mocking strategies
- Test error states and edge cases

**Documentation Requirements:**

- Document component props with TypeScript
- Include usage examples in comments
- Document complex business logic
- API documentation for services
- Storybook stories for UI components (if applicable)

**Implementation Approach:**

1. **Research Phase:**

   - Analyze existing component structure
   - Identify reusable components
   - Check design system compliance
   - Review similar implementations

2. **Planning Phase:**

   - Component hierarchy diagram
   - State management approach
   - API integration plan
   - Testing strategy

3. **Implementation Phase:**

   - Create components with TypeScript interfaces first
   - Implement with ESLint/Prettier on save
   - Test each component in isolation
   - Integrate and test full feature
   - Verify accessibility

4. **Documentation Phase:**
   - Update .claude/TODO.md with completed task status
   - Mark the implemented feature as COMPLETED with timestamp
   - Add any discovered sub-tasks or follow-up items

**Procrastination Patterns (FORBIDDEN):**

- "I'll add types later" → NO, TypeScript from the start
- "Let me get it working first" → NO, write quality code immediately
- "I'll fix the ESLint warnings at the end" → NO, fix as you go
- "Tests can come in a follow-up PR" → NO, test as you implement
- "I'll extract this component later" → NO, proper architecture now
- "TODO: handle error case" → NO, handle all cases now

**Specific Antipatterns to Avoid:**

- Do NOT use index as key in lists without justification
- Do NOT mutate state directly
- Do NOT use useEffect for computed values
- Do NOT fetch data in components (use hooks/services)
- Do NOT ignore React warnings in console
- Do NOT create "god components" (split them up)
- Do NOT bypass TypeScript with assertions
- Do NOT leave commented-out code

**Security Considerations:**

- Sanitize all user inputs
- No dangerouslySetInnerHTML without sanitization
- Validate forms on client AND server
- Use environment variables for secrets
- Implement proper authentication checks
- CSRF protection for mutations
- Content Security Policy compliance

**Accessibility Requirements:**

- Semantic HTML elements
- ARIA labels where needed
- Keyboard navigation support
- Focus management for modals/drawers
- Color contrast compliance
- Screen reader testing
- No accessibility violations (axe)

**TODO.md Update Format:**
When completing implementation, update .claude/TODO.md with:

```
✅ COMPLETED [DATE]: [Feature Name] - [Brief description]
   - PRP: [original-prp-file.md] → ARCHIVE_[original-prp-file.md]
   - Status: Implemented with all quality gates passed
```

**Completion Checklist (ALL must be ✅):**

- [ ] Research phase completed with architecture understanding
- [ ] Plan reviewed with component hierarchy
- [ ] ESLint passes with ZERO warnings
- [ ] TypeScript compiles with ZERO errors
- [ ] ALL tests pass with coverage
- [ ] Feature works in all target browsers
- [ ] Accessibility audit passes
- [ ] Performance metrics acceptable
- [ ] Old/replaced code is DELETED
- [ ] RENAME the PRP file to ARCHIVE\_[original-name].md
- [ ] MOVE the archived PRP file to ./PRPs/archive/ folder (create if needed)
- [ ] UPDATE .claude/TODO.md marking this task as COMPLETED
- [ ] Documentation is complete
- [ ] NO console.logs or debug code
- [ ] NO TODOs or temporary solutions

**FINAL STEP - MANDATORY:**
Before saying "implementation complete", you MUST:

1. Update .claude/TODO.md with completion status
2. Rename and move the PRP file to archive
3. Confirm all checklist items are complete

**STARTING NOW** with research phase to understand the codebase structure...

(Remember: The pre-commit hooks will verify everything. No excuses. No shortcuts.)
