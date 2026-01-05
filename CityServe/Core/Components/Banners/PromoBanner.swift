//
//  PromoBanner.swift
//  CityServe
//
//  Promotional Banner Component
//  Design System Component - From designs
//

import SwiftUI

/// Horizontal promotional banner with customizable content
/// Usage: Home screen promotions, special offers, custom package builder CTA
struct PromoBanner: View {

    // MARK: - Properties

    let promo: PromoBannerModel
    let action: (() -> Void)?

    @State private var isPressed = false

    init(promo: PromoBannerModel, action: (() -> Void)? = nil) {
        self.promo = promo
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button(action: handleTap) {
            HStack(spacing: Spacing.md) {
                // Icon or image
                if !promo.icon.isEmpty {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 48, height: 48)

                        Image(systemName: promo.icon)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                }

                // Content
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(promo.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(2)

                    if !promo.subtitle.isEmpty {
                        Text(promo.subtitle)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.85))
                            .lineLimit(2)
                    }
                }

                Spacer()

                // Action arrow
                if action != nil {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
            }
            .padding(Spacing.md)
            .background(backgroundGradient)
            .cornerRadius(Spacing.radiusLg)
            .floatingCardShadow()
            .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if action != nil {
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

    // MARK: - Subviews

    private var backgroundGradient: some View {
        LinearGradient(
            colors: promo.gradientColors,
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    // MARK: - Actions

    private func handleTap() {
        guard action != nil else { return }
        Haptics.light()
        action?()
    }
}

// MARK: - Note
// PromoBannerModel is defined in Views/Home/HomeView.swift
// This component uses that existing model for compatibility

// MARK: - Scrollable Promo Banner List

/// Horizontal scrollable list of promotional banners
struct PromoBannerList: View {
    let promos: [PromoBannerModel]
    let onPromoTapped: ((PromoBannerModel) -> Void)?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.md) {
                ForEach(promos) { promo in
                    PromoBanner(promo: promo) {
                        onPromoTapped?(promo)
                    }
                    .frame(width: 320)
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }
}

// MARK: - Preview

#Preview("Promo Banners") {
    VStack(spacing: Spacing.lg) {
        ForEach(PromoBannerModel.mockBanners.prefix(3)) { promo in
            PromoBanner(
                promo: promo,
                action: {
                    print("Tapped: \(promo.title)")
                }
            )
        }
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
}

#Preview("Horizontal Scrollable List") {
    VStack(alignment: .leading, spacing: Spacing.md) {
        Text("Special Offers")
            .font(.sectionHeader)
            .foregroundColor(.textPrimary)
            .padding(.horizontal, Spacing.screenPadding)

        PromoBannerList(
            promos: PromoBannerModel.mockBanners,
            onPromoTapped: { promo in
                print("Tapped: \(promo.title)")
            }
        )
    }
    .background(Color.background)
}

#Preview("In Home Screen Context") {
    ScrollView {
        VStack(alignment: .leading, spacing: Spacing.xl) {
            // Search
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Search for services")
                Spacer()
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .padding(.horizontal, Spacing.screenPadding)

            // Membership banner
            MembershipBanner()
                .padding(.horizontal, Spacing.screenPadding)

            // Promo banners
            VStack(alignment: .leading, spacing: Spacing.sm) {
                PromoBannerList(
                    promos: Array(PromoBannerModel.mockBanners.prefix(3)),
                    onPromoTapped: { _ in }
                )
            }

            // Categories
            Text("Personal Services")
                .font(.sectionHeader)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)
        }
        .padding(.vertical, Spacing.lg)
    }
    .background(Color.background)
}

#Preview("Promo Banners Dark Mode") {
    VStack(spacing: Spacing.lg) {
        ForEach(PromoBannerModel.mockBanners.prefix(3)) { promo in
            PromoBanner(promo: promo, action: { })
        }
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
    .preferredColorScheme(.dark)
}
