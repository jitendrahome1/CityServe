//
//  RewardsView.swift
//  CityServe
//
//  Rewards & Points Hub - Loyalty points and redemption
//  UI-only placeholder implementation
//

import SwiftUI

struct RewardsView: View {

    @State private var pointsBalance: Int = 0
    @State private var showEarnPointsInfo = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.xl) {
                    // Points Balance Section
                    pointsBalanceSection

                    // How to Earn Points
                    earnPointsSection

                    // Available Rewards (Coming Soon)
                    availableRewardsSection

                    // Rewards History (Coming Soon)
                    historySection
                }
                .padding(.vertical, Spacing.md)
            }
            .background(Color.background)
            .navigationTitle("Rewards")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showEarnPointsInfo) {
            EarnPointsInfoSheet(onDismiss: {
                showEarnPointsInfo = false
            })
        }
    }

    // MARK: - Subviews

    private var pointsBalanceSection: some View {
        VStack(spacing: Spacing.md) {
            // Points Card
            VStack(spacing: Spacing.md) {
                // Icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.warning, Color.secondary],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)

                    Image(systemName: "gift.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                }

                Text("\(pointsBalance)")
                    .font(.custom("Inter-Bold", size: 48))
                    .foregroundColor(.primary)

                Text("Reward Points")
                    .font(.h5)
                    .foregroundColor(.textSecondary)

                Text("Start booking to earn points!")
                    .font(.bodySmall)
                    .foregroundColor(.textTertiary)
                    .multilineTextAlignment(.center)
            }
            .padding(Spacing.xl)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [Color.primary.opacity(0.05), Color.secondary.opacity(0.05)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(Spacing.radiusLg)
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    private var earnPointsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text("How to Earn Points")
                    .font(.h3)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Spacer()

                Button(action: {
                    showEarnPointsInfo = true
                }) {
                    Image(systemName: "info.circle")
                        .font(.system(size: Spacing.iconMD))
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal, Spacing.screenPadding)

            VStack(spacing: Spacing.md) {
                EarnPointsCard(
                    icon: "checkmark.circle.fill",
                    iconColor: .success,
                    title: "Complete Bookings",
                    points: "+50 points",
                    description: "Earn points for every completed service"
                )

                EarnPointsCard(
                    icon: "star.fill",
                    iconColor: .warning,
                    title: "Write Reviews",
                    points: "+20 points",
                    description: "Share your feedback on completed services"
                )

                EarnPointsCard(
                    icon: "person.2.fill",
                    iconColor: .info,
                    title: "Refer Friends",
                    points: "+100 points",
                    description: "Invite friends and earn when they book"
                )

                EarnPointsCard(
                    icon: "trophy.fill",
                    iconColor: .secondary,
                    title: "Special Offers",
                    points: "Bonus points",
                    description: "Complete challenges for extra rewards"
                )
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    private var availableRewardsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Available Rewards")
                .font(.h3)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            // Coming Soon Message
            VStack(spacing: Spacing.md) {
                Image(systemName: "sparkles")
                    .font(.system(size: 50))
                    .foregroundColor(.textTertiary)

                Text("Coming Soon")
                    .font(.h4)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Text("Exciting rewards will be available soon. Keep earning points to redeem amazing offers!")
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.xl)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.xl)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .padding(.horizontal, Spacing.screenPadding)
        }
    }

    private var historySection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Points History")
                .font(.h3)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            // Empty State
            VStack(spacing: Spacing.md) {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: 40))
                    .foregroundColor(.textTertiary)

                Text("No activity yet")
                    .font(.body)
                    .foregroundColor(.textSecondary)

                Text("Your points transactions will appear here")
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.xl)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .padding(.horizontal, Spacing.screenPadding)
        }
    }
}

// MARK: - Earn Points Card

struct EarnPointsCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let points: String
    let description: String

    var body: some View {
        HStack(spacing: Spacing.md) {
            // Icon
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 50, height: 50)

                Image(systemName: icon)
                    .font(.system(size: Spacing.iconMD))
                    .foregroundColor(iconColor)
            }

            // Content
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(title)
                    .font(.bodyLarge)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                    .lineSpacing(2)
            }

            Spacer()

            // Points Badge
            Text(points)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.warning)
                .padding(.horizontal, Spacing.sm)
                .padding(.vertical, 4)
                .background(Color.warning.opacity(0.1))
                .cornerRadius(Spacing.radiusPill)
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
    }
}

// MARK: - Earn Points Info Sheet

struct EarnPointsInfoSheet: View {
    let onDismiss: () -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    // Header
                    VStack(spacing: Spacing.xs) {
                        Text("Earn & Redeem Points")
                            .font(.h2)
                            .fontWeight(.bold)
                            .foregroundColor(.textPrimary)

                        Text("Learn how the rewards program works")
                            .font(.body)
                            .foregroundColor(.textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Divider()

                    // Earning Rules
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        Text("Earning Points")
                            .font(.h4)
                            .fontWeight(.semibold)
                            .foregroundColor(.textPrimary)

                        RewardInfoRow(
                            icon: "checkmark.circle",
                            text: "Complete a service: 50 points"
                        )

                        RewardInfoRow(
                            icon: "star",
                            text: "Write a review: 20 points"
                        )

                        RewardInfoRow(
                            icon: "person.2",
                            text: "Refer a friend: 100 points"
                        )

                        RewardInfoRow(
                            icon: "trophy",
                            text: "Special promotions: Variable points"
                        )
                    }

                    Divider()

                    // Redemption Rules
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        Text("Redeeming Points (Coming Soon)")
                            .font(.h4)
                            .fontWeight(.semibold)
                            .foregroundColor(.textPrimary)

                        Text("You'll soon be able to redeem points for:")
                            .font(.body)
                            .foregroundColor(.textSecondary)

                        RewardInfoRow(
                            icon: "tag",
                            text: "Service discounts"
                        )

                        RewardInfoRow(
                            icon: "gift",
                            text: "Free add-ons"
                        )

                        RewardInfoRow(
                            icon: "percent",
                            text: "Exclusive offers"
                        )
                    }

                    Divider()

                    // Terms
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Terms & Conditions")
                            .font(.bodySmall)
                            .fontWeight(.semibold)
                            .foregroundColor(.textPrimary)

                        Text("• Points expire after 12 months of inactivity\n• Points cannot be transferred or exchanged for cash\n• UrbanNest reserves the right to modify the rewards program")
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                            .lineSpacing(3)
                    }
                }
                .padding(Spacing.screenPadding)
            }
            .background(Color.background)
            .navigationTitle("Rewards Info")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        onDismiss()
                        dismiss()
                    }
                    .foregroundColor(.primary)
                }
            }
        }
    }
}

// MARK: - Reward Info Row

struct RewardInfoRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(.primary)
                .frame(width: 20)

            Text(text)
                .font(.body)
                .foregroundColor(.textPrimary)

            Spacer()
        }
    }
}

// MARK: - Preview

#Preview("Rewards") {
    RewardsView()
}

#Preview("Rewards - Dark") {
    RewardsView()
        .preferredColorScheme(.dark)
}
