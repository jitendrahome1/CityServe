# 01 - Splash Screen

**Screen ID:** 01
**Screen Name:** Splash Screen
**User Flow:** App launch → First screen shown
**Duration:** 1-2 seconds (while loading)
**Next Screen:** Onboarding (first launch) or Home (returning user)

---

## Overview

The splash screen is the first visual element users see when launching the UrbanNest app. It displays the brand logo with a clean, professional animation while the app loads initial data and checks authentication status.

**Purpose:**
- Display brand identity
- Provide visual feedback during app initialization
- Check user authentication state
- Load critical app data (cities, configuration)
- Create a polished, premium first impression

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│                                        │
│                                        │
│                                        │
│                                        │
│                                        │
│                                        │
│            ┌──────────┐                │
│            │          │                │
│            │   [UN]   │                │ ← App Icon Logo
│            │          │                │   (120x120pt)
│            └──────────┘                │
│                                        │
│             UrbanNest                  │ ← Brand Name
│                                        │
│     Trusted services, delivered        │ ← Tagline
│              smartly                   │
│                                        │
│                                        │
│                                        │
│                                        │
│                 ⚫⚫⚫                   │ ← Loading indicator
│                                        │
│                                        │
│                                        │
│                                        │
└────────────────────────────────────────┘
```

---

## Layout Specifications

### Screen Dimensions
```
Device: iPhone 14 (390x844pt)
Safe Area Top: 47pt (status bar + notch)
Safe Area Bottom: 34pt (home indicator)
Content Area: 390x763pt
```

### Background
```
Color: Deep Teal (#0D7377)
Alternative: White (#FFFFFF) for light variant
Gradient: Optional - #0D7377 to #14A0A5 (vertical, subtle)
```

### Logo Container
```
Position: Center (horizontally and vertically)
Vertical Offset: -40pt from center (slightly above center)

Logo Icon:
├─ Size: 120x120pt
├─ Image: App icon without rounded corners (PNG)
├─ Background: White circle, 120pt diameter
├─ Shadow: 0 8px 24px rgba(0,0,0,0.15)
└─ Border: None
```

### Brand Name
```
Position: 16pt below logo icon
Text: "UrbanNest"
Font: Inter Bold, 32pt
Color: White (#FFFFFF) on teal, #1E1E1E on white background
Letter Spacing: -0.5pt
Alignment: Center
```

### Tagline
```
Position: 8pt below brand name
Text: "Trusted services, delivered smartly"
Font: SF Pro Regular, 14pt
Color: White 80% opacity on teal, #666666 on white
Alignment: Center
Max Width: 280pt (for readability)
```

### Loading Indicator
```
Position: 80pt below tagline
Type: Three animated dots or spinner
Size: 32x32pt (spinner) or 3 dots (8pt each, 8pt gap)
Color: White (#FFFFFF) on teal, #0D7377 on white
Animation: Fade in after 500ms, rotate/pulse continuously
```

---

## Component Breakdown

### 1. Logo Icon
```
Component: Image view (PNG)
Size: 120x120pt
Asset: Logo-Icon-Splash.png (@2x: 240px, @3x: 360px)
Background: White circle
Shadow: Level 3 (Large)
Border Radius: 50% (circle)

States:
└─ Default: Opacity 0, Scale 0.8 (initial)
└─ Animated: Fade in + scale to 1.0 (300ms, ease out)
```

### 2. Brand Text Stack
```
Component: VStack (spacing: 8pt)
Alignment: Center
Content:
├─ Brand Name (Text)
└─ Tagline (Text)

Animation:
└─ Fade in 100ms after logo animation completes
└─ Slide up 10pt while fading in
```

### 3. Loading Indicator
```
Component: ProgressView (iOS native) or custom dots
Style: Circular spinner or pulsing dots
Tint: White (on teal background)
Animation: Continuous rotation or pulse

States:
└─ Hidden initially
└─ Fade in after 500ms (if loading takes longer)
```

---

## Animations & Transitions

### Entry Animation Sequence

**Total Duration:** 1000ms

```
Timeline:
0ms    - Screen appears with solid background
0ms    - Logo scale: 0.8, opacity: 0
100ms  - Logo starts animation
400ms  - Logo animation complete (scale: 1.0, opacity: 1.0)
500ms  - Brand text fades in + slides up (duration: 200ms)
700ms  - Brand text animation complete
1000ms - Loading indicator appears (if still loading)
```

**Logo Animation:**
```
Duration: 300ms
Easing: Ease Out (deceleration curve)
Effect: Fade in (opacity 0 → 1) + Scale (0.8 → 1.0)
```

**Brand Text Animation:**
```
Duration: 200ms
Easing: Ease Out
Effect: Fade in + Slide up 10pt
```

**Loading Indicator Animation:**
```
Trigger: After 1000ms if still loading
Duration: Fade in 200ms
Loop: Continuous rotation (1000ms per rotation)
```

### Exit Animation

**When Loading Completes:**
```
Duration: 300ms
Easing: Ease In (acceleration curve)
Effect: Fade out entire screen (opacity 1 → 0)
Next: Navigate to Onboarding or Home screen
```

---

## States

### Loading State
```
Status: App is initializing
Visual: Logo + brand text + loading indicator (after 1s)
Duration: 1-3 seconds typical
Max Duration: 5 seconds (then show error)
```

### Success State (Authenticated User)
```
Status: User logged in, app data loaded
Next Screen: Home Screen (with tab bar)
Transition: Fade out splash → Fade in home (300ms crossfade)
```

### Success State (New User)
```
Status: First launch, no authentication
Next Screen: Onboarding Screen (3 slides)
Transition: Fade out splash → Slide in onboarding
```

### Error State (Network Failure)
```
Status: Critical data failed to load
Visual: Replace loading indicator with error message
Message: "Unable to connect. Please check your internet."
Action: "Retry" button appears
Color: Error red (#EA5455) for message
```

---

## Dark Mode

### Dark Mode Variant

```
Background: #1E1E1E (dark background)
Logo Icon: Same (white background circle)
Brand Name: #E0E0E0 (light text)
Tagline: #A0A0A0 (secondary light text)
Loading Indicator: #14A0A5 (lighter teal for visibility)
```

**Note:** Splash screen typically matches light mode even if device is in dark mode, to maintain strong brand presence. Dark mode can be applied if preferred.

---

## Accessibility

### VoiceOver
```
Logo: "UrbanNest" (label only, no "image" suffix)
Brand Text: Skipped (decorative, same as logo label)
Loading: "Loading app" (announcement)
Screen: "UrbanNest splash screen, loading"
```

### Reduced Motion
```
If user has "Reduce Motion" enabled:
├─ Logo: Instant appear (no scale animation), simple fade in
├─ Brand Text: Instant appear with logo
├─ Loading: Static dots instead of rotating spinner
└─ Exit: Instant transition (no fade)
```

### Dynamic Type
```
Not applicable: Splash screen has fixed sizes
Brand name and tagline do not scale with system font size
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct SplashView: View {
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0.0
    @State private var textOpacity: Double = 0.0
    @State private var showLoading: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            // Background
            Color.brandPrimary
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                // Logo Icon
                Image("logo-icon-splash")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .background(
                        Circle()
                            .fill(Color.white)
                            .shadow(radius: 8, y: 8)
                    )
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)

                // Brand Text
                VStack(spacing: 8) {
                    Text("UrbanNest")
                        .font(.custom("Inter-Bold", size: 32))
                        .foregroundColor(.white)
                        .tracking(-0.5)

                    Text("Trusted services, delivered smartly")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 280)
                }
                .opacity(textOpacity)

                Spacer()

                // Loading Indicator
                if showLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                        .transition(.opacity)
                }

                Spacer()
                    .frame(height: 100)
            }
        }
        .onAppear {
            animateEntrance()
            checkAuthenticationAndLoadData()
        }
        .accessibilityLabel("UrbanNest splash screen, loading")
    }

    private func animateEntrance() {
        // Logo animation
        withAnimation(.easeOut(duration: 0.3).delay(0.1)) {
            logoScale = 1.0
            logoOpacity = 1.0
        }

        // Brand text animation
        withAnimation(.easeOut(duration: 0.2).delay(0.5)) {
            textOpacity = 1.0
        }

        // Loading indicator (if still loading after 1s)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if authViewModel.isLoading {
                withAnimation {
                    showLoading = true
                }
            }
        }
    }

    private func checkAuthenticationAndLoadData() {
        Task {
            // Check if user is authenticated
            let isAuthenticated = await authViewModel.checkAuthStatus()

            // Load critical data (cities, config)
            await authViewModel.loadInitialData()

            // Wait minimum 1 second for smooth UX
            try? await Task.sleep(nanoseconds: 1_000_000_000)

            // Navigate to appropriate screen
            if isAuthenticated {
                // Navigate to Home Screen
                authViewModel.showHomeScreen()
            } else {
                // Navigate to Onboarding
                authViewModel.showOnboarding()
            }
        }
    }
}
```

### Data Loading Tasks

```swift
// In AuthViewModel
func loadInitialData() async {
    async let citiesTask = loadCities()
    async let configTask = loadAppConfig()
    async let authCheckTask = checkAuthStatus()

    // Wait for all tasks to complete
    let (cities, config, isAuth) = await (citiesTask, configTask, authCheckTask)

    // Store results
    self.availableCities = cities
    self.appConfig = config
    self.isAuthenticated = isAuth
}
```

---

## Assets Required

### Images
```
1. Logo-Icon-Splash.png
   - Size: @1x: 120x120px, @2x: 240x240px, @3x: 360x360px
   - Content: UrbanNest icon/symbol
   - Format: PNG with transparency
   - Background: Transparent (white circle added programmatically)

Optional Variants:
2. Logo-Icon-Splash-White.png (if using white background)
3. Logo-Icon-Splash-Dark.png (for dark mode, if different)
```

### Colors Used
```
From Design System:
- brandPrimary: #0D7377 (background)
- white: #FFFFFF (logo background, text)
- white80: #FFFFFF with 80% opacity (tagline)
```

---

## Navigation Flow

### Entry Points
```
- App Launch (cold start)
- App Resume from background (if session expired)
```

### Exit Points
```
If Authenticated:
└─ Navigate to: Home Screen (Tab Bar with Home selected)
   └─ Transition: Crossfade (300ms)

If Not Authenticated (First Launch):
└─ Navigate to: Onboarding Screen (Slide 1 of 3)
   └─ Transition: Slide in from right (300ms)

If Not Authenticated (Returning):
└─ Navigate to: Login Screen
   └─ Transition: Fade in (300ms)

If Error (Network Failure):
└─ Show Error State on current screen
   └─ User can tap "Retry" to reload
```

---

## Error Handling

### Network Error
```
Scenario: No internet connection on app launch

Visual Changes:
├─ Loading indicator → Error icon (xmark.circle.fill, red)
├─ Add error message below logo
│   ├─ Text: "Unable to connect"
│   ├─ Font: SF Pro Medium 16pt, #EA5455
│   └─ Alignment: Center
├─ Add secondary message
│   ├─ Text: "Please check your internet connection"
│   ├─ Font: SF Pro Regular 14pt, White 70%
│   └─ Alignment: Center
└─ Add retry button (Primary Button, white variant)
    ├─ Text: "Retry"
    ├─ Action: Reload data, restart animation
    └─ Position: 24pt below message

Error State Layout:
┌────────────────────────────────────────┐
│                                        │
│            ┌──────────┐                │
│            │   [UN]   │                │
│            └──────────┘                │
│             UrbanNest                  │
│                                        │
│                 ⊗                      │ ← Error icon
│         Unable to connect              │
│  Please check your internet connection │
│                                        │
│          [ Retry Button ]              │
│                                        │
└────────────────────────────────────────┘
```

### Timeout
```
Scenario: Loading takes longer than 10 seconds

Action: Show error state automatically
Message: "This is taking longer than expected"
Options: "Retry" or "Continue Offline" (if applicable)
```

---

## Performance Requirements

### Loading Time
```
Target: < 1 second (ideal)
Maximum: < 3 seconds (acceptable)
Timeout: 10 seconds (show error)
```

### Memory Usage
```
Splash Screen: < 50MB
Assets: < 1MB total (logo images)
```

### Frame Rate
```
Animations: 60fps (smooth)
Fallback: 30fps acceptable for older devices
```

---

## Testing Checklist

- [ ] Logo animates smoothly (scale + fade)
- [ ] Brand text appears after logo
- [ ] Loading indicator appears after 1 second (if still loading)
- [ ] Transitions to correct screen based on auth status
- [ ] Network error state displays correctly
- [ ] Retry button works and reloads data
- [ ] Dark mode variant (if implemented) looks good
- [ ] VoiceOver announces correctly
- [ ] Reduced motion respected
- [ ] Works on all device sizes (iPhone SE to Pro Max)
- [ ] Portrait and landscape orientations
- [ ] Fast app launch (< 1s on modern devices)
- [ ] No crashes or memory leaks

---

## Design Rationale

**Why this design:**
- **Centered Logo**: Creates strong brand presence, immediately recognizable
- **Deep Teal Background**: Bold, confident, matches brand identity
- **Minimal Elements**: Reduces cognitive load, feels premium
- **Smooth Animations**: Creates polished, professional feel
- **White Logo Circle**: Provides contrast, makes logo stand out
- **Loading Indicator Delay**: Avoids flash if app loads quickly (<1s)
- **Error Handling**: User-friendly recovery from network issues

**Alternatives Considered:**
- White background: Less brand impact, feels generic
- Animated logo: Risks being gimmicky, increases complexity
- Full-screen image: Increases app size, slower load time
- Skip splash: Possible but loses branding opportunity

---

**This splash screen sets the tone for the entire app experience. It should feel fast, polished, and premium while clearly communicating the UrbanNest brand identity.**
