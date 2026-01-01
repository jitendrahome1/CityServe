//
//  ReviewsListView.swift
//  CityServe
//
//  Full List of Service Reviews
//

import SwiftUI

struct ReviewsListView: View {

    let reviews: [ServiceReview]
    let serviceName: String

    @State private var selectedFilter: RatingFilter = .all
    @State private var filteredReviews: [ServiceReview] = []
    @State private var showFilterMenu = false

    enum RatingFilter: String, CaseIterable {
        case all = "All"
        case fiveStar = "5 Stars"
        case fourStar = "4 Stars"
        case threeStar = "3 Stars"
        case twoStar = "2 Stars"
        case oneStar = "1 Star"

        var filterValue: Int? {
            switch self {
            case .all: return nil
            case .fiveStar: return 5
            case .fourStar: return 4
            case .threeStar: return 3
            case .twoStar: return 2
            case .oneStar: return 1
            }
        }
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Rating Summary
                ratingSummary

                // Filter Bar
                filterBar

                // Reviews List
                if filteredReviews.isEmpty {
                    emptyState
                } else {
                    reviewsList
                }
            }
        }
        .navigationTitle("Reviews")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            applyFilter()
        }
    }

    // MARK: - Subviews

    private var ratingSummary: some View {
        VStack(spacing: Spacing.md) {
            // Average Rating
            VStack(spacing: Spacing.xs) {
                Text(String(format: "%.1f", averageRating))
                    .font(.custom("Inter-Bold", size: 48))
                    .foregroundColor(.textPrimary)

                HStack(spacing: Spacing.xxs) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= Int(round(averageRating)) ? "star.fill" : "star")
                            .font(.system(size: Spacing.iconSM))
                            .foregroundColor(.warning)
                    }
                }

                Text("Based on \(reviews.count) reviews")
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }

            // Rating Distribution
            VStack(spacing: Spacing.xs) {
                ForEach((1...5).reversed(), id: \.self) { star in
                    HStack(spacing: Spacing.sm) {
                        // Star count
                        HStack(spacing: Spacing.xxs) {
                            Text("\(star)")
                                .font(.bodySmall)
                                .foregroundColor(.textSecondary)
                                .frame(width: 12, alignment: .trailing)

                            Image(systemName: "star.fill")
                                .font(.system(size: Spacing.iconXS))
                                .foregroundColor(.warning)
                        }
                        .frame(width: 40, alignment: .leading)

                        // Progress bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.divider)
                                    .frame(height: 6)
                                    .cornerRadius(3)

                                Rectangle()
                                    .fill(Color.warning)
                                    .frame(
                                        width: geometry.size.width * ratingPercentage(for: star),
                                        height: 6
                                    )
                                    .cornerRadius(3)
                            }
                        }
                        .frame(height: 6)

                        // Count
                        Text("\(ratingCount(for: star))")
                            .font(.caption)
                            .foregroundColor(.textTertiary)
                            .frame(width: 30, alignment: .trailing)
                    }
                }
            }
            .padding(.horizontal, Spacing.xl)
        }
        .padding(.vertical, Spacing.xl)
        .frame(maxWidth: .infinity)
        .background(Color.surface)
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                ForEach(RatingFilter.allCases, id: \.self) { filter in
                    FilterButton(
                        title: filter.rawValue,
                        count: filter == .all ? reviews.count : ratingCount(for: filter.filterValue ?? 0),
                        isSelected: selectedFilter == filter,
                        action: {
                            selectedFilter = filter
                            applyFilter()
                        }
                    )
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
        .padding(.vertical, Spacing.sm)
        .background(Color.background)
    }

    private var reviewsList: some View {
        ScrollView {
            LazyVStack(spacing: Spacing.md) {
                ForEach(filteredReviews) { review in
                    ReviewDetailCard(review: review)
                }
            }
            .padding(Spacing.screenPadding)
        }
    }

    private var emptyState: some View {
        EmptyStateView(
            icon: "star",
            title: "No reviews found",
            description: "There are no reviews matching this filter."
        )
    }

    // MARK: - Helper Methods

    private var averageRating: Double {
        guard !reviews.isEmpty else { return 0 }
        let sum = reviews.reduce(0) { $0 + $1.rating }
        return sum / Double(reviews.count)
    }

    private func ratingCount(for star: Int) -> Int {
        reviews.filter { Int(round($0.rating)) == star }.count
    }

    private func ratingPercentage(for star: Int) -> CGFloat {
        let count = ratingCount(for: star)
        let total = reviews.count
        return total > 0 ? CGFloat(count) / CGFloat(total) : 0
    }

    private func applyFilter() {
        if let filterValue = selectedFilter.filterValue {
            filteredReviews = reviews.filter { Int(round($0.rating)) == filterValue }
        } else {
            filteredReviews = reviews
        }
    }
}

// MARK: - Filter Button

struct FilterButton: View {
    let title: String
    let count: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            Haptics.light()
            action()
        }) {
            HStack(spacing: Spacing.xxs) {
                Text(title)
                    .font(.bodySmall)
                    .fontWeight(isSelected ? .semibold : .regular)

                Text("(\(count))")
                    .font(.caption)
            }
            .foregroundColor(isSelected ? .white : .textPrimary)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.xs)
            .background(isSelected ? Color.primary : Color.surface)
            .cornerRadius(Spacing.radiusPill)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusPill)
                    .stroke(isSelected ? Color.clear : Color.divider, lineWidth: 1)
            )
        }
    }
}

// MARK: - Review Detail Card

struct ReviewDetailCard: View {
    let review: ServiceReview

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // User Info
            HStack(spacing: Spacing.sm) {
                // Avatar
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.primary.opacity(0.8), Color.primaryDark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 48, height: 48)
                    .overlay(
                        Text(review.userName.prefix(1))
                            .font(.h4)
                            .foregroundColor(.white)
                    )

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(review.userName)
                        .font(.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    HStack(spacing: Spacing.xxs) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= Int(review.rating) ? "star.fill" : "star")
                                .font(.system(size: Spacing.iconXS))
                                .foregroundColor(.warning)
                        }
                    }
                }

                Spacer()

                // Date
                Text(review.formattedDate)
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }

            // Review Comment
            Text(review.comment)
                .font(.body)
                .foregroundColor(.textSecondary)
                .lineSpacing(4)

            // Review Images (if any)
            if let images = review.images, !images.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Spacing.sm) {
                        ForEach(images, id: \.self) { imageURL in
                            RoundedRectangle(cornerRadius: Spacing.radiusMd)
                                .fill(Color.surface)
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.textTertiary)
                                )
                        }
                    }
                }
            }

            // Helpful Section
            HStack(spacing: Spacing.md) {
                Text("Was this helpful?")
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)

                Button(action: {
                    Haptics.light()
                }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "hand.thumbsup")
                            .font(.body)

                        Text("Yes")
                            .font(.bodySmall)
                    }
                    .foregroundColor(.textPrimary)
                    .padding(.horizontal, Spacing.sm)
                    .padding(.vertical, Spacing.xxs)
                    .background(Color.background)
                    .cornerRadius(Spacing.radiusPill)
                }

                Button(action: {
                    Haptics.light()
                }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "hand.thumbsdown")
                            .font(.body)

                        Text("No")
                            .font(.bodySmall)
                    }
                    .foregroundColor(.textPrimary)
                    .padding(.horizontal, Spacing.sm)
                    .padding(.vertical, Spacing.xxs)
                    .background(Color.background)
                    .cornerRadius(Spacing.radiusPill)
                }

                Spacer()
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusMd)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ReviewsListView(
            reviews: ServiceReview.mockReviews,
            serviceName: "AC Repair & Service"
        )
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        ReviewsListView(
            reviews: ServiceReview.mockReviews,
            serviceName: "AC Repair & Service"
        )
    }
    .preferredColorScheme(.dark)
}

// MARK: - Mock Reviews for Preview

extension ServiceReview {
    static let mockReviews: [ServiceReview] = [
        ServiceReview(
            id: "SR1",
            serviceId: "1",
            userId: "U1",
            userName: "Priya Sharma",
            userPhotoURL: nil,
            rating: 5.0,
            comment: "Excellent service! The technician was very professional and fixed my AC in no time. He explained everything clearly and the price was reasonable. Highly recommended!",
            images: nil,
            createdAt: Date().addingTimeInterval(-7 * 24 * 60 * 60)
        ),
        ServiceReview(
            id: "SR2",
            serviceId: "1",
            userId: "U2",
            userName: "Rohit Verma",
            userPhotoURL: nil,
            rating: 4.0,
            comment: "Good work. Came on time and completed the job efficiently. Would have given 5 stars but the cleanup could have been better.",
            images: nil,
            createdAt: Date().addingTimeInterval(-14 * 24 * 60 * 60)
        ),
        ServiceReview(
            id: "SR3",
            serviceId: "1",
            userId: "U3",
            userName: "Anjali Gupta",
            userPhotoURL: nil,
            rating: 5.0,
            comment: "Best service ever! Very professional and courteous. The technician arrived on time and did a thorough job. My AC is working perfectly now.",
            images: nil,
            createdAt: Date().addingTimeInterval(-21 * 24 * 60 * 60)
        ),
        ServiceReview(
            id: "SR4",
            serviceId: "1",
            userId: "U4",
            userName: "Vikram Singh",
            userPhotoURL: nil,
            rating: 3.0,
            comment: "Average service. The work was done but took longer than expected. The technician was polite though.",
            images: nil,
            createdAt: Date().addingTimeInterval(-28 * 24 * 60 * 60)
        ),
        ServiceReview(
            id: "SR5",
            serviceId: "1",
            userId: "U5",
            userName: "Neha Patel",
            userPhotoURL: nil,
            rating: 5.0,
            comment: "Absolutely fantastic! The technician was knowledgeable and fixed the issue quickly. Great value for money.",
            images: nil,
            createdAt: Date().addingTimeInterval(-35 * 24 * 60 * 60)
        ),
        ServiceReview(
            id: "SR6",
            serviceId: "1",
            userId: "U6",
            userName: "Arjun Reddy",
            userPhotoURL: nil,
            rating: 4.0,
            comment: "Very satisfied with the service. Professional and efficient. Will definitely use again.",
            images: nil,
            createdAt: Date().addingTimeInterval(-42 * 24 * 60 * 60)
        ),
        ServiceReview(
            id: "SR7",
            serviceId: "1",
            userId: "U7",
            userName: "Kavita Desai",
            userPhotoURL: nil,
            rating: 5.0,
            comment: "Outstanding service! The best AC repair service I've ever used. Highly recommend to everyone.",
            images: nil,
            createdAt: Date().addingTimeInterval(-49 * 24 * 60 * 60)
        ),
        ServiceReview(
            id: "SR8",
            serviceId: "1",
            userId: "U8",
            userName: "Sanjay Kumar",
            userPhotoURL: nil,
            rating: 4.0,
            comment: "Good service overall. The technician was skilled and professional. Minor delay in arrival but otherwise great.",
            images: nil,
            createdAt: Date().addingTimeInterval(-56 * 24 * 60 * 60)
        )
    ]
}
