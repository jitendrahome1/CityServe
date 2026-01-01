# CityServe Claude Code Agents

This directory contains specialized AI agents for the CityServe iOS project. These agents help maintain code quality, ensure design consistency, and speed up development workflows.

## Available Agents

### 🔒 security-auditor
**Purpose**: iOS security and vulnerability auditing expert
**When to use**: PROACTIVELY before production, when handling sensitive data, or implementing auth/payments
**Key features**:
- OWASP Mobile Top 10 compliance
- Firebase security rules validation
- Payment security (PCI DSS)
- Data protection & privacy (GDPR)
- Secure coding practices
- Vulnerability detection
- KeychainService implementation
- Pre-production security checklist

**Example invocation**:
```
> Use the security-auditor agent to audit the app before production release.
> Check Firebase security rules with the security-auditor agent.
```

### ⚡ performance-optimizer
**Purpose**: iOS performance analysis and optimization expert
**When to use**: PROACTIVELY when app feels slow, before production, or after adding features
**Key features**:
- App launch time optimization
- Memory leak detection and fixes
- Scroll and animation performance
- Network performance optimization
- Battery usage reduction
- Profiling with Instruments
- SwiftUI performance patterns
- Image optimization

**Example invocation**:
```
> Use the performance-optimizer agent to analyze app launch time.
> Check for memory leaks with the performance-optimizer agent.
```

### 🌐 api-integrator
**Purpose**: REST API and third-party service integration expert
**When to use**: Integrating external APIs, payment gateways, maps, or backend services
**Key features**:
- REST API integration (Cloud Functions, custom backends)
- Payment gateways (Razorpay, Stripe)
- Google Maps Platform integration
- Push notifications (FCM)
- Networking layer setup
- Error handling and retry logic
- SDK integration
- Environment configuration

**Example invocation**:
```
> Use the api-integrator agent to integrate Razorpay payment gateway.
> Set up Google Maps autocomplete with the api-integrator agent.
```

### 🔄 data-migrator
**Purpose**: Data migration specialist for mock data to Firebase
**When to use**: PROACTIVELY when migrating features from mock to real backend
**Key features**:
- Migrate ViewModels from mock to Firestore
- Replace simulated API calls with real queries
- Set up real-time listeners
- Data seeding scripts
- Migration validation
- Rollback strategies

**Example invocation**:
```
> Use the data-migrator agent to migrate services from mock data to Firestore.
> Migrate the booking creation flow to Firebase using the data-migrator agent.
```

### 🎬 ui-animator
**Purpose**: SwiftUI animation and transitions expert
**When to use**: Adding animations, improving UI motion, gesture interactions
**Key features**:
- SwiftUI animation patterns
- Custom transitions and gestures
- Loading states and shimmer effects
- Performance optimization
- Accessibility (Reduce Motion support)
- Haptic feedback integration

**Example invocation**:
```
> Use the ui-animator agent to add smooth transitions to the booking flow.
> Add loading animations to the service cards using the ui-animator agent.
```

### 🔥 firebase-integrator
**Purpose**: Firebase integration expert
**When to use**: Setting up Firebase services, replacing mock data with backend
**Key features**:
- Firebase Authentication (Phone, Email, Google)
- Firestore Database integration
- Cloud Storage setup
- Cloud Functions connection
- FCM push notifications
- Migration from mock data to production

**Example invocation**:
```
> Use the firebase-integrator agent to set up Firebase Authentication.
> Replace mock data with Firestore using the firebase-integrator agent.
```

### 🔨 ios-builder
**Purpose**: Build and compilation expert
**When to use**: Build errors, compilation failures, Swift compiler issues
**Key features**:
- Fixes parameter ordering issues
- Handles missing imports
- Resolves type inference problems
- Deals with compiler timeouts

**Example invocation**:
```
> The build is failing with parameter errors. Use the ios-builder agent to fix them.
```

### 🎨 swiftui-reviewer
**Purpose**: SwiftUI code review and best practices
**When to use**: After creating/modifying SwiftUI views
**Key features**:
- Checks SwiftUI best practices
- Reviews performance patterns
- Ensures accessibility compliance
- Validates design system usage

**Example invocation**:
```
> Use the swiftui-reviewer agent to review my HomeView changes.
```

### 📱 viewmodel-expert
**Purpose**: MVVM architecture and Combine framework specialist
**When to use**: Working with ViewModels, @Published properties, state management
**Key features**:
- Ensures proper MVVM patterns
- Validates Combine usage
- Checks async/await patterns
- Reviews state management

**Example invocation**:
```
> Use the viewmodel-expert agent to review BookingViewModel.
```

### 🐛 ios-debugger
**Purpose**: Runtime debugging and crash analysis
**When to use**: Crashes, unexpected behavior, memory issues
**Key features**:
- Analyzes crash logs
- Debugs force unwrap issues
- Identifies memory leaks
- Fixes navigation problems

**Example invocation**:
```
> The app is crashing on ProfileView. Use the ios-debugger agent to investigate.
```

### 🧪 test-runner
**Purpose**: Testing specialist
**When to use**: Running tests, analyzing failures, ensuring coverage
**Key features**:
- Runs unit and UI tests
- Analyzes test failures
- Suggests test improvements
- Tracks test coverage

**Example invocation**:
```
> Use the test-runner agent to run all tests and fix any failures.
```

### 🎨 design-enforcer
**Purpose**: Design system compliance checker
**When to use**: After UI changes to ensure consistency
**Key features**:
- Validates color usage
- Checks spacing consistency
- Ensures typography compliance
- Reviews component patterns

**Example invocation**:
```
> Use the design-enforcer agent to check design system compliance.
```

## Quick Start

### Automatic Usage (Recommended)
Claude Code will automatically select the appropriate agent based on your request:

```
> Fix the build errors
→ Automatically uses ios-builder

> Review my SwiftUI code
→ Automatically uses swiftui-reviewer

> The app is crashing
→ Automatically uses ios-debugger
```

### Explicit Usage
You can explicitly request a specific agent:

```
> Use the ios-builder agent to fix compilation errors
> Ask the swiftui-reviewer agent to check my code
> Have the test-runner agent run all tests
```

### Chaining Agents
For complex workflows, chain multiple agents:

```
> First use the ios-builder to fix build errors, then use the test-runner to verify tests pass
```

## Agent Configuration

All agents are configured in this directory as Markdown files with YAML frontmatter:

```markdown
---
name: agent-name
description: When to use this agent
tools: Read, Edit, Bash, Grep, Glob
model: sonnet
---

Agent's system prompt and instructions...
```

### Modifying Agents

To customize an agent:

1. **Using CLI** (Recommended):
   ```
   /agents
   ```
   Then select the agent to edit.

2. **Direct file edit**:
   Edit the `.md` file directly in this directory.

Changes take effect on the next agent invocation.

## Project-Specific Knowledge

### CityServe/UrbanNest Design System
- **Primary Color**: Deep Teal (#0D7377)
- **Secondary Color**: Warm Orange (#FF6B35)
- **Spacing**: 4pt grid system (Spacing.xs through Spacing.xxl)
- **Typography**: .h1Style() through .h5Style(), .bodyStyle()

### Common Patterns
```swift
// Buttons
PrimaryButton("Title", icon: "icon", action: { })
SecondaryButton("Title", icon: "icon", action: { })

// Components
ServiceCard(service: model, action: { }, style: .vertical)
EmptyStateView(icon: "icon", title: "Title", description: "Text")

// ViewModels
@MainActor
class MyViewModel: ObservableObject {
    @Published var items: [Item] = []
    // Must import Combine!
}
```

### Common Issues These Agents Fix

1. **Missing Combine Import**
   - Agent: ios-builder
   - Fix: Adds `import Combine` to ViewModels

2. **Button Parameter Order**
   - Agent: ios-builder, swiftui-reviewer
   - Fix: Title (unlabeled) first, action last

3. **EmptyStateView 'message' vs 'description'**
   - Agent: ios-builder, design-enforcer
   - Fix: Use `description:` not `message:`

4. **Hardcoded Colors/Spacing**
   - Agent: design-enforcer
   - Fix: Use design system constants

5. **Force Unwrap Crashes**
   - Agent: ios-debugger
   - Fix: Use guard statements or optional binding

## Best Practices

### ✅ Do's
- Let agents work proactively (include "PROACTIVELY" in descriptions)
- Use agents for specialized tasks they're designed for
- Chain agents for complex workflows
- Review agent suggestions before applying

### ❌ Don'ts
- Don't override agent recommendations without understanding why
- Don't use agents for tasks outside their expertise
- Don't ignore agent warnings about best practices

## Troubleshooting

### Agent Not Being Used Automatically
Make sure your request clearly matches the agent's description:
```
❌ "Something's wrong"
✅ "Build is failing with parameter errors" → ios-builder
✅ "App crashes on ProfileView" → ios-debugger
✅ "Review my SwiftUI code" → swiftui-reviewer
```

### Agent Making Unexpected Changes
Check the agent's prompt in its .md file to understand its behavior, then:
1. Edit the agent's system prompt if needed
2. Use explicit instructions: "Use ios-builder but only fix import statements"

### Multiple Agents Needed
Chain them explicitly:
```
> Use ios-builder to fix build, then swiftui-reviewer to check code quality
```

## Performance Considerations

- **Haiku agents** (design-enforcer): Fast, low-cost, read-only checks
- **Sonnet agents** (most): Balanced performance and capability
- **Opus agents**: Reserved for complex reasoning (none currently)

## Contributing New Agents

To add a new agent:

1. Create `agent-name.md` in this directory
2. Follow the format:
   ```markdown
   ---
   name: agent-name
   description: Clear description of when to use (include PROACTIVELY if auto-use)
   tools: List, Of, Tools
   model: sonnet
   ---

   Detailed system prompt...
   ```
3. Test with explicit invocation
4. Update this README

## Related Documentation

- Main project: `../README.md`
- Design system: `../docs/DESIGN_SYSTEM.md`
- Component library: `../docs/COMPONENT_LIBRARY.md`
- Architecture: `../docs/ARCHITECTURE.md`

## Support

For issues or suggestions:
1. Check agent's .md file for its intended behavior
2. Try explicit invocation to confirm agent works
3. Modify agent prompt if needed for your specific use case

---

**Last Updated**: January 2026
**CityServe Version**: 1.0 MVP
**Total Agents**: 12
**Claude Code Version**: Latest
