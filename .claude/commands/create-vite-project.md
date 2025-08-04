# 🚀 CREATE-VITE-PROJECT Command

## ⚡ PRIME DIRECTIVE
Transform a user's vision into a FULLY FUNCTIONING, PRODUCTION-READY Vite + React project with ZERO compromises on quality, architecture, or best practices.

## 🎯 WHAT THIS COMMAND DOES

**MANDATORY: USE SPECIALIZED SUB-AGENTS** for comprehensive project creation:
- **rapid-prototyper**: Fast project initialization, feature scaffolding, and trend integration
- **frontend-developer**: React setup, state management configuration, and component architecture
- **ui-designer**: Design system integration, component library setup, and accessibility compliance
- **performance-tester**: Bundle optimization, code splitting strategies, and performance validation

**Sub-Agent Collaboration Protocol:**
- All agents MUST read `.claude/collab/team_notes.md` before starting project creation
- All agents MUST append their setup decisions and performance optimizations to team_notes.md
- Use standard format with build configurations, optimization strategies, and performance metrics
- Coordinate to ensure optimal bundle size and development experience

When you invoke `/create-vite-project`, you will:
1. **EXTRACT** the complete project vision from the user
2. **CLARIFY** any missing technical decisions
3. **ARCHITECT** a robust, scalable solution (using specialized sub-agents)
4. **GENERATE** multiple focused PRPs for systematic implementation
5. **EXECUTE** the setup with military precision
6. **VALIDATE** everything works perfectly

## 📋 INFORMATION GATHERING PHASE

### MUST ASK (if not specified):
1. **Vite Configuration**:
   - React, Vue, Preact, or Vanilla?
   - SWC or Babel for React?
   - PWA support needed?
   - Module federation required?

2. **Language & Tooling**:
   - TypeScript or JavaScript?
   - Package manager (npm, yarn, pnpm, bun)?
   - CSS solution (Tailwind, CSS Modules, styled-components, vanilla CSS)?

3. **Core Libraries**:
   - State management (Zustand, Redux Toolkit, Valtio, Jotai)?
   - Routing (React Router, TanStack Router)?
   - Data fetching (TanStack Query, SWR, native fetch)?
   - Form handling (React Hook Form, Formik)?
   - UI library (shadcn/ui, MUI, Ant Design, Mantine)?

4. **Infrastructure**:
   - Authentication needs?
   - Backend API (existing or need to create)?
   - Deployment target (Netlify, Vercel, AWS, GitHub Pages)?
   - CDN requirements?

### EXTRACT FROM USER:
- **Core functionality** and user flows
- **Target audience** and scale expectations
- **Performance requirements** (especially bundle size)
- **Any specific integrations** needed
- **Timeline or MVP scope**

## 🏗️ ARCHITECTURE PHASE

### YOU MUST:
1. **CREATE** a comprehensive technical architecture document
2. **DESIGN** the folder structure following Vite best practices
3. **PLAN** the data flow and state management approach
4. **IDENTIFY** all required dependencies
5. **MAP OUT** the component hierarchy
6. **DEFINE** API contracts and data models

### NEVER:
- Skip architecture planning "to save time"
- Choose trendy tech over proven solutions
- Ignore bundle size considerations
- Forget about code splitting strategies
- Overlook build optimization opportunities

## 📝 PRP GENERATION PHASE

Generate **AT LEAST 4-6 FOCUSED PRPs** covering:

### PRP 1: Project Foundation
```
Set up the base project with:
- Vite initialization with React/Vue
- TypeScript configuration (strict mode)
- ESLint + Prettier setup
- Git hooks (Husky + lint-staged)
- Environment variable structure
- Basic folder architecture
- Path aliases configuration
```

### PRP 2: Core Infrastructure
```
Implement foundational systems:
- Routing setup (React Router/TanStack Router)
- Layout components
- Error boundaries
- Suspense boundaries
- Authentication setup (if needed)
- API client configuration
- Build optimization config
```

### PRP 3: UI/UX Foundation
```
Build the design system:
- Theme configuration
- Base components
- Typography system
- Color palette
- Responsive breakpoints
- CSS-in-JS or Tailwind setup
- Dark mode support
```

### PRP 4: Data Layer
```
Set up data management:
- State management solution
- API integration patterns
- Data fetching hooks
- Cache management
- Optimistic updates
- WebSocket setup (if needed)
```

### PRP 5: Core Features (First Set)
```
Implement primary user flows:
- Main feature implementation
- Form handling
- Validation logic
- Success/error states
- Loading skeletons
```

### PRP 6: Testing & Optimization
```
Ensure quality and performance:
- Vitest configuration
- Component testing setup
- E2E test infrastructure
- Bundle analysis
- Lazy loading implementation
- Performance monitoring
```

## ⚠️ QUALITY GATES

### EVERY PRP MUST:
- ✅ Pass ALL linting rules (ZERO warnings)
- ✅ Have ZERO TypeScript errors
- ✅ Include relevant tests
- ✅ Follow established patterns
- ✅ Update documentation
- ✅ Consider bundle size impact

### THE PROJECT ISN'T READY UNTIL:
- 🎯 `npm run build` succeeds
- 🎯 `npm run lint` shows ZERO issues
- 🎯 `npm run type-check` passes
- 🎯 At least one test runs successfully
- 🎯 Bundle size is optimized
- 🎯 Lighthouse score > 90
- 🎯 `.claude/PROJECT.md` is created

## 💪 EXECUTION GUIDELINES

### DO:
- **USE AGENTS** for parallel PRP execution when possible
- **CREATE** `.claude/PROJECT.md` with complete project context
- **IMPLEMENT** git hooks from the start
- **SET UP** CI/CD pipeline basics
- **CONFIGURE** Vite plugins properly
- **OPTIMIZE** for production from day one

### DON'T:
- Start coding without architecture approval
- Skip any setup steps "for now"
- Use `any` types anywhere
- Ignore tree-shaking opportunities
- Forget about code splitting
- Leave console.logs in code

## 🚨 COMMON PITFALLS TO AVOID

1. **"We'll add TypeScript later"** → NO! TypeScript from day one
2. **"Tests can wait"** → NO! Vitest from the start
3. **"Let's just get it working"** → NO! Quality from the beginning
4. **"We'll optimize the bundle later"** → NO! Performance now
5. **"Documentation later"** → NO! Document as you build

## 📊 SUCCESS METRICS

The project setup is ONLY complete when:
- ✅ All PRPs executed successfully
- ✅ Zero linting errors or warnings
- ✅ Zero TypeScript errors
- ✅ All tests passing
- ✅ Build succeeds and is optimized
- ✅ Bundle size is reasonable
- ✅ Development server has HMR working
- ✅ Git hooks catch issues pre-commit
- ✅ Project structure supports scaling

## 🎯 EXAMPLE USAGE

```
User: /create-vite-project I want to build a real-time collaborative whiteboard app where multiple users can draw, add shapes, and see each other's cursors in real-time.

Agent: Let me gather some additional information to create the perfect Vite architecture for your collaborative whiteboard app:

1. **Framework**: Would you prefer React (recommended for this type of app) or Vue?
2. **Real-time Engine**: WebSockets, Socket.io, or a service like Liveblocks?
3. **Canvas Library**: Konva, Fabric.js, or native Canvas API?
4. **State Sync**: How should drawing data be persisted? (Database, local storage, cloud storage?)
5. **User Limits**: How many concurrent users per session?
6. **Performance**: Any specific FPS or latency requirements?

[After clarification...]

Excellent! Based on your requirements, I'll architect a Vite + React collaborative whiteboard with:
- Vite + React 18 with TypeScript
- Socket.io for real-time collaboration
- Konva.js for canvas manipulation
- Zustand for local state management
- IndexedDB for offline support
- Tailwind CSS for UI styling

Here are the 6 PRPs I'll generate for systematic implementation:
[Lists PRPs...]
```

## 🔥 FINAL REMINDER

You are creating the FOUNDATION of what could become a major application. Vite's speed is only valuable if the codebase remains maintainable. Every decision matters. Every shortcut will haunt the project. Do it RIGHT from the START.

**NO COMPROMISES. NO EXCUSES. ONLY EXCELLENCE.**