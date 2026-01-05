//
//  IconButton.swift
//  CityServe
//
//  Icon-only Button Component
//  Design System Component
//

import SwiftUI

/// Icon-only button for navigation, actions, utility functions
/// Usage: Back buttons, close buttons, favorite, share, more options
struct IconButton: View {

    // MARK: - Properties

    let icon: String
    let action: () -> Void

    var style: IconButtonStyle = .ghost
    var size: IconSize = .medium
    var isDisabled: Bool = false
    var accessibilityLabel: String? = nil

    @State private var isPressed = false

    // MARK: - Icon Button Styles

    enum IconButtonStyle {
        case ghost        // No background
        case filled       // Primary color background
        case outlined     // Border with transparent background
        case subtle       // Light gray background

        var backgroundColor: Color {
            switch self {
            case .ghost: return .clear
            case .filled: return .primary
            case .outlined: return .clear
            case .subtle: return Color.neutralGray
            }
        }

        var iconColor: Color {
            switch self {
            case .ghost: return .textPrimary
            case .filled: return .white
            case .outlined: return .primary
            case .subtle: return .textPrimary
            }
        }

        var borderColor: Color? {
            switch self {
            case .outlined: return .primary
            default: return nil
            }
        }
    }

    // MARK: - Icon Sizes

    enum IconSize {
        case small, medium, large

        var dimension: CGFloat {
            switch self {
            case .small: return 36
            case .medium: return 44
            case .large: return 56
            }
        }

        var iconSize: CGFloat {
            switch self {
            case .small: return Spacing.iconMD
            case .medium: return Spacing.iconLG
            case .large: return Spacing.iconXL
            }
        }
    }

    // MARK: - Initializer

    init(
        _ icon: String,
        style: IconButtonStyle = .ghost,
        size: IconSize = .medium,
        isDisabled: Bool = false,
        accessibilityLabel: String? = nil,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.style = style
        self.size = size
        self.isDisabled = isDisabled
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button(action: handleTap) {
            Image(systemName: icon)
                .font(.system(size: size.iconSize, weight: .medium))
                .foregroundColor(iconColor)
                .frame(width: size.dimension, height: size.dimension)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                        .stroke(
                            style.borderColor ?? Color.clear,
                            lineWidth: style.borderColor != nil ? 2 : 0
                        )
                )
                .cornerRadius(Spacing.radiusLg)  // More rounded (12pt instead of 8pt)
                .scaleEffect(isPressed ? 0.92 : 1.0)  // Slightly less dramatic for icon buttons
                .opacity(isDisabled ? 0.5 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
        .accessibilityLabel(accessibilityLabel ?? "")
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(Animations.buttonTap) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(Animations.buttonTap) {
                        isPressed = false
                    }
                }
        )
    }

    // MARK: - Computed Properties

    private var iconColor: Color {
        if isDisabled {
            return Color.textDisabled
        }
        return style.iconColor
    }

    private var backgroundColor: Color {
        if isPressed && style == .ghost {
            return Color.neutralGray
        }
        if isPressed && style == .subtle {
            return Color.neutralGray.opacity(0.7)
        }
        return style.backgroundColor
    }

    // MARK: - Actions

    private func handleTap() {
        guard !isDisabled else { return }

        Haptics.light()
        action()
    }
}

// MARK: - Preview

#Preview("Icon Button Styles") {
    VStack(spacing: Spacing.xl) {
        HStack(spacing: Spacing.lg) {
            VStack(spacing: Spacing.sm) {
                IconButton("xmark", style: .ghost) {
                    print("Close")
                }
                Text("Ghost")
                    .captionStyle()
            }

            VStack(spacing: Spacing.sm) {
                IconButton("heart.fill", style: .filled) {
                    print("Favorite")
                }
                Text("Filled")
                    .captionStyle()
            }

            VStack(spacing: Spacing.sm) {
                IconButton("share", style: .outlined) {
                    print("Share")
                }
                Text("Outlined")
                    .captionStyle()
            }

            VStack(spacing: Spacing.sm) {
                IconButton("ellipsis", style: .subtle) {
                    print("More")
                }
                Text("Subtle")
                    .captionStyle()
            }
        }

        Divider()

        // Sizes
        HStack(spacing: Spacing.lg) {
            VStack(spacing: Spacing.sm) {
                IconButton("arrow.left", style: .filled, size: .small) {
                    print("Back")
                }
                Text("Small")
                    .captionStyle()
            }

            VStack(spacing: Spacing.sm) {
                IconButton("arrow.left", style: .filled, size: .medium) {
                    print("Back")
                }
                Text("Medium")
                    .captionStyle()
            }

            VStack(spacing: Spacing.sm) {
                IconButton("arrow.left", style: .filled, size: .large) {
                    print("Back")
                }
                Text("Large")
                    .captionStyle()
            }
        }

        Divider()

        // Common use cases
        HStack(spacing: Spacing.lg) {
            IconButton("arrow.left", style: .ghost, accessibilityLabel: "Back") {
                print("Back")
            }

            IconButton("xmark", style: .ghost, accessibilityLabel: "Close") {
                print("Close")
            }

            IconButton("heart", style: .ghost, accessibilityLabel: "Favorite") {
                print("Favorite")
            }

            IconButton("share", style: .ghost, accessibilityLabel: "Share") {
                print("Share")
            }

            IconButton("ellipsis", style: .subtle, accessibilityLabel: "More options") {
                print("More")
            }
        }

        // Disabled
        IconButton("bell.fill", style: .filled, isDisabled: true) {
            print("Notifications")
        }
    }
    .padding(Spacing.screenPadding)
}

#Preview("Icon Button Dark Mode") {
    VStack(spacing: Spacing.lg) {
        HStack(spacing: Spacing.lg) {
            IconButton("xmark", style: .ghost) {
                print("Close")
            }

            IconButton("heart.fill", style: .filled) {
                print("Favorite")
            }

            IconButton("share", style: .outlined) {
                print("Share")
            }

            IconButton("ellipsis", style: .subtle) {
                print("More")
            }
        }
    }
    .padding(Spacing.screenPadding)
    .preferredColorScheme(.dark)
}
