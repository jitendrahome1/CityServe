//
//  Animations.swift
//  CityServe
//
//  Design System - Animation Timing & Easing
//  Based on UrbanNest Design System
//

import SwiftUI

// MARK: - Animation Timing

struct Animations {

    // MARK: - Duration Constants

    /// Instant - 0.1s
    /// Usage: Hover states, micro-interactions
    static let instant: Double = 0.1

    /// Fast - 0.2s
    /// Usage: Button presses, toggles, switches
    static let fast: Double = 0.2

    /// Normal - 0.3s (Default)
    /// Usage: Most UI transitions, view changes
    static let normal: Double = 0.3

    /// Slow - 0.5s
    /// Usage: Modal presentations, complex animations
    static let slow: Double = 0.5

    /// Very Slow - 0.8s
    /// Usage: Major screen transitions, emphasis
    static let verySlow: Double = 0.8

    // MARK: - Easing Curves

    /// Linear easing (no acceleration)
    /// Usage: Loading spinners, progress bars
    static let linear = Animation.linear

    /// Ease in - starts slow, accelerates
    /// Usage: Exits, hiding elements
    static let easeIn = Animation.easeIn(duration: normal)

    /// Ease out - starts fast, decelerates
    /// Usage: Entrances, showing elements
    static let easeOut = Animation.easeOut(duration: normal)

    /// Ease in-out - slow start and end, fast middle
    /// Usage: Most transitions (default)
    static let easeInOut = Animation.easeInOut(duration: normal)

    /// Spring - bouncy, natural feeling
    /// Usage: Interactive elements, delightful moments
    static let spring = Animation.spring(
        response: 0.4,
        dampingFraction: 0.7,
        blendDuration: 0
    )

    /// Smooth spring - subtle bounce
    /// Usage: Cards, modals, gentle transitions
    static let smoothSpring = Animation.spring(
        response: 0.5,
        dampingFraction: 0.8,
        blendDuration: 0
    )

    /// Bouncy spring - pronounced bounce
    /// Usage: Success states, confirmations, delight
    static let bouncySpring = Animation.spring(
        response: 0.3,
        dampingFraction: 0.6,
        blendDuration: 0
    )

    // MARK: - Common Animations

    /// Button tap animation
    static let buttonTap = Animation.easeInOut(duration: fast)

    /// Card appearance animation
    static let cardAppear = Animation.spring(
        response: 0.4,
        dampingFraction: 0.75
    )

    /// Modal presentation animation
    static let modalPresent = Animation.spring(
        response: 0.5,
        dampingFraction: 0.8
    )

    /// Tab switch animation (smooth spring for modern feel)
    static let tabSwitch = Animation.spring(
        response: 0.3,
        dampingFraction: 0.75
    )

    /// Loading animation
    static let loading = Animation.linear(duration: normal).repeatForever(autoreverses: false)

    /// Pulse animation (for notifications, alerts)
    static let pulse = Animation.easeInOut(duration: slow).repeatForever(autoreverses: true)

    /// Badge pulse animation (for membership/high-demand badges) - from designs
    static let badgePulse = Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)

    /// Card press animation (for service cards with subtle feedback)
    static let cardPress = Animation.spring(
        response: 0.25,
        dampingFraction: 0.6
    )

    /// Floating card appear animation (for elevated service cards) - from designs
    static let floatingCardAppear = Animation.spring(
        response: 0.45,
        dampingFraction: 0.75
    )

    /// Shake animation (for errors)
    static let shake = Animation.linear(duration: instant).repeatCount(3, autoreverses: true)

    // MARK: - Transition Animations

    /// Fade transition
    static let fade = AnyTransition.opacity.animation(easeInOut)

    /// Slide from bottom
    static let slideFromBottom = AnyTransition.move(edge: .bottom).animation(smoothSpring)

    /// Slide from top
    static let slideFromTop = AnyTransition.move(edge: .top).animation(smoothSpring)

    /// Slide from leading
    static let slideFromLeading = AnyTransition.move(edge: .leading).animation(easeInOut)

    /// Slide from trailing
    static let slideFromTrailing = AnyTransition.move(edge: .trailing).animation(easeInOut)

    /// Scale up (grow from center)
    static let scaleUp = AnyTransition.scale.animation(smoothSpring)

    /// Combined fade + slide from bottom
    static let fadeSlideBottom = AnyTransition.opacity
        .combined(with: .move(edge: .bottom))
        .animation(smoothSpring)

    /// Combined fade + scale
    static let fadeScale = AnyTransition.opacity
        .combined(with: .scale)
        .animation(smoothSpring)
}

// MARK: - View Extensions

extension View {

    /// Animate with fast timing
    func fastAnimation() -> some View {
        self.animation(Animations.easeInOut, value: UUID())
    }

    /// Animate with normal timing (default)
    func normalAnimation() -> some View {
        self.animation(Animations.easeInOut, value: UUID())
    }

    /// Animate with spring
    func springAnimation() -> some View {
        self.animation(Animations.spring, value: UUID())
    }

    /// Scale animation for button press
    func scaleButtonEffect(isPressed: Bool) -> some View {
        self.scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(Animations.buttonTap, value: isPressed)
    }

    /// Shake animation for errors
    func shake(trigger: Int) -> some View {
        self.modifier(ShakeEffect(shakes: trigger))
    }

    /// Pulse animation for notifications
    func pulse(isActive: Bool) -> some View {
        self.modifier(PulseEffect(isActive: isActive))
    }

    /// Shimmer loading effect
    func shimmer(isActive: Bool) -> some View {
        self.modifier(ShimmerEffect(isActive: isActive))
    }

    /// Badge pulse animation (for membership/high-demand badges)
    func badgePulse(isActive: Bool) -> some View {
        self.modifier(BadgePulseEffect(isActive: isActive))
    }

    /// Card press animation (for service cards with subtle feedback)
    func cardPressEffect(isPressed: Bool) -> some View {
        self.scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(Animations.cardPress, value: isPressed)
    }
}

// MARK: - Animation Modifiers

/// Shake effect for error states
struct ShakeEffect: GeometryEffect {
    var shakes: Int

    var animatableData: Int {
        get { shakes }
        set { shakes = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = sin(CGFloat(shakes) * .pi * 2) * 10
        return ProjectionTransform(
            CGAffineTransform(translationX: translation, y: 0)
        )
    }
}

/// Pulse effect for notifications/alerts
struct PulseEffect: ViewModifier {
    let isActive: Bool
    @State private var scale: CGFloat = 1.0

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                if isActive {
                    withAnimation(Animations.pulse) {
                        scale = 1.1
                    }
                }
            }
            .onChange(of: isActive) { newValue in
                if newValue {
                    withAnimation(Animations.pulse) {
                        scale = 1.1
                    }
                } else {
                    scale = 1.0
                }
            }
    }
}

/// Badge pulse effect for membership/high-demand badges (from designs)
struct BadgePulseEffect: ViewModifier {
    let isActive: Bool
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                if isActive {
                    withAnimation(Animations.badgePulse) {
                        scale = 1.05
                        opacity = 0.9
                    }
                }
            }
            .onChange(of: isActive) { oldValue, newValue in
                if newValue {
                    withAnimation(Animations.badgePulse) {
                        scale = 1.05
                        opacity = 0.9
                    }
                } else {
                    scale = 1.0
                    opacity = 1.0
                }
            }
    }
}

/// Shimmer loading effect
struct ShimmerEffect: ViewModifier {
    let isActive: Bool
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    if isActive {
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0),
                                Color.white.opacity(0.5),
                                Color.white.opacity(0)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: geometry.size.width * 0.3)
                        .offset(x: phase * geometry.size.width)
                        .onAppear {
                            withAnimation(Animations.loading) {
                                phase = 1.0
                            }
                        }
                    }
                }
            )
            .clipped()
    }
}

// MARK: - Button Press Animation

/// Button press state modifier
struct ButtonPressModifier: ViewModifier {
    @Binding var isPressed: Bool

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .opacity(isPressed ? 0.9 : 1.0)
            .animation(Animations.buttonTap, value: isPressed)
    }
}

extension View {
    func buttonPress(isPressed: Binding<Bool>) -> some View {
        self.modifier(ButtonPressModifier(isPressed: isPressed))
    }
}

// MARK: - Animation Documentation

/*
 Animation System
 ================

 Duration Constants:
 - Instant: 0.1s - Hover states, micro-interactions
 - Fast: 0.2s - Button presses, toggles
 - Normal: 0.3s - Most transitions (default)
 - Slow: 0.5s - Modal presentations
 - Very Slow: 0.8s - Major transitions

 Easing Curves:
 - Linear: No acceleration (loading spinners)
 - Ease In: Starts slow (exits)
 - Ease Out: Ends slow (entrances)
 - Ease In-Out: Slow start and end (most transitions)
 - Spring: Bouncy, natural (interactive elements)

 Common Animations:
 - Button Tap: Fast ease in-out
 - Card Appear: Smooth spring
 - Modal Present: Gentle spring
 - Tab Switch: Smooth spring (updated for modern feel)
 - Loading: Linear repeat forever
 - Pulse: Ease in-out repeat
 - Badge Pulse: Subtle pulse for membership/high-demand badges (NEW - from designs)
 - Card Press: Spring animation for service cards (NEW - from designs)
 - Floating Card Appear: Smooth spring for elevated cards (NEW - from designs)
 - Shake: Fast linear repeat (3x)

 Transitions:
 - Fade: Opacity change
 - Slide: From bottom/top/leading/trailing
 - Scale: Grow/shrink from center
 - Fade + Slide: Combined effect
 - Fade + Scale: Combined effect

 Usage Examples:

 ```swift
 // NEW: Badge pulse animation (membership/high-demand badges)
 Text("Plus")
     .badgePulse(isActive: true)

 // NEW: Card press animation (service cards)
 ServiceCardView()
     .cardPressEffect(isPressed: isPressed)

 // NEW: Floating card appearance
 if showCard {
     ServiceCard()
         .transition(.opacity.animation(Animations.floatingCardAppear))
 }

 // NEW: Smooth tab switching
 TabView(selection: $selectedTab) {
     // ...
 }
 .animation(Animations.tabSwitch, value: selectedTab)

 // Button press animation
 Button("Tap Me") { }
     .scaleButtonEffect(isPressed: isPressed)

 // View transition
 if showModal {
     ModalView()
         .transition(Animations.fadeSlideBottom)
 }

 // Shake on error
 TextField("Email", text: $email)
     .shake(trigger: errorCount)

 // Pulse notification badge
 Circle()
     .fill(Color.error)
     .pulse(isActive: hasNotification)

 // Shimmer loading
 Rectangle()
     .shimmer(isActive: isLoading)

 // With haptic feedback
 Button("Submit") {
     Haptics.success()
     submitForm()
 }
 .springAnimation()
 ```

 Best Practices:
 - Use spring animations for delightful, natural feel
 - Keep most animations under 0.3s for responsiveness
 - Add haptic feedback to important interactions
 - Respect user's motion preferences (reduceMotion)
 - Don't over-animate - subtle is better
 - Match animation to user action (faster tap = faster animation)

 Performance:
 - Avoid animating too many views simultaneously
 - Use .animation() modifier sparingly
 - Prefer explicit withAnimation {} blocks
 - Test on actual devices, not just simulator
 - Profile with Instruments for 60fps target

 Accessibility:
 - Respect UIAccessibility.isReduceMotionEnabled
 - Provide alternative for critical animated content
 - Ensure animations don't convey essential information
 */
