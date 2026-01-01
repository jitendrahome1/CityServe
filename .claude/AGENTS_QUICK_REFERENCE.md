# Claude Code Agents - Quick Reference

> **TL;DR**: Just describe your problem naturally, and Claude will use the right agent automatically.

## 🚀 Quick Examples

| What You Say | Agent Used | What It Does |
|--------------|------------|--------------|
| "Set up Firebase" | firebase-integrator | Integrates Firebase services |
| "Replace mock data" | firebase-integrator | Migrates to Firebase backend |
| "Build is failing" | ios-builder | Fixes compilation errors |
| "Review my code" | swiftui-reviewer | Checks SwiftUI best practices |
| "App is crashing" | ios-debugger | Debugs runtime issues |
| "Run the tests" | test-runner | Runs and fixes tests |
| "Check design system" | design-enforcer | Validates UI consistency |
| "Fix my ViewModel" | viewmodel-expert | Reviews MVVM patterns |

## 📋 Agent Cheat Sheet

### 🔥 firebase-integrator
**Use for**: Firebase setup, backend integration, replacing mock data
**Model**: Sonnet (smart)
**Tools**: Read, Edit, Bash, Grep, Glob

**Handles**:
- ✅ Firebase Authentication (Phone, Email, Google)
- ✅ Firestore Database integration
- ✅ Cloud Storage setup
- ✅ Cloud Functions connection
- ✅ Firebase Cloud Messaging (FCM)
- ✅ Mock data to production migration

---

### 🔨 ios-builder
**Use for**: Build errors, compilation failures, parameter issues
**Model**: Sonnet (smart)
**Tools**: Read, Edit, Bash, Grep, Glob

**Common fixes**:
- ✅ Missing `import Combine`
- ✅ Button parameter order (title first, action last)
- ✅ EmptyStateView `description` vs `message`
- ✅ ServiceCardModel missing parameters
- ✅ Swift compiler timeouts

---

### 🎨 swiftui-reviewer
**Use for**: Code review, best practices, accessibility
**Model**: Sonnet (smart)
**Tools**: Read, Grep, Glob (read-only)

**Checks for**:
- ✅ Proper use of @State, @StateObject, @ObservedObject
- ✅ Performance issues
- ✅ Accessibility labels
- ✅ Design system compliance
- ✅ Code organization

---

### 📱 viewmodel-expert
**Use for**: ViewModels, Combine, @Published properties
**Model**: Sonnet (smart)
**Tools**: Read, Edit, Grep, Glob

**Ensures**:
- ✅ `@MainActor` on ViewModels
- ✅ `import Combine` present
- ✅ Proper MVVM separation
- ✅ Correct async/await patterns
- ✅ State management best practices

---

### 🐛 ios-debugger
**Use for**: Crashes, runtime errors, memory leaks
**Model**: Sonnet (smart)
**Tools**: Read, Edit, Bash, Grep, Glob

**Debugs**:
- ✅ Force unwrap crashes
- ✅ Memory leaks (retain cycles)
- ✅ Navigation issues
- ✅ View not updating
- ✅ Thread safety problems

---

### 🧪 test-runner
**Use for**: Running tests, test failures, coverage
**Model**: Sonnet (smart)
**Tools**: Read, Edit, Bash, Grep, Glob

**Handles**:
- ✅ Running xcodebuild tests
- ✅ Analyzing test failures
- ✅ Writing new tests
- ✅ Improving test coverage
- ✅ Debugging flaky tests

---

### 🎨 design-enforcer
**Use for**: UI consistency, design system compliance
**Model**: Haiku (fast & cheap)
**Tools**: Read, Grep, Glob (read-only)

**Validates**:
- ✅ No hardcoded colors
- ✅ Spacing constants used
- ✅ Typography extensions
- ✅ Component patterns
- ✅ Dark mode support

## 💡 Usage Patterns

### Automatic (Recommended)
```
> Fix the build errors
> My app is crashing on profile screen
> Check if my code follows best practices
```

### Explicit
```
> Use ios-builder to fix compilation errors
> Ask swiftui-reviewer to check my HomeView
> Have test-runner run all unit tests
```

### Chained
```
> First use ios-builder to fix build, then test-runner to verify tests
> Use swiftui-reviewer for code review, then design-enforcer for UI
```

## 🎯 Common Workflows

### After Writing Code
1. **ios-builder** - Ensure it compiles
2. **swiftui-reviewer** - Check best practices
3. **design-enforcer** - Validate design system
4. **test-runner** - Run tests

### When Debugging
1. **ios-debugger** - Identify root cause
2. **ios-builder** - Fix compilation if needed
3. **test-runner** - Add regression test

### Before Commit
1. **swiftui-reviewer** - Final code review
2. **test-runner** - All tests passing
3. **design-enforcer** - UI consistency check

### Backend Integration
1. **firebase-integrator** - Set up Firebase services
2. **ios-builder** - Fix any compilation issues
3. **test-runner** - Test integration
4. **swiftui-reviewer** - Review code changes

## 📝 Project-Specific Patterns

### Button Usage
```swift
// ✅ Correct
PrimaryButton(
    "Submit",           // Unlabeled title
    icon: "checkmark",
    action: { }         // Action LAST
)

// ❌ Wrong
PrimaryButton(
    title: "Submit",    // Should be unlabeled
    action: { },        // Should be last
    icon: "checkmark"
)
```

### EmptyStateView
```swift
// ✅ Correct
EmptyStateView(
    icon: "star",
    title: "No Items",
    description: "Add some items"  // description!
)

// ❌ Wrong
EmptyStateView(
    icon: "star",
    title: "No Items",
    message: "Add some items"  // Should be 'description'
)
```

### ViewModels
```swift
// ✅ Correct
import Combine  // REQUIRED!

@MainActor  // REQUIRED for UI ViewModels
class MyViewModel: ObservableObject {
    @Published var data: [Item] = []
}

// ❌ Wrong - Missing imports and @MainActor
class MyViewModel: ObservableObject {
    @Published var data: [Item] = []  // Compile error!
}
```

### Design System
```swift
// ✅ Correct
Text("Hello")
    .foregroundColor(.primary)
    .padding(Spacing.md)
    .h2Style()

// ❌ Wrong - Hardcoded values
Text("Hello")
    .foregroundColor(Color.blue)
    .padding(16)
    .font(.system(size: 24))
```

## 🔍 Troubleshooting

| Problem | Solution |
|---------|----------|
| Agent not auto-invoked | Be more specific in request |
| Wrong agent used | Use explicit invocation |
| Agent changes too much | Review changes, narrow scope |
| Need multiple agents | Chain them explicitly |

## 🚨 Emergency Fixes

### Build Broken
```
> Use ios-builder to fix all compilation errors
```

### App Crashing
```
> Use ios-debugger to investigate the crash in [FileName]
```

### Tests Failing
```
> Use test-runner to run tests and fix failures
```

### Design Review Failed
```
> Use design-enforcer to find all design system violations
```

## 📚 More Info

- Full documentation: `.claude/agents/README.md`
- Individual agents: `.claude/agents/*.md`
- Design system: `docs/DESIGN_SYSTEM.md`
- Component library: `docs/COMPONENT_LIBRARY.md`

## 🎓 Pro Tips

1. **Be specific**: "Fix build errors" > "Something's wrong"
2. **Chain agents**: Complex workflows benefit from multiple agents
3. **Review outputs**: Understand what agents change and why
4. **Customize agents**: Edit `.md` files to tune behavior
5. **Use haiku agents**: For simple checks (faster, cheaper)

---

**Remember**: You don't need to memorize this. Just describe what you need, and Claude will pick the right agent! 🚀
