---
allowed-tools: all
description: Verify code quality, run tests, and ensure production readiness for Next.js/React/TypeScript projects
---

# 🚨🚨🚨 CRITICAL REQUIREMENT: FIX ALL ERRORS! 🚨🚨🚨

**THIS IS NOT A REPORTING TASK - THIS IS A FIXING TASK!**

When you run `/check`, you are REQUIRED to:

1. **IDENTIFY** all errors, warnings, and issues
2. **FIX EVERY SINGLE ONE** - not just report them!
3. **USE MULTIPLE SPECIALIZED SUBAGENTS** to fix issues in parallel:
   - Use the test-writer-fixer subagent to fix failing tests and improve coverage
   - Use the frontend-developer subagent to fix ESLint issues and React warnings
   - Use the nextjs-specialist subagent to fix Next.js-specific errors
   - Use the backend-architect subagent to fix API and TypeScript errors
   - Use the performance-tester subagent to fix performance issues
   - Say: "I'll use multiple specialized subagents to fix all these issues in parallel"
4. **DO NOT STOP** until:
   - ✅ ALL ESLint rules pass with ZERO warnings
   - ✅ TypeScript compilation has ZERO errors
   - ✅ ALL tests pass
   - ✅ Build succeeds
   - ✅ No console errors in browser
   - ✅ EVERYTHING is GREEN

**FORBIDDEN BEHAVIORS:**

- ❌ "Here are the issues I found" → NO! FIX THEM!
- ❌ "ESLint reports these problems" → NO! RESOLVE THEM!
- ❌ "TypeScript is complaining about..." → NO! SATISFY IT!
- ❌ "Tests are failing because..." → NO! MAKE THEM PASS!
- ❌ Stopping after listing issues → NO! KEEP WORKING!

**MANDATORY WORKFLOW:**

```
1. Run checks → Find issues
2. IMMEDIATELY spawn agents to fix ALL issues
3. Re-run checks → Find remaining issues
4. Fix those too
5. REPEAT until EVERYTHING passes
```

**YOU ARE NOT DONE UNTIL:**

- ESLint passes with zero warnings
- TypeScript compiles with zero errors
- All tests pass successfully
- Next.js build completes without errors
- No browser console errors/warnings
- Lighthouse scores are green
- Everything shows passing status

---

🛑 **MANDATORY PRE-FLIGHT CHECK** 🛑

1. Re-read CLAUDE.md RIGHT NOW
2. Check current .claude/TODO.md status
3. Verify you're not declaring "done" prematurely

Execute comprehensive quality checks with ZERO tolerance for excuses.

**FORBIDDEN EXCUSE PATTERNS:**

- "This is just a warning" → NO, warnings are errors
- "TypeScript is being too strict" → NO, TypeScript is right
- "The linter is opinionated" → NO, the linter is law
- "It works in the browser" → NO, it must be perfect
- "Users won't notice" → NO, excellence is non-negotiable
- "It's a known React issue" → NO, work around it

Let me ultrathink about validating this codebase against our exceptional standards.

🚨 **REMEMBER: Pre-commit hooks will verify EVERYTHING and block on violations!** 🚨

**Universal Quality Verification Protocol:**

**Step 0: Hook Status Check**

- Run `npm run lint` to see current ESLint state
- Run `npm run type-check` for TypeScript status
- Check for any pre-commit hooks that will block commits
- Verify `next build` completes successfully

**Step 1: Pre-Check Analysis**

- Review recent changes to understand scope
- Identify which components/tests should be affected
- Check for any TODO comments or temporary code
- Scan for console.log statements

**Step 2: Comprehensive Linting & Type Checking**

Run ALL quality checks:

```bash
npm run lint          # ESLint with all rules
npm run lint:fix      # Auto-fix what's possible
npm run type-check    # TypeScript strict mode
npm run format        # Prettier formatting
npm run test          # Jest tests
npm run test:coverage # Coverage requirements
npm run build         # Next.js production build
```

**Universal Requirements:**

- ZERO ESLint warnings or errors
- ZERO TypeScript errors (strict mode)
- ZERO disabled ESLint rules without documented justification
- ZERO `@ts-ignore` or `@ts-expect-error` without explanation
- ZERO formatting issues (Prettier must pass)
- ZERO `any` types without explicit justification
- ZERO console.log/warn/error in production code

**React/Next.js Specific Requirements:**

- No `useEffect` without dependency array or cleanup
- No missing React keys in lists
- No direct DOM manipulation
- No inline styles without justification
- Proper error boundaries implemented
- All images have alt text
- All forms have proper labels
- No hardcoded URLs or API keys
- Proper loading states for async operations
- No memory leaks from subscriptions/timers

**Step 3: Test Verification**

Run `npm run test` and ensure:

- ALL unit tests pass
- ALL integration tests pass
- ALL e2e tests pass (if applicable)
- Test coverage meets requirements (usually >80%)
- No skipped tests without justification
- Tests use React Testing Library best practices
- No `waitFor` with arbitrary delays
- Proper mocking of external dependencies
- Tests actually test user behavior, not implementation

**TypeScript Quality Checklist:**

- [ ] No any types - use unknown or proper types
- [ ] No non-null assertions (!) without null checks
- [ ] Proper discriminated unions for complex types
- [ ] No type assertions (as) without justification
- [ ] All props interfaces properly defined
- [ ] Generic components properly typed
- [ ] Event handlers properly typed
- [ ] API responses fully typed
- [ ] No implicit any in tsconfig
- [ ] Strict null checks enabled

**React/Component Quality Checklist:**

- [ ] Components follow single responsibility principle
- [ ] No business logic in components (use hooks/utils)
- [ ] Proper prop validation with TypeScript
- [ ] Memoization used appropriately (React.memo, useMemo, useCallback)
- [ ] No unnecessary re-renders
- [ ] Accessible markup (ARIA labels, roles)
- [ ] Keyboard navigation works
- [ ] Error boundaries catch failures
- [ ] Suspense boundaries for code splitting
- [ ] SEO meta tags properly set

**Code Hygiene Verification:**

- [ ] All components have display names
- [ ] No commented-out code blocks
- [ ] No debugging console statements
- [ ] No TODO comments without tickets
- [ ] Consistent file naming (kebab-case or PascalCase)
- [ ] Imports organized and no unused imports
- [ ] CSS modules or styled-components (no global CSS)
- [ ] No inline styles unless dynamic
- [ ] Proper folder structure maintained

**Security Audit:**

- [ ] Input sanitization on all user inputs
- [ ] XSS prevention (no dangerouslySetInnerHTML without sanitization)
- [ ] CSRF tokens implemented
- [ ] Secure headers configured
- [ ] No sensitive data in client bundles
- [ ] API keys in environment variables
- [ ] Authentication properly implemented
- [ ] Authorization checks on protected routes
- [ ] Content Security Policy configured

**Performance Verification:**

- [ ] Bundle size within limits
- [ ] No unnecessary re-renders (React DevTools Profiler)
- [ ] Images optimized and using next/image
- [ ] Lazy loading implemented where appropriate
- [ ] Code splitting at route level
- [ ] No blocking scripts in head
- [ ] Critical CSS inlined
- [ ] Web Vitals scores passing (LCP, FID, CLS)
- [ ] Lighthouse score >90 for performance
- [ ] No memory leaks in components

**Accessibility Verification:**

- [ ] All interactive elements keyboard accessible
- [ ] Proper focus management
- [ ] ARIA labels on all buttons/links
- [ ] Color contrast ratios passing WCAG AA
- [ ] Screen reader tested
- [ ] No accessibility violations (axe-core)
- [ ] Proper heading hierarchy
- [ ] Form validation messages accessible

**Failure Response Protocol:**

When issues are found:

1. **IMMEDIATELY USE SPECIALIZED SUBAGENTS** to fix issues in parallel:
   ```
   "I found 23 ESLint errors, 8 TypeScript errors, and 5 failing tests. I'll use specialized subagents to fix these:
   - Use the frontend-developer subagent to fix ESLint errors in components/
   - Use the backend-architect subagent to fix TypeScript errors in lib/ and utils/
   - Use the nextjs-specialist subagent to fix ESLint errors in pages/
   - Use the test-writer-fixer subagent to fix failing test suites
   - Use the ui-designer subagent to fix accessibility violations
   Let me invoke these subagents to tackle all issues in parallel..."
   ```
2. **FIX EVERYTHING** - Address EVERY issue, no matter how "minor"
3. **VERIFY** - Re-run all checks after fixes
4. **REPEAT** - If new issues found, spawn more agents and fix those too
5. **NO STOPPING** - Keep working until ALL checks show ✅ GREEN
6. **NO EXCUSES** - Common invalid excuses:
   - "It's just a warning" → Fix it NOW
   - "TypeScript inference should handle this" → Be explicit NOW
   - "It's a third-party type issue" → Add declarations NOW
   - "The rule is too strict" → Follow it anyway NOW
   - "Other components do this" → Fix those too NOW
7. **ESCALATE** - Only ask for help if truly blocked after attempting fixes

**Browser Testing Requirements:**

After all checks pass, verify in browser:

- [ ] No console errors or warnings
- [ ] All features work as expected
- [ ] Responsive design works on all breakpoints
- [ ] No visual regressions
- [ ] Animations perform at 60fps
- [ ] Forms validate properly
- [ ] Error states display correctly

**Final Verification:**

The code is ready when:
✓ npm run lint: ZERO warnings or errors
✓ npm run type-check: ZERO errors
✓ npm run test: ALL tests pass
✓ npm run test:coverage: Meets threshold
✓ npm run build: Successful with no warnings
✓ Lighthouse audit: All green scores
✓ Browser console: Clean, no errors
✓ Accessibility audit: Zero violations
✓ All checklist items verified
✓ Feature works end-to-end in all browsers

**Final Commitment:**

I will now execute EVERY check listed above and FIX ALL ISSUES. I will:

- ✅ Run all linting and type checks
- ✅ USE MULTIPLE SPECIALIZED SUBAGENTS to fix issues in parallel:
  - test-writer-fixer subagent for test failures and coverage
  - frontend-developer subagent for React and ESLint issues
  - nextjs-specialist subagent for Next.js specific problems
  - backend-architect subagent for TypeScript and API errors
  - performance-tester subagent for performance optimizations
- ✅ Keep working until EVERYTHING passes
- ✅ Verify in browser with DevTools
- ✅ Not stop until all checks show passing status

I will NOT:

- ❌ Just report issues without fixing them
- ❌ Skip any checks
- ❌ Accept "good enough"
- ❌ Ignore TypeScript errors
- ❌ Leave any warnings
- ❌ Stop working while ANY issues remain

**REMEMBER: This is a FIXING task, not a reporting task!**

The code is ready ONLY when every single check shows ✅ GREEN.

**Executing comprehensive validation and FIXING ALL ISSUES NOW...**
