//
//  Spacing.swift
//  CityServe
//
//  Design System - Spacing System (8pt Grid)
//  Based on UrbanNest Design System
//

import SwiftUI

// MARK: - Spacing Constants

/// Design system spacing based on 8pt grid
struct Spacing {

    // MARK: - Base Units

    /// Tight spacing - 4pt
    static let xxs: CGFloat = 4

    /// Base unit - 8pt
    static let xs: CGFloat = 8

    /// Small spacing - 12pt
    static let sm: CGFloat = 12

    /// Medium spacing - 16pt
    static let md: CGFloat = 16

    /// Large spacing - 24pt
    static let lg: CGFloat = 24

    /// Extra large spacing - 32pt
    static let xl: CGFloat = 32

    /// Extra extra large spacing - 48pt
    static let xxl: CGFloat = 48

    /// Massive spacing - 64pt
    static let xxxl: CGFloat = 64

    // MARK: - Semantic Spacing

    /// Padding inside buttons, cards
    static let padding = md // 16pt

    /// Margin between elements
    static let margin = md // 16pt

    /// Gap between list items
    static let listGap = md // 16pt

    /// Gap between sections
    static let sectionGap = lg // 24pt

    /// Screen edge padding
    static let screenPadding = md // 16pt

    /// Card padding
    static let cardPadding = md // 16pt

    /// Card content padding - tighter for dense layouts (from designs)
    static let cardContentPadding: CGFloat = 12

    /// Grid gap (horizontal)
    static let gridGapX = sm // 12pt

    /// Grid gap (vertical)
    static let gridGapY = md // 16pt

    /// Grid item spacing - for category grids (from designs)
    static let gridItemSpacing = md // 16pt

    /// Section header spacing - specific spacing for section headers (from designs)
    static let sectionHeaderSpacing: CGFloat = 20

    // MARK: - Component Spacing

    /// Spacing between icon and text in buttons
    static let iconTextGap = xs // 8pt

    /// Spacing between form fields
    static let formFieldGap = md // 16pt

    /// Spacing between label and input
    static let labelInputGap = xs // 8pt

    /// Spacing for pill/tag items
    static let pillGap = xs // 8pt

    /// Spacing between rating stars
    static let ratingStarGap: CGFloat = 2

    // MARK: - Touch Targets

    /// Minimum touch target size (iOS HIG)
    static let minTouchTarget: CGFloat = 44

    /// Recommended touch target size
    static let touchTarget: CGFloat = 48

    // MARK: - Border Radius

    /// Small radius - 4pt
    static let radiusSm: CGFloat = 4

    /// Medium radius - 8pt
    static let radiusMd: CGFloat = 8

    /// Large radius - 12pt
    static let radiusLg: CGFloat = 12

    /// Extra large radius - 16pt
    static let radiusXl: CGFloat = 16

    /// Pill radius - 999pt (fully rounded)
    static let radiusPill: CGFloat = 999

    // MARK: - Safe Area Insets

    /// Standard safe area bottom inset (home indicator)
    static let safeAreaBottom: CGFloat = 34

    /// Standard safe area top inset (status bar + notch)
    static let safeAreaTop: CGFloat = 47

    // MARK: - Common Dimensions

    /// Standard button height
    static let buttonHeight: CGFloat = 48

    /// Small button height
    static let buttonHeightSmall: CGFloat = 36

    /// Large button height
    static let buttonHeightLarge: CGFloat = 56

    /// Text field height
    static let textFieldHeight: CGFloat = 48

    /// Search bar height
    static let searchBarHeight: CGFloat = 44

    /// Tab bar height
    static let tabBarHeight: CGFloat = 49

    /// Navigation bar height
    static let navigationBarHeight: CGFloat = 44

    /// Card elevation (shadow offset)
    static let cardElevation: CGFloat = 2

    /// Bottom sheet corner radius
    static let bottomSheetRadius: CGFloat = 24

    // MARK: - Avatar Sizes

    /// Extra small avatar - 24pt
    static let avatarXS: CGFloat = 24

    /// Small avatar - 32pt
    static let avatarSM: CGFloat = 32

    /// Medium avatar - 40pt
    static let avatarMD: CGFloat = 40

    /// Large avatar - 56pt
    static let avatarLG: CGFloat = 56

    /// Extra large avatar - 72pt
    static let avatarXL: CGFloat = 72

    /// Massive avatar - 96pt
    static let avatarXXL: CGFloat = 96

    // MARK: - Icon Sizes

    /// Extra small icon - 12pt
    static let iconXS: CGFloat = 12

    /// Small icon - 16pt
    static let iconSM: CGFloat = 16

    /// Medium icon - 20pt
    static let iconMD: CGFloat = 20

    /// Large icon - 24pt
    static let iconLG: CGFloat = 24

    /// Extra large icon - 32pt
    static let iconXL: CGFloat = 32

    /// Service category icon - 40pt
    static let iconService: CGFloat = 40
}

// MARK: - Edge Insets Extension

extension EdgeInsets {

    /// Zero insets
    static let zero = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

    /// Screen edge insets (16pt all sides)
    static let screen = EdgeInsets(
        top: Spacing.screenPadding,
        leading: Spacing.screenPadding,
        bottom: Spacing.screenPadding,
        trailing: Spacing.screenPadding
    )

    /// Card insets (16pt all sides)
    static let card = EdgeInsets(
        top: Spacing.cardPadding,
        leading: Spacing.cardPadding,
        bottom: Spacing.cardPadding,
        trailing: Spacing.cardPadding
    )

    /// Button insets (12pt horizontal, 16pt vertical)
    static let button = EdgeInsets(
        top: Spacing.sm,
        leading: Spacing.md,
        bottom: Spacing.sm,
        trailing: Spacing.md
    )

    /// List item insets (12pt vertical, 16pt horizontal)
    static let listItem = EdgeInsets(
        top: Spacing.sm,
        leading: Spacing.md,
        bottom: Spacing.sm,
        trailing: Spacing.md
    )

    /// Bottom sheet insets with safe area
    static let bottomSheet = EdgeInsets(
        top: Spacing.lg,
        leading: Spacing.md,
        bottom: Spacing.safeAreaBottom + Spacing.md,
        trailing: Spacing.md
    )
}

// MARK: - View Extensions

extension View {

    /// Apply screen edge padding (16pt all sides)
    func screenPadding() -> some View {
        self.padding(Spacing.screenPadding)
    }

    /// Apply card padding (16pt all sides)
    func cardPadding() -> some View {
        self.padding(Spacing.cardPadding)
    }

    /// Apply section gap (24pt vertical)
    func sectionSpacing() -> some View {
        self.padding(.vertical, Spacing.sectionGap)
    }

    /// Apply list item gap (16pt vertical)
    func listItemSpacing() -> some View {
        self.padding(.vertical, Spacing.listGap)
    }

    /// Apply corner radius from design system
    func cornerRadius(_ radius: Spacing.Radius) -> some View {
        self.cornerRadius(radius.value)
    }

    /// Apply frame with minimum touch target
    func touchTargetFrame(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        self.frame(
            minWidth: width ?? Spacing.minTouchTarget,
            minHeight: height ?? Spacing.minTouchTarget
        )
    }
}

// MARK: - Radius Enum

extension Spacing {
    enum Radius {
        case small    // 4pt
        case medium   // 8pt
        case large    // 12pt
        case extraLarge // 16pt
        case pill     // 999pt

        var value: CGFloat {
            switch self {
            case .small: return Spacing.radiusSm
            case .medium: return Spacing.radiusMd
            case .large: return Spacing.radiusLg
            case .extraLarge: return Spacing.radiusXl
            case .pill: return Spacing.radiusPill
            }
        }
    }
}

// MARK: - Spacing Documentation

/*
 Spacing System (8pt Grid)
 =========================

 Base Units:
 - XXS: 4pt  - Tight spacing
 - XS: 8pt   - Base unit
 - SM: 12pt  - Small spacing
 - MD: 16pt  - Medium spacing (default)
 - LG: 24pt  - Large spacing
 - XL: 32pt  - Extra large spacing
 - XXL: 48pt - Extra extra large spacing
 - XXXL: 64pt - Massive spacing

 Semantic Usage:
 - Padding: 16pt (inside elements)
 - Margin: 16pt (between elements)
 - Section Gap: 24pt (between major sections)
 - Screen Padding: 16pt (edge to edge)
 - Card Content Padding: 12pt (tighter for dense layouts)
 - Section Header Spacing: 20pt (for section titles)
 - Grid Item Spacing: 16pt (for category grids)

 Border Radius:
 - Small: 4pt - Tags, badges
 - Medium: 8pt - Buttons, inputs
 - Large: 12pt - Cards
 - Extra Large: 16pt - Modals, bottom sheets
 - Pill: 999pt - Fully rounded (pills, avatars)

 Common Dimensions:
 - Button Height: 48pt (standard), 36pt (small), 56pt (large)
 - Text Field Height: 48pt
 - Tab Bar Height: 49pt
 - Navigation Bar: 44pt

 Avatar Sizes:
 - XS: 24pt
 - SM: 32pt
 - MD: 40pt
 - LG: 56pt
 - XL: 72pt
 - XXL: 96pt

 Icon Sizes:
 - XS: 12pt
 - SM: 16pt
 - MD: 20pt
 - LG: 24pt
 - XL: 32pt
 - Service: 40pt

 Usage Examples:

 ```swift
 // Using spacing constants
 VStack(spacing: Spacing.md) {
     Text("Title")
     Text("Content")
 }
 .padding(Spacing.screenPadding)

 // Using view extensions
 VStack {
     Text("Content")
 }
 .screenPadding()
 .cardPadding()

 // Using border radius
 Rectangle()
     .cornerRadius(Spacing.radiusLg)

 // Or with enum
 Rectangle()
     .cornerRadius(.large)

 // Touch target
 Button("Tap") { }
     .touchTargetFrame()

 // Edge insets
 HStack {
     Text("Item")
 }
 .padding(.screen)
 ```

 Accessibility:
 - All touch targets minimum 44x44pt
 - Spacing scales with Dynamic Type
 - Maintains visual hierarchy at all sizes
 */
