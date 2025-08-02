---
allowed-tools: all
description: Comprehensive API and database call audit, optimization, and cost reduction for Next.js/React/TypeScript projects
---

# 🚀🚀🚀 CRITICAL REQUIREMENT: OPTIMIZE ALL API & DATABASE CALLS! 🚀🚀🚀

**THIS IS NOT A REPORTING TASK - THIS IS AN OPTIMIZATION TASK!**

When you run `/check-api-database`, you are REQUIRED to:

1. **IDENTIFY** all API endpoints, database queries, and external service calls
2. **OPTIMIZE EVERY SINGLE ONE** - not just report them!
3. **USE MULTIPLE SPECIALIZED SUBAGENTS** to optimize issues in parallel:
   - Use the backend-architect subagent to consolidate duplicate API calls and design efficient endpoints
   - Use the database-architect subagent to optimize queries and implement proper indexing
   - Use the performance-tester subagent to implement caching strategies and measure improvements
   - Use the frontend-developer subagent to optimize client-side data fetching patterns
   - Use the infrastructure-ops subagent to configure CDN and edge caching
   - Say: "I'll use multiple specialized subagents to optimize all these API/database issues in parallel"
4. **DO NOT STOP** until:
   - ✅ ALL redundant calls are eliminated
   - ✅ NO N+1 query problems exist
   - ✅ ALL requests are properly cached
   - ✅ ALL queries are optimized
   - ✅ NO overfetching of data
   - ✅ MINIMAL API usage costs
   - ✅ EVERYTHING is EFFICIENT

**FORBIDDEN BEHAVIORS:**

- ❌ "Here are the inefficient API calls I found" → NO! OPTIMIZE THEM!
- ❌ "This component makes multiple requests" → NO! CONSOLIDATE THEM!
- ❌ "Database queries could be faster" → NO! MAKE THEM FASTER!
- ❌ "API usage might be expensive" → NO! REDUCE THE COST!
- ❌ Stopping after listing inefficiencies → NO! KEEP WORKING!

**MANDATORY WORKFLOW:**

```
1. Audit all API/database usage → Find inefficiencies
2. IMMEDIATELY spawn agents to optimize ALL issues
3. Re-run performance checks → Find remaining issues
4. Optimize those too
5. REPEAT until EVERYTHING is efficient
```

**YOU ARE NOT DONE UNTIL:**

- Zero duplicate API calls across components
- All database queries use proper indexing
- All data fetching is cached appropriately
- No waterfall loading patterns
- Minimal API request counts
- Optimized payload sizes
- Cost-effective API usage
- Everything shows optimal performance

---

⚡ **MANDATORY API/DATABASE PRE-FLIGHT CHECK** ⚡

1. Re-read CLAUDE.md RIGHT NOW
2. Re-read PROJECT.md to understand architecture
3. Check current .claude/TODO.md status
4. Verify you're not declaring "optimized" prematurely

Execute comprehensive API/database audit with ZERO tolerance for inefficiency.

**FORBIDDEN EXCUSE PATTERNS:**

- "This is how the API works" → NO, find a better way
- "The database is fast enough" → NO, make it faster
- "Users won't notice the delay" → NO, every millisecond counts
- "It's a third-party limitation" → NO, work around it
- "Caching is complex" → NO, implement it anyway
- "The cost is reasonable" → NO, minimize it further

Let me ultrathink about optimizing this codebase's external communications.

🚨 **REMEMBER: Every unnecessary API call costs money and degrades performance!** 🚨

**Universal API/Database Verification Protocol:**

**Step 0: Documentation Discovery**

- Search for API documentation URLs in codebase
- Identify all external services being used
- Fetch and analyze API documentation for each service
- Understand rate limits, pricing, and best practices
- Document all database schemas and relationships

**Step 1: API & Database Discovery Scan**

Comprehensive audit of all external calls:

```bash
# Find all API endpoints
grep -r "fetch\|axios\|http" --include="*.ts" --include="*.tsx" --include="*.js" .
grep -r "API_URL\|ENDPOINT" --include="*.ts" --include="*.tsx" .
grep -r "process.env.*API\|process.env.*URL" .

# Find database queries
grep -r "prisma\|query\|findMany\|findUnique" --include="*.ts" .
grep -r "SELECT\|INSERT\|UPDATE\|DELETE" --include="*.ts" .
grep -r "mongoose\|mongodb\|postgres\|mysql" --include="*.ts" .

# Find GraphQL queries
grep -r "gql\|useQuery\|useMutation" --include="*.ts" --include="*.tsx" .
```

**Step 2: Performance Analysis**

Identify performance bottlenecks:

- [ ] Map all API calls and their frequencies
- [ ] Identify duplicate or similar requests
- [ ] Find N+1 query problems
- [ ] Detect waterfall loading patterns
- [ ] Measure request/response sizes
- [ ] Calculate API usage costs
- [ ] Analyze query execution times
- [ ] Check for missing database indexes

**Frontend API Optimization Requirements:**

- NO duplicate API calls for same data
- NO sequential requests that could be batched
- NO fetching unused data fields
- NO missing loading states during requests
- NO unhandled error states
- NO requests without proper caching
- NO large payload transfers
- NO polling when websockets available

**Backend/Database Optimization Requirements:**

- ALL queries use proper indexes
- ALL queries avoid N+1 problems
- ALL queries select only needed fields
- ALL batch operations use transactions
- ALL frequently accessed data is cached
- ALL connection pooling is optimized
- ALL queries are parameterized
- ALL pagination is implemented efficiently

**Step 3: API Call Consolidation**

Optimize API usage patterns:

**❌ INEFFICIENT - Multiple calls:**
```typescript
// Bad: Three separate API calls
const user = await fetch('/api/user/123');
const posts = await fetch('/api/user/123/posts');
const comments = await fetch('/api/user/123/comments');
```

**✅ OPTIMIZED - Single batched call:**
```typescript
// Good: One call with includes
const userData = await fetch('/api/user/123?include=posts,comments');
// OR use GraphQL to fetch exactly what's needed
```

**❌ INEFFICIENT - Waterfall pattern:**
```typescript
// Bad: Sequential loading
const users = await getUsers();
for (const user of users) {
  user.profile = await getProfile(user.id); // N+1 problem!
}
```

**✅ OPTIMIZED - Batch loading:**
```typescript
// Good: Batch fetch profiles
const users = await getUsers();
const userIds = users.map(u => u.id);
const profiles = await getProfiles(userIds); // Single query
```

**Step 4: Caching Implementation**

Implement proper caching strategies:

**Client-side caching checklist:**
- [ ] SWR or React Query for API caching
- [ ] Proper cache invalidation strategies
- [ ] Optimistic updates for better UX
- [ ] Local storage for persistent data
- [ ] Service worker caching for offline
- [ ] CDN caching for static assets
- [ ] Browser cache headers configured
- [ ] Image optimization and caching

**Server-side caching checklist:**
- [ ] Redis/Memcached for API responses
- [ ] Database query result caching
- [ ] Edge caching with CDN
- [ ] Static generation where possible
- [ ] Incremental Static Regeneration (ISR)
- [ ] Route segment caching (App Router)
- [ ] Proper cache-control headers
- [ ] ETags for conditional requests

**Step 5: Database Query Optimization**

**❌ INEFFICIENT - Overfetching:**
```typescript
// Bad: Fetching entire objects
const users = await prisma.user.findMany({
  include: {
    posts: true,
    comments: true,
    profile: true,
    settings: true
  }
});
```

**✅ OPTIMIZED - Select only needed fields:**
```typescript
// Good: Fetch only what's needed
const users = await prisma.user.findMany({
  select: {
    id: true,
    name: true,
    email: true,
    posts: {
      select: {
        title: true,
        createdAt: true
      },
      take: 5 // Limit related data
    }
  }
});
```

**Step 6: Request Batching & Deduplication**

Implement request batching:

```typescript
// Batch multiple requests with DataLoader pattern
const userLoader = new DataLoader(async (userIds) => {
  const users = await prisma.user.findMany({
    where: { id: { in: userIds } }
  });
  return userIds.map(id => users.find(u => u.id === id));
});

// Automatic deduplication and batching
const user1 = await userLoader.load(1);
const user2 = await userLoader.load(2);
const user1Again = await userLoader.load(1); // Uses cached result
```

**Step 7: API Cost Optimization**

Reduce API usage costs:

- [ ] Implement request quotas and limits
- [ ] Use webhooks instead of polling
- [ ] Cache expensive API responses
- [ ] Batch operations when possible
- [ ] Use more efficient endpoints
- [ ] Implement retry with backoff
- [ ] Monitor API usage metrics
- [ ] Set up usage alerts

**Next.js Specific Optimizations:**

- [ ] Use Server Components for data fetching
- [ ] Implement proper data fetching patterns
- [ ] Use Route Handlers efficiently
- [ ] Leverage ISR for static content
- [ ] Optimize Image component usage
- [ ] Use Edge Runtime where appropriate
- [ ] Implement proper error boundaries
- [ ] Configure revalidation strategies

**Common Optimization Patterns:**

**1. Implement Data Loaders:**
```typescript
// Centralized data loading with caching
export const loaders = {
  user: new DataLoader(fetchUsers),
  posts: new DataLoader(fetchPosts),
  comments: new DataLoader(fetchComments)
};
```

**2. Use Proper Pagination:**
```typescript
// ✅ Cursor-based pagination
const { data, hasMore } = await fetchPosts({
  cursor: lastPostId,
  limit: 20
});
```

**3. Implement Field-Level Caching:**
```typescript
// Cache individual fields that change rarely
const user = await cache.wrap(
  `user:${id}:profile`,
  () => fetchUserProfile(id),
  { ttl: 3600 } // 1 hour cache
);
```

**4. Optimize Real-time Updates:**
```typescript
// Use WebSockets for real-time data
const socket = io();
socket.on('update', (data) => {
  // Update only changed data
  queryClient.setQueryData(['posts', data.id], data);
});
```

**Monitoring & Metrics Requirements:**

- [ ] Track API response times
- [ ] Monitor database query performance
- [ ] Set up cost tracking for APIs
- [ ] Alert on performance degradation
- [ ] Log slow queries
- [ ] Track cache hit rates
- [ ] Monitor request volumes
- [ ] Analyze usage patterns

**Failure Response Protocol:**

When inefficiencies are found:

1. **IMMEDIATELY USE SPECIALIZED SUBAGENTS** to optimize in parallel:
   ```
   "I found 47 duplicate API calls, 23 N+1 queries, and 15 uncached endpoints. I'll use specialized subagents to optimize:
   - Use the frontend-developer subagent to consolidate duplicate API calls in components/
   - Use the performance-tester subagent to implement caching for user data endpoints
   - Use the database-architect subagent to fix N+1 queries in post loading
   - Use the backend-architect subagent to batch API requests in dashboard
   - Use the database-architect subagent to optimize database indexes
   Let me invoke these subagents to tackle all optimizations in parallel..."
   ```
2. **OPTIMIZE EVERYTHING** - Address EVERY inefficiency
3. **VERIFY** - Re-run performance checks after optimizations
4. **REPEAT** - If new issues found, spawn more agents
5. **NO STOPPING** - Keep working until ALL metrics show ✅ OPTIMAL
6. **NO EXCUSES** - Common invalid excuses:
   - "The API doesn't support batching" → Implement client-side batching
   - "Caching might show stale data" → Implement smart invalidation
   - "The queries are already fast" → Make them faster
   - "It's premature optimization" → It's necessary optimization
   - "The cost is negligible" → Every cent counts

**Performance Benchmarks:**

The code is optimized when:
✓ Zero duplicate API requests
✓ All queries < 100ms execution time
✓ Cache hit rate > 80%
✓ No N+1 query problems
✓ API costs reduced by > 50%
✓ Page load time < 3 seconds
✓ Time to interactive < 5 seconds
✓ All lighthouse scores > 90
✓ Database connection pool optimized
✓ All endpoints have caching
✓ Request payloads minimized
✓ All tests still pass

**Final Optimization Commitment:**

I will now execute EVERY optimization check listed above and FIX ALL INEFFICIENCIES. I will:

- ✅ Analyze all API and database usage patterns
- ✅ Read API documentation to understand best practices
- ✅ USE MULTIPLE SPECIALIZED SUBAGENTS to optimize in parallel:
  - database-architect subagent for query optimization and indexing
  - backend-architect subagent for API design and batching
  - performance-tester subagent for caching and benchmarking
  - frontend-developer subagent for client-side optimization
  - infrastructure-ops subagent for CDN and edge caching
- ✅ Keep working until EVERYTHING is efficient
- ✅ Verify with performance metrics
- ✅ Not stop until all checks show optimal status

I will NOT:

- ❌ Just report inefficiencies without fixing them
- ❌ Skip any optimization opportunities
- ❌ Accept "good enough" performance
- ❌ Ignore potential cost savings
- ❌ Leave any redundant calls
- ❌ Stop working while inefficiencies remain

**REMEMBER: This is an OPTIMIZATION task, not a reporting task!**

The code is optimized ONLY when every single metric shows ✅ OPTIMAL.

**Executing comprehensive API/database audit and OPTIMIZING ALL CALLS NOW...**