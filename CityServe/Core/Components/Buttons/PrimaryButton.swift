//
//  PrimaryButton.swift
//  CityServe
//
//  Primary CTA Button Component
//  Design System Component
//

import SwiftUI

/// Primary action button - Deep Teal background, white text
/// Usage: Main CTAs, submit actions, affirmative choices
struct PrimaryButton: View {

    // MARK: - Properties

    let title: String
    let icon: String?
    let action: () -> Void

    var isDisabled: Bool = false
    var isLoading: Bool = false
    var fullWidth: Bool = true
    var size: ButtonSize = .large

    @State private var isPressed = false

    // MARK: - Button Sizes

    enum ButtonSize {
        case small, medium, large

        var height: CGFloat {
            switch self {
            case .small: return Spacing.buttonHeightSmall
            case .medium: return Spacing.buttonHeight
            case .large: return Spacing.buttonHeightLarge
            }
        }

        var font: Font {
            switch self {
            case .small: return .buttonSmall
            case .medium, .large: return .button
            }
        }

        var horizontalPadding: CGFloat {
            switch self {
            case .small: return Spacing.md
            case .medium: return Spacing.lg
            case .large: return Spacing.xl
            }
        }
    }

    // MARK: - Initializer

    init(
        _ title: String,
        icon: String? = nil,
        isDisabled: Bool = false,
        isLoading: Bool = false,
        fullWidth: Bool = true,
        size: ButtonSize = .large,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isDisabled = isDisabled
        self.isLoading = isLoading
        self.fullWidth = fullWidth
        self.size = size
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button(action: handleTap) {
            HStack(spacing: Spacing.iconTextGap) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: Spacing.iconMD))
                    }

                    Text(title)
                        .font(size.font)
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .frame(height: size.height)
            .padding(.horizontal, size.horizontalPadding)
            .background(backgroundColor)
            .cornerRadius(Spacing.radiusLg)  // More rounded (12pt instead of 8pt)
            .floatingCardShadow()  // Lighter, more modern shadow
            .scaleEffect(isPressed ? 0.98 : 1.0)  // Subtle press effect
            .opacity(opacity)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled || isLoading)
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

    private var backgroundColor: Color {
        if isDisabled {
            return Color.textDisabled
        }
        return Color.primary
    }

    private var opacity: Double {
        if isDisabled {
            return 0.5
        }
        return isPressed ? 0.9 : 1.0
    }

    // MARK: - Actions

    private func handleTap() {
        guard !isDisabled && !isLoading else { return }

        Haptics.medium()
        action()
    }
}

// MARK: - Preview

#Preview("Primary Button States") {
    VStack(spacing: Spacing.lg) {
        // Normal
        PrimaryButton("Sign Up") {
            print("Tapped")
        }

        // With icon
        PrimaryButton("Continue", icon: "arrow.right") {
            print("Tapped")
        }

        // Loading
        PrimaryButton("Processing...", isLoading: true) {
            print("Tapped")
        }

        // Disabled
        PrimaryButton("Unavailable", isDisabled: true) {
            print("Tapped")
        }

        // Small size
        PrimaryButton("Small Button", size: .small) {
            print("Tapped")
        }

        // Not full width
        PrimaryButton("Compact", fullWidth: false, size: .medium) {
            print("Tapped")
        }
    }
    .padding(Spacing.screenPadding)
}

#Preview("Primary Button Dark Mode") {
    VStack(spacing: Spacing.lg) {
        PrimaryButton("Sign Up") {
            print("Tapped")
        }

        PrimaryButton("Continue", icon: "arrow.right") {
            print("Tapped")
        }
    }
    .padding(Spacing.screenPadding)
    .preferredColorScheme(.dark)
}
