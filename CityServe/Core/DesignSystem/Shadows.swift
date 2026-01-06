//
//  Shadows.swift
//  CityServe
//
//  Design System - Shadow Styles
//  Based on UrbanNest Design System
//

import SwiftUI

// MARK: - Shadow Styles

struct Shadows {

    // MARK: - Shadow Definitions

    /// Subtle shadow - minimal elevation for flat design
    /// Offset: 0 1px, Radius: 2px, Opacity: 0.05
    /// Usage: Flat cards, list items, minimal elevation (from designs)
    static let subtle = Shadow(
        color: .black,
        radius: 2,
        x: 0,
        y: 1,
        opacity: 0.05
    )

    /// Small shadow - subtle elevation
    /// Offset: 0 2px, Radius: 4px, Opacity: 0.08
    /// Usage: Buttons, small cards, tags
    static let small = Shadow(
        color: .black,
        radius: 4,
        x: 0,
        y: 2,
        opacity: 0.08
    )

    /// Floating card shadow - elevated cards in booking flow
    /// Offset: 0 3px, Radius: 6px, Opacity: 0.10
    /// Usage: Service cards, booking summary cards, elevated content (from designs)
    static let floatingCard = Shadow(
        color: .black,
        radius: 6,
        x: 0,
        y: 3,
        opacity: 0.10
    )

    /// Medium shadow - standard elevation
    /// Offset: 0 4px, Radius: 8px, Opacity: 0.10
    /// Usage: Cards, modals, dropdowns
    static let medium = Shadow(
        color: .black,
        radius: 8,
        x: 0,
        y: 4,
        opacity: 0.10
    )

    /// Large shadow - prominent elevation
    /// Offset: 0 8px, Radius: 16px, Opacity: 0.12
    /// Usage: Floating action buttons, popovers, tooltips
    static let large = Shadow(
        color: .black,
        radius: 16,
        x: 0,
        y: 8,
        opacity: 0.12
    )

    /// Extra large shadow - maximum elevation
    /// Offset: 0 12px, Radius: 24px, Opacity: 0.15
    /// Usage: Modals, bottom sheets, overlays
    static let extraLarge = Shadow(
        color: .black,
        radius: 24,
        x: 0,
        y: 12,
        opacity: 0.15
    )

    /// Button pressed shadow - subtle inset feel
    /// Offset: 0 1px, Radius: 2px, Opacity: 0.08
    /// Usage: Button pressed state
    static let pressed = Shadow(
        color: .black,
        radius: 2,
        x: 0,
        y: 1,
        opacity: 0.08
    )

    /// No shadow
    static let none = Shadow(
        color: .clear,
        radius: 0,
        x: 0,
        y: 0,
        opacity: 0
    )
}

// MARK: - Shadow Model

struct Shadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    let opacity: Double

    /// Initialize with default black color
    init(
        color: Color = .black,
        radius: CGFloat,
        x: CGFloat = 0,
        y: CGFloat = 0,
        opacity: Double
    ) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
        self.opacity = opacity
    }
}

// MARK: - View Extensions

extension View {

    /// Apply subtle shadow (minimal elevation for flat design)
    func subtleShadow() -> some View {
        self.shadow(
            color: Shadows.subtle.color.opacity(Shadows.subtle.opacity),
            radius: Shadows.subtle.radius,
            x: Shadows.subtle.x,
            y: Shadows.subtle.y
        )
    }

    /// Apply small shadow (subtle elevation)
    func smallShadow() -> some View {
        self.shadow(
            color: Shadows.small.color.opacity(Shadows.small.opacity),
            radius: Shadows.small.radius,
            x: Shadows.small.x,
            y: Shadows.small.y
        )
    }

    /// Apply floating card shadow (elevated cards in booking flow)
    func floatingCardShadow() -> some View {
        self.shadow(
            color: Shadows.floatingCard.color.opacity(Shadows.floatingCard.opacity),
            radius: Shadows.floatingCard.radius,
            x: Shadows.floatingCard.x,
            y: Shadows.floatingCard.y
        )
    }

    /// Apply medium shadow (standard elevation)
    func mediumShadow() -> some View {
        self.shadow(
            color: Shadows.medium.color.opacity(Shadows.medium.opacity),
            radius: Shadows.medium.radius,
            x: Shadows.medium.x,
            y: Shadows.medium.y
        )
    }

    /// Apply large shadow (prominent elevation)
    func largeShadow() -> some View {
        self.shadow(
            color: Shadows.large.color.opacity(Shadows.large.opacity),
            radius: Shadows.large.radius,
            x: Shadows.large.x,
            y: Shadows.large.y
        )
    }

    /// Apply extra large shadow (maximum elevation)
    func extraLargeShadow() -> some View {
        self.shadow(
            color: Shadows.extraLarge.color.opacity(Shadows.extraLarge.opacity),
            radius: Shadows.extraLarge.radius,
            x: Shadows.extraLarge.x,
            y: Shadows.extraLarge.y
        )
    }

    /// Apply pressed shadow (subtle inset feel)
    func pressedShadow() -> some View {
        self.shadow(
            color: Shadows.pressed.color.opacity(Shadows.pressed.opacity),
            radius: Shadows.pressed.radius,
            x: Shadows.pressed.x,
            y: Shadows.pressed.y
        )
    }

    /// Apply custom shadow from Shadow model
    func customShadow(_ shadow: Shadow) -> some View {
        self.shadow(
            color: shadow.color.opacity(shadow.opacity),
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }

    /// Apply card shadow (medium shadow with corner radius)
    func cardShadow(radius: CGFloat = Spacing.radiusLg) -> some View {
        self
            .background(Color.surface)
            .cornerRadius(radius)
            .mediumShadow()
    }
}

// MARK: - Elevation Levels

/// Semantic elevation levels for consistent z-ordering
enum Elevation: Int {
    case flat = 0           // No shadow
    case raised = 1         // Small shadow
    case floating = 2       // Medium shadow
    case overlay = 3        // Large shadow
    case modal = 4          // Extra large shadow

    var shadow: Shadow {
        switch self {
        case .flat:
            return Shadows.none
        case .raised:
            return Shadows.small
        case .floating:
            return Shadows.medium
        case .overlay:
            return Shadows.large
        case .modal:
            return Shadows.extraLarge
        }
    }
}

extension View {
    /// Apply elevation level
    func elevation(_ level: Elevation) -> some View {
        self.customShadow(level.shadow)
    }
}

// MARK: - Shadow Documentation

/*
 Shadow System
 =============

 Shadow Levels (updated for modern, subtle design):

 1. Subtle Shadow (NEW - from designs)
    - Offset: 0 1px
    - Radius: 2px
    - Opacity: 0.05
    - Usage: Flat cards, list items, minimal elevation
    - Elevation: Barely visible, flat design

 2. Small Shadow
    - Offset: 0 2px
    - Radius: 4px
    - Opacity: 0.08 (reduced from 0.1)
    - Usage: Buttons, small cards, tags
    - Elevation: Subtle, barely noticeable

 3. Floating Card Shadow (NEW - from designs)
    - Offset: 0 3px
    - Radius: 6px
    - Opacity: 0.10
    - Usage: Service cards, booking summary cards, elevated content
    - Elevation: Light elevation for cards

 4. Medium Shadow (Default)
    - Offset: 0 4px
    - Radius: 8px
    - Opacity: 0.10 (reduced from 0.12)
    - Usage: Cards, modals, dropdowns
    - Elevation: Standard, clearly elevated

 5. Large Shadow
    - Offset: 0 8px
    - Radius: 16px
    - Opacity: 0.12 (reduced from 0.15)
    - Usage: FABs, popovers, tooltips
    - Elevation: Prominent, floating above

 6. Extra Large Shadow
    - Offset: 0 12px
    - Radius: 24px
    - Opacity: 0.15 (reduced from 0.18)
    - Usage: Modals, bottom sheets, overlays
    - Elevation: Maximum, clearly separated

 7. Pressed Shadow
    - Offset: 0 1px
    - Radius: 2px
    - Opacity: 0.08
    - Usage: Button pressed state
    - Elevation: Reduced, pressed down

 Semantic Elevation:
 - Flat (0): No shadow
 - Raised (1): Small shadow
 - Floating (2): Medium shadow
 - Overlay (3): Large shadow
 - Modal (4): Extra large shadow

 Usage Examples:

 ```swift
 // Using new shadow extensions (from designs)

 // Subtle shadow for flat cards
 Rectangle()
     .frame(width: 200, height: 100)
     .subtleShadow()

 // Floating card shadow for service cards
 VStack {
     Text("Service Card")
 }
 .floatingCardShadow()

 // Using existing shadow extensions
 Rectangle()
     .frame(width: 200, height: 100)
     .smallShadow()

 // Card with shadow
 VStack {
     Text("Card Content")
 }
 .cardShadow()

 // Custom shadow
 Circle()
     .customShadow(Shadows.floatingCard)

 // Elevation levels
 VStack {
     Text("Elevated content")
 }
 .elevation(.floating)

 // Button states
 Button("Press Me") { }
     .mediumShadow() // Normal
     .pressedShadow() // When pressed
 ```

 Dark Mode:
 - Shadows are automatically dimmed in dark mode
 - System handles shadow color adaptation
 - Consider reducing shadow intensity in dark mode

 Performance:
 - Shadows can impact performance if overused
 - Use sparingly on scrolling content
 - Prefer single shadow over multiple layered shadows
 - Consider using borders instead for simple elevation

 Accessibility:
 - Shadows are decorative only
 - Don't rely on shadows for critical information
 - Ensure sufficient color contrast regardless of shadow
 */
