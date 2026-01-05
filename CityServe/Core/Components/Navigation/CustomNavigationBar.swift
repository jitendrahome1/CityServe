//
//  CustomNavigationBar.swift
//  CityServe
//
//  Modern Custom Navigation Bar with Animations
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let showBackButton: Bool
    let backAction: (() -> Void)?
    var trailingActions: [NavigationAction]
    var style: NavigationBarStyle
    var hideOnScroll: Bool

    @State private var titleOpacity: Double = 0
    @State private var isPressed = false

    init(
        title: String,
        showBackButton: Bool = true,
        backAction: (() -> Void)? = nil,
        trailingActions: [NavigationAction] = [],
        style: NavigationBarStyle = .gradient,
        hideOnScroll: Bool = false
    ) {
        self.title = title
        self.showBackButton = showBackButton
        self.backAction = backAction
        self.trailingActions = trailingActions
        self.style = style
        self.hideOnScroll = hideOnScroll
    }

    var body: some View {
        ZStack {
            // Background
            backgroundView

            // Content
            HStack(spacing: Spacing.md) {
                // Leading: Back Button
                if showBackButton {
                    backButton
                } else {
                    Spacer()
                        .frame(width: 44)
                }

                // Center: Title
                Text(title)
                    .font(.h4)
                    .fontWeight(.semibold)
                    .foregroundColor(style.textColor)
                    .opacity(titleOpacity)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)

                // Trailing: Actions
                HStack(spacing: Spacing.xs) {
                    ForEach(trailingActions) { action in
                        actionButton(action)
                    }
                }
                .frame(width: 44 * CGFloat(max(1, trailingActions.count)))
            }
            .padding(.horizontal, Spacing.md)
            .frame(height: 56)
        }
        .frame(height: 56)
        .onAppear {
            withAnimation(.easeOut(duration: 0.3).delay(0.1)) {
                titleOpacity = 1
            }
        }
    }

    // MARK: - Background

    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .gradient:
            LinearGradient(
                colors: [
                    Color.primary,
                    Color.primary.opacity(0.9)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(
                Color.white.opacity(0.1)
            )

        case .blur:
            Color.clear
                .background(.ultraThinMaterial)
                .overlay(
                    Rectangle()
                        .fill(Color.primary.opacity(0.05))
                )

        case .solid:
            Color.primary

        case .transparent:
            Color.clear
        }
    }

    // MARK: - Back Button

    private var backButton: some View {
        Button(action: {
            Haptics.light()
            backAction?()
        }) {
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(style.textColor)
            }
            .frame(width: 44, height: 44)
            .contentShape(Rectangle())
        }
        .buttonStyle(ScaleButtonStyle())
    }

    // MARK: - Action Button

    private func actionButton(_ action: NavigationAction) -> some View {
        Button(action: {
            Haptics.light()
            action.action()
        }) {
            Image(systemName: action.icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(style.textColor)
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Navigation Bar Style

enum NavigationBarStyle {
    case gradient    // Gradient background (primary color)
    case blur        // Frosted glass effect
    case solid       // Solid color background
    case transparent // No background

    var textColor: Color {
        switch self {
        case .gradient, .solid:
            return .white
        case .blur, .transparent:
            return .textPrimary
        }
    }
}

// MARK: - Navigation Action

struct NavigationAction: Identifiable {
    let id = UUID()
    let icon: String
    let action: () -> Void
}

// MARK: - Scale Button Style

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.90 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Preview

#Preview("Gradient Style") {
    VStack(spacing: 0) {
        CustomNavigationBar(
            title: "Service Details",
            showBackButton: true,
            backAction: {},
            trailingActions: [
                NavigationAction(icon: "heart", action: {}),
                NavigationAction(icon: "square.and.arrow.up", action: {})
            ],
            style: .gradient
        )

        Spacer()
    }
}

#Preview("Blur Style") {
    ZStack {
        // Background content
        LinearGradient(
            colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        VStack(spacing: 0) {
            CustomNavigationBar(
                title: "Home",
                showBackButton: false,
                trailingActions: [
                    NavigationAction(icon: "bell", action: {})
                ],
                style: .blur
            )

            Spacer()
        }
    }
}

#Preview("Transparent Style") {
    VStack(spacing: 0) {
        CustomNavigationBar(
            title: "Settings",
            showBackButton: true,
            backAction: {},
            style: .transparent
        )

        Spacer()
    }
}
