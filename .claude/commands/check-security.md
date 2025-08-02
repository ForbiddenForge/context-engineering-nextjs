---
allowed-tools: all
description: Comprehensive security audit and vulnerability remediation for Next.js/React/TypeScript projects
---

# 🔐🔐🔐 CRITICAL REQUIREMENT: SECURE ALL VULNERABILITIES! 🔐🔐🔐

**THIS IS NOT A REPORTING TASK - THIS IS A SECURING TASK!**

When you run `/security-check`, you are REQUIRED to:

1. **IDENTIFY** all security vulnerabilities, exposures, and risks
2. **FIX EVERY SINGLE ONE** - not just report them!
3. **USE MULTIPLE SUBAGENTS** to fix security issues in parallel:
   - Use the security-guardian subagent to audit and fix authentication vulnerabilities
   - Use the backend-architect subagent to secure API endpoints and database queries
   - Use the frontend-developer subagent to fix XSS and input validation issues
   - Use the infrastructure-ops subagent to configure security headers and HTTPS
   - Use the test-writer-fixer subagent to create security test suites
   - Say: "I'll use multiple specialized subagents to fix all these security issues in parallel"
4. **DO NOT STOP** until:
   - ✅ ALL sensitive data is secured
   - ✅ NO credentials exposed in frontend
   - ✅ ALL inputs are validated and sanitized
   - ✅ ALL API endpoints are protected
   - ✅ NO XSS vulnerabilities exist
   - ✅ NO SQL injection possibilities
   - ✅ EVERYTHING is SECURE

**FORBIDDEN BEHAVIORS:**

- ❌ "Here are the security issues I found" → NO! SECURE THEM!
- ❌ "API keys are exposed in..." → NO! HIDE THEM!
- ❌ "This input could be vulnerable to..." → NO! SECURE IT!
- ❌ "Authentication might be weak..." → NO! STRENGTHEN IT!
- ❌ Stopping after listing vulnerabilities → NO! KEEP WORKING!

**MANDATORY WORKFLOW:**

```
1. Run security scans → Find vulnerabilities
2. IMMEDIATELY spawn agents to fix ALL issues
3. Re-run security checks → Find remaining issues
4. Secure those too
5. REPEAT until EVERYTHING is secure
```

**YOU ARE NOT DONE UNTIL:**

- No sensitive data exposed in frontend bundles
- All API keys and secrets in environment variables
- All user inputs validated and sanitized
- All API endpoints have proper authentication
- No XSS, CSRF, or injection vulnerabilities
- All dependencies are updated and secure
- Security headers are properly configured
- Everything shows secure status

---

🛡️ **MANDATORY SECURITY PRE-FLIGHT CHECK** 🛡️

1. Re-read CLAUDE.md RIGHT NOW
2. Check current .claude/TODO.md status
3. Verify you're not declaring "secure" prematurely

Execute comprehensive security audit with ZERO tolerance for vulnerabilities.

**FORBIDDEN EXCUSE PATTERNS:**

- "This is just a minor exposure" → NO, all exposures are critical
- "It's internal data" → NO, secure everything
- "Users won't access this" → NO, assume they will
- "It's behind authentication" → NO, defense in depth
- "It's a known library issue" → NO, work around it
- "HTTPS will protect it" → NO, that's not enough

Let me ultrathink about securing this codebase against all possible attack vectors.

🚨 **REMEMBER: One security flaw can compromise the entire application!** 🚨

**Universal Security Verification Protocol:**

**Step 0: Security Environment Check**

- Verify all environment variables are properly configured
- Check that .env files are not committed to version control
- Ensure production builds don't include debug information
- Scan for any hardcoded secrets in the codebase

**Step 1: Sensitive Data Exposure Scan**

- Search for API keys, passwords, tokens in all files
- Check for database credentials in code
- Look for hardcoded URLs and endpoints
- Scan for debug information in production builds
- Review environment variable usage

**Step 2: Input Validation & Sanitization**

Run comprehensive input security checks:

```bash
# Check for unvalidated inputs
grep -r "req.body" --include="*.ts" --include="*.js" .
grep -r "req.query" --include="*.ts" --include="*.js" .
grep -r "req.params" --include="*.ts" --include="*.js" .

# Check for dangerous HTML rendering
grep -r "dangerouslySetInnerHTML" --include="*.tsx" --include="*.jsx" .

# Check for direct SQL queries
grep -r "SELECT\|INSERT\|UPDATE\|DELETE" --include="*.ts" --include="*.js" .
```

**Frontend Security Requirements:**

- NO API keys, secrets, or credentials in client-side code
- NO sensitive data in localStorage or sessionStorage
- NO direct database queries from frontend
- NO unencrypted sensitive data transmission
- NO XSS vulnerabilities through user input
- NO CSRF vulnerabilities in forms
- NO clickjacking vulnerabilities
- NO mixed content (HTTP resources over HTTPS)

**Backend/API Security Requirements:**

- ALL API endpoints require proper authentication
- ALL user inputs validated with schemas (Zod, Joi, etc.)
- ALL database queries use parameterized statements
- ALL file uploads are validated and sanitized
- ALL error messages don't expose sensitive information
- ALL API responses don't leak internal data
- ALL middleware implements proper security headers
- ALL routes implement rate limiting

**Step 3: Authentication & Authorization Security**

Verify authentication implementation:

- [ ] JWT tokens are properly signed and verified
- [ ] Session management is secure (httpOnly, secure flags)
- [ ] Password hashing uses bcrypt or stronger
- [ ] Password reset flows are secure
- [ ] Multi-factor authentication implemented (if required)
- [ ] OAuth flows are properly implemented
- [ ] Role-based access control is enforced
- [ ] Session timeout is configured appropriately
- [ ] Brute force protection is implemented
- [ ] Account lockout policies are in place

**Step 4: API Security Audit**

```bash
# Check for unprotected API routes
find . -name "route.ts" -o -name "*.api.ts" | xargs grep -L "auth\|token\|session"

# Check for missing input validation
find . -name "route.ts" -o -name "*.api.ts" | xargs grep -L "validate\|schema\|zod"

# Check for SQL injection vulnerabilities
find . -name "*.ts" -o -name "*.js" | xargs grep -n "query.*+\|query.*\${" 
```

**Next.js Specific Security Checklist:**

- [ ] No sensitive data in getServerSideProps return
- [ ] No API keys in getStaticProps
- [ ] Environment variables use NEXT_PUBLIC_ prefix correctly
- [ ] No server-side code executed on client
- [ ] No database connections in client components
- [ ] Proper Content Security Policy configured
- [ ] Security headers configured in next.config.js
- [ ] No eval() or Function() constructors
- [ ] No inline scripts without nonce
- [ ] Image optimization doesn't expose paths

**Database Security Verification:**

- [ ] All queries use parameterized statements
- [ ] Database connection strings are in environment variables
- [ ] Database user has minimal required permissions
- [ ] No raw SQL queries with user input
- [ ] Database errors don't expose schema information
- [ ] Connection pooling is properly configured
- [ ] Database backups are encrypted
- [ ] No database credentials in logs

**React/Component Security Checklist:**

- [ ] No dangerouslySetInnerHTML without DOMPurify
- [ ] User input is escaped before rendering
- [ ] No direct DOM manipulation with user data
- [ ] File uploads are validated client and server-side
- [ ] Forms include CSRF protection
- [ ] No sensitive data in component state
- [ ] No XSS through CSS injection
- [ ] No postMessage without origin validation
- [ ] No localStorage for sensitive data
- [ ] No console.log with sensitive information

**Dependency Security Audit:**

```bash
# Check for known vulnerabilities
npm audit
npm audit fix

# Check for outdated packages
npm outdated

# Verify package integrity
npm ci --verify-signatures
```

**Step 5: Security Headers Configuration**

Verify security headers are properly configured:

- [ ] Content-Security-Policy (CSP) header
- [ ] X-Content-Type-Options: nosniff
- [ ] X-Frame-Options: DENY or SAMEORIGIN
- [ ] X-XSS-Protection: 1; mode=block
- [ ] Strict-Transport-Security (HSTS)
- [ ] Referrer-Policy: strict-origin-when-cross-origin
- [ ] Permissions-Policy properly configured
- [ ] Cross-Origin-Embedder-Policy
- [ ] Cross-Origin-Opener-Policy
- [ ] Cross-Origin-Resource-Policy

**Step 6: File Upload Security**

If file uploads are implemented:

- [ ] File type validation (whitelist, not blacklist)
- [ ] File size limits enforced
- [ ] Malicious file detection
- [ ] Files stored outside web root
- [ ] No executable files allowed
- [ ] Antivirus scanning implemented
- [ ] File content validation
- [ ] Secure file naming

**Step 7: Session Security**

- [ ] Session tokens are cryptographically random
- [ ] Sessions expire after inactivity
- [ ] Session fixation protection
- [ ] Secure session storage
- [ ] Session invalidation on logout
- [ ] No session data in URLs
- [ ] Session hijacking prevention
- [ ] Concurrent session limits

**Common Vulnerability Patterns to Fix:**

**1. Exposed Secrets:**
```typescript
// ❌ DANGEROUS - API key exposed
const apiKey = "sk-1234567890abcdef";

// ✅ SECURE - Use environment variables
const apiKey = process.env.API_KEY;
```

**2. Unvalidated Input:**
```typescript
// ❌ DANGEROUS - No validation
app.post('/api/user', (req, res) => {
  const { name, email } = req.body;
  // Direct database insert
});

// ✅ SECURE - Validate with schema
const userSchema = z.object({
  name: z.string().min(1).max(100),
  email: z.string().email(),
});

app.post('/api/user', (req, res) => {
  const validated = userSchema.parse(req.body);
  // Safe to use validated data
});
```

**3. XSS Vulnerability:**
```typescript
// ❌ DANGEROUS - XSS vulnerability
<div dangerouslySetInnerHTML={{__html: userInput}} />

// ✅ SECURE - Sanitize input
import DOMPurify from 'dompurify';
<div dangerouslySetInnerHTML={{__html: DOMPurify.sanitize(userInput)}} />
```

**4. SQL Injection:**
```typescript
// ❌ DANGEROUS - SQL injection
const query = `SELECT * FROM users WHERE id = ${userId}`;

// ✅ SECURE - Parameterized query
const query = 'SELECT * FROM users WHERE id = $1';
db.query(query, [userId]);
```

**Step 8: Security Testing**

Run security-focused tests:

```bash
# Static security analysis
npm run lint:security  # ESLint security rules
npm run audit:security # Security-focused audit

# Dynamic security testing
npm run test:security  # Security-focused test suites
```

**Failure Response Protocol:**

When security vulnerabilities are found:

1. **IMMEDIATELY USE SPECIALIZED SUBAGENTS** to fix vulnerabilities in parallel:
   ```
   "I found API keys exposed in 5 files, 12 unvalidated inputs, and 3 XSS vulnerabilities. I'll use specialized subagents to fix these:
   - Use the security-guardian subagent to secure API keys and move to environment variables
   - Use the backend-architect subagent to add input validation to all API endpoints  
   - Use the frontend-developer subagent to fix XSS vulnerabilities in components
   - Use the infrastructure-ops subagent to update dependencies and configure security headers
   - Use the test-writer-fixer subagent to add security tests
   Let me invoke these subagents to tackle all issues in parallel..."
   ```
2. **SECURE EVERYTHING** - Address EVERY vulnerability, no matter how "minor"
3. **VERIFY** - Re-run all security checks after fixes
4. **REPEAT** - If new vulnerabilities found, spawn more agents and fix those too
5. **NO STOPPING** - Keep working until ALL security checks show ✅ SECURE
6. **NO EXCUSES** - Common invalid excuses:
   - "It's just test data" → Secure it NOW
   - "Users won't access this" → Assume they will NOW
   - "It's behind authentication" → Defense in depth NOW
   - "HTTPS will protect it" → That's not enough NOW
   - "It's a low-risk vulnerability" → Fix it anyway NOW

**Critical Security Verification:**

The code is secure when:
✓ No secrets in frontend code or version control
✓ All inputs validated and sanitized
✓ All API endpoints protected
✓ No XSS vulnerabilities
✓ No SQL injection possibilities
✓ All dependencies updated and secure
✓ Security headers configured
✓ Authentication properly implemented
✓ Authorization enforced on all routes
✓ No sensitive data leakage
✓ All security tests pass
✓ Security audit tools show no issues

**Final Security Commitment:**

I will now execute EVERY security check listed above and FIX ALL VULNERABILITIES. I will:

- ✅ Scan for all exposed secrets and secure them
- ✅ USE MULTIPLE SPECIALIZED SUBAGENTS to fix vulnerabilities in parallel:
  - security-guardian subagent for authentication and encryption
  - backend-architect subagent for API and database security
  - frontend-developer subagent for XSS and CSRF protection
  - infrastructure-ops subagent for security headers and SSL/TLS
  - test-writer-fixer subagent for security test coverage
- ✅ Keep working until EVERYTHING is secure
- ✅ Verify with security tools and manual testing
- ✅ Not stop until all security checks show passing status

I will NOT:

- ❌ Just report vulnerabilities without fixing them
- ❌ Skip any security checks
- ❌ Accept "low-risk" vulnerabilities
- ❌ Ignore potential attack vectors
- ❌ Leave any security warnings
- ❌ Stop working while ANY vulnerabilities remain

**REMEMBER: This is a SECURING task, not a reporting task!**

The code is secure ONLY when every single security check shows ✅ SECURE.

**Executing comprehensive security audit and FIXING ALL VULNERABILITIES NOW...**