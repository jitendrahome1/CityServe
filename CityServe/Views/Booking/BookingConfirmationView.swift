//
//  BookingConfirmationView.swift
//  CityServe
//
//  Booking Success Confirmation Screen
//

import SwiftUI

struct BookingConfirmationView: View {

    let booking: Booking
    @Environment(\.dismiss) private var dismiss
    @State private var showConfetti = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: Spacing.xl) {
                        // Success Animation
                        successAnimation

                        // Booking ID
                        bookingIdSection

                        // Booking Details Card
                        bookingDetailsCard

                        // Next Steps
                        nextStepsSection

                        // Action Buttons
                        actionButtons

                        Spacer(minLength: Spacing.xl)
                    }
                    .padding(Spacing.screenPadding)
                }
            }
            .navigationTitle("Booking Confirmed")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Navigate back to home
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.button)
                            .foregroundColor(.textPrimary)
                    }
                }
            }
            .onAppear {
                Haptics.success()
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    showConfetti = true
                }
            }
        }
    }

    // MARK: - Subviews

    private var successAnimation: some View {
        VStack(spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.success.opacity(0.1), Color.success.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 140, height: 140)

                Circle()
                    .fill(Color.success.opacity(0.1))
                    .frame(width: 100, height: 100)

                Image(systemName: "checkmark.circle.fill")
                    .font(.displayLarge)
                    .foregroundColor(.success)
                    .scaleEffect(showConfetti ? 1.0 : 0.5)
                    .opacity(showConfetti ? 1.0 : 0.0)
            }

            VStack(spacing: Spacing.xs) {
                Text("Booking Confirmed!")
                    .font(.h2)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.bold)

                Text("Your service has been successfully booked")
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.top, Spacing.xl)
    }

    private var bookingIdSection: some View {
        VStack(spacing: Spacing.xs) {
            Text("Booking ID")
                .font(.caption)
                .foregroundColor(.textTertiary)

            HStack(spacing: Spacing.xs) {
                Text("#\(booking.id.prefix(8).uppercased())")
                    .font(.h4)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Button(action: {
                    UIPasteboard.general.string = booking.id
                    Haptics.light()
                }) {
                    Image(systemName: "doc.on.doc")
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.primary.opacity(0.05))
        .cornerRadius(Spacing.radiusMd)
    }

    private var bookingDetailsCard: some View {
        VStack(spacing: Spacing.lg) {
            // Service
            DetailRow(
                icon: "wrench.and.screwdriver.fill",
                label: "Service",
                value: booking.serviceName
            )

            Divider()

            // Date & Time
            DetailRow(
                icon: "calendar",
                label: "Date & Time",
                value: booking.formattedScheduledTime
            )

            Divider()

            // Address
            VStack(alignment: .leading, spacing: Spacing.xs) {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "location.fill")
                        .font(.body)
                        .foregroundColor(.primary)

                    Text("Service Address")
                        .font(.bodySmall)
                        .foregroundColor(.textTertiary)
                }

                Text(booking.address.fullAddress)
                    .font(.body)
                    .foregroundColor(.textPrimary)
                    .lineSpacing(2)
            }

            Divider()

            // Payment
            HStack {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.body)
                        .foregroundColor(.success)

                    Text("Payment")
                        .font(.bodySmall)
                        .foregroundColor(.textTertiary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: Spacing.xxs) {
                    Text("₹\(Int(booking.pricing.total))")
                        .font(.h5)
                        .fontWeight(.bold)
                        .foregroundColor(.textPrimary)

                    Text("Paid")
                        .font(.caption)
                        .foregroundColor(.success)
                }
            }
        }
        .padding(Spacing.lg)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
    }

    private var nextStepsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("What's Next?")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: Spacing.md) {
                NextStepRow(
                    number: 1,
                    title: "Provider Assignment",
                    description: "We'll assign a verified professional to your booking"
                )

                NextStepRow(
                    number: 2,
                    title: "Confirmation Call",
                    description: "The provider will contact you to confirm the details"
                )

                NextStepRow(
                    number: 3,
                    title: "Service Delivery",
                    description: "Professional will arrive at your scheduled time"
                )

                NextStepRow(
                    number: 4,
                    title: "Review & Rating",
                    description: "Share your experience after service completion"
                )
            }
            .padding(Spacing.md)
            .background(Color.info.opacity(0.05))
            .cornerRadius(Spacing.radiusMd)
        }
    }

    private var actionButtons: some View {
        VStack(spacing: Spacing.md) {
            // View Booking Button
            NavigationLink(destination: Text("Booking Details - Coming Soon")) {
                HStack {
                    Image(systemName: "doc.text")
                        .font(.h5)

                    Text("View Booking Details")
                        .font(.bodyLarge)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color.primary)
                .cornerRadius(Spacing.radiusMd)
            }

            // Back to Home Button
            Button(action: {
                dismiss()
            }) {
                HStack {
                    Image(systemName: "house")
                        .font(.h5)

                    Text("Back to Home")
                        .font(.bodyLarge)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusMd)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.radiusMd)
                        .stroke(Color.primary, lineWidth: 1.5)
                )
            }
        }
    }
}

// MARK: - Detail Row

struct DetailRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(.primary)

            Text(label)
                .font(.bodySmall)
                .foregroundColor(.textTertiary)

            Spacer()

            Text(value)
                .font(.bodyLarge)
                .fontWeight(.medium)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.trailing)
        }
    }
}

// MARK: - Next Step Row

struct NextStepRow: View {
    let number: Int
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.sm) {
            ZStack {
                Circle()
                    .fill(Color.primary.opacity(0.1))
                    .frame(width: 28, height: 28)

                Text("\(number)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(title)
                    .font(.bodyLarge)
                    .fontWeight(.medium)
                    .foregroundColor(.textPrimary)

                Text(description)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
                    .lineSpacing(2)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    let booking = Booking(
        id: "BK12345678",
        serviceId: "1",
        serviceName: "AC Repair & Service",
        categoryId: "1",
        customerId: "U123",
        providerId: nil,
        providerName: nil,
        address: Address(
            id: "1",
            label: "Home",
            fullAddress: "123, MG Road, Connaught Place, New Delhi - 110001",
            city: "Delhi",
            isDefault: true
        ),
        scheduledDate: Date().addingTimeInterval(24 * 60 * 60),
        scheduledTimeSlot: TimeSlot(id: "1", startTime: "10:00", endTime: "11:00", isAvailable: true),
        pricing: BookingPricing(
            basePrice: 499,
            taxes: 89.82,
            platformFee: 20,
            discount: 0,
            promoCode: nil,
            total: 608.82
        ),
        payment: PaymentInfo(
            id: "PAY123",
            method: .upi,
            status: .completed,
            amount: 608.82,
            transactionId: "TXN123456",
            razorpayOrderId: "order_123",
            razorpayPaymentId: "pay_456",
            timestamp: Date()
        ),
        status: .pending,
        statusHistory: [],
        instructions: nil,
        images: nil,
        createdAt: Date(),
        updatedAt: Date(),
        completedAt: nil,
        cancelledAt: nil
    )

    return BookingConfirmationView(booking: booking)
}
