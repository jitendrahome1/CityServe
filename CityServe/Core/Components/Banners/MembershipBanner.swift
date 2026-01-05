//
//  MembershipBanner.swift
//  CityServe
//
//  Plus Membership Banner Component
//  Design System Component - From designs
//

import SwiftUI

/// Purple gradient banner showing Plus membership benefits
/// Usage: Home screen, service detail screens
struct MembershipBanner: View {

    // MARK: - Properties

    var title: String = "Plus"
    var subtitle: String = "Save 15% on every service"
    var showCloseButton: Bool = false
    var onTap: (() -> Void)? = nil
    var onClose: (() -> Void)? = nil

    @State private var isPressed = false

    // MARK: - Body

    var body: some View {
        Button(action: handleTap) {
            HStack(spacing: Spacing.md) {
                // Plus badge icon
                ZStack {
                    Circle()
                        .fill(Color.membershipGold)
                        .frame(width: 40, height: 40)

                    Text("P")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }

                // Content
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    HStack(spacing: Spacing.xxs) {
                        Text(title)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)

                        Image(systemName: "crown.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.membershipGold)
                    }

                    Text(subtitle)
                        .font(.bodySmall)
                        .foregroundColor(.white.opacity(0.9))
                }

                Spacer()

                // Arrow or close button
                if showCloseButton {
                    Button(action: handleClose) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                            .frame(width: 28, height: 28)
                    }
                    .buttonStyle(PlainButtonStyle())
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .padding(Spacing.md)
            .background(
                LinearGradient(
                    colors: [
                        Color(hex: "#6C5CE7"),  // Purple
                        Color(hex: "#A29BFE")   // Light Purple
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(Spacing.radiusLg)
            .floatingCardShadow()
            .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if onTap != nil {
                        withAnimation(Animations.cardPress) {
                            isPressed = true
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation(Animations.cardPress) {
                        isPressed = false
                    }
                }
        )
    }

    // MARK: - Actions

    private func handleTap() {
        guard onTap != nil else { return }
        Haptics.light()
        onTap?()
    }

    private func handleClose() {
        Haptics.light()
        onClose?()
    }
}

// MARK: - Preview

#Preview("Membership Banner") {
    VStack(spacing: Spacing.lg) {
        // Default
        MembershipBanner(
            onTap: {
                print("Tapped banner")
            }
        )

        // With close button
        MembershipBanner(
            showCloseButton: true,
            onTap: {
                print("Tapped banner")
            },
            onClose: {
                print("Closed banner")
            }
        )

        // Custom text
        MembershipBanner(
            title: "Become a Plus Member",
            subtitle: "Exclusive benefits and savings await",
            onTap: {
                print("Tapped")
            }
        )

        // No action (non-interactive)
        MembershipBanner(
            title: "Plus",
            subtitle: "You're saving 15% on this order"
        )
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
}

#Preview("In Home Screen Context") {
    ScrollView {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.textSecondary)
                Text("Search for services")
                    .foregroundColor(.textTertiary)
                Spacer()
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)

            // Membership banner
            MembershipBanner(
                onTap: {
                    print("Navigate to Plus membership")
                }
            )

            // Categories section
            Text("Personal Services")
                .font(.sectionHeader)
                .foregroundColor(.textPrimary)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible()), count: 4),
                spacing: Spacing.gridItemSpacing
            ) {
                ForEach(0..<4) { _ in
                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                        .fill(Color.neutralGray)
                        .frame(height: 80)
                }
            }
        }
        .padding(Spacing.screenPadding)
    }
    .background(Color.background)
}

#Preview("Membership Banner Dark Mode") {
    VStack(spacing: Spacing.lg) {
        MembershipBanner(
            onTap: { print("Tapped") }
        )

        MembershipBanner(
            showCloseButton: true,
            onClose: { print("Closed") }
        )
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
    .preferredColorScheme(.dark)
}
