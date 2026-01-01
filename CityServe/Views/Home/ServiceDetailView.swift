//
//  ServiceDetailView.swift
//  CityServe
//
//  Detailed Service Information Screen
//

import SwiftUI

struct ServiceDetailView: View {

    let service: Service
    @StateObject private var viewModel: ServiceDetailViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var navigateToBooking = false

    init(service: Service) {
        self.service = service
        _viewModel = StateObject(wrappedValue: ServiceDetailViewModel(service: service))
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Service Image/Icon
                    serviceHeader

                    VStack(spacing: Spacing.xl) {
                        // Title & Rating
                        titleSection

                        // Price & Duration
                        priceSection

                        // Quick Actions (Book Now button)
                        bookNowButton

                        Divider()

                        // Description
                        descriptionSection

                        Divider()

                        // Inclusions & Exclusions
                        inclusionsSection

                        Divider()

                        // Reviews Summary
                        reviewsSection

                        Divider()

                        // FAQs
                        if !service.faqs.isEmpty {
                            faqSection
                            Divider()
                        }

                        // Related Services
                        if !viewModel.relatedServices.isEmpty {
                            relatedServicesSection
                        }
                    }
                    .padding(.top, Spacing.lg)
                }
            }

            // Loading overlay
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                LoadingView(message: Strings.Service.loading, style: .spinner)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $navigateToBooking) {
            BookingFlowContainerView(service: service)
                .environmentObject(authViewModel)
        }
    }

    // MARK: - Subviews

    private var serviceHeader: some View {
        ZStack {
            LinearGradient(
                colors: [Color.primary.opacity(0.1), Color.primaryLight.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            if let icon = service.icon {
                Image(systemName: icon)
                    .font(.displayXL)
                    .foregroundColor(.primary)
            }
        }
        .frame(height: 200)
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            // Tags
            if !service.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Spacing.xs) {
                        ForEach(service.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                                .padding(.horizontal, Spacing.sm)
                                .padding(.vertical, Spacing.xxs)
                                .background(Color.primary.opacity(0.1))
                                .cornerRadius(Spacing.radiusPill)
                        }
                    }
                }
            }

            Text(service.name)
                .font(.h2)
                .foregroundColor(.textPrimary)
                .fontWeight(.bold)

            Text(service.shortDescription)
                .font(.body)
                .foregroundColor(.textSecondary)

            // Rating
            HStack(spacing: Spacing.xs) {
                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "star.fill")
                        .font(.body)
                        .foregroundColor(.warning)

                    Text(String(format: "%.1f", service.rating))
                        .font(.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)
                }

                Text("•")
                    .foregroundColor(.textTertiary)

                Text("\(service.reviewCount) reviews")
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.screenPadding)
    }

    private var priceSection: some View {
        HStack(spacing: Spacing.lg) {
            // Price
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(Strings.Service.price)
                    .font(.caption)
                    .foregroundColor(.textSecondary)

                Text(service.formattedPrice)
                    .font(.h3)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
            }

            Divider()
                .frame(height: 40)

            // Duration
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(Strings.Service.duration)
                    .font(.caption)
                    .foregroundColor(.textSecondary)

                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "clock")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.textSecondary)

                    Text(service.formattedDuration)
                        .font(.bodyLarge)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.medium)
                }
            }

            Spacer()
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusMd)
        .padding(.horizontal, Spacing.screenPadding)
    }

    private var bookNowButton: some View {
        PrimaryButton(
            Strings.Service.bookNow,
            icon: "calendar",
            size: .large,
            action: {
                navigateToBooking = true
            }
        )
        .padding(.horizontal, Spacing.screenPadding)
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(Strings.Service.about)
                .font(.h4)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            Text(service.longDescription)
                .font(.body)
                .foregroundColor(.textSecondary)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.screenPadding)
    }

    private var inclusionsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Inclusions
            if !service.inclusions.isEmpty {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text(Strings.Service.included)
                        .font(.h5)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    ForEach(service.inclusions, id: \.self) { inclusion in
                        HStack(alignment: .top, spacing: Spacing.sm) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: Spacing.iconSM))
                                .foregroundColor(.success)

                            Text(inclusion)
                                .font(.body)
                                .foregroundColor(.textSecondary)
                        }
                    }
                }
            }

            // Exclusions
            if !service.exclusions.isEmpty {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text(Strings.Service.excluded)
                        .font(.h5)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    ForEach(service.exclusions, id: \.self) { exclusion in
                        HStack(alignment: .top, spacing: Spacing.sm) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: Spacing.iconSM))
                                .foregroundColor(.error)

                            Text(exclusion)
                                .font(.body)
                                .foregroundColor(.textSecondary)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.screenPadding)
    }

    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text(Strings.Service.reviews)
                    .font(.h4)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.semibold)

                Spacer()

                NavigationLink(destination: ReviewsListView(reviews: viewModel.reviews, serviceName: service.name)) {
                    Text(Strings.Common.seeAll)
                        .font(.bodySmall)
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                }
            }

            // Rating Summary
            HStack(alignment: .center, spacing: Spacing.lg) {
                // Average Rating
                VStack(spacing: Spacing.xxs) {
                    Text(String(format: "%.1f", viewModel.averageRating))
                        .font(.custom("Inter-Bold", size: 40))
                        .foregroundColor(.textPrimary)

                    HStack(spacing: Spacing.xxs) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= service.starRating ? "star.fill" : "star")
                                .font(.system(size: Spacing.iconXS))
                                .foregroundColor(.warning)
                        }
                    }

                    Text(Strings.Service.reviewsCount(service.reviewCount))
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }

                // Rating Distribution
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    ForEach((1...5).reversed(), id: \.self) { star in
                        HStack(spacing: Spacing.xs) {
                            Text("\(star)")
                                .font(.caption)
                                .foregroundColor(.textSecondary)

                            Image(systemName: "star.fill")
                                .font(.system(size: Spacing.iconXS))
                                .foregroundColor(.warning)

                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color.divider)
                                        .frame(height: 4)

                                    Rectangle()
                                        .fill(Color.warning)
                                        .frame(
                                            width: geometry.size.width * ratingPercentage(for: star),
                                            height: 4
                                        )
                                }
                            }
                            .frame(height: 4)
                        }
                    }
                }
            }

            // Recent Reviews
            if !viewModel.displayedReviews.isEmpty {
                VStack(spacing: Spacing.md) {
                    ForEach(viewModel.displayedReviews.prefix(2)) { review in
                        ReviewCard(review: review)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.screenPadding)
    }

    private var faqSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(Strings.Service.faqs)
                .font(.h4)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            ForEach(Array(service.faqs.enumerated()), id: \.element.id) { index, faq in
                FAQItem(
                    faq: faq,
                    isExpanded: viewModel.selectedFAQIndex == index,
                    onTap: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.toggleFAQ(index)
                        }
                    }
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.screenPadding)
    }

    private var relatedServicesSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(Strings.Service.related)
                .font(.h4)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)
                .padding(.horizontal, Spacing.screenPadding)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.md) {
                    ForEach(viewModel.relatedServices.prefix(4)) { relatedService in
                        NavigationLink(destination: ServiceDetailView(service: relatedService)) {
                            ServiceCard(
                                service: ServiceCardModel(
                                    id: relatedService.id,
                                    name: relatedService.name,
                                    icon: relatedService.icon,
                                    imageURL: relatedService.imageURL,
                                    shortDescription: relatedService.shortDescription,
                                    basePrice: relatedService.basePrice,
                                    maxPrice: relatedService.priceRange?.max,
                                    rating: relatedService.rating,
                                    reviewCount: relatedService.reviewCount
                                ),
                                style: .vertical
                            )
                            .frame(width: 160)
                        }
                    }
                }
                .padding(.horizontal, Spacing.screenPadding)
            }
        }
    }

    // MARK: - Helper Methods

    private func ratingPercentage(for star: Int) -> CGFloat {
        let distribution = viewModel.ratingDistribution
        let count = distribution[star] ?? 0
        let total = viewModel.reviews.count
        return total > 0 ? CGFloat(count) / CGFloat(total) : 0
    }
}

// MARK: - Review Card

struct ReviewCard: View {
    let review: ServiceReview

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

            Text(review.comment)
                .font(.body)
                .foregroundColor(.textSecondary)
                .lineSpacing(2)
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusMd)
    }
}

// MARK: - FAQ Item

struct FAQItem: View {
    let faq: FAQ
    let isExpanded: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Button(action: {
                Haptics.light()
                onTap()
            }) {
                HStack {
                    Text(faq.question)
                        .font(.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimary)
                        .multilineTextAlignment(.leading)

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.buttonSmall)
                        .foregroundColor(.textSecondary)
                }
            }

            if isExpanded {
                Text(faq.answer)
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .transition(.opacity)
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusMd)
    }
}

// MARK: - Preview

#Preview {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(
        id: "123",
        fullName: "Rahul Sharma",
        email: "rahul@example.com",
        phoneNumber: "9876543210",
        photoURL: nil,
        userType: .customer,
        city: "Delhi",
        addresses: [],
        createdAt: Date(),
        updatedAt: Date()
    )
    authViewModel.isAuthenticated = true

    return NavigationStack {
        ServiceDetailView(service: Service.mockServices[0])
            .environmentObject(authViewModel)
    }
}

#Preview("Dark Mode") {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(
        id: "123",
        fullName: "Rahul Sharma",
        email: "rahul@example.com",
        phoneNumber: "9876543210",
        photoURL: nil,
        userType: .customer,
        city: "Delhi",
        addresses: [],
        createdAt: Date(),
        updatedAt: Date()
    )
    authViewModel.isAuthenticated = true

    return NavigationStack {
        ServiceDetailView(service: Service.mockServices[0])
            .environmentObject(authViewModel)
    }
    .preferredColorScheme(.dark)
}
