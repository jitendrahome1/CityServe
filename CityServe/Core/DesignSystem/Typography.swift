//
//  Typography.swift
//  CityServe
//
//  Design System - Typography System
//  Based on UrbanNest Design System
//

import SwiftUI

// MARK: - Font Styles

extension Font {

    // MARK: - Display Fonts (Hero/Splash)

    /// Display XL - Extra large display text (splash screens, hero sections)
    /// Inter Bold, 80pt
    static let displayXL = Font.custom("Inter-Bold", size: 80)

    /// Display Large - Large display text (onboarding, confirmation screens)
    /// Inter Bold, 72pt
    static let displayLarge = Font.custom("Inter-Bold", size: 72)

    /// Display Medium - Medium display text (promotional screens)
    /// Inter Bold, 60pt
    static let displayMedium = Font.custom("Inter-Bold", size: 60)

    /// Display Small - Small display text (mini hero sections)
    /// Inter SemiBold, 56pt
    static let displaySmall = Font.custom("Inter-SemiBold", size: 56)

    // MARK: - Headings

    /// H1 - Large titles, hero text
    /// Inter Bold, 32pt, 1.2 line height
    static let h1 = Font.custom("Inter-Bold", size: 32)

    /// H2 - Section titles
    /// Inter SemiBold, 24pt, 1.3 line height
    static let h2 = Font.custom("Inter-SemiBold", size: 24)

    /// H3 - Subsection titles
    /// Inter SemiBold, 20pt, 1.3 line height
    static let h3 = Font.custom("Inter-SemiBold", size: 20)

    /// H4 - Card titles
    /// Inter Medium, 18pt, 1.4 line height
    static let h4 = Font.custom("Inter-Medium", size: 18)

    /// H5 - List item titles
    /// Inter Medium, 16pt, 1.4 line height
    static let h5 = Font.custom("Inter-Medium", size: 16)

    // MARK: - Body Text

    /// Body Large - Large readable text
    /// SF Pro Regular, 16pt, 1.5 line height
    static let bodyLarge = Font.system(size: 16, weight: .regular, design: .default)

    /// Body - Default body text
    /// SF Pro Regular, 14pt, 1.5 line height
    static let body = Font.system(size: 14, weight: .regular, design: .default)

    /// Body Small - Compact body text
    /// SF Pro Regular, 12pt, 1.4 line height
    static let bodySmall = Font.system(size: 12, weight: .regular, design: .default)

    /// Caption - Smallest text
    /// SF Pro Regular, 11pt, 1.3 line height
    static let caption = Font.system(size: 11, weight: .regular, design: .default)

    // MARK: - Special Purpose

    /// Button Text - All button labels
    /// Inter SemiBold, 16pt
    static let button = Font.custom("Inter-SemiBold", size: 16)

    /// Button Small - Small button labels
    /// Inter SemiBold, 14pt
    static let buttonSmall = Font.custom("Inter-SemiBold", size: 14)

    /// Input - Text field input
    /// SF Pro Regular, 14pt
    static let input = Font.system(size: 14, weight: .regular, design: .default)

    /// Label - Form field labels
    /// Inter Medium, 13pt
    static let label = Font.custom("Inter-Medium", size: 13)

    /// Price - Price displays
    /// Inter Bold, 20pt
    static let price = Font.custom("Inter-Bold", size: 20)

    /// Price Small - Compact price displays
    /// Inter SemiBold, 16pt
    static let priceSmall = Font.custom("Inter-SemiBold", size: 16)

    /// Rating - Star ratings text
    /// Inter Medium, 13pt
    static let rating = Font.custom("Inter-Medium", size: 13)

    /// Tag - Pill/tag labels
    /// Inter Medium, 12pt
    static let tag = Font.custom("Inter-Medium", size: 12)

    /// Badge - Small badges and indicators (similar to tag)
    /// Inter Medium, 11pt
    static let badge = Font.custom("Inter-Medium", size: 11)

    /// Section Header - For section titles in lists
    /// Inter SemiBold, 14pt
    static let sectionHeader = Font.custom("Inter-SemiBold", size: 14)

    /// Price Label - Prominent price displays (larger than standard price)
    /// Inter Bold, 24pt
    static let priceLabel = Font.custom("Inter-Bold", size: 24)

    /// Code - Monospaced text (IDs, codes)
    /// SF Mono Regular, 12pt
    static let code = Font.system(size: 12, weight: .regular, design: .monospaced)

    // MARK: - Font Weights

    /// Font weight enum for consistent usage
    enum FontWeight {
        case regular // 400
        case medium  // 500
        case semiBold // 600
        case bold    // 700

        var weight: SwiftUI.Font.Weight {
            switch self {
            case .regular: return .regular
            case .medium: return .medium
            case .semiBold: return .semibold
            case .bold: return .bold
            }
        }
    }
}

// MARK: - Text Modifiers

extension Text {

    /// Apply H1 heading style
    func h1Style() -> Text {
        self
            .font(.h1)
            .foregroundColor(.textPrimary)
    }

    /// Apply H2 heading style
    func h2Style() -> Text {
        self
            .font(.h2)
            .foregroundColor(.textPrimary)
    }

    /// Apply H3 heading style
    func h3Style() -> Text {
        self
            .font(.h3)
            .foregroundColor(.textPrimary)
    }

    /// Apply H4 heading style
    func h4Style() -> Text {
        self
            .font(.h4)
            .foregroundColor(.textPrimary)
    }

    /// Apply H5 heading style
    func h5Style() -> Text {
        self
            .font(.h5)
            .foregroundColor(.textPrimary)
    }

    /// Apply body large style
    func bodyLargeStyle() -> Text {
        self
            .font(.bodyLarge)
            .foregroundColor(.textPrimary)
    }

    /// Apply body style
    func bodyStyle() -> Text {
        self
            .font(.body)
            .foregroundColor(.textPrimary)
    }

    /// Apply body small style
    func bodySmallStyle() -> Text {
        self
            .font(.bodySmall)
            .foregroundColor(.textSecondary)
    }

    /// Apply caption style
    func captionStyle() -> Text {
        self
            .font(.caption)
            .foregroundColor(.textSecondary)
    }

    /// Apply secondary text color (maintains current font)
    func secondaryText() -> Text {
        self.foregroundColor(.textSecondary)
    }

    /// Apply tertiary text color (maintains current font)
    func tertiaryText() -> Text {
        self.foregroundColor(.textTertiary)
    }

    /// Apply price style
    func priceStyle() -> Text {
        self
            .font(.price)
            .foregroundColor(.textPrimary)
    }

    /// Apply large price label style
    func priceLabelStyle() -> Text {
        self
            .font(.priceLabel)
            .foregroundColor(.textPrimary)
    }

    /// Apply badge style
    func badgeStyle() -> Text {
        self
            .font(.badge)
            .foregroundColor(.textSecondary)
    }

    /// Apply section header style
    func sectionHeaderStyle() -> Text {
        self
            .font(.sectionHeader)
            .foregroundColor(.textPrimary)
    }

    /// Apply code/monospaced style
    func codeStyle() -> Text {
        self
            .font(.code)
            .foregroundColor(.textSecondary)
    }
}

// MARK: - View Modifiers

/// Typography view modifier for consistent text styling
struct TypographyModifier: ViewModifier {
    let style: TypographyStyle

    enum TypographyStyle {
        case h1, h2, h3, h4, h5
        case bodyLarge, body, bodySmall, caption
        case button, buttonSmall
        case label, price, priceLabel, rating, tag, badge, sectionHeader, code

        var font: Font {
            switch self {
            case .h1: return .h1
            case .h2: return .h2
            case .h3: return .h3
            case .h4: return .h4
            case .h5: return .h5
            case .bodyLarge: return .bodyLarge
            case .body: return .body
            case .bodySmall: return .bodySmall
            case .caption: return .caption
            case .button: return .button
            case .buttonSmall: return .buttonSmall
            case .label: return .label
            case .price: return .price
            case .priceLabel: return .priceLabel
            case .rating: return .rating
            case .tag: return .tag
            case .badge: return .badge
            case .sectionHeader: return .sectionHeader
            case .code: return .code
            }
        }

        var lineSpacing: CGFloat {
            switch self {
            case .h1: return 8  // 1.2 line height
            case .h2: return 7  // 1.3 line height
            case .h3: return 6  // 1.3 line height
            case .h4: return 7  // 1.4 line height
            case .h5: return 6  // 1.4 line height
            case .bodyLarge: return 8  // 1.5 line height
            case .body: return 7  // 1.5 line height
            case .bodySmall: return 5  // 1.4 line height
            case .caption: return 3  // 1.3 line height
            default: return 4
            }
        }
    }

    func body(content: Content) -> some View {
        content
            .font(style.font)
            .lineSpacing(style.lineSpacing)
    }
}

extension View {
    /// Apply typography style to any view
    func typography(_ style: TypographyModifier.TypographyStyle) -> some View {
        self.modifier(TypographyModifier(style: style))
    }
}

// MARK: - Typography Documentation

/*
 Typography System
 =================

 Font Families:
 - Inter: Headings, buttons, labels (need to add to project)
 - SF Pro: Body text, inputs (system font)
 - SF Mono: Code, IDs, monospaced text

 Hierarchy:
 - H1: Inter Bold, 32pt - Large titles, hero text
 - H2: Inter SemiBold, 24pt - Section titles
 - H3: Inter SemiBold, 20pt - Subsection titles
 - H4: Inter Medium, 18pt - Card titles
 - H5: Inter Medium, 16pt - List item titles

 Body Text:
 - Body Large: SF Pro Regular, 16pt - Large readable text
 - Body: SF Pro Regular, 14pt - Default body text
 - Body Small: SF Pro Regular, 12pt - Compact text
 - Caption: SF Pro Regular, 11pt - Smallest text

 Special Purpose:
 - Button: Inter SemiBold, 16pt - Button labels
 - Price: Inter Bold, 20pt - Price displays
 - Price Label: Inter Bold, 24pt - Prominent price displays
 - Rating: Inter Medium, 13pt - Star ratings
 - Tag: Inter Medium, 12pt - Pill/tag labels
 - Badge: Inter Medium, 11pt - Small badges and indicators
 - Section Header: Inter SemiBold, 14pt - Section titles in lists
 - Code: SF Mono Regular, 12pt - IDs, codes

 Usage Examples:

 ```swift
 // Using font extensions
 Text("Welcome")
     .font(.h1)

 // Using text modifiers
 Text("Welcome")
     .h1Style()

 // Using view modifiers
 VStack {
     Text("Title")
     Text("Subtitle")
 }
 .typography(.body)

 // Price display
 Text("₹499")
     .priceStyle()

 // Secondary text
 Text("Supporting text")
     .bodyStyle()
     .secondaryText()
 ```

 Dynamic Type Support:
 - All fonts support Dynamic Type scaling
 - Text scales from -2 to +3 accessibility sizes
 - Maintain minimum touch target 44x44pt

 Setup:
 1. Add Inter font family to project:
    - Inter-Regular.ttf
    - Inter-Medium.ttf
    - Inter-SemiBold.ttf
    - Inter-Bold.ttf
 2. Add fonts to Info.plist under "Fonts provided by application"
 3. Register fonts in app initialization
 */
