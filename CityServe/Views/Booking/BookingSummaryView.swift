//
//  BookingSummaryView.swift
//  CityServe
//
//  Booking Summary and Review
//

import SwiftUI

struct BookingSummaryView: View {

    @ObservedObject var viewModel: BookingViewModel
    @State private var showPromoSheet = false
    @FocusState private var isInstructionsFocused: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Header
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Review your booking")
                        .font(.h3)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    Text("Please verify all details before proceeding")
                        .font(.body)
                        .foregroundColor(.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Service Details
                serviceSection

                Divider()

                // Address Details
                addressSection

                Divider()

                // Date & Time Details
                dateTimeSection

                Divider()

                // Special Instructions
                instructionsSection

                Divider()

                // Promo Code
                promoCodeSection

                Divider()

                // Price Breakdown
                pricingSection

                Spacer(minLength: Spacing.xl)
            }
            .padding(Spacing.screenPadding)
        }
        .sheet(isPresented: $showPromoSheet) {
            PromoCodeSheet(viewModel: viewModel)
        }
    }

    // MARK: - Subviews

    private var serviceSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Service")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            HStack(spacing: Spacing.md) {
                // Service Icon
                ZStack {
                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                        .fill(Color.primary.opacity(0.1))
                        .frame(width: 60, height: 60)

                    if let icon = viewModel.service.icon {
                        Image(systemName: icon)
                            .font(.h2)
                            .foregroundColor(.primary)
                    }
                }

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(viewModel.service.name)
                        .font(.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "clock")
                            .font(.system(size: Spacing.iconXS))

                        Text(viewModel.service.formattedDuration)
                            .font(.bodySmall)
                    }
                    .foregroundColor(.textSecondary)

                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "star.fill")
                            .font(.system(size: Spacing.iconXS))
                            .foregroundColor(.warning)

                        Text(String(format: "%.1f", viewModel.service.rating))
                            .font(.caption)
                            .foregroundColor(.textSecondary)
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
            HStack {
                Text("Service Address")
                    .font(.h5)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.semibold)

                Spacer()

                Button(action: {
                    viewModel.goToStep(.address)
                }) {
                    Text("Change")
                        .font(.bodySmall)
                        .foregroundColor(.primary)
                        .fontWeight(.medium)
                }
            }

            if let address = viewModel.selectedAddress {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    HStack {
                        Image(systemName: "location.fill")
                            .font(.body)
                            .foregroundColor(.primary)

                        Text(address.label)
                            .font(.bodyLarge)
                            .fontWeight(.medium)
                            .foregroundColor(.textPrimary)
                    }

                    Text(address.fullAddress)
                        .font(.body)
                        .foregroundColor(.textSecondary)
                        .lineSpacing(2)

                    Text(address.city)
                        .font(.bodySmall)
                        .foregroundColor(.textTertiary)
                }
                .padding(Spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusLg)
            }
        }
    }

    private var dateTimeSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Text("Date & Time")
                    .font(.h5)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.semibold)

                Spacer()

                Button(action: {
                    viewModel.goToStep(.dateTime)
                }) {
                    Text("Change")
                        .font(.bodySmall)
                        .foregroundColor(.primary)
                        .fontWeight(.medium)
                }
            }

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

                        Text(formatDate(viewModel.selectedDate))
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

                        Text(viewModel.selectedTimeSlot?.displayText ?? "Not selected")
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

    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Special Instructions (Optional)")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            TextEditor(text: $viewModel.specialInstructions)
                .font(.input)
                .frame(height: 80)
                .padding(Spacing.md)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusLg)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                        .stroke(Color.divider, lineWidth: 1)
                )
                .focused($isInstructionsFocused)

            if viewModel.specialInstructions.isEmpty && !isInstructionsFocused {
                Text("Add any special requirements or notes for the service provider")
                    .font(.caption)
                    .foregroundColor(.textTertiary)
                    .padding(.horizontal, Spacing.sm)
            }
        }
    }

    private var promoCodeSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Promo Code")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            if let promo = viewModel.appliedPromoCode {
                // Applied Promo Code
                HStack {
                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                        HStack(spacing: Spacing.xs) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: Spacing.iconSM))
                                .foregroundColor(.success)

                            Text(promo.code)
                                .font(.bodyLarge)
                                .fontWeight(.bold)
                                .foregroundColor(.success)
                        }

                        Text(promo.description)
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)

                        Text("You saved \(promo.formattedDiscount)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.success)
                    }

                    Spacer()

                    Button(action: {
                        viewModel.removePromoCode()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.h4)
                            .foregroundColor(.textTertiary)
                    }
                }
                .padding(Spacing.md)
                .background(Color.success.opacity(0.1))
                .cornerRadius(Spacing.radiusLg)
            } else {
                // Apply Promo Code Button
                Button(action: {
                    showPromoSheet = true
                }) {
                    HStack {
                        Image(systemName: "ticket")
                            .font(.h5)
                            .foregroundColor(.primary)

                        Text("Apply Promo Code")
                            .font(.bodyLarge)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.body)
                            .foregroundColor(.textTertiary)
                    }
                    .padding(Spacing.md)
                    .background(Color.surface)
                    .cornerRadius(Spacing.radiusLg)
                    .overlay(
                        RoundedRectangle(cornerRadius: Spacing.radiusLg)
                            .stroke(Color.primary.opacity(0.3), style: StrokeStyle(lineWidth: 1.5, dash: [5, 5]))
                    )
                }
            }
        }
    }

    private var pricingSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Price Details")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            if let pricing = viewModel.pricing {
                VStack(spacing: Spacing.sm) {
                    // Base Price
                    PriceRow(label: "Service Charge", value: pricing.formattedSubtotal)

                    // Taxes
                    PriceRow(label: "Taxes & Fees", value: pricing.formattedTaxes)

                    // Platform Fee
                    PriceRow(label: "Platform Fee", value: pricing.formattedPlatformFee)

                    // Discount
                    if pricing.discount > 0 {
                        PriceRow(
                            label: "Discount",
                            value: "- \(pricing.formattedDiscount)",
                            valueColor: .success
                        )
                    }

                    Divider()

                    // Total
                    HStack {
                        Text("Total Amount")
                            .font(.h5)
                            .fontWeight(.bold)
                            .foregroundColor(.textPrimary)

                        Spacer()

                        Text(pricing.formattedTotal)
                            .font(.h4)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                }
                .padding(Spacing.md)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusLg)
            }
        }
    }

    // MARK: - Helper Methods

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}

// MARK: - Price Row

struct PriceRow: View {
    let label: String
    let value: String
    var valueColor: Color = .textPrimary

    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(.textSecondary)

            Spacer()

            Text(value)
                .font(.bodyLarge)
                .fontWeight(.medium)
                .foregroundColor(valueColor)
        }
    }
}

// MARK: - Promo Code Sheet

struct PromoCodeSheet: View {
    @ObservedObject var viewModel: BookingViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var promoCodeInput = ""
    @State private var isApplying = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                VStack(spacing: Spacing.lg) {
                    // Promo Code Input
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Text("Enter Promo Code")
                            .font(.label)
                            .foregroundColor(.textPrimary)

                        HStack(spacing: Spacing.sm) {
                            TextField("Enter code", text: $promoCodeInput)
                                .font(.input)
                                .textInputAutocapitalization(.characters)
                                .autocorrectionDisabled()
                                .padding(Spacing.md)
                                .background(Color.surface)
                                .cornerRadius(Spacing.radiusLg)

                            PrimaryButton(
                                "Apply",
                                isDisabled: promoCodeInput.isEmpty,
                                isLoading: isApplying,
                                size: .medium,
                                action: {
                                    applyPromo()
                                }
                            )
                            .frame(width: 100)
                        }
                    }

                    // Available Promo Codes
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        Text("Available Offers")
                            .font(.h5)
                            .foregroundColor(.textPrimary)
                            .fontWeight(.semibold)

                        ForEach(PromoCode.mockPromoCodes) { promo in
                            PromoCodeCard(promo: promo) {
                                promoCodeInput = promo.code
                                applyPromo()
                            }
                        }
                    }

                    Spacer()
                }
                .padding(Spacing.screenPadding)
            }
            .navigationTitle("Promo Codes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func applyPromo() {
        isApplying = true

        Task {
            let success = await viewModel.applyPromoCode(promoCodeInput)
            isApplying = false

            if success {
                dismiss()
            }
        }
    }
}

// MARK: - Promo Code Card

struct PromoCodeCard: View {
    let promo: PromoCode
    let onApply: () -> Void

    var body: some View {
        Button(action: onApply) {
            HStack(spacing: Spacing.md) {
                Image(systemName: "ticket.fill")
                    .font(.h3)
                    .foregroundColor(.secondary)

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(promo.code)
                        .font(.bodyLarge)
                        .fontWeight(.bold)
                        .foregroundColor(.textPrimary)

                    Text(promo.description)
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                        .lineLimit(2)

                    Text(promo.formattedDiscount)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Text("Apply")
                    .font(.bodySmall)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .stroke(Color.divider, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    let viewModel = BookingViewModel(service: Service.mockServices[0])
    viewModel.selectedAddress = Address(
        id: "1",
        label: "Home",
        fullAddress: "123, MG Road, Connaught Place, New Delhi - 110001",
        city: "Delhi",
        isDefault: true
    )
    viewModel.selectedDate = Date()
    viewModel.selectedTimeSlot = TimeSlot.mockTimeSlots[0]
    viewModel.calculatePricing()

    return NavigationStack {
        BookingSummaryView(viewModel: viewModel)
    }
}
