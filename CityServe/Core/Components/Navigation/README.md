# Custom Navigation System

A modern, animated navigation system for SwiftUI with smooth transitions, gesture support, and customizable navigation bars.

## Features

✨ **Smooth Animations**: Multiple transition styles (slide, fade, scale, slideUp, hero)
🎨 **Custom Navigation Bar**: Modern bar with gradient/blur/solid/transparent styles
👆 **Gesture Support**: Swipe-to-go-back with haptic feedback
🎯 **Easy Integration**: Simple API similar to standard SwiftUI navigation
⚡ **Performance**: 60fps animations with proper timing curves
🌙 **Dark Mode**: Full support for light and dark themes

## Components

### 1. NavigationTransition
Defines transition animation styles:
- `.slide` - Standard slide from right (iOS default)
- `.fade` - Fade in/out
- `.scale` - Scale up from center
- `.slideUp` - Slide up from bottom (modal style)
- `.hero` - Hero animation with shared element
- `.none` - No animation

### 2. CustomNavigationBar
Modern navigation bar with customizable styles:
- **Styles**: `.gradient`, `.blur`, `.solid`, `.transparent`
- **Features**: Back button, title, trailing actions
- **Animations**: Smooth title fade-in on appear

### 3. CustomNavigationStack
Container for managing navigation with custom transitions:
- Gesture-driven navigation (swipe to go back)
- Stack management (push, pop, popToRoot)
- Smooth animated transitions

### 4. CustomNavigationLink
Declarative navigation link component:
- Card-style links
- Hero animation links
- Simple text links

## Usage

### Basic Setup

Replace `NavigationStack` with `CustomNavigationStack` in your root view:

```swift
// Before (Standard Navigation)
NavigationStack {
    HomeView()
}

// After (Custom Navigation)
CustomNavigationStack {
    HomeView()
}
```

### Using CustomNavigationBar

```swift
struct MyView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                title: "My Screen",
                showBackButton: true,
                backAction: { navigator.pop() },
                trailingActions: [
                    NavigationAction(icon: "heart", action: { }),
                    NavigationAction(icon: "square.and.arrow.up", action: { })
                ],
                style: .gradient
            )

            // Your content here
        }
    }
}
```

### Using CustomNavigationContainer

Convenient wrapper that combines navigation bar with content:

```swift
CustomNavigationContainer(
    title: "Service Detail",
    backAction: { navigator.pop() },
    trailingActions: [
        NavigationAction(icon: "heart", action: { })
    ],
    barStyle: .gradient
) {
    // Your content here
    Text("Service Details")
}
```

### Programmatic Navigation

```swift
struct HomeView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator

    var body: some View {
        VStack {
            // Push with custom transition
            Button("Go to Detail") {
                navigator.push(DetailView(), transition: .slide)
            }

            // Different transition styles
            Button("Fade Transition") {
                navigator.push(AnotherView(), transition: .fade)
            }

            Button("Scale Transition") {
                navigator.push(ThirdView(), transition: .scale)
            }

            // Pop operations
            Button("Go Back") {
                navigator.pop()
            }

            Button("Go to Root") {
                navigator.popToRoot()
            }
        }
    }
}
```

### Using CustomNavigationLink

```swift
// Simple text link
CustomNavigationLink("Go to Settings", transition: .slide) {
    SettingsView()
}

// Card-style link
CustomNavigationCard(
    imageName: "house.fill",
    title: "Home Services",
    subtitle: "20+ services available",
    badge: "Popular",
    transition: .slide
) {
    ServiceDetailView()
}

// Hero animation link
HeroNavigationLink(heroTag: "serviceImage") {
    ServiceDetailView()
} label: {
    ServiceCard(service: service)
}
```

## Navigation Styles

### Gradient (Default)
```swift
CustomNavigationBar(title: "My View", style: .gradient)
```
- Modern gradient background with primary color
- White text color
- Best for colorful, branded screens

### Blur
```swift
CustomNavigationBar(title: "My View", style: .blur)
```
- Frosted glass effect
- Adapts to content behind it
- Best for overlays and dynamic content

### Solid
```swift
CustomNavigationBar(title: "My View", style: .solid)
```
- Solid color background
- Clean and simple
- Best for standard screens

### Transparent
```swift
CustomNavigationBar(title: "My View", style: .transparent)
```
- No background
- Content shows through
- Best for custom layouts

## Transition Styles

### Slide (Default)
```swift
navigator.push(view, transition: .slide)
```
Standard iOS-style slide from right with spring animation.

### Fade
```swift
navigator.push(view, transition: .fade)
```
Smooth fade in/out transition.

### Scale
```swift
navigator.push(view, transition: .scale)
```
Scale up from center, great for detail views.

### SlideUp
```swift
navigator.push(view, transition: .slideUp)
```
Modal-style slide up from bottom.

### Hero
```swift
navigator.push(view, transition: .hero)
```
Hero animation with shared elements.

## Gesture Support

The custom navigation stack includes built-in swipe-to-go-back gesture:
- Swipe from left edge to go back
- Automatic haptic feedback
- Threshold-based activation (100pt)

## Integration with Existing Views

### Migrating from Standard NavigationStack

**Before:**
```swift
NavigationStack {
    HomeView()
        .navigationDestination(for: Service.self) { service in
            ServiceDetailView(service: service)
        }
}
```

**After:**
```swift
CustomNavigationStack {
    HomeView()
}

// In HomeView:
@EnvironmentObject var navigator: NavigationStackCoordinator

CustomNavigationLink(transition: .slide) {
    ServiceDetailView(service: service)
} label: {
    ServiceCard(service: service)
}
```

## Best Practices

1. **Use appropriate transitions**:
   - `.slide` for standard navigation
   - `.fade` for lightweight transitions
   - `.scale` for detail views
   - `.slideUp` for modal-like presentations

2. **Consistent navigation bar style**:
   - Use `.gradient` for main screens
   - Use `.blur` for overlays
   - Use `.transparent` for custom layouts

3. **Haptic feedback**:
   - Already included in all navigation actions
   - Enhances user experience

4. **Performance**:
   - All animations are optimized for 60fps
   - Uses spring animations for natural feel

## Example Project

See `CustomNavigationExampleView.swift` for a complete working example with:
- Home screen with categories
- Service cards with different transitions
- Provider cards with hero animations
- Nested navigation flows
- Different navigation bar styles

## Troubleshooting

### "Missing EnvironmentObject" error
Make sure your root view is wrapped in `CustomNavigationStack`:
```swift
CustomNavigationStack {
    YourRootView()
}
```

### Gestures not working
Ensure you're using `CustomNavigationStack` and not mixing with standard `NavigationStack`.

### Animations choppy
Check that you're running on a real device or using a simulator with sufficient performance.

## Performance Tips

1. Limit the number of views in the navigation stack
2. Use `.popToRoot()` to clear the stack when appropriate
3. Avoid complex view hierarchies in transition animations
4. Use `.hero` transition sparingly for best performance

## Design System Integration

The custom navigation system fully integrates with the existing CityServe design system:
- Uses `Color` extensions (primary, secondary, surface, etc.)
- Uses `Typography` (h1, h2, body, etc.)
- Uses `Spacing` (xs, md, lg, screenPadding, etc.)
- Uses `Haptics` for feedback
- Supports dark mode automatically

---

**Created for CityServe (UrbanNest)**
Version 1.0 - January 2026
