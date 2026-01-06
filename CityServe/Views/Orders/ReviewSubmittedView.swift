//
//  ReviewSubmittedView.swift
//  CityServe
//
//  Success confirmation screen after submitting a review
//  Design Spec: 42_REVIEW_SUBMITTED.md
//

import SwiftUI

struct ReviewSubmittedView: View {

    let review: SubmittedReview
    @Environment(\.dismiss) var dismiss
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var showConfetti = false
    @State private var animateCheckmark = false

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Success Animation
                ZStack {
                    Circle()
                        .fill(Color.success)
                        .frame(width: 100, height: 100)
                        .scaleEffect(animateCheckmark ? 1.0 : 0.5)
                        .opacity(animateCheckmark ? 1.0 : 0.0)

                    Image(systemName: "checkmark")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                        .scaleEffect(animateCheckmark ? 1.0 : 0.5)
                        .opacity(animateCheckmark ? 1.0 : 0.0)
                }
                .padding(.bottom, Spacing.lg)

                // Confetti Overlay (for high ratings 4+)
                if showConfetti {
                    ConfettiView()
                        .allowsHitTesting(false)
                }

                // Heading
                Text(review.overallRating >= 4 ? "Thank You!" : "Thank You for Your Feedback")
                    .font(.h1)
                    .foregroundColor(.textPrimary)
                    .padding(.bottom, Spacing.xs)

                // Subheading
                Text(review.overallRating >= 4
                     ? "Your review has been\nsubmitted successfully"
                     : "We appreciate your\nhonest review")
                    .font(.bodyLarge)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.bottom, Spacing.xl)

                // Review Summary Card
                ReviewSummaryCard(review: review)
                    .padding(.horizontal, Spacing.screenPadding)
                    .padding(.bottom, Spacing.md)

                // Share Button
                Button(action: {
                    Haptics.light()
                    shareReview()
                }) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: Spacing.iconSM))
                        Text("Share Your Review")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(Spacing.radiusLg)
                }
                .padding(.horizontal, Spacing.screenPadding)
                .padding(.bottom, Spacing.lg)

                Divider()
                    .padding(.horizontal, Spacing.screenPadding)
                    .padding(.bottom, Spacing.md)

                // Action Buttons
                VStack(spacing: Spacing.md) {
                    // View My Review
                    PrimaryButton(
                        "View My Review",
                        size: .large
                    ) {
                        Haptics.medium()
                        viewReview()
                    }
                    .padding(.horizontal, Spacing.screenPadding)

                    // Book Again
                    SecondaryButton(
                        "Book Again",
                        size: .large
                    ) {
                        Haptics.medium()
                        bookAgain()
                    }
                    .padding(.horizontal, Spacing.screenPadding)

                    // Return to Home
                    Button(action: {
                        Haptics.light()
                        returnHome()
                    }) {
                        Text("Return to Home")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.textSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                    }
                    .padding(.horizontal, Spacing.screenPadding)
                }
                .padding(.bottom, Spacing.md)

                // Helpful Tip
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "lightbulb.fill")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.secondary)

                    Text(review.overallRating >= 4
                         ? "Your review helps others make informed decisions!"
                         : "Your feedback helps providers improve their service")
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                        .lineSpacing(3)
                }
                .padding(Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(Spacing.radiusLg)
                .padding(.horizontal, Spacing.screenPadding)

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            // Animate checkmark
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                animateCheckmark = true
            }

            // Show confetti for high ratings (4+)
            if review.overallRating >= 4 && !reduceMotion {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showConfetti = true
                }
            }

            // Haptic success feedback
            Haptics.success()
        }
        .accessibilityLabel("Review submitted successfully")
        .accessibilityHint("Your \(review.overallRating) star review for \(review.providerName) has been posted")
    }

    // MARK: - Actions

    private func shareReview() {
        let shareText = "I just reviewed \(review.providerName) on UrbanNest! ⭐ \(review.overallRating)/5"
        let activityVC = UIActivityViewController(
            activityItems: [shareText, review.reviewURL],
            applicationActivities: nil
        )

        // Get the root view controller
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }

    private func viewReview() {
        // TODO: Navigate to provider reviews list with user's review highlighted
        dismiss()
    }

    private func bookAgain() {
        // TODO: Navigate to service detail for same provider/service
        dismiss()
    }

    private func returnHome() {
        dismiss()
    }
}

// MARK: - Review Summary Card

struct ReviewSummaryCard: View {
    let review: SubmittedReview

    var body: some View {
        VStack(spacing: Spacing.md) {
            // Star Rating
            HStack(spacing: Spacing.xxs) {
                ForEach(0..<review.overallRating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.secondary)
                }
                ForEach(0..<(5 - review.overallRating), id: \.self) { _ in
                    Image(systemName: "star")
                        .font(.system(size: 24))
                        .foregroundColor(.textTertiary)
                }
            }
            .padding(.top, Spacing.xxs)

            Text("\(String(format: "%.1f", Double(review.overallRating))) Overall Rating")
                .font(.h5)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)

            Divider()

            // Review Details
            VStack(spacing: Spacing.sm) {
                HStack(spacing: Spacing.xs) {
                    Text("Reviewed:")
                        .font(.label)
                        .foregroundColor(.textSecondary)
                    Spacer()
                }

                HStack(spacing: Spacing.xs) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.primary)

                    Text("\(review.providerName) (\(review.serviceName))")
                        .font(.bodySmall)
                        .foregroundColor(.textPrimary)

                    Spacer()
                }

                HStack(spacing: Spacing.xs) {
                    Image(systemName: "calendar")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.primary)

                    Text(review.submittedDate.formatted(date: .long, time: .omitted))
                        .font(.bodySmall)
                        .foregroundColor(.textPrimary)

                    Spacer()
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusLg)
                .stroke(Color.divider, lineWidth: 1)
        )
    }
}

// MARK: - Confetti View

struct ConfettiView: View {
    @State private var confettiPieces: [ConfettiPiece] = []

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(confettiPieces) { piece in
                    Rectangle()
                        .fill(piece.color)
                        .frame(width: 10, height: 10)
                        .rotationEffect(.degrees(piece.rotation))
                        .position(x: piece.x, y: piece.y)
                }
            }
            .onAppear {
                generateConfetti(in: geometry.size)
            }
        }
    }

    private func generateConfetti(in size: CGSize) {
        let colors: [Color] = [.primary, .secondary, .success, .warning]

        for i in 0..<50 {
            let piece = ConfettiPiece(
                id: i,
                color: colors.randomElement() ?? .primary,  // FIXED: Use nil coalescing
                x: CGFloat.random(in: 0...size.width),
                y: -20,
                rotation: Double.random(in: 0...360),
                speed: CGFloat.random(in: 2...5)
            )
            confettiPieces.append(piece)
        }

        // Animate falling
        withAnimation(.linear(duration: 3.0)) {
            for i in 0..<confettiPieces.count {
                confettiPieces[i].y = size.height + 20
                confettiPieces[i].rotation += Double.random(in: 360...720)
            }
        }
    }
}

struct ConfettiPiece: Identifiable {
    let id: Int
    let color: Color
    var x: CGFloat
    var y: CGFloat
    var rotation: Double
    let speed: CGFloat
}

// MARK: - Data Model

struct SubmittedReview {
    let reviewId: String
    let bookingId: String
    let providerId: String
    let providerName: String
    let serviceName: String
    let overallRating: Int
    let submittedDate: Date
    let reviewURL: URL
}

// MARK: - Preview

#Preview("Review Submitted - 5 Stars") {
    ReviewSubmittedView(
        review: SubmittedReview(
            reviewId: "rev_123",
            bookingId: "bkg_456",
            providerId: "prv_789",
            providerName: "John Doe",
            serviceName: "Electrician",
            overallRating: 5,
            submittedDate: Date(),
            reviewURL: URL(string: "https://urbannest.com/reviews/rev_123")!
        )
    )
}

#Preview("Review Submitted - 3 Stars") {
    ReviewSubmittedView(
        review: SubmittedReview(
            reviewId: "rev_124",
            bookingId: "bkg_457",
            providerId: "prv_790",
            providerName: "Jane Smith",
            serviceName: "Plumber",
            overallRating: 3,
            submittedDate: Date(),
            reviewURL: URL(string: "https://urbannest.com/reviews/rev_124")!
        )
    )
}

#Preview("Review Submitted - Dark Mode") {
    ReviewSubmittedView(
        review: SubmittedReview(
            reviewId: "rev_125",
            bookingId: "bkg_458",
            providerId: "prv_791",
            providerName: "Mike Johnson",
            serviceName: "AC Repair",
            overallRating: 5,
            submittedDate: Date(),
            reviewURL: URL(string: "https://urbannest.com/reviews/rev_125")!
        )
    )
    .preferredColorScheme(.dark)
}
