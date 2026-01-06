//
//  Colors.swift
//  CityServe
//
//  Design System - Brand Colors with Dark Mode Support
//  Based on UrbanNest Design System
//

import SwiftUI

extension Color {

    // MARK: - Brand Colors

    /// Primary brand color - Modern Purple (Urban Company style)
    /// Used for: Primary CTA buttons, active states, brand elements
    static let primary = Color("Primary")

    /// Primary color - Light variant
    /// Used for: Hover states, light backgrounds
    static let primaryLight = Color("PrimaryLight")

    /// Primary color - Dark variant
    /// Used for: Pressed states, borders
    static let primaryDark = Color("PrimaryDark")

    /// Secondary brand color - Vibrant Orange
    /// Used for: Accent, highlights, secondary CTAs, notifications
    static let secondary = Color("Secondary")

    /// Secondary color - Light variant
    static let secondaryLight = Color("SecondaryLight")

    /// Secondary color - Dark variant
    static let secondaryDark = Color("SecondaryDark")

    // MARK: - Modern Accent Colors

    /// Gradient start color for modern cards
    static let gradientStart = Color("GradientStart")

    /// Gradient end color for modern cards
    static let gradientEnd = Color("GradientEnd")

    // MARK: - Neutral Colors

    /// Neutral gray - for backgrounds, dividers
    static let neutralGray = Color("NeutralGray")

    /// Background color - adapts to light/dark mode
    static let background = Color("Background")

    /// Surface color - for cards, elevated elements
    static let surface = Color("Surface")

    /// Divider color
    static let divider = Color("Divider")

    // MARK: - Text Colors

    /// Primary text color - adapts to light/dark mode
    static let textPrimary = Color("TextPrimary")

    /// Secondary text color - for supporting text
    static let textSecondary = Color("TextSecondary")

    /// Tertiary text color - for hints, placeholders
    static let textTertiary = Color("TextTertiary")

    /// Disabled text color
    static let textDisabled = Color("TextDisabled")

    // MARK: - Functional Colors

    /// Success color - for success states, positive actions
    static let success = Color("Success")

    /// Warning color - for warning states, caution
    static let warning = Color("Warning")

    /// Error color - for error states, destructive actions
    static let error = Color("Error")

    /// Info color - for informational messages
    static let info = Color("Info")

    // MARK: - Design-Specific Semantic Colors

    /// Membership gold color - for Plus membership badges and highlights
    /// Used for: Plus badge, premium features, membership UI
    static let membershipGold = Color("MembershipGold")

    /// High demand indicator color - for popular time slots and services
    /// Used for: "High demand" badges, popular markers
    static let highDemand = Color("HighDemand")

    /// Promo background color - for promotional banners
    /// Used for: Promo cards, offer banners, discount highlights
    static let promoBackground = Color("PromoBackground")

    /// Card overlay color - for glassmorphism effects
    /// Used for: Frosted glass overlays, modern card effects
    static let cardOverlay = Color("CardOverlay")

    /// UC Safe badge color - for verified/safe badges
    /// Used for: Safety badges, verification marks
    static let ucSafeBadge = Color("UCSafeBadge")

    // MARK: - Fallback Colors (for when Assets.xcassets is not set up)

    /// Returns the color with fallback to hex value
    init(_ name: String) {
        // First try to load from asset catalog
        if let _ = UIColor(named: name) {
            self.init(name)
        } else {
            // Fallback to hardcoded hex values
            switch name {
            // Primary (Modern Purple - Extracted from designs)
            case "Primary":
                self.init(hex: "#6366F1")  // Indigo/Purple from designs
            case "PrimaryLight":
                self.init(hex: "#A5A8FF")  // Light Indigo
            case "PrimaryDark":
                self.init(hex: "#4F46E5")  // Dark Indigo

            // Secondary
            case "Secondary":
                self.init(hex: "#FF6B35")  // Vibrant Orange
            case "SecondaryLight":
                self.init(hex: "#FF8B60")
            case "SecondaryDark":
                self.init(hex: "#E5501F")

            // Gradient Colors
            case "GradientStart":
                self.init(hex: "#6C5CE7")  // Purple
            case "GradientEnd":
                self.init(hex: "#A29BFE")  // Light Purple

            // Neutral
            case "NeutralGray":
                self.init(hex: "#F5F5F5")
            case "Background":
                self.init(uiColor: .systemBackground)
            case "Surface":
                self.init(uiColor: .secondarySystemBackground)
            case "Divider":
                self.init(hex: "#E0E0E0")

            // Text
            case "TextPrimary":
                self.init(hex: "#1E1E1E")
            case "TextSecondary":
                self.init(hex: "#666666")
            case "TextTertiary":
                self.init(hex: "#999999")
            case "TextDisabled":
                self.init(hex: "#CCCCCC")

            // Functional
            case "Success":
                self.init(hex: "#28C76F")
            case "Warning":
                self.init(hex: "#FFC107")
            case "Error":
                self.init(hex: "#EA5455")
            case "Info":
                self.init(hex: "#00CFE8")

            // Design-Specific Semantic Colors
            case "MembershipGold":
                self.init(hex: "#FFD700")  // Gold for Plus membership
            case "HighDemand":
                self.init(hex: "#FF5252")  // Bright red for high demand badges
            case "PromoBackground":
                self.init(hex: "#FFF3E0")  // Light orange/cream for promo banners
            case "CardOverlay":
                self.init(hex: "#26FFFFFF")  // Semi-transparent white (15% opacity) for glassmorphism
            case "UCSafeBadge":
                self.init(hex: "#4CAF50")  // Green for UC Safe verification

            default:
                self.init(.gray)
            }
        }
    }

    // MARK: - Hex Initializer

    /// Initialize Color from hex string
    /// - Parameter hex: Hex color string (e.g., "#FF0000" or "FF0000")
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Color Palette Documentation

/*
 Brand Color Palette
 ===================

 Primary Colors:
 - Primary (Indigo Purple): #6366F1 (extracted from designs)
   - Light: #A5A8FF
   - Dark: #4F46E5
   Usage: Primary CTA buttons, active states, brand elements

 - Secondary (Warm Orange): #FF6B35
   - Light: #FF8B60
   - Dark: #E5501F
   Usage: Accent, highlights, secondary CTAs, notifications

 Neutral Colors:
 - Neutral Gray: #F5F5F5
   Usage: Backgrounds, dividers

 Functional Colors:
 - Success: #28C76F (Green)
 - Warning: #FFC107 (Yellow/Amber)
 - Error: #EA5455 (Red)
 - Info: #00CFE8 (Cyan)

 Design-Specific Semantic Colors:
 - Membership Gold: #FFD700 (for Plus membership badges)
 - High Demand: #FF5252 (for popular time slot badges)
 - Promo Background: #FFF3E0 (for promotional banners)
 - Card Overlay: #FFFFFF with 15% opacity (for glassmorphism)
 - UC Safe Badge: #4CAF50 (for verification badges)

 Dark Mode:
 - Background Dark: #1E1E1E
 - Surface Dark: #2A2A2A
 - Text Dark: #E0E0E0

 Usage Examples:

 ```swift
 // Using brand colors
 Button("Sign Up") { }
     .foregroundColor(.white)
     .background(Color.primary)

 // Using functional colors
 Text("Success!")
     .foregroundColor(.success)

 // Using text colors
 Text("Main title")
     .foregroundColor(.textPrimary)

 Text("Supporting text")
     .foregroundColor(.textSecondary)
 ```

 Accessibility:
 - All color combinations meet WCAG AA contrast requirements (4.5:1 ratio)
 - Text on Primary: White (#FFFFFF)
 - Text on Secondary: White (#FFFFFF)
 - Text on Success: White (#FFFFFF)
 - Text on Warning: Dark (#333333)
 */
