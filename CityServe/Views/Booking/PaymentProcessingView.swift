//
//  PaymentProcessingView.swift
//  CityServe
//
//  Payment processing with multiple states (processing, success, failure, UPI, etc.)
//  Design Spec: 16_PAYMENT_PROCESSING.md
//

import SwiftUI
import Combine

struct PaymentProcessingView: View {

    @StateObject private var viewModel: PaymentProcessingViewModel
    @Environment(\.dismiss) var dismiss

    init(booking: Booking, paymentMethod: PaymentMethodData) {
        self._viewModel = StateObject(wrappedValue: PaymentProcessingViewModel(
            booking: booking,
            paymentMethod: paymentMethod
        ))
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            // State-based content
            Group {
                switch viewModel.paymentState {
                case .initializing, .processing, .verifying:
                    ProcessingStateView()

                case .awaitingUPI(let upiId, let remainingTime):
                    UPICollectionView(
                        upiId: upiId,
                        amount: viewModel.amount,
                        remainingTime: remainingTime,
                        onConfirm: {
                            Task {
                                await viewModel.checkUPIStatus()
                            }
                        },
                        onCancel: {
                            viewModel.cancelPayment()
                        }
                    )

                case .success(let transactionId):
                    PaymentSuccessView(
                        amount: viewModel.amount,
                        paymentMethod: viewModel.paymentMethodName,
                        transactionId: transactionId
                    )

                case .failed(let error):
                    PaymentFailureView(
                        error: error,
                        transactionId: viewModel.transactionId,
                        onRetry: {
                            dismiss()
                        },
                        onContactSupport: {
                            // TODO: Open support
                        }
                    )

                case .timeout:
                    PaymentTimeoutView(
                        onRetry: {
                            dismiss()
                        }
                    )

                case .cancelled:
                    EmptyView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .interactiveDismissDisabled(true)
        .onAppear {
            Task {
                await viewModel.processPayment()
            }
        }
        .onChange(of: viewModel.paymentState) { oldValue, newValue in
            handleStateChange(newValue)
        }
    }

    private func handleStateChange(_ state: PaymentState) {
        switch state {
        case .success:
            Haptics.success()
            // Auto-redirect after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // TODO: Navigate to BookingConfirmationView
                dismiss()
            }

        case .failed:
            Haptics.heavy()

        case .timeout:
            Haptics.heavy()

        default:
            break
        }
    }
}

// MARK: - Processing State View

struct ProcessingStateView: View {
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            // Animated Spinner
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.primary, lineWidth: 6)
                .frame(width: 80, height: 80)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    .linear(duration: 1.5).repeatForever(autoreverses: false),
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true
                }

            // Status Text
            Text("Processing Payment...")
                .font(.h4)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)

            // Subtitle
            VStack(spacing: Spacing.xxs) {
                Text("Please wait")
                    .font(.body)
                    .foregroundColor(.textSecondary)
                Text("Do not press back or close")
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: 280)

            Spacer()
            Spacer()

            // Security Badge
            HStack(spacing: Spacing.xs) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(.success)

                VStack(alignment: .leading, spacing: 2) {
                    Text("🔒 Secure Payment")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.textSecondary)

                    Text("Powered by Razorpay")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .background(Color.primary.opacity(0.1))
            .cornerRadius(Spacing.radiusMd)

            Spacer()
        }
        .padding(.horizontal, Spacing.screenPadding)
    }
}

// MARK: - UPI Collection View

struct UPICollectionView: View {
    let upiId: String
    let amount: Double
    let remainingTime: Int
    let onConfirm: () -> Void
    let onCancel: () -> Void

    private var timeString: String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            // Phone Icon
            Image(systemName: "iphone.gen3")
                .font(.system(size: 64))
                .foregroundColor(.primary)

            // Status
            Text("Waiting for approval...")
                .font(.h4)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)

            // Amount
            Text("A payment request of ")
                .font(.body)
                .foregroundColor(.textSecondary)
            +
            Text("₹\(Int(amount))")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            +
            Text(" has been sent to your UPI app")
                .font(.body)
                .foregroundColor(.textSecondary)

            // UPI ID
            Text(upiId)
                .font(.system(.body, design: .monospaced))
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.xs)
                .background(Color.primary.opacity(0.1))
                .cornerRadius(Spacing.radiusMd)

            // Countdown Timer
            HStack(spacing: Spacing.xxs) {
                Image(systemName: "clock.fill")
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(.warning)

                Text(timeString)
                    .font(.h4)
                    .fontWeight(.medium)
                    .foregroundColor(.warning)
            }
            .padding(.top, Spacing.md)

            // Instruction
            Text("Please approve the payment\nin your UPI app")
                .font(.body)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, Spacing.sm)

            Spacer()

            // Confirmation Button
            PrimaryButton(
                "I've approved the payment",
                size: .large
            ) {
                Haptics.medium()
                onConfirm()
            }
            .padding(.horizontal, Spacing.screenPadding)

            // Cancel Link
            Button(action: {
                Haptics.light()
                onCancel()
            }) {
                Text("Cancel Payment")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.error)
            }
            .padding(.bottom, Spacing.lg)
        }
        .padding(.horizontal, Spacing.screenPadding)
    }
}

// MARK: - Payment Success View

struct PaymentSuccessView: View {
    let amount: Double
    let paymentMethod: String
    let transactionId: String

    @State private var showCheck = false

    var body: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            // Success Icon with Animation
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.success)
                .scaleEffect(showCheck ? 1 : 0)
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: showCheck)
                .onAppear {
                    showCheck = true
                }

            // Status
            Text("Payment Successful!")
                .font(.h3)
                .fontWeight(.bold)
                .foregroundColor(.textPrimary)
                .opacity(showCheck ? 1 : 0)
                .animation(.easeIn(duration: 0.3).delay(0.2), value: showCheck)

            // Details
            Text("₹\(Int(amount)) paid via \(paymentMethod)")
                .font(.body)
                .foregroundColor(.textSecondary)
                .opacity(showCheck ? 1 : 0)
                .animation(.easeIn(duration: 0.3).delay(0.3), value: showCheck)

            // Redirecting
            Text("Redirecting...")
                .font(.caption)
                .foregroundColor(.textTertiary)
                .opacity(showCheck ? 1 : 0)
                .animation(.easeIn(duration: 0.3).delay(0.4), value: showCheck)

            Spacer()
            Spacer()
        }
        .padding(.horizontal, Spacing.screenPadding)
    }
}

// MARK: - Payment Failure View

struct PaymentFailureView: View {
    let error: PaymentError
    let transactionId: String?
    let onRetry: () -> Void
    let onContactSupport: () -> Void

    @State private var showError = false

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                Spacer(minLength: 80)

                // Error Icon with Animation
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.error)
                    .scaleEffect(showError ? 1 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: showError)
                    .onAppear {
                        showError = true
                    }

                // Status
                Text("Payment Failed")
                    .font(.h3)
                    .fontWeight(.bold)
                    .foregroundColor(.textPrimary)

                // Error Message
                Text("Your payment could not be processed due to:")
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 300)
                    .padding(.top, Spacing.sm)

                // Error Reason
                Text(error.message)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.error)
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.xs)
                    .background(Color.error.opacity(0.1))
                    .cornerRadius(Spacing.radiusMd)

                // Transaction ID
                if let transactionId = transactionId {
                    HStack {
                        Text("Transaction ID:")
                            .font(.caption)
                            .foregroundColor(.textSecondary)

                        Text(transactionId)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.textTertiary)
                    }
                    .padding(.top, Spacing.sm)
                }

                Spacer(minLength: 40)

                // Retry Button
                PrimaryButton(
                    "Try Another Payment Method",
                    size: .large
                ) {
                    Haptics.medium()
                    onRetry()
                }
                .padding(.horizontal, Spacing.screenPadding)

                // Support Link
                Button(action: {
                    Haptics.light()
                    onContactSupport()
                }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: Spacing.iconSM))

                        Text("Contact Support")
                            .font(.body)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.primary)
                }
                .padding(.bottom, Spacing.xl)
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }
}

// MARK: - Payment Timeout View

struct PaymentTimeoutView: View {
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            // Timeout Icon
            Image(systemName: "clock.badge.xmark.fill")
                .font(.system(size: 80))
                .foregroundColor(.warning)

            // Status
            Text("Request Timed Out")
                .font(.h3)
                .fontWeight(.bold)
                .foregroundColor(.textPrimary)

            // Message
            Text("You didn't approve the payment within 5 minutes. Please try again.")
                .font(.body)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 300)

            Spacer()

            // Retry Button
            PrimaryButton(
                "Try Again",
                size: .large
            ) {
                Haptics.medium()
                onRetry()
            }
            .padding(.horizontal, Spacing.screenPadding)

            Spacer()
        }
        .padding(.horizontal, Spacing.screenPadding)
    }
}

// MARK: - Data Models

enum PaymentState: Equatable {
    case initializing
    case processing
    case awaitingUPI(upiId: String, remainingTime: Int)
    case verifying
    case success(transactionId: String)
    case failed(PaymentError)
    case timeout
    case cancelled
}

enum PaymentError: Equatable {
    case networkError
    case insufficientBalance
    case cardDeclined
    case authenticationFailed
    case serverError
    case bookingCreationFailed
    case unknown(String)

    var message: String {
        switch self {
        case .networkError:
            return "Network connection lost"
        case .insufficientBalance:
            return "Insufficient balance"
        case .cardDeclined:
            return "Card declined by bank"
        case .authenticationFailed:
            return "Authentication failed"
        case .serverError:
            return "Server error occurred"
        case .bookingCreationFailed:
            return "Booking creation failed"
        case .unknown(let msg):
            return msg
        }
    }
}

struct PaymentMethodData {
    let id: String
    let name: String
    let type: String
}

// MARK: - View Model

class PaymentProcessingViewModel: ObservableObject {

    @Published var paymentState: PaymentState = .initializing
    @Published var upiTimeRemaining: Int = 300 // 5 minutes

    let booking: Booking
    let paymentMethod: PaymentMethodData
    var transactionId: String?

    var amount: Double {
        booking.pricing.total
    }

    var paymentMethodName: String {
        paymentMethod.name
    }

    private var upiTimer: Timer?

    init(booking: Booking, paymentMethod: PaymentMethodData) {
        self.booking = booking
        self.paymentMethod = paymentMethod
    }

    @MainActor
    func processPayment() async {
        paymentState = .processing

        // Simulate payment processing
        try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds

        // Generate mock transaction ID
        transactionId = "TXN\(Int.random(in: 100000...999999))"

        // Simulate different payment scenarios based on payment method type
        if paymentMethod.type == "UPI" {
            // UPI flow
            startUPITimer()
            paymentState = .awaitingUPI(upiId: "user@oksbi", remainingTime: upiTimeRemaining)
        } else {
            // Direct payment flow (Card, Wallet, etc.)
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second

            // Simulate 90% success rate
            if Int.random(in: 1...10) <= 9 {
                guard let txnId = transactionId else {
                    paymentState = .failed(.unknown)
                    return
                }
                paymentState = .success(transactionId: txnId)
            } else {
                paymentState = .failed(.insufficientBalance)
            }
        }
    }

    @MainActor
    func checkUPIStatus() async {
        paymentState = .verifying
        upiTimer?.invalidate()

        // Simulate verification
        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds

        // Simulate 80% success rate for UPI
        if Int.random(in: 1...10) <= 8 {
            guard let txnId = transactionId else {
                paymentState = .failed(.unknown)
                return
            }
            paymentState = .success(transactionId: txnId)
        } else {
            paymentState = .failed(.authenticationFailed)
        }
    }

    func cancelPayment() {
        upiTimer?.invalidate()
        paymentState = .cancelled
    }

    private func startUPITimer() {
        upiTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            Task { @MainActor in
                self.upiTimeRemaining -= 1

                if self.upiTimeRemaining <= 0 {
                    self.upiTimer?.invalidate()
                    self.paymentState = .timeout
                }

                // Update state with new remaining time
                if case .awaitingUPI(let upiId, _) = self.paymentState {
                    self.paymentState = .awaitingUPI(upiId: upiId, remainingTime: self.upiTimeRemaining)
                }
            }
        }
    }

    deinit {
        upiTimer?.invalidate()
    }
}

// MARK: - Preview

#Preview("Processing") {
    PaymentProcessingView(
        booking: Booking.mockBookings[0],
        paymentMethod: PaymentMethodData(id: "pm_1", name: "Debit Card", type: "Card")
    )
}

#Preview("UPI Collection") {
    let viewModel = PaymentProcessingViewModel(
        booking: Booking.mockBookings[0],
        paymentMethod: PaymentMethodData(id: "pm_2", name: "UPI", type: "UPI")
    )
    viewModel.paymentState = .awaitingUPI(upiId: "rahul@oksbi", remainingTime: 295)

    return ZStack {
        Color.background.ignoresSafeArea()
        UPICollectionView(
            upiId: "rahul@oksbi",
            amount: 949,
            remainingTime: 295,
            onConfirm: {},
            onCancel: {}
        )
    }
}

#Preview("Success") {
    ZStack {
        Color.background.ignoresSafeArea()
        PaymentSuccessView(
            amount: 949,
            paymentMethod: "Debit Card",
            transactionId: "TXN123456"
        )
    }
}

#Preview("Failure") {
    ZStack {
        Color.background.ignoresSafeArea()
        PaymentFailureView(
            error: .insufficientBalance,
            transactionId: "TXN123456",
            onRetry: {},
            onContactSupport: {}
        )
    }
}

#Preview("Timeout") {
    ZStack {
        Color.background.ignoresSafeArea()
        PaymentTimeoutView(onRetry: {})
    }
}
