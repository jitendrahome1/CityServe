//
//  BookingDetailView.swift
//  CityServe
//
//  Detailed Booking View with Tracking
//

import SwiftUI

struct BookingDetailView: View {

    let booking: Booking
    @StateObject private var viewModel = OrdersViewModel()
    @State private var showCancelAlert = false
    @State private var showReschedule = false
    @State private var showRatingSheet = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: Spacing.xl) {
                    // Status Timeline
                    statusTimeline

                    // Service Details
                    serviceSection

                    Divider()

                    // Date & Time
                    dateTimeSection

                    Divider()

                    // Address
                    addressSection

                    Divider()

                    // Provider Details (if assigned)
                    if booking.providerId != nil {
                        providerSection
                        Divider()
                    }

                    // Special Instructions
                    if let instructions = booking.instructions {
                        instructionsSection(instructions)
                        Divider()
                    }

                    // Payment Details
                    paymentSection

                    // Action Buttons
                    actionButtons

                    Spacer(minLength: Spacing.xl)
                }
                .padding(Spacing.screenPadding)
            }
        }
        .navigationTitle("Booking Details")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Cancel Booking", isPresented: $showCancelAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Yes, Cancel Booking", role: .destructive) {
                cancelBooking()
            }
        } message: {
            Text("Are you sure you want to cancel this booking? This action cannot be undone.")
        }
        .sheet(isPresented: $showRatingSheet) {
            RatingSheetView(booking: booking)
        }
    }

    // MARK: - Subviews

    private var statusTimeline: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Booking Status")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            // Current Status Card
            HStack(spacing: Spacing.md) {
                ZStack {
                    Circle()
                        .fill(statusColor.opacity(0.15))
                        .frame(width: 56, height: 56)

                    Image(systemName: statusIcon)
                        .font(.h2)
                        .foregroundColor(statusColor)
                }

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(booking.status.displayText)
                        .font(.h4)
                        .fontWeight(.bold)
                        .foregroundColor(.textPrimary)

                    Text(statusMessage)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                }

                Spacer()
            }
            .padding(Spacing.md)
            .background(statusColor.opacity(0.05))
            .cornerRadius(Spacing.radiusLg)

            // Status History
            if booking.statusHistory.count > 1 {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Timeline")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)

                    ForEach(booking.statusHistory.reversed()) { update in
                        StatusHistoryRow(update: update, isLatest: update.id == booking.statusHistory.last?.id)
                    }
                }
            }
        }
    }

    private var serviceSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Service Details")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            HStack(spacing: Spacing.md) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                        .fill(Color.primary.opacity(0.1))
                        .frame(width: 60, height: 60)

                    Image(systemName: serviceIcon)
                        .font(.h2)
                        .foregroundColor(.primary)
                }

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(booking.serviceName)
                        .font(.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    Text("Booking ID: #\(booking.id.prefix(8).uppercased())")
                        .font(.bodySmall)
                        .foregroundColor(.textTertiary)

                    Text("Created: \(formatDate(booking.createdAt))")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }

                Spacer()
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
        }
    }

    private var dateTimeSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Scheduled Date & Time")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            HStack(spacing: Spacing.lg) {
                // Date
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "calendar")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.primary)

                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                        Text("Date")
                            .font(.caption)
                            .foregroundColor(.textTertiary)

                        Text(formatDetailedDate(booking.scheduledDate))
                            .font(.bodyLarge)
                            .fontWeight(.medium)
                            .foregroundColor(.textPrimary)
                    }
                }

                Divider()
                    .frame(height: 40)

                // Time
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "clock")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.primary)

                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                        Text("Time")
                            .font(.caption)
                            .foregroundColor(.textTertiary)

                        Text(booking.scheduledTimeSlot.displayText)
                            .font(.bodyLarge)
                            .fontWeight(.medium)
                            .foregroundColor(.textPrimary)
                    }
                }

                Spacer()
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
        }
    }

    private var addressSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Service Address")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "location.fill")
                        .font(.body)
                        .foregroundColor(.primary)

                    Text(booking.address.label)
                        .font(.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimary)
                }

                Text(booking.address.fullAddress)
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .lineSpacing(2)

                Text(booking.address.city)
                    .font(.bodySmall)
                    .foregroundColor(.textTertiary)
            }
            .padding(Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
        }
    }

    private var providerSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Service Provider")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            HStack(spacing: Spacing.md) {
                // Provider Avatar
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.primary, Color.primaryDark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text(booking.providerName?.prefix(1) ?? "P")
                            .font(.h4)
                            .foregroundColor(.white)
                    )

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    HStack(spacing: Spacing.xs) {
                        Text(booking.providerName ?? "Not Assigned")
                            .font(.bodyLarge)
                            .fontWeight(.semibold)
                            .foregroundColor(.textPrimary)

                        Image(systemName: "checkmark.seal.fill")
                            .font(.body)
                            .foregroundColor(.primary)
                    }

                    Text("Verified Professional")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                }

                Spacer()

                // Call button
                Button(action: {
                    // Call provider
                }) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(Color.success)
                        .clipShape(Circle())
                }
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
        }
    }

    private func instructionsSection(_ instructions: String) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Special Instructions")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            Text(instructions)
                .font(.body)
                .foregroundColor(.textSecondary)
                .lineSpacing(2)
                .padding(Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.info.opacity(0.05))
                .cornerRadius(Spacing.radiusLg)
        }
    }

    private var paymentSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Payment Details")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            VStack(spacing: Spacing.sm) {
                PriceRow(label: "Service Charge", value: booking.pricing.formattedSubtotal)
                PriceRow(label: "Taxes & Fees", value: booking.pricing.formattedTaxes)
                PriceRow(label: "Platform Fee", value: booking.pricing.formattedPlatformFee)

                if booking.pricing.discount > 0 {
                    PriceRow(
                        label: "Discount",
                        value: "- \(booking.pricing.formattedDiscount)",
                        valueColor: .success
                    )
                }

                Divider()

                HStack {
                    Text("Total Paid")
                        .font(.bodyLarge)
                        .fontWeight(.bold)
                        .foregroundColor(.textPrimary)

                    Spacer()

                    Text(booking.pricing.formattedTotal)
                        .font(.h5)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)

            // Payment Status
            if let payment = booking.payment {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.body)
                        .foregroundColor(.success)

                    Text("Paid via \(payment.method.displayText)")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)

                    Spacer()

                    Text(payment.transactionId ?? "")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }
                .padding(.horizontal, Spacing.sm)
            }
        }
    }

    private var actionButtons: some View {
        VStack(spacing: Spacing.md) {
            // Cancel or Rate & Review buttons based on status
            if booking.canCancel {
                HStack(spacing: Spacing.md) {
                    if booking.canReschedule {
                        SecondaryButton(
                            "Reschedule",
                            icon: "calendar",
                            size: .large,
                            action: {
                                showReschedule = true
                            }
                        )
                    }

                    SecondaryButton(
                        "Cancel Booking",
                        icon: "xmark.circle",
                        size: .large,
                        action: {
                            showCancelAlert = true
                        }
                    )
                    .foregroundColor(.error)
                }
            } else if booking.status == .completed {
                PrimaryButton(
                    "Rate & Review",
                    icon: "star.fill",
                    size: .large,
                    action: {
                        showRatingSheet = true
                    }
                )
            }

            // Get Help button
            SecondaryButton(
                "Get Help",
                icon: "questionmark.circle",
                size: .large,
                action: {
                    // Navigate to help
                }
            )
        }
    }

    // MARK: - Computed Properties

    private var serviceIcon: String {
        switch booking.categoryId {
        case "1": return "air.conditioner.horizontal"
        case "2": return "drop.fill"
        case "3": return "bolt.fill"
        case "4": return "scissors"
        case "5": return "sparkles"
        case "6": return "paintbrush.fill"
        default: return "wrench.and.screwdriver.fill"
        }
    }

    private var statusColor: Color {
        switch booking.status {
        case .pending: return .warning
        case .confirmed, .providerAssigned: return .info
        case .providerEnRoute, .inProgress: return .primary
        case .completed: return .success
        case .cancelled, .refunded: return .error
        }
    }

    private var statusIcon: String {
        switch booking.status {
        case .pending: return "clock"
        case .confirmed: return "checkmark.circle"
        case .providerAssigned: return "person.fill.checkmark"
        case .providerEnRoute: return "car.fill"
        case .inProgress: return "wrench.and.screwdriver.fill"
        case .completed: return "checkmark.circle.fill"
        case .cancelled, .refunded: return "xmark.circle.fill"
        }
    }

    private var statusMessage: String {
        switch booking.status {
        case .pending: return "Waiting for confirmation"
        case .confirmed: return "Booking confirmed, assigning provider"
        case .providerAssigned: return "Provider assigned to your booking"
        case .providerEnRoute: return "Provider is on the way"
        case .inProgress: return "Service in progress"
        case .completed: return "Service completed successfully"
        case .cancelled: return "Booking was cancelled"
        case .refunded: return "Payment refunded"
        }
    }

    // MARK: - Helper Methods

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }

    private func formatDetailedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM dd"
        return formatter.string(from: date)
    }

    private func cancelBooking() {
        Task {
            let success = await viewModel.cancelBooking(booking.id)
            if success {
                dismiss()
            }
        }
    }
}

// MARK: - Status History Row

struct StatusHistoryRow: View {
    let update: BookingStatusUpdate
    let isLatest: Bool

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.sm) {
            // Timeline indicator
            ZStack {
                if !isLatest {
                    Rectangle()
                        .fill(Color.divider)
                        .frame(width: 2)
                        .offset(y: 12)
                }

                Circle()
                    .fill(isLatest ? Color.primary : Color.divider)
                    .frame(width: 10, height: 10)
            }
            .frame(width: 10)

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(update.status.displayText)
                    .font(.bodySmall)
                    .fontWeight(isLatest ? .semibold : .regular)
                    .foregroundColor(.textPrimary)

                if let note = update.note {
                    Text(note)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }

                Text(formatTimestamp(update.timestamp))
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }
        }
    }

    private func formatTimestamp(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

// MARK: - Rating Sheet

struct RatingSheetView: View {
    let booking: Booking
    @Environment(\.dismiss) private var dismiss

    @State private var rating: Int = 5
    @State private var comment: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: Spacing.xl) {
                // Rating Stars
                VStack(spacing: Spacing.md) {
                    Text("How was your experience?")
                        .font(.h4)
                        .foregroundColor(.textPrimary)

                    HStack(spacing: Spacing.md) {
                        ForEach(1...5, id: \.self) { star in
                            Button(action: {
                                rating = star
                                Haptics.light()
                            }) {
                                Image(systemName: star <= rating ? "star.fill" : "star")
                                    .font(.h1)
                                    .foregroundColor(star <= rating ? .warning : .textTertiary)
                            }
                        }
                    }
                }

                // Comment
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Write a review (Optional)")
                        .font(.label)
                        .foregroundColor(.textPrimary)

                    TextEditor(text: $comment)
                        .font(.input)
                        .frame(height: 120)
                        .padding(Spacing.md)
                        .background(Color.surface)
                        .cornerRadius(Spacing.radiusLg)
                }

                Spacer()

                // Submit button
                PrimaryButton(
                    "Submit Review",
                    icon: "checkmark",
                    size: .large,
                    action: {
                        submitReview()
                    }
                )
            }
            .padding(Spacing.screenPadding)
            .navigationTitle("Rate Service")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func submitReview() {
        // Submit review
        Haptics.success()
        dismiss()
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        BookingDetailView(booking: Booking.mockBookings[1])
    }
}
