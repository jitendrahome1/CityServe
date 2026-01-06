//
//  PaymentMethodView.swift
//  CityServe
//
//  Payment Method Selection
//

import SwiftUI

struct PaymentMethodView: View {

    @ObservedObject var viewModel: BookingViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.xl) {
                // Header
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Choose payment method")
                        .font(.h3)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    Text("Select how you'd like to pay")
                        .font(.body)
                        .foregroundColor(.textSecondary)
                }

                // Amount to Pay
                amountSection

                // Saved Payment Methods
                if !viewModel.paymentMethods.isEmpty {
                    savedMethodsSection
                }

                // All Payment Methods
                allMethodsSection

                // Payment Security Notice
                securityNotice

                Spacer(minLength: Spacing.xl)
            }
            .padding(Spacing.screenPadding)
        }
    }

    // MARK: - Subviews

    private var amountSection: some View {
        VStack(spacing: Spacing.sm) {
            HStack {
                Text("Amount to Pay")
                    .font(.body)
                    .foregroundColor(.textSecondary)

                Spacer()

                Text("₹\(Int(viewModel.totalAmount))")
                    .font(.custom("Inter-Bold", size: 32))
                    .foregroundColor(.primary)
            }

            if let pricing = viewModel.pricing, pricing.discount > 0 {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.body)
                        .foregroundColor(.success)

                    Text("You saved ₹\(Int(pricing.discount))")
                        .font(.bodySmall)
                        .fontWeight(.medium)
                        .foregroundColor(.success)

                    Spacer()
                }
            }
        }
        .padding(Spacing.lg)
        .background(
            LinearGradient(
                colors: [Color.primary.opacity(0.05), Color.primaryLight.opacity(0.03)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(Spacing.radiusLg)
    }

    private var savedMethodsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Saved Payment Methods")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            ForEach(viewModel.paymentMethods) { method in
                SavedPaymentMethodCard(
                    method: method,
                    isSelected: viewModel.savedPaymentMethodId == method.id,
                    onSelect: {
                        viewModel.selectSavedPaymentMethod(method.id)
                    }
                )
            }
        }
    }

    private var allMethodsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Other Payment Methods")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            ForEach(PaymentMethod.allCases, id: \.self) { method in
                PaymentMethodCard(
                    method: method,
                    isSelected: viewModel.selectedPaymentMethod == method && viewModel.savedPaymentMethodId == nil,
                    onSelect: {
                        viewModel.selectPaymentMethod(method)
                    }
                )
            }
        }
    }

    private var securityNotice: some View {
        HStack(alignment: .top, spacing: Spacing.sm) {
            Image(systemName: "lock.shield.fill")
                .font(.system(size: Spacing.iconSM))
                .foregroundColor(.success)

            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text("100% Secure Payments")
                    .font(.bodySmall)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Text("Your payment information is encrypted and secure. We use Razorpay for payment processing.")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                    .lineSpacing(2)
            }
        }
        .padding(Spacing.md)
        .background(Color.success.opacity(0.05))
        .cornerRadius(Spacing.radiusLg)
    }
}

// MARK: - Saved Payment Method Card

struct SavedPaymentMethodCard: View {
    let method: SavedPaymentMethod
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: {
            Haptics.light()
            onSelect()
        }) {
            HStack(spacing: Spacing.md) {
                // Selection indicator
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color.primary : Color.divider, lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if isSelected {
                        Circle()
                            .fill(Color.primary)
                            .frame(width: 14, height: 14)
                    }
                }

                // Icon
                Image(systemName: method.type.icon)
                    .font(.h3)
                    .foregroundColor(.primary)
                    .frame(width: 40)

                // Details
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(method.displayName)
                        .font(.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimary)

                    Text(method.type.displayText)
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                }

                Spacer()

                if method.isDefault {
                    Text("DEFAULT")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal, Spacing.xs)
                        .padding(.vertical, 2)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(4)
                }
            }
            .padding(Spacing.md)
            .background(isSelected ? Color.primary.opacity(0.05) : Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .stroke(isSelected ? Color.primary : Color.divider, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Payment Method Card

struct PaymentMethodCard: View {
    let method: PaymentMethod
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: {
            Haptics.light()
            onSelect()
        }) {
            HStack(spacing: Spacing.md) {
                // Selection indicator
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color.primary : Color.divider, lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if isSelected {
                        Circle()
                            .fill(Color.primary)
                            .frame(width: 14, height: 14)
                    }
                }

                // Icon
                Image(systemName: method.icon)
                    .font(.h3)
                    .foregroundColor(.primary)
                    .frame(width: 40)

                // Details
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(method.displayText)
                        .font(.bodyLarge)
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimary)

                    if method == .cashOnService {
                        Text("Pay after service completion")
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)
                    } else {
                        Text("Secure payment")
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)
                    }
                }

                Spacer()

                if method == .upi {
                    Image(systemName: "indianrupeesign.circle.fill")
                        .font(.h4)
                        .foregroundColor(.success)
                }
            }
            .padding(Spacing.md)
            .background(isSelected ? Color.primary.opacity(0.05) : Color.surface)
            .cornerRadius(Spacing.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .stroke(isSelected ? Color.primary : Color.divider, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    let viewModel = BookingViewModel(service: Service.mockServices[0])
    viewModel.pricing = BookingPricing(
        basePrice: 499,
        taxes: 89.82,
        platformFee: 20,
        discount: 100,
        promoCode: "FIRST20",
        total: 508.82
    )
    viewModel.paymentMethods = SavedPaymentMethod.mockSavedMethods

    return NavigationStack {
        PaymentMethodView(viewModel: viewModel)
    }
}
