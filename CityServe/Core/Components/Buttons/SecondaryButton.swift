//
//  SecondaryButton.swift
//  CityServe
//
//  Secondary Button Component - Outlined style
//  Design System Component
//

import SwiftUI

/// Secondary button - Outlined with Deep Teal border and text
/// Usage: Secondary actions, cancel, alternative choices
struct SecondaryButton: View {

    // MARK: - Properties

    let title: String
    let icon: String?
    let action: () -> Void

    var isDisabled: Bool = false
    var isLoading: Bool = false
    var fullWidth: Bool = true
    var size: PrimaryButton.ButtonSize = .large
    var style: ButtonStyle = .outlined

    @State private var isPressed = false

    // MARK: - Button Styles

    enum ButtonStyle {
        case outlined  // Border + colored text
        case ghost     // No border, colored text
    }

    // MARK: - Initializer

    init(
        _ title: String,
        icon: String? = nil,
        isDisabled: Bool = false,
        isLoading: Bool = false,
        fullWidth: Bool = true,
        size: PrimaryButton.ButtonSize = .large,
        style: ButtonStyle = .outlined,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isDisabled = isDisabled
        self.isLoading = isLoading
        self.fullWidth = fullWidth
        self.size = size
        self.style = style
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button(action: handleTap) {
            HStack(spacing: Spacing.iconTextGap) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .primary))
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
            .foregroundColor(textColor)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .frame(height: size.height)
            .padding(.horizontal, size.horizontalPadding)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .cornerRadius(Spacing.radiusLg)  // More rounded (12pt instead of 8pt)
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

    private var textColor: Color {
        if isDisabled {
            return Color.textDisabled
        }
        return Color.primary
    }

    private var backgroundColor: Color {
        if isPressed && style == .outlined {
            return Color.primary.opacity(0.05)
        }
        return Color.clear
    }

    private var borderColor: Color {
        if isDisabled {
            return Color.textDisabled
        }
        return style == .outlined ? Color.primary : Color.clear
    }

    private var borderWidth: CGFloat {
        style == .outlined ? 2 : 0
    }

    private var opacity: Double {
        isDisabled ? 0.5 : 1.0
    }

    // MARK: - Actions

    private func handleTap() {
        guard !isDisabled && !isLoading else { return }

        Haptics.light()
        action()
    }
}

// MARK: - Preview

#Preview("Secondary Button States") {
    VStack(spacing: Spacing.lg) {
        // Normal outlined
        SecondaryButton("Cancel") {
            print("Tapped")
        }

        // With icon
        SecondaryButton("Back", icon: "arrow.left") {
            print("Tapped")
        }

        // Ghost style
        SecondaryButton("Skip", style: .ghost) {
            print("Tapped")
        }

        // Loading
        SecondaryButton("Loading...", isLoading: true) {
            print("Tapped")
        }

        // Disabled
        SecondaryButton("Unavailable", isDisabled: true) {
            print("Tapped")
        }

        // Small size
        SecondaryButton("Small", size: .small) {
            print("Tapped")
        }

        // Not full width
        SecondaryButton("Compact", fullWidth: false, size: .medium) {
            print("Tapped")
        }
    }
    .padding(Spacing.screenPadding)
}

#Preview("Secondary Button Dark Mode") {
    VStack(spacing: Spacing.lg) {
        SecondaryButton("Cancel") {
            print("Tapped")
        }

        SecondaryButton("Back", icon: "arrow.left") {
            print("Tapped")
        }

        SecondaryButton("Skip", style: .ghost) {
            print("Tapped")
        }
    }
    .padding(Spacing.screenPadding)
    .preferredColorScheme(.dark)
}
