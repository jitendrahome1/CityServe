//
//  RatingStars.swift
//  CityServe
//
//  Interactive Star Rating Component
//  Design System Component - From designs
//

import SwiftUI

/// Interactive 5-star rating input for service reviews
/// Usage: Rate order screen, service feedback, review forms
struct RatingStars: View {

    // MARK: - Properties

    @Binding var rating: Int

    var maxRating: Int = 5
    var size: StarSize = .medium
    var isInteractive: Bool = true
    var showLabel: Bool = false
    var onRatingChanged: ((Int) -> Void)? = nil

    @State private var tempRating: Int = 0

    // MARK: - Star Sizes

    enum StarSize {
        case small, medium, large

        var dimension: CGFloat {
            switch self {
            case .small: return 24
            case .medium: return 32
            case .large: return 40
            }
        }

        var spacing: CGFloat {
            switch self {
            case .small: return 4
            case .medium: return 6
            case .large: return 8
            }
        }
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: Spacing.xs) {
            HStack(spacing: size.spacing) {
                ForEach(1...maxRating, id: \.self) { index in
                    starView(for: index)
                }
            }

            if showLabel {
                ratingLabel
            }
        }
    }

    // MARK: - Subviews

    private func starView(for index: Int) -> some View {
        let isFilled = (tempRating > 0 ? tempRating : rating) >= index

        return Image(systemName: isFilled ? "star.fill" : "star")
            .font(.system(size: size.dimension * 0.7))
            .foregroundColor(isFilled ? .secondary : .divider)
            .frame(width: size.dimension, height: size.dimension)
            .contentShape(Rectangle())
            .onTapGesture {
                handleTap(at: index)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if isInteractive {
                            tempRating = index
                        }
                    }
                    .onEnded { _ in
                        if isInteractive {
                            setRating(index)
                            tempRating = 0
                        }
                    }
            )
    }

    private var ratingLabel: some View {
        Group {
            if rating > 0 {
                Text(ratingText)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
            }
        }
    }

    private var ratingText: String {
        switch rating {
        case 1: return "Poor"
        case 2: return "Fair"
        case 3: return "Good"
        case 4: return "Very Good"
        case 5: return "Excellent"
        default: return ""
        }
    }

    // MARK: - Actions

    private func handleTap(at index: Int) {
        guard isInteractive else { return }
        setRating(index)
    }

    private func setRating(_ newRating: Int) {
        guard isInteractive else { return }

        // Allow deselecting by tapping the same star
        if rating == newRating && newRating == 1 {
            rating = 0
        } else {
            rating = newRating
        }

        Haptics.light()
        onRatingChanged?(rating)
    }
}

// MARK: - Read-Only Rating Display

/// Non-interactive rating display for showing existing ratings
struct RatingDisplay: View {
    let rating: Double
    let reviewCount: Int?
    var size: RatingStars.StarSize = .small
    var showCount: Bool = true

    var body: some View {
        HStack(spacing: Spacing.xxs) {
            // Stars
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: starIcon(for: index))
                        .font(.system(size: size.dimension * 0.6))
                        .foregroundColor(.secondary)
                }
            }

            // Rating number
            Text(String(format: "%.1f", rating))
                .font(.bodySmall)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)

            // Review count
            if showCount, let count = reviewCount {
                Text("(\(count))")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
        }
    }

    private func starIcon(for position: Int) -> String {
        let difference = rating - Double(position - 1)

        if difference >= 1.0 {
            return "star.fill"
        } else if difference >= 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}

// MARK: - Preview

#Preview("Interactive Rating Stars") {
    VStack(spacing: Spacing.xl) {
        // Small size
        VStack(spacing: Spacing.sm) {
            Text("Small Size")
                .font(.h5)

            RatingStars(
                rating: .constant(0),
                size: .small,
                showLabel: true
            )
        }

        Divider()

        // Medium size (default)
        VStack(spacing: Spacing.sm) {
            Text("Medium Size")
                .font(.h5)

            RatingStars(
                rating: .constant(3),
                size: .medium,
                showLabel: true
            )
        }

        Divider()

        // Large size
        VStack(spacing: Spacing.sm) {
            Text("Large Size")
                .font(.h5)

            RatingStars(
                rating: .constant(5),
                size: .large,
                showLabel: true
            )
        }

        Divider()

        // Non-interactive (read-only)
        VStack(spacing: Spacing.sm) {
            Text("Non-interactive")
                .font(.h5)

            RatingStars(
                rating: .constant(4),
                size: .medium,
                isInteractive: false
            )
        }
    }
    .padding(Spacing.screenPadding)
}

#Preview("Rating Display (Read-Only)") {
    VStack(spacing: Spacing.lg) {
        RatingDisplay(
            rating: 4.8,
            reviewCount: 245,
            size: .small
        )

        RatingDisplay(
            rating: 3.5,
            reviewCount: 89,
            size: .medium
        )

        RatingDisplay(
            rating: 4.2,
            reviewCount: nil,
            size: .large
        )

        RatingDisplay(
            rating: 5.0,
            reviewCount: 1024,
            size: .medium,
            showCount: true
        )
    }
    .padding(Spacing.screenPadding)
}

#Preview("Rate Order Screen Example") {
    VStack(spacing: Spacing.xl) {
        // Header
        VStack(spacing: Spacing.sm) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.success)

            Text("Order Completed!")
                .font(.h2)
                .foregroundColor(.textPrimary)

            Text("How was your experience?")
                .font(.body)
                .foregroundColor(.textSecondary)
        }

        // Rating
        VStack(spacing: Spacing.md) {
            Text("Rate your delivery")
                .font(.h4)
                .foregroundColor(.textPrimary)

            RatingStars(
                rating: .constant(0),
                size: .large,
                showLabel: true,
                onRatingChanged: { rating in
                    print("Rating changed to: \(rating)")
                }
            )
        }
        .padding(Spacing.lg)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .floatingCardShadow()

        Spacer()

        PrimaryButton("Submit Rating") {
            print("Submit")
        }
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
}
