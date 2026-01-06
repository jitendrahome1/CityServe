//
//  PlusMembershipView.swift
//  CityServe
//
//  Plus Membership Hub - Membership benefits and upgrade options
//  UI-only placeholder implementation
//

import SwiftUI

struct PlusMembershipView: View {

    @State private var showUpgradeSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.xl) {
                    // Hero Section
                    heroSection

                    // Benefits List
                    benefitsSection

                    // Pricing Section
                    pricingSection

                    // Upgrade CTA
                    upgradeCTA

                    // Terms
                    termsSection
                }
                .padding(.vertical, Spacing.md)
            }
            .background(Color.background)
            .navigationTitle("Plus Membership")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showUpgradeSheet) {
            UpgradeToPlusSheet(onDismiss: {
                showUpgradeSheet = false
            })
        }
    }

    // MARK: - Subviews

    private var heroSection: some View {
        VStack(spacing: Spacing.md) {
            // Plus Badge
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.secondary, Color.warning],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)

                Image(systemName: "star.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }

            Text("UrbanNest Plus")
                .font(.h1)
                .fontWeight(.bold)
                .foregroundColor(.textPrimary)

            Text("Premium benefits for smart customers")
                .font(.body)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, Spacing.screenPadding)
        .padding(.top, Spacing.lg)
    }

    private var benefitsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Member Benefits")
                .font(.h3)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            VStack(spacing: Spacing.md) {
                BenefitCard(
                    icon: "percent",
                    iconColor: .success,
                    title: "Save 15% on every service",
                    description: "Instant discount on all bookings"
                )

                BenefitCard(
                    icon: "calendar.badge.clock",
                    iconColor: .info,
                    title: "Free cancellation",
                    description: "Cancel anytime up to 2 hours before service"
                )

                BenefitCard(
                    icon: "star.circle.fill",
                    iconColor: .warning,
                    title: "Priority booking",
                    description: "Get preferred time slots and faster provider assignment"
                )

                BenefitCard(
                    icon: "gift.fill",
                    iconColor: .secondary,
                    title: "Exclusive offers",
                    description: "Access to members-only deals and promotions"
                )

                BenefitCard(
                    icon: "headphones",
                    iconColor: .primary,
                    title: "Priority support",
                    description: "Dedicated support line for Plus members"
                )
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    private var pricingSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Choose Your Plan")
                .font(.h3)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            VStack(spacing: Spacing.md) {
                PricingCard(
                    title: "Monthly",
                    price: "₹299",
                    period: "/month",
                    features: ["All Plus benefits", "Cancel anytime"],
                    isPopular: false
                )

                PricingCard(
                    title: "Annual",
                    price: "₹2,999",
                    period: "/year",
                    features: ["All Plus benefits", "Save ₹588/year", "Best value"],
                    isPopular: true
                )
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    private var upgradeCTA: some View {
        VStack(spacing: Spacing.md) {
            PrimaryButton(
                "Upgrade to Plus",
                icon: "star.fill",
                size: .large
            ) {
                Haptics.medium()
                showUpgradeSheet = true
            }
            .padding(.horizontal, Spacing.screenPadding)

            Text("Start saving today!")
                .font(.bodySmall)
                .foregroundColor(.textSecondary)
        }
    }

    private var termsSection: some View {
        VStack(spacing: Spacing.xs) {
            Text("Terms & Conditions")
                .font(.caption)
                .foregroundColor(.primary)
                .underline()

            Text("By subscribing, you agree to our membership terms")
                .font(.caption)
                .foregroundColor(.textTertiary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, Spacing.screenPadding)
        .padding(.vertical, Spacing.md)
    }
}

// MARK: - Benefit Card

struct BenefitCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 50, height: 50)

                Image(systemName: icon)
                    .font(.system(size: Spacing.iconMD))
                    .foregroundColor(iconColor)
            }

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(title)
                    .font(.bodyLarge)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Text(description)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
                    .lineSpacing(2)
            }

            Spacer()
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
    }
}

// MARK: - Pricing Card

struct PricingCard: View {
    let title: String
    let price: String
    let period: String
    let features: [String]
    let isPopular: Bool

    var body: some View {
        VStack(spacing: Spacing.md) {
            // Header
            HStack {
                Text(title)
                    .font(.h4)
                    .fontWeight(.bold)
                    .foregroundColor(.textPrimary)

                Spacer()

                if isPopular {
                    Text("POPULAR")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, Spacing.sm)
                        .padding(.vertical, 4)
                        .background(Color.secondary)
                        .cornerRadius(Spacing.radiusPill)
                }
            }

            // Price
            HStack(alignment: .firstTextBaseline, spacing: Spacing.xxs) {
                Text(price)
                    .font(.custom("Inter-Bold", size: 32))
                    .foregroundColor(.primary)

                Text(period)
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()

            // Features
            VStack(alignment: .leading, spacing: Spacing.sm) {
                ForEach(features, id: \.self) { feature in
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.body)
                            .foregroundColor(.success)

                        Text(feature)
                            .font(.body)
                            .foregroundColor(.textPrimary)

                        Spacer()
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusLg)
                .stroke(isPopular ? Color.secondary : Color.divider, lineWidth: isPopular ? 2 : 1)
        )
    }
}

// MARK: - Upgrade Sheet

struct UpgradeToPlusSheet: View {
    let onDismiss: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: Spacing.xl) {
                Spacer()

                Image(systemName: "star.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.secondary)

                Text("Coming Soon")
                    .font(.h2)
                    .fontWeight(.bold)
                    .foregroundColor(.textPrimary)

                Text("Plus membership upgrades will be available soon. We'll notify you when they're ready!")
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.screenPadding)

                PrimaryButton("Got it", size: .large) {
                    Haptics.light()
                    onDismiss()
                    dismiss()
                }
                .padding(.horizontal, Spacing.screenPadding)

                Spacer()
            }
            .navigationTitle("Upgrade to Plus")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        onDismiss()
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: Spacing.iconMD))
                            .foregroundColor(.textPrimary)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview("Plus Membership") {
    PlusMembershipView()
}

#Preview("Plus Membership - Dark") {
    PlusMembershipView()
        .preferredColorScheme(.dark)
}
