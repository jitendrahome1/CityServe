# 02 - Onboarding

**Screen ID:** 02
**Screen Name:** Onboarding (3 Slides)
**User Flow:** First app launch → After splash screen
**Duration:** User-controlled (can skip anytime)
**Next Screen:** Phone Registration

---

## Overview

The onboarding experience introduces new users to UrbanNest's core value proposition through 3 engaging slides. Each slide highlights a key benefit: discovering services, easy booking, and reliable service delivery.

**Purpose:**
- Communicate app's value proposition quickly
- Set user expectations
- Build trust and excitement
- Guide users to registration
- Reduce drop-off with skip option

**Key Principles:**
- Simple, visual storytelling
- Benefit-focused (not feature-focused)
- Quick to complete (< 30 seconds)
- Skippable at any time
- Consistent with brand identity

---

## ASCII Wireframe

### Slide 1: Discover Services

```
┌────────────────────────────────────────┐
│                         Skip >         │ ← Skip button (top right)
├────────────────────────────────────────┤
│                                        │
│                                        │
│          [Illustration 1]              │ ← Illustration
│         Person browsing                 │   280x240pt
│         services on phone               │
│                                        │
│                                        │
│                                        │
├────────────────────────────────────────┤
│                                        │
│      Discover Trusted Services         │ ← Title (H2)
│                                        │
│   Find expert professionals for all    │ ← Description
│   your home service needs in one app   │   (Body text)
│                                        │
│                                        │
│            ⚫ ⚪ ⚪                      │ ← Page indicator
│                                        │
│                                        │
│          [Next Button]                 │ ← Primary CTA
│        or swipe to continue            │   48pt height
│                                        │
└────────────────────────────────────────┘
```

### Slide 2: Easy Booking

```
┌────────────────────────────────────────┐
│                         Skip >         │
├────────────────────────────────────────┤
│                                        │
│                                        │
│          [Illustration 2]              │
│        Calendar + clock with           │
│           checkmark                    │
│                                        │
│                                        │
│                                        │
├────────────────────────────────────────┤
│                                        │
│        Book in Just 3 Steps            │
│                                        │
│    Select service, choose time, and    │
│      confirm. It's that simple!        │
│                                        │
│                                        │
│            ⚪ ⚫ ⚪                      │
│                                        │
│                                        │
│          [Next Button]                 │
│                                        │
│                                        │
└────────────────────────────────────────┘
```

### Slide 3: Reliable Service

```
┌────────────────────────────────────────┐
│                                        │ ← No skip (last slide)
├────────────────────────────────────────┤
│                                        │
│                                        │
│          [Illustration 3]              │
│        Person relaxing while           │
│       service professional works       │
│                                        │
│                                        │
│                                        │
├────────────────────────────────────────┤
│                                        │
│      Sit Back & Relax                  │
│                                        │
│   Track your service in real-time      │
│      and enjoy quality results         │
│                                        │
│                                        │
│            ⚪ ⚪ ⚫                      │
│                                        │
│                                        │
│      [Get Started Button]              │ ← Primary CTA
│                                        │
│                                        │
└────────────────────────────────────────┘
```

---

## Layout Specifications

### Screen Dimensions
```
Device: iPhone 14 (390x844pt)
Safe Area Top: 47pt
Safe Area Bottom: 34pt
Content Area: 390x763pt
```

### Skip Button (Top Right)
```
Position: Top right, 16pt from edge, 16pt from top safe area
Text: "Skip"
Font: SF Pro Medium 16pt
Color: #666666 (gray), #0D7377 on tap (primary)
Touch Target: 44x44pt minimum
Visibility: Visible on slides 1 & 2, hidden on slide 3
```

### Illustration Area
```
Position: Top section, centered
Height: 320pt (including padding)
Padding: 48pt top, 24pt sides
Content Size: 280x240pt (illustration itself)
Background: White (#FFFFFF)
```

### Content Section
```
Position: Below illustration
Padding: 32pt horizontal, 24pt vertical
Background: White (#FFFFFF)
```

### Title
```
Font: Inter SemiBold 24pt
Color: #1E1E1E (gray900)
Line Height: 1.3 (31pt)
Alignment: Center
Max Width: 326pt (full width - 64pt)
Margin Bottom: 12pt
```

### Description
```
Font: SF Pro Regular 16pt
Color: #666666 (gray600)
Line Height: 1.5 (24pt)
Alignment: Center
Max Width: 326pt
Min Height: 72pt (3 lines)
```

### Page Indicator
```
Position: Below description, centered
Dots: 3 total
Dot Size: 8pt diameter (inactive), 20x8pt pill (active)
Gap: 8pt between dots
Active Color: #0D7377 (primary)
Inactive Color: #E0E0E0 (gray200)
Margin: 24pt top, 24pt bottom
```

### CTA Button
```
Text: "Next" (slides 1-2), "Get Started" (slide 3)
Style: Primary Button (Large)
Height: 48pt
Width: Full width - 64pt margins (326pt)
Margin: 0pt top, 32pt bottom
Shadow: Level 1
```

---

## Component Breakdown

### 1. Skip Button
```
Component: Text Button
Touch Target: 44x44pt
Padding: 12pt vertical, 16pt horizontal
Alignment: Top trailing

States:
├─ Default: Color #666666
├─ Pressed: Color #0D7377, opacity 0.8
└─ Hidden: On slide 3 (final slide)

Interaction:
├─ Tap: Skip all slides, go directly to Phone Registration
├─ Animation: Fade out slides, slide in registration (300ms)
└─ Haptic: Light impact
```

### 2. Illustration Image
```
Component: Image (SVG or PNG)
Size: 280x240pt
Assets:
├─ Slide 1: Onboarding-1-Discover.svg
├─ Slide 2: Onboarding-2-Book.svg
└─ Slide 3: Onboarding-3-Relax.svg

Style:
├─ Vector graphics (SVG preferred)
├─ Colors: Primary (#0D7377), Secondary (#FF6B35), neutrals
├─ Style: Friendly, modern, minimal illustration
└─ No text in illustrations (text is separate)

States:
└─ Loads with fade in animation
```

### 3. Title + Description Stack
```
Component: VStack (spacing: 12pt)
Alignment: Center
Content:
├─ Title (Text)
└─ Description (Text)

Animation:
└─ Slides in from bottom with fade (when slide appears)
```

### 4. Page Control (Dots)
```
Component: PageControl (UIPageControl on iOS)
Current Page: Highlighted (pill shape, primary color)
Other Pages: Dots (circle, gray)
Interactive: Yes (tap to jump to page)

States:
├─ Slide 1: Dot 1 active
├─ Slide 2: Dot 2 active
└─ Slide 3: Dot 3 active
```

### 5. Primary Button
```
Component: Primary Button (from component library)
Variants:
├─ Slide 1-2: "Next"
└─ Slide 3: "Get Started"

States:
├─ Default: Background #0D7377
├─ Pressed: Scale 0.98, background #095256
└─ Loading: Spinner (if navigating)
```

---

## Interactions & Animations

### Slide Transitions

**Swipe Gesture:**
```
Gesture: Horizontal swipe (left/right)
Threshold: 50pt minimum swipe distance
Speed: Velocity-based (fast swipe = quick transition)

Left Swipe (Next):
├─ Animation: Current slide exits left, next slide enters right
├─ Duration: 300ms
├─ Easing: Ease In Out
└─ Haptic: Light impact on slide change

Right Swipe (Previous):
├─ Animation: Current slide exits right, previous slide enters left
├─ Only on slides 2-3 (can't go back from slide 1)
└─ Same animation parameters as left swipe
```

**Next Button Tap:**
```
Action: Advance to next slide
Animation: Same as left swipe gesture
Haptic: Medium impact
Slides 1-2: Advance to next onboarding slide
Slide 3: Navigate to Phone Registration screen
```

**Page Indicator Tap:**
```
Action: Jump to specific slide
Animation: Crossfade (200ms) if adjacent, slide if not
Haptic: Light impact
Example: Tap dot 3 from slide 1 → slides fade/slide to slide 3
```

**Skip Button Tap:**
```
Action: Skip all slides, go to registration
Animation: Fade out entire onboarding (200ms), then slide in registration
Haptic: Medium impact
Analytics: Track "skip" event with last viewed slide
```

### Slide Appearance Animation

**When Each Slide Appears:**
```
Sequence:
1. Illustration: Fade in + scale (0.9 → 1.0), 400ms, ease out
2. Title: Slide up 20pt + fade in, 300ms, ease out, delay 200ms
3. Description: Slide up 20pt + fade in, 300ms, ease out, delay 300ms
4. Page indicator: Fade in, 200ms, delay 500ms
5. Button: Slide up 20pt + fade in, 300ms, ease out, delay 600ms
```

**Interactive Slide Transition (Gesture):**
```
During swipe:
├─ Current slide: Moves with finger, parallax effect
├─ Next slide: Enters from edge, follows finger
├─ Rubber-band: At first/last slide, slides slightly then bounces back
└─ Cancel: If swipe < threshold, animate back to original position
```

---

## Content Specifications

### Slide 1: Discover Services

```
Title: "Discover Trusted Services"

Description: "Find expert professionals for all your home service needs in one app"

Illustration Description:
- Person (diverse, gender-neutral) looking at phone
- Phone screen shows service categories (icons)
- Happy, engaged expression
- Modern, clean style
- Colors: Primary teal, warm orange accents

Key Message: Wide variety of services available
Emotion: Discovery, excitement
```

### Slide 2: Easy Booking

```
Title: "Book in Just 3 Steps"

Description: "Select service, choose time, and confirm. It's that simple!"

Illustration Description:
- Calendar icon with date circled
- Clock showing time selection
- Large checkmark indicating confirmation
- Visual flow arrows (1 → 2 → 3)
- Colors: Primary teal, success green

Key Message: Quick and easy process
Emotion: Simplicity, confidence
```

### Slide 3: Reliable Service

```
Title: "Sit Back & Relax"

Description: "Track your service in real-time and enjoy quality results"

Illustration Description:
- Person relaxing on couch or chair
- Service professional working in background
- Sparkles or stars indicating quality
- Peaceful, satisfied expression
- Colors: Primary teal, warm orange, success green

Key Message: Quality service, peace of mind
Emotion: Trust, satisfaction
```

---

## States

### Default State (Slide 1)
```
Display: Slide 1 visible, full content shown
Skip Button: Visible, top right
Page Indicator: Dot 1 active
CTA Button: "Next"
Gestures: Left swipe enabled, right swipe disabled
```

### Middle State (Slide 2)
```
Display: Slide 2 visible
Skip Button: Visible
Page Indicator: Dot 2 active
CTA Button: "Next"
Gestures: Both left and right swipe enabled
```

### Final State (Slide 3)
```
Display: Slide 3 visible
Skip Button: Hidden (no skip on last slide)
Page Indicator: Dot 3 active
CTA Button: "Get Started" (different text)
Gestures: Right swipe enabled, left swipe disabled
```

---

## Dark Mode

### Dark Mode Specifications

```
Background: #1E1E1E (dark)
Illustrations: Adjusted colors (lighter teal #14A0A5, maintain contrast)
Title: #E0E0E0 (light gray)
Description: #A0A0A0 (medium gray)
Skip Button: #A0A0A0 (default), #14A0A5 (pressed)
Page Indicator:
├─ Active: #14A0A5 (lighter teal)
└─ Inactive: #3A3A3A (dark gray)
CTA Button: Same as light mode (maintains brand presence)
```

---

## Accessibility

### VoiceOver

```
Slide Container:
├─ Label: "Onboarding, page 1 of 3" (updates per slide)
├─ Trait: Adjustable (can swipe to change slides)
└─ Hint: "Swipe left or right to navigate"

Skip Button:
├─ Label: "Skip onboarding"
├─ Trait: Button
└─ Hint: "Skips to registration"

Illustration:
├─ Label: Descriptive alt text (e.g., "Person discovering services")
├─ Trait: Image
└─ Hidden from VO: No (descriptive content)

Title:
├─ Label: Title text
├─ Trait: Header
└─ Level: H1

Description:
├─ Label: Description text
└─ Trait: Static text

Page Indicator:
├─ Label: "Page 1 of 3" (updates)
├─ Trait: Page indicator
└─ Actions: Swipe up/down to change pages

CTA Button:
├─ Label: "Next" or "Get Started"
├─ Trait: Button
└─ Hint: "Advances to next slide" or "Opens registration"
```

### Reduced Motion

```
If user has "Reduce Motion" enabled:
├─ Slide transitions: Instant crossfade instead of slide animation
├─ Content animations: Instant appear instead of staged fade-ins
├─ Page indicator: Instant update instead of animated
└─ Gestures: Still work, but no parallax effect
```

### Dynamic Type

```
Title: Scales with system font size (-2 to +3)
Description: Scales with system font size
Minimum: All text readable at smallest size
Maximum: Layout adjusts to accommodate larger text
Button: Text scales, maintains min 44pt touch target
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct OnboardingView: View {
    @State private var currentPage: Int = 0
    @State private var dragOffset: CGFloat = 0
    @Environment(\.dismiss) var dismiss

    let slides: [OnboardingSlide] = [
        OnboardingSlide(
            illustration: "onboarding-1-discover",
            title: "Discover Trusted Services",
            description: "Find expert professionals for all your home service needs in one app"
        ),
        OnboardingSlide(
            illustration: "onboarding-2-book",
            title: "Book in Just 3 Steps",
            description: "Select service, choose time, and confirm. It's that simple!"
        ),
        OnboardingSlide(
            illustration: "onboarding-3-relax",
            title: "Sit Back & Relax",
            description: "Track your service in real-time and enjoy quality results"
        )
    ]

    var body: some View {
        ZStack {
            // Background
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Skip Button
                if currentPage < slides.count - 1 {
                    HStack {
                        Spacer()
                        Button("Skip") {
                            skipOnboarding()
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray600)
                        .padding(.trailing, 16)
                        .padding(.top, 16)
                    }
                } else {
                    Spacer()
                        .frame(height: 60)
                }

                // Slides (TabView with PageTabViewStyle)
                TabView(selection: $currentPage) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        OnboardingSlideView(slide: slides[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)

                // Page Indicator
                PageIndicator(
                    currentPage: $currentPage,
                    numberOfPages: slides.count
                )
                .padding(.vertical, 24)

                // CTA Button
                PrimaryButton(
                    title: currentPage == slides.count - 1 ? "Get Started" : "Next",
                    action: nextAction
                )
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
            }
        }
        .accessibilityLabel("Onboarding, page \(currentPage + 1) of \(slides.count)")
    }

    private func nextAction() {
        if currentPage < slides.count - 1 {
            withAnimation {
                currentPage += 1
            }
        } else {
            completeOnboarding()
        }
    }

    private func skipOnboarding() {
        // Analytics: Track skip event
        Analytics.track("onboarding_skipped", properties: [
            "last_page_viewed": currentPage + 1
        ])

        // Navigate to registration
        dismiss()
    }

    private func completeOnboarding() {
        // Analytics: Track completion
        Analytics.track("onboarding_completed")

        // Mark onboarding as seen (UserDefaults or similar)
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")

        // Navigate to registration
        dismiss()
    }
}

struct OnboardingSlideView: View {
    let slide: OnboardingSlide
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 24) {
            // Illustration
            Image(slide.illustration)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 280, height: 240)
                .scaleEffect(isAnimating ? 1.0 : 0.9)
                .opacity(isAnimating ? 1.0 : 0.0)
                .padding(.top, 48)
                .padding(.horizontal, 24)

            Spacer()
                .frame(height: 32)

            // Title
            Text(slide.title)
                .font(.custom("Inter-SemiBold", size: 24))
                .foregroundColor(.gray900)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 326)
                .offset(y: isAnimating ? 0 : 20)
                .opacity(isAnimating ? 1.0 : 0.0)

            // Description
            Text(slide.description)
                .font(.system(size: 16))
                .foregroundColor(.gray600)
                .multilineTextAlignment(.center)
                .lineSpacing(8)
                .frame(maxWidth: 326)
                .frame(minHeight: 72)
                .offset(y: isAnimating ? 0 : 20)
                .opacity(isAnimating ? 1.0 : 0.0)

            Spacer()
        }
        .onAppear {
            // Staggered animations
            withAnimation(.easeOut(duration: 0.4)) {
                isAnimating = true
            }
        }
    }
}

struct OnboardingSlide {
    let illustration: String
    let title: String
    let description: String
}

struct PageIndicator: View {
    @Binding var currentPage: Int
    let numberOfPages: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                if index == currentPage {
                    // Active (pill shape)
                    Capsule()
                        .fill(Color.brandPrimary)
                        .frame(width: 20, height: 8)
                        .transition(.scale)
                } else {
                    // Inactive (dot)
                    Circle()
                        .fill(Color.gray200)
                        .frame(width: 8, height: 8)
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: currentPage)
    }
}
```

---

## Assets Required

### Illustrations

```
1. Onboarding-1-Discover.svg / .png
   - Size: @1x: 280x240pt, @2x: 560x480px, @3x: 840x720px
   - Content: Person browsing services on phone
   - Style: Friendly, modern, minimal
   - Colors: #0D7377, #FF6B35, neutrals
   - Format: SVG (preferred) or PNG with transparency

2. Onboarding-2-Book.svg / .png
   - Size: Same as above
   - Content: Calendar + clock + checkmark flow
   - Style: Consistent with slide 1
   - Colors: #0D7377, #28C76F

3. Onboarding-3-Relax.svg / .png
   - Size: Same as above
   - Content: Person relaxing, professional working
   - Style: Consistent with slides 1-2
   - Colors: #0D7377, #FF6B35, #28C76F
```

---

## Navigation Flow

### Entry Points
```
- From Splash Screen (first app launch)
- From Settings → "View Onboarding Again"
```

### Exit Points
```
Skip Button (Slides 1-2):
└─ Navigate to: Phone Registration Screen
   └─ Transition: Fade + slide right (300ms)

Get Started Button (Slide 3):
└─ Navigate to: Phone Registration Screen
   └─ Transition: Slide up (300ms)

Completion:
└─ Set flag: UserDefaults "hasCompletedOnboarding" = true
└─ Analytics: Track completion/skip
```

---

## Analytics Events

```
Events to Track:
├─ onboarding_started (when view appears)
├─ onboarding_page_viewed (page: 1/2/3)
├─ onboarding_skipped (last_page: 1/2)
├─ onboarding_completed (all slides viewed)
├─ onboarding_next_tapped (from_page: 1/2)
└─ onboarding_get_started_tapped

Metrics to Monitor:
├─ Completion rate (completed / started)
├─ Skip rate (skipped / started)
├─ Average time spent per slide
└─ Drop-off by slide
```

---

## Testing Checklist

- [ ] All 3 slides display correctly
- [ ] Swipe gestures work (left/right)
- [ ] Skip button appears on slides 1-2 only
- [ ] Skip button navigates to registration
- [ ] Page indicator updates correctly
- [ ] Tapping page dots jumps to correct slide
- [ ] Next button advances slides
- [ ] Get Started button appears on slide 3
- [ ] Get Started navigates to registration
- [ ] Illustrations load and display properly
- [ ] Animations smooth (60fps)
- [ ] Dark mode looks good
- [ ] VoiceOver navigation works
- [ ] Reduced motion respected
- [ ] Dynamic Type scales properly
- [ ] Works on all device sizes
- [ ] Can't swipe back from slide 1
- [ ] Can't swipe forward from slide 3
- [ ] Onboarding marked as completed after finish
- [ ] Analytics events firing correctly

---

## Design Rationale

**Why this approach:**
- **3 Slides**: Quick overview without overwhelming, optimal for mobile
- **Benefit-Focused**: "What's in it for me" rather than features
- **Visual Storytelling**: Illustrations convey concepts faster than text
- **Skippable**: Respects user time, reduces friction
- **Simple Navigation**: Swipe or tap, familiar mobile pattern
- **Consistent Layout**: Same structure per slide = predictable, easy to scan
- **Progressive CTAs**: "Next" → "Get Started" guides user journey
- **Page Indicator**: Clear progress, allows jumping

**Best Practices:**
- Keep text minimal (< 15 words per description)
- Use illustrations, not screenshots (more timeless)
- Make skip prominent (builds trust)
- No auto-advance (user controls pace)
- Maintain brand colors consistently

---

**This onboarding experience balances conveying value with respecting user time. It should feel quick, engaging, and build excitement for using the app.**
