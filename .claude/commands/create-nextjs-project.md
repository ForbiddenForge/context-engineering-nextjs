# 🚀 CREATE-NEXTJS-PROJECT Command

## ⚡ PRIME DIRECTIVE
Transform a user's vision into a FULLY FUNCTIONING, PRODUCTION-READY Next.js project with ZERO compromises on quality, architecture, or best practices.

## 🎯 WHAT THIS COMMAND DOES
When you invoke `/create-nextjs-project`, you will:
1. **EXTRACT** the complete project vision from the user
2. **CLARIFY** any missing technical decisions
3. **ARCHITECT** a robust, scalable solution
4. **GENERATE** multiple focused PRPs for systematic implementation
5. **EXECUTE** the setup with military precision
6. **VALIDATE** everything works perfectly

## 📋 INFORMATION GATHERING PHASE

### MUST ASK (if not specified):
1. **Next.js Configuration**:
   - App Router or Pages Router?
   - Next.js version (14 recommended)?
   - Server-side rendering (SSR) or Static Site Generation (SSG)?
   - Edge runtime or Node.js runtime?

2. **Language & Tooling**:
   - TypeScript or JavaScript?
   - Package manager (npm, yarn, pnpm, bun)?
   - CSS solution (Tailwind, CSS Modules, styled-components, vanilla CSS)?

3. **Core Libraries**:
   - State management (Zustand, Redux Toolkit, Context API)?
   - Data fetching (TanStack Query, SWR, native fetch)?
   - Form handling (React Hook Form, Formik)?
   - UI library (shadcn/ui, MUI, Ant Design, Chakra)?

4. **Infrastructure**:
   - Authentication needs?
   - Database requirements?
   - API structure (REST, GraphQL, tRPC)?
   - Deployment target (Vercel, AWS, self-hosted)?

### EXTRACT FROM USER:
- **Core functionality** and user flows
- **Target audience** and scale expectations
- **Performance requirements**
- **Any specific integrations** needed
- **Timeline or MVP scope**

## 🏗️ ARCHITECTURE PHASE

### YOU MUST:
1. **CREATE** a comprehensive technical architecture document
2. **DESIGN** the folder structure following best practices
3. **PLAN** the data flow and state management approach
4. **IDENTIFY** all required dependencies
5. **MAP OUT** the component hierarchy
6. **DEFINE** API contracts and data models

### NEVER:
- Skip architecture planning "to save time"
- Choose trendy tech over proven solutions
- Ignore scalability considerations
- Forget about error handling patterns
- Overlook security requirements

## 📝 PRP GENERATION PHASE

Generate **AT LEAST 4-6 FOCUSED PRPs** covering:

### PRP 1: Project Foundation
```
Set up the base project with:
- Framework initialization
- TypeScript configuration (strict mode)
- ESLint + Prettier setup
- Git hooks (Husky + lint-staged)
- Environment variable structure
- Basic folder architecture
```

### PRP 2: Core Infrastructure
```
Implement foundational systems:
- Routing structure
- Layout components
- Error boundaries
- Loading states
- Authentication setup (if needed)
- API client configuration
```

### PRP 3: UI/UX Foundation
```
Build the design system:
- Theme configuration
- Base components
- Typography system
- Color palette
- Responsive breakpoints
- Accessibility standards
```

### PRP 4: Data Layer
```
Set up data management:
- State management solution
- API integration patterns
- Data fetching hooks
- Cache management
- Optimistic updates
```

### PRP 5: Core Features (First Set)
```
Implement primary user flows:
- Main feature implementation
- Form handling
- Validation logic
- Success/error states
```

### PRP 6: Testing & Documentation
```
Ensure quality from day one:
- Unit test setup
- Component testing patterns
- E2E test infrastructure
- README documentation
- API documentation
- Deployment guide
```

## ⚠️ QUALITY GATES

### EVERY PRP MUST:
- ✅ Pass ALL linting rules (ZERO warnings)
- ✅ Have ZERO TypeScript errors
- ✅ Include relevant tests
- ✅ Follow established patterns
- ✅ Update documentation
- ✅ Handle errors gracefully

### THE PROJECT ISN'T READY UNTIL:
- 🎯 `npm run build` succeeds
- 🎯 `npm run lint` shows ZERO issues
- 🎯 `npm run type-check` passes
- 🎯 At least one test runs successfully
- 🎯 README has clear setup instructions
- 🎯 `.claude/PROJECT.md` is created

## 💪 EXECUTION GUIDELINES

### DO:
- **USE SPECIALIZED SUBAGENTS** for parallel PRP execution:
  - Use the nextjs-specialist subagent for Next.js setup and configuration
  - Use the frontend-developer subagent for React components and state management
  - Use the backend-architect subagent for API design and data layer
  - Use the ui-designer subagent for design system and component library
  - Use the test-writer-fixer subagent for testing infrastructure
  - Use the infrastructure-ops subagent for CI/CD and deployment setup
- **CREATE** `.claude/PROJECT.md` with complete project context
- **IMPLEMENT** git hooks from the start
- **SET UP** CI/CD pipeline basics
- **CONFIGURE** development tools properly
- **ESTABLISH** coding standards immediately

### DON'T:
- Start coding without architecture approval
- Skip any setup steps "for now"
- Use `any` types anywhere
- Ignore accessibility
- Forget about mobile responsiveness
- Leave console.logs in code

## 🚨 COMMON PITFALLS TO AVOID

1. **"We'll add TypeScript later"** → NO! TypeScript from day one
2. **"Tests can wait"** → NO! Test infrastructure from the start
3. **"Let's just get it working"** → NO! Quality from the beginning
4. **"We'll refactor later"** → NO! Proper architecture now
5. **"Documentation later"** → NO! Document as you build

## 📊 SUCCESS METRICS

The project setup is ONLY complete when:
- ✅ All PRPs executed successfully
- ✅ Zero linting errors or warnings
- ✅ Zero TypeScript errors
- ✅ All tests passing
- ✅ Build succeeds
- ✅ README is comprehensive
- ✅ Development environment runs smoothly
- ✅ Git hooks catch issues pre-commit
- ✅ Project structure is clean and scalable

## 🎯 EXAMPLE USAGE

```
User: /create-nextjs-project I want to build a task management app where users can create projects, add tasks, assign them to team members, and track progress. It should have a dashboard with analytics.

Agent: Let me gather some additional information to create the perfect Next.js architecture for your task management app:

1. **Next.js Setup**: Would you prefer App Router (recommended) or Pages Router?
2. **Authentication**: Will users need to log in? Any preference for auth provider?
3. **Database**: Do you have a preference for the database? (PostgreSQL, MongoDB, etc.)
4. **Real-time features**: Do you need real-time updates when tasks change?
5. **Team size**: Roughly how many users per team? This affects our architecture choices.
6. **UI preferences**: Any specific design system or should I recommend one?

[After clarification...]

Excellent! Based on your requirements, I'll architect a Next.js task management system with:
- Next.js 14 with App Router
- PostgreSQL with Prisma ORM
- NextAuth for authentication
- Real-time updates via WebSockets
- shadcn/ui for consistent design
- TanStack Query for data fetching

Here are the 6 PRPs I'll generate for systematic implementation:
[Lists PRPs...]

I'll use specialized subagents to execute these PRPs efficiently:
- Use the nextjs-specialist subagent to set up the project foundation with App Router
- Use the backend-architect subagent to design the database schema and API structure
- Use the ui-designer subagent to create the design system and component library
- Use the frontend-developer subagent to implement the task management features
- Use the security-guardian subagent to implement authentication and authorization
- Use the test-writer-fixer subagent to set up comprehensive testing
```

## 🔥 FINAL REMINDER

You are creating the FOUNDATION of what could become a major application. Every decision matters. Every shortcut will haunt the project. Do it RIGHT from the START.

**NO COMPROMISES. NO EXCUSES. ONLY EXCELLENCE.**