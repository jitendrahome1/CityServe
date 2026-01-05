//
//  ProviderProfileView.swift
//  CityServe
//
//  Provider Profile and Reviews
//

import SwiftUI

struct ProviderProfileView: View {

    let provider: Provider
    @State private var selectedTab: ProfileTab = .about
    @State private var providerReviews: [ProviderReview] = []
    @State private var isLoading = false

    enum ProfileTab: String, CaseIterable {
        case about = "About"
        case reviews = "Reviews"
        case services = "Services"
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Provider Header
                    providerHeader

                    // Stats Section
                    statsSection

                    // Tab Selector
                    tabSelector

                    // Tab Content
                    tabContent
                }
            }
        }
        .navigationTitle("Provider Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadProviderData()
        }
    }

    // MARK: - Subviews

    private var providerHeader: some View {
        VStack(spacing: Spacing.md) {
            // Profile Photo
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.primary, Color.primaryDark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)

                Text(provider.fullName.prefix(1))
                    .font(.custom("Inter-Bold", size: 40))
                    .foregroundColor(.white)
            }

            // Name & Verification
            VStack(spacing: Spacing.xxs) {
                HStack(spacing: Spacing.xs) {
                    Text(provider.fullName)
                        .font(.h3)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.bold)

                    if provider.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.h4)
                            .foregroundColor(.primary)
                    }
                }

                Text(provider.city)
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }

            // Rating
            HStack(spacing: Spacing.xs) {
                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "star.fill")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.warning)

                    Text(provider.formattedRating)
                        .font(.h4)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)
                }

                Text("•")
                    .foregroundColor(.textTertiary)

                Text("\(provider.reviewCount) reviews")
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }

            // Availability Badge
            HStack(spacing: Spacing.xxs) {
                Circle()
                    .fill(provider.availability.isAvailableNow ? Color.success : Color.error)
                    .frame(width: 8, height: 8)

                Text(provider.availability.isAvailableNow ? "Available Now" : "Not Available")
                    .font(.bodySmall)
                    .fontWeight(.medium)
                    .foregroundColor(provider.availability.isAvailableNow ? .success : .error)
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.xs)
            .background(
                (provider.availability.isAvailableNow ? Color.success : Color.error).opacity(0.1)
            )
            .cornerRadius(Spacing.radiusPill)
        }
        .padding(.vertical, Spacing.xl)
        .frame(maxWidth: .infinity)
        .background(Color.surface)
    }

    private var statsSection: some View {
        HStack(spacing: 0) {
            StatItem(
                icon: "briefcase.fill",
                value: provider.jobsCompletedText,
                label: "Completed"
            )

            Divider()
                .frame(height: 50)

            StatItem(
                icon: "clock.fill",
                value: provider.experienceText,
                label: "Experience"
            )

            Divider()
                .frame(height: 50)

            StatItem(
                icon: "star.fill",
                value: provider.formattedRating,
                label: "Rating"
            )
        }
        .padding(.vertical, Spacing.lg)
        .background(Color.surface)
    }

    private var tabSelector: some View {
        HStack(spacing: 0) {
            ForEach(ProfileTab.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: Spacing.xs) {
                        Text(tab.rawValue)
                            .font(.bodyLarge)
                            .fontWeight(selectedTab == tab ? .semibold : .regular)
                            .foregroundColor(selectedTab == tab ? .primary : .textSecondary)

                        Rectangle()
                            .fill(selectedTab == tab ? Color.primary : Color.clear)
                            .frame(height: 2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.surface)
        .padding(.top, Spacing.md)
    }

    private var tabContent: some View {
        Group {
            switch selectedTab {
            case .about:
                aboutTab
            case .reviews:
                reviewsTab
            case .services:
                servicesTab
            }
        }
        .padding(.top, Spacing.lg)
    }

    private var aboutTab: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            // Bio
            if let bio = provider.bio {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("About")
                        .font(.h5)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    Text(bio)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .lineSpacing(4)
                }
            }

            // Certifications
            if !provider.certifications.isEmpty {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Certifications")
                        .font(.h5)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    ForEach(provider.certifications, id: \.self) { certification in
                        HStack(spacing: Spacing.sm) {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: Spacing.iconSM))
                                .foregroundColor(.primary)

                            Text(certification)
                                .font(.body)
                                .foregroundColor(.textSecondary)
                        }
                    }
                }
            }

            // Working Hours
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Working Hours")
                    .font(.h5)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.semibold)

                HStack {
                    Image(systemName: "clock")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.textSecondary)

                    Text("\(provider.availability.workingHours.start) - \(provider.availability.workingHours.end)")
                        .font(.body)
                        .foregroundColor(.textSecondary)
                }

                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.textSecondary)

                    Text(provider.availability.workingDays.joined(separator: ", "))
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .lineLimit(2)
                }
            }

            // Member Since
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Member Since")
                    .font(.h5)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.semibold)

                Text(formatJoinedDate())
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.screenPadding)
    }

    private var reviewsTab: some View {
        VStack(spacing: Spacing.md) {
            if providerReviews.isEmpty {
                EmptyStateView(
                    icon: "star",
                    title: "No reviews yet",
                    description: "This provider hasn't received any reviews yet."
                )
                .padding(.top, Spacing.xl)
            } else {
                ForEach(providerReviews) { review in
                    ProviderReviewCard(review: review)
                }
            }
        }
        .padding(Spacing.screenPadding)
    }

    private var servicesTab: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Services Offered")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            // Get service names from categories
            ForEach(provider.serviceCategories, id: \.self) { categoryId in
                if let category = getCategoryName(for: categoryId) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: Spacing.iconSM))
                            .foregroundColor(.success)

                        Text(category)
                            .font(.body)
                            .foregroundColor(.textSecondary)

                        Spacer()
                    }
                    .padding(Spacing.md)
                    .background(Color.surface)
                    .cornerRadius(Spacing.radiusLg)
                }
            }
        }
        .padding(Spacing.screenPadding)
    }

    // MARK: - Helper Methods

    private func loadProviderData() {
        isLoading = true

        Task {
            try await Task.sleep(nanoseconds: 800_000_000)

            // Load mock reviews for this provider
            providerReviews = ProviderReview.mockReviews.filter { $0.providerId == provider.id }

            isLoading = false
        }
    }

    private func getCategoryName(for categoryId: String) -> String? {
        ServiceCategory.mockCategories.first(where: { $0.id == categoryId })?.name
    }

    private func formatJoinedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: provider.joinedAt)
    }
}

// MARK: - Stat Item

struct StatItem: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: Spacing.xs) {
            Image(systemName: icon)
                .font(.h3)
                .foregroundColor(.primary)

            Text(value)
                .font(.h4)
                .fontWeight(.bold)
                .foregroundColor(.textPrimary)

            Text(label)
                .font(.caption)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Provider Review Card

struct ProviderReviewCard: View {
    let review: ProviderReview

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                // User Avatar
                Circle()
                    .fill(Color.primary.opacity(0.1))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(review.userName.prefix(1))
                            .font(.h5)
                            .foregroundColor(.primary)
                    )

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(review.userName)
                        .font(.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimary)

                    HStack(spacing: Spacing.xxs) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= Int(review.rating) ? "star.fill" : "star")
                                .font(.system(size: Spacing.iconXS))
                                .foregroundColor(.warning)
                        }

                        Text("•")
                            .font(.caption)
                            .foregroundColor(.textTertiary)

                        Text(review.formattedDate)
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }
                }

                Spacer()
            }

            // Service name
            Text("For: \(review.serviceName)")
                .font(.bodySmall)
                .foregroundColor(.primary)
                .fontWeight(.medium)

            Text(review.comment)
                .font(.body)
                .foregroundColor(.textSecondary)
                .lineSpacing(2)
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ProviderProfileView(provider: Provider.mockProviders[0])
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        ProviderProfileView(provider: Provider.mockProviders[0])
    }
    .preferredColorScheme(.dark)
}
