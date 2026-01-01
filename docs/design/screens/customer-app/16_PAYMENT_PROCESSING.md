# Payment Processing

## Overview
- **Screen ID**: 16
- **Screen Name**: Payment Processing
- **User Flow**: After selecting payment method, process the actual payment
- **Navigation**:
  - Entry: From Payment Method Selection (tap "Pay" button)
  - Exit: To Booking Confirmation (on success) OR Error state (on failure)
  - Back: Disabled during processing

## ASCII Wireframe

### State 1: Processing
```
┌──────────────────────────────────────────┐
│                                          │
│                                          │
│                                          │
│                                          │
│                                          │
│              🔄                          │ ← Animated Spinner
│                                          │
│         Processing Payment...            │ ← Status Text
│                                          │
│         Please wait                      │ ← Subtitle
│         Do not press back or close       │
│                                          │
│                                          │
│         🔒 Secure Payment                │ ← Security Badge
│         Powered by Razorpay              │
│                                          │
│                                          │
│                                          │
│                                          │
│                                          │
└──────────────────────────────────────────┘
```

### State 2: 3D Secure Verification (Card Payments)
```
┌──────────────────────────────────────────┐
│  ←  Secure Payment                       │ ← Nav Bar
├──────────────────────────────────────────┤
│                                          │
│  ┌────────────────────────────────────┐ │
│  │                                    │ │
│  │  [Bank's 3D Secure Page]          │ │ ← WebView
│  │                                    │ │   (Bank OTP)
│  │  Enter OTP sent to your           │ │
│  │  mobile: ******3210               │ │
│  │                                    │ │
│  │  [ _ _ _ _ _ _ ]                  │ │
│  │                                    │ │
│  │  [Submit]                          │ │
│  │                                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  🔒 This page is securely hosted         │
│      by your bank                        │
│                                          │
└──────────────────────────────────────────┘
```

### State 3: UPI Collection Request
```
┌──────────────────────────────────────────┐
│                                          │
│                                          │
│              📱                          │ ← Phone Icon
│                                          │
│         Waiting for approval...          │ ← Status
│                                          │
│         A payment request of ₹949        │ ← Amount
│         has been sent to your UPI app    │
│                                          │
│         rahul@oksbi                      │ ← UPI ID
│                                          │
│         ⏱️ 4:58                          │ ← Countdown Timer
│                                          │
│         Please approve the payment       │ ← Instruction
│         in your UPI app                  │
│                                          │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  I've approved the payment         │ │ ← Confirmation Button
│  └────────────────────────────────────┘ │
│                                          │
│         Cancel Payment                   │ ← Cancel Link
│                                          │
└──────────────────────────────────────────┘
```

### State 4: Success (Brief)
```
┌──────────────────────────────────────────┐
│                                          │
│                                          │
│                                          │
│                                          │
│              ✅                          │ ← Success Icon
│                                          │
│         Payment Successful!              │ ← Status
│                                          │
│         ₹949 paid via Debit Card         │ ← Details
│                                          │
│         Redirecting...                   │ ← Next Action
│                                          │
│                                          │
│                                          │
│                                          │
│                                          │
│                                          │
└──────────────────────────────────────────┘
```

### State 5: Failure
```
┌──────────────────────────────────────────┐
│                                          │
│                                          │
│              ❌                          │ ← Error Icon
│                                          │
│         Payment Failed                   │ ← Status
│                                          │
│         Your payment could not be        │ ← Error Message
│         processed due to:                │
│                                          │
│         Insufficient balance             │ ← Reason
│                                          │
│         Transaction ID: TXN123456789     │ ← Reference
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Try Another Payment Method        │ │ ← Retry CTA
│  └────────────────────────────────────┘ │
│                                          │
│         Contact Support                  │ ← Support Link
│                                          │
│                                          │
└──────────────────────────────────────────┘
```

## Layout Specifications

### Dimensions
- **Screen Width**: 390pt (iPhone 14)
- **Full Screen**: No navigation bar during processing
- **Safe Area Top**: 47pt (status bar only)
- **Safe Area Bottom**: 34pt (home indicator)

### Processing State

#### Spinner
- **Icon**: Custom animated circular progress indicator
- **Size**: 80x80pt
- **Color**: #0D7377 (primary teal)
- **Animation**: Continuous rotation, 1.5s duration, ease-in-out
- **Position**: Center of screen (vertically)

#### Status Text
- **Typography**: Inter SemiBold 22pt
- **Color**: #1E1E1E / #E0E0E0 (dark mode)
- **Position**: 24pt below spinner
- **Alignment**: Center

#### Subtitle
- **Typography**: SF Pro Regular 15pt
- **Color**: #666666 / #A0A0A0 (dark mode)
- **Position**: 12pt below status text
- **Alignment**: Center
- **Line Spacing**: 1.4
- **Max Width**: 280pt

#### Security Badge
- **Position**: 48pt below subtitle
- **Background**: #F0FAFB / #1A3D3E (dark mode)
- **Border Radius**: 8pt
- **Padding**: 12pt vertical, 16pt horizontal
- **Icon**: 16x16pt lock.shield.fill, #28C76F
- **Text**: SF Pro Regular 13pt, #666666
- **Shadow**: 0 2px 4px rgba(0,0,0,0.06)

### 3D Secure WebView State

#### Navigation Bar
- **Height**: 56pt
- **Background**: White / Dark (#2A2A2A)
- **Title**: Inter Medium 16pt, "Secure Payment"
- **Back Button**: Disabled during verification
- **Lock Icon**: 16x16pt, #28C76F, top-right

#### WebView Container
- **Margin**: 16pt horizontal
- **Border Radius**: 12pt
- **Background**: White
- **Shadow**: 0 4px 12px rgba(0,0,0,0.1)
- **Height**: Dynamic (based on bank page)
- **Min Height**: 400pt
- **Max Height**: Screen height - 200pt

#### Security Note
- **Position**: 16pt below WebView
- **Typography**: SF Pro Regular 12pt
- **Color**: #666666
- **Icon**: 16x16pt lock.fill, #0D7377
- **Alignment**: Center
- **Padding**: 16pt horizontal

### UPI Collection State

#### Phone Icon
- **Icon**: Custom phone with arrow
- **Size**: 64x64pt
- **Color**: #0D7377
- **Position**: Center, top third of screen

#### Status Text
- **Typography**: Inter SemiBold 20pt
- **Color**: #1E1E1E / #E0E0E0
- **Position**: 24pt below icon

#### Amount Display
- **Typography**: Inter Regular 15pt
- **Color**: #666666 / #A0A0A0
- **Highlight Amount**: Inter SemiBold 15pt, #0D7377

#### UPI ID Display
- **Typography**: SF Pro Mono Medium 16pt
- **Color**: #0D7377
- **Background**: #F0FAFB / #1A3D3E
- **Padding**: 8pt vertical, 16pt horizontal
- **Border Radius**: 8pt
- **Margin**: 12pt top

#### Countdown Timer
- **Icon**: 16x16pt clock.fill, #FF6B35
- **Typography**: Inter Medium 18pt
- **Color**: #FF6B35 (orange, creates urgency)
- **Format**: M:SS
- **Position**: 16pt below UPI ID
- **Animation**: Pulse every second

#### Instruction Text
- **Typography**: SF Pro Regular 14pt
- **Color**: #666666 / #A0A0A0
- **Position**: 20pt below timer
- **Alignment**: Center
- **Max Width**: 280pt

#### Confirmation Button
- **Height**: 56pt
- **Border Radius**: 12pt
- **Background**: #0D7377
- **Text**: Inter SemiBold 16pt, White
- **Margin**: 40pt horizontal, 32pt top
- **Shadow**: 0 4px 12px rgba(13,115,119,0.3)

#### Cancel Link
- **Typography**: Inter Medium 14pt
- **Color**: #EA5455 (error red)
- **Position**: 16pt below button
- **Underline**: None
- **Active**: Opacity 0.6

### Success State

#### Success Icon
- **Icon**: checkmark.circle.fill
- **Size**: 80x80pt
- **Color**: #28C76F (success green)
- **Animation**: Scale from 0 to 1, spring animation, 0.5s
- **Position**: Center, top third

#### Status Text
- **Typography**: Inter SemiBold 24pt
- **Color**: #1E1E1E / #E0E0E0
- **Position**: 24pt below icon
- **Animation**: Fade in after icon animation

#### Details Text
- **Typography**: SF Pro Regular 15pt
- **Color**: #666666 / #A0A0A0
- **Position**: 12pt below status
- **Alignment**: Center

#### Redirecting Text
- **Typography**: SF Pro Regular 13pt
- **Color**: #999999
- **Position**: 20pt below details
- **Animation**: Fade in, fade out (pulsing)

### Failure State

#### Error Icon
- **Icon**: xmark.circle.fill
- **Size**: 80x80pt
- **Color**: #EA5455 (error red)
- **Animation**: Shake horizontally, then settle
- **Position**: Center, top third

#### Status Text
- **Typography**: Inter SemiBold 24pt
- **Color**: #1E1E1E / #E0E0E0
- **Position**: 24pt below icon

#### Error Message
- **Typography**: SF Pro Regular 15pt
- **Color**: #666666 / #A0A0A0
- **Position**: 16pt below status
- **Alignment**: Center
- **Max Width**: 300pt
- **Line Spacing**: 1.5

#### Error Reason
- **Typography**: Inter Medium 15pt
- **Color**: #EA5455
- **Background**: #FFF5F5 / #3D1E1E (dark mode)
- **Padding**: 8pt vertical, 16pt horizontal
- **Border Radius**: 8pt
- **Margin**: 12pt top

#### Transaction ID
- **Typography**: SF Pro Mono Regular 12pt
- **Color**: #999999
- **Position**: 12pt below reason
- **Copyable**: Long press to copy

#### Retry Button
- **Height**: 56pt
- **Border Radius**: 12pt
- **Background**: #0D7377
- **Text**: Inter SemiBold 16pt, White
- **Margin**: 32pt horizontal, 32pt top
- **Shadow**: 0 4px 12px rgba(13,115,119,0.3)

#### Support Link
- **Typography**: Inter Medium 14pt
- **Color**: #0D7377
- **Position**: 16pt below button
- **Underline**: None
- **Icon**: 16x16pt questionmark.circle, left of text

## Components Used

### Existing Components
1. **LoadingSpinner** (custom animated)
2. **FixedBottomCTA** (for retry)
3. **CustomNavigationBar** (for 3D secure)

### New Components Needed
1. **PaymentProcessingView** - Main container for all states
2. **SecureWebView** - For bank 3D secure pages
3. **CountdownTimer** - For UPI collection timeout
4. **PaymentStatusCard** - Success/failure display
5. **TransactionReference** - Copyable transaction ID

## State Machine

### States
1. **Initializing**: Setting up payment gateway
2. **Processing**: Sending payment request
3. **AwaitingAuthentication**: Card 3D secure or UPI approval
4. **Verifying**: Checking payment status
5. **Success**: Payment completed
6. **Failed**: Payment failed
7. **Timeout**: User took too long (UPI)
8. **Cancelled**: User cancelled

### Transitions
```
Initializing → Processing
Processing → AwaitingAuthentication (if 3DS/UPI)
Processing → Verifying (if direct payment)
AwaitingAuthentication → Verifying (after user action)
Verifying → Success (payment confirmed)
Verifying → Failed (payment declined)
AwaitingAuthentication → Timeout (5 min timer)
Any State → Cancelled (user cancels)
Success → Navigate to Booking Confirmation
Failed → Show retry options
```

## Interactions

### During Processing
- **Back Button**: Disabled (cannot go back)
- **Home Button**: Shows confirmation alert if user tries to leave app
- **Screen Lock**: Keep screen awake during processing
- **Network Loss**: Show reconnecting indicator, auto-retry

### 3D Secure WebView
- **WebView Load**: Show loading indicator
- **User Input**: Enable all bank page interactions
- **Form Submit**: Capture and process
- **Cancel Button**: Show confirmation dialog
- **JavaScript**: Enable for bank page functionality

### UPI Collection
- **Countdown**: Update every second
- **Timeout**: After 5 minutes, show timeout state
- **Confirmation Button**: Check payment status
- **Cancel**: Show confirmation dialog, then cancel payment
- **Deep Link**: Handle UPI app returning to our app

### Success State
- **Auto-Redirect**: After 2 seconds, navigate to Booking Confirmation
- **User Tap**: Allow immediate navigation
- **Haptic**: Success feedback on state entry

### Failure State
- **Retry Button**: Return to Payment Method Selection
- **Support Link**: Open support chat or dial number
- **Transaction ID**: Long press to copy
- **Haptic**: Error feedback on state entry

## Payment Flow by Method

### Credit/Debit Card (Razorpay)
1. Initialize Razorpay SDK
2. Show "Processing Payment..."
3. If 3D Secure required:
   - Show bank's authentication page in WebView
   - User enters OTP
   - Submit to bank
4. Verify payment with backend
5. Show success or failure

### UPI
1. Create UPI collection request
2. Send to user's UPI app (deep link)
3. Show "Waiting for approval..."
4. Start 5-minute countdown
5. Poll backend every 3 seconds for status
6. User approves in UPI app
7. Verify payment
8. Show success or failure

### Paytm Wallet
1. Initialize Paytm SDK
2. Show Paytm login/PIN page
3. User completes Paytm flow
4. Return to our app
5. Verify payment
6. Show success or failure

### Net Banking
1. Redirect to bank's net banking page
2. User logs in and authorizes
3. Bank redirects back to our app
4. Verify payment
5. Show success or failure

### Cash on Delivery
1. Create booking with COD flag
2. Show "Confirming booking..."
3. Verify booking created
4. Show success (no payment processing)

## Error Handling

### Error Types

#### 1. Network Error
```
Icon: WiFi with slash
Title: "Connection Lost"
Message: "Please check your internet connection and try again."
Actions: [Retry, Cancel]
```

#### 2. Insufficient Balance
```
Icon: Credit card with slash
Title: "Payment Failed"
Message: "Your payment could not be processed due to:\n\nInsufficient balance"
Actions: [Try Another Method, Cancel]
```

#### 3. Card Declined
```
Icon: X mark
Title: "Card Declined"
Message: "Your bank has declined this transaction. Please contact your bank or try another payment method."
Actions: [Try Another Method, Contact Bank]
```

#### 4. UPI Timeout
```
Icon: Clock with slash
Title: "Request Timed Out"
Message: "You didn't approve the payment within 5 minutes. Please try again."
Actions: [Try Again, Cancel]
```

#### 5. 3D Secure Failed
```
Icon: Shield with slash
Title: "Verification Failed"
Message: "Card verification failed. Please check your OTP and try again."
Actions: [Try Again, Use Another Card]
```

#### 6. Server Error
```
Icon: Server with X
Title: "Something Went Wrong"
Message: "We encountered an error processing your payment. Your account has not been charged."
Actions: [Try Again, Contact Support]
Reference: Transaction ID
```

#### 7. Booking Creation Failed
```
Icon: Calendar with X
Title: "Booking Failed"
Message: "Payment was successful but we couldn't create your booking. Don't worry, we'll refund the amount within 3-5 business days."
Actions: [Contact Support]
Reference: Payment ID, Transaction ID
```

## Analytics Events

### Payment Initiated
```json
{
  "event": "payment_initiated",
  "booking_id": "BK123456",
  "amount": 949,
  "payment_method": "card",
  "gateway": "razorpay"
}
```

### Payment Processing
```json
{
  "event": "payment_processing",
  "transaction_id": "TXN123456789",
  "time_elapsed": 1.5, // seconds
  "requires_authentication": true
}
```

### 3D Secure Started
```json
{
  "event": "3ds_authentication_started",
  "transaction_id": "TXN123456789",
  "card_brand": "visa"
}
```

### UPI Collection Sent
```json
{
  "event": "upi_collection_sent",
  "transaction_id": "TXN123456789",
  "upi_id": "rahul@oksbi"
}
```

### Payment Success
```json
{
  "event": "payment_success",
  "transaction_id": "TXN123456789",
  "amount": 949,
  "payment_method": "card",
  "processing_time": 5.2, // seconds
  "required_authentication": true
}
```

### Payment Failed
```json
{
  "event": "payment_failed",
  "transaction_id": "TXN123456789",
  "amount": 949,
  "payment_method": "upi",
  "error_code": "INSUFFICIENT_BALANCE",
  "error_message": "Insufficient balance",
  "processing_time": 3.1
}
```

### Payment Cancelled
```json
{
  "event": "payment_cancelled",
  "transaction_id": "TXN123456789",
  "cancelled_at_state": "awaiting_authentication",
  "time_elapsed": 45 // seconds
}
```

## SwiftUI Implementation

### View Structure
```swift
struct PaymentProcessingView: View {
    @StateObject private var viewModel: PaymentProcessingViewModel
    @State private var currentState: PaymentState = .initializing
    @Environment(\.dismiss) var dismiss

    init(bookingId: String, paymentMethodId: String, amount: Double) {
        _viewModel = StateObject(wrappedValue: PaymentProcessingViewModel(
            bookingId: bookingId,
            paymentMethodId: paymentMethodId,
            amount: amount
        ))
    }

    var body: some View {
        ZStack {
            Color.gray100
                .ignoresSafeArea()

            // State-based content
            Group {
                switch currentState {
                case .initializing, .processing, .verifying:
                    ProcessingStateView()

                case .awaitingAuthentication(let type):
                    if type == .threeDS {
                        ThreeDSecureWebView(
                            authUrl: viewModel.authUrl,
                            onComplete: viewModel.handle3DSComplete
                        )
                    } else if type == .upi {
                        UPICollectionView(
                            upiId: viewModel.upiId,
                            amount: viewModel.amount,
                            remainingTime: viewModel.upiTimeRemaining,
                            onConfirm: viewModel.checkUPIStatus,
                            onCancel: viewModel.cancelPayment
                        )
                    }

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
                        onRetry: { dismiss() },
                        onContactSupport: viewModel.contactSupport
                    )

                case .timeout:
                    PaymentTimeoutView(
                        onRetry: { dismiss() }
                    )

                case .cancelled:
                    // Navigate back
                    EmptyView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .interactiveDismissDisabled(true) // Prevent swipe back
        .onAppear {
            initiatePayment()
        }
        .onChange(of: viewModel.paymentState) { newState in
            withAnimation {
                currentState = newState
            }
            handleStateChange(newState)
        }
    }

    private func initiatePayment() {
        Task {
            await viewModel.processPayment()
        }

        Analytics.logEvent("payment_initiated", parameters: [
            "booking_id": viewModel.bookingId,
            "amount": viewModel.amount,
            "payment_method": viewModel.paymentMethodId
        ])
    }

    private func handleStateChange(_ state: PaymentState) {
        switch state {
        case .success:
            HapticFeedback.success()
            // Auto-redirect after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                navigateToBookingConfirmation()
            }

        case .failed:
            HapticFeedback.error()

        case .timeout:
            HapticFeedback.error()

        default:
            break
        }
    }

    private func navigateToBookingConfirmation() {
        guard let transactionId = viewModel.transactionId else { return }

        navigationController?.setViewControllers([
            BookingConfirmationView(
                bookingId: viewModel.bookingId,
                transactionId: transactionId
            )
        ], animated: true)
    }
}
```

### ViewModel
```swift
enum PaymentState: Equatable {
    case initializing
    case processing
    case awaitingAuthentication(AuthenticationType)
    case verifying
    case success(transactionId: String)
    case failed(PaymentError)
    case timeout
    case cancelled
}

enum AuthenticationType {
    case threeDS
    case upi
}

class PaymentProcessingViewModel: ObservableObject {
    @Published var paymentState: PaymentState = .initializing
    @Published var upiTimeRemaining: Int = 300 // 5 minutes

    let bookingId: String
    let paymentMethodId: String
    let amount: Double

    var transactionId: String?
    var authUrl: URL?
    var upiId: String?
    var paymentMethodName: String = ""

    private let paymentService: PaymentService
    private var upiTimer: Timer?
    private var upiPollTimer: Timer?

    init(bookingId: String, paymentMethodId: String, amount: Double) {
        self.bookingId = bookingId
        self.paymentMethodId = paymentMethodId
        self.amount = amount
        self.paymentService = PaymentService()
    }

    func processPayment() async {
        paymentState = .processing

        do {
            // Initialize payment with Razorpay
            let paymentRequest = try await paymentService.initializePayment(
                bookingId: bookingId,
                paymentMethodId: paymentMethodId,
                amount: amount
            )

            transactionId = paymentRequest.transactionId
            paymentMethodName = paymentRequest.methodName

            // Handle based on payment method type
            switch paymentRequest.requiresAuthentication {
            case .threeDS(let url):
                authUrl = url
                paymentState = .awaitingAuthentication(.threeDS)

            case .upi(let upiId):
                self.upiId = upiId
                paymentState = .awaitingAuthentication(.upi)
                startUPITimer()
                startUPIPolling()

            case .none:
                // Direct payment (wallet, COD)
                try await verifyPayment()
            }

        } catch {
            paymentState = .failed(PaymentError.from(error))
        }
    }

    func handle3DSComplete(success: Bool) {
        if success {
            Task {
                try await verifyPayment()
            }
        } else {
            paymentState = .failed(.authenticationFailed)
        }
    }

    func checkUPIStatus() {
        Task {
            try await verifyPayment()
        }
    }

    func cancelPayment() {
        upiTimer?.invalidate()
        upiPollTimer?.invalidate()

        Task {
            await paymentService.cancelPayment(transactionId: transactionId)
            paymentState = .cancelled
        }
    }

    private func verifyPayment() async throws {
        paymentState = .verifying

        let result = try await paymentService.verifyPayment(
            transactionId: transactionId!
        )

        if result.success {
            paymentState = .success(transactionId: transactionId!)

            Analytics.logEvent("payment_success", parameters: [
                "transaction_id": transactionId!,
                "amount": amount,
                "payment_method": paymentMethodId
            ])
        } else {
            throw PaymentError.verificationFailed(result.reason)
        }
    }

    private func startUPITimer() {
        upiTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            self.upiTimeRemaining -= 1

            if self.upiTimeRemaining <= 0 {
                self.upiTimer?.invalidate()
                self.upiPollTimer?.invalidate()
                self.paymentState = .timeout
            }
        }
    }

    private func startUPIPolling() {
        // Poll every 3 seconds for UPI payment status
        upiPollTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            Task {
                let status = try await self.paymentService.checkUPIPaymentStatus(
                    transactionId: self.transactionId!
                )

                if status == .completed {
                    self.upiTimer?.invalidate()
                    self.upiPollTimer?.invalidate()
                    try await self.verifyPayment()
                }
            }
        }
    }

    func contactSupport() {
        // Open support chat or phone dialer
        SupportManager.shared.openSupport(
            context: "Payment Failed",
            transactionId: transactionId
        )
    }

    deinit {
        upiTimer?.invalidate()
        upiPollTimer?.invalidate()
    }
}
```

### Component: ProcessingStateView
```swift
struct ProcessingStateView: View {
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 24) {
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
                .font(.custom("Inter-SemiBold", size: 22))
                .foregroundColor(.textPrimary)

            // Subtitle
            VStack(spacing: 4) {
                Text("Please wait")
                Text("Do not press back or close")
            }
            .font(.system(size: 15))
            .foregroundColor(.textSecondary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 280)

            Spacer()
            Spacer()

            // Security Badge
            HStack(spacing: 8) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.success)

                VStack(alignment: .leading, spacing: 2) {
                    Text("🔒 Secure Payment")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.textSecondary)

                    Text("Powered by Razorpay")
                        .font(.system(size: 11))
                        .foregroundColor(.textTertiary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.primaryLight.opacity(0.1))
            .cornerRadius(8)

            Spacer()
        }
    }
}
```

### Component: PaymentSuccessView
```swift
struct PaymentSuccessView: View {
    let amount: Double
    let paymentMethod: String
    let transactionId: String

    @State private var showCheck = false

    var body: some View {
        VStack(spacing: 24) {
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
                .font(.custom("Inter-SemiBold", size: 24))
                .foregroundColor(.textPrimary)
                .opacity(showCheck ? 1 : 0)
                .animation(.easeIn(duration: 0.3).delay(0.2), value: showCheck)

            // Details
            Text("₹\(Int(amount)) paid via \(paymentMethod)")
                .font(.system(size: 15))
                .foregroundColor(.textSecondary)
                .opacity(showCheck ? 1 : 0)
                .animation(.easeIn(duration: 0.3).delay(0.3), value: showCheck)

            // Redirecting
            Text("Redirecting...")
                .font(.system(size: 13))
                .foregroundColor(.textTertiary)
                .opacity(showCheck ? 1 : 0)
                .animation(.easeIn(duration: 0.3).delay(0.4), value: showCheck)

            Spacer()
            Spacer()
        }
    }
}
```

## Security Considerations

### Data Protection
- Never log sensitive payment data (card numbers, CVV, OTP)
- Use HTTPS for all API calls
- Implement certificate pinning for Razorpay API
- Clear sensitive data from memory after use

### Session Management
- Timeout after 10 minutes of inactivity
- Invalidate payment session after completion
- Prevent screenshot capture on payment screens

### Fraud Prevention
- Device fingerprinting
- IP address validation
- Velocity checks (multiple failed attempts)
- 3D Secure for card payments

## Testing Checklist

### Card Payment
- ✅ Process card without 3DS
- ✅ Process card with 3DS
- ✅ Handle 3DS OTP entry
- ✅ Handle 3DS failure
- ✅ Handle card declined
- ✅ Handle insufficient balance

### UPI Payment
- ✅ Send UPI collection request
- ✅ Countdown timer works
- ✅ Polling for payment status
- ✅ Handle UPI approval
- ✅ Handle UPI rejection
- ✅ Handle UPI timeout (5 min)

### Wallet Payment
- ✅ Launch wallet SDK
- ✅ Handle wallet authentication
- ✅ Handle insufficient wallet balance
- ✅ Return from wallet app

### Error Scenarios
- ✅ Network error during payment
- ✅ Server error (500)
- ✅ Payment gateway timeout
- ✅ Booking creation failure after payment
- ✅ User closes app during payment

### UI/UX
- ✅ Loading animation smooth
- ✅ State transitions smooth
- ✅ Success animation plays correctly
- ✅ Error messages clear
- ✅ Back button disabled during processing
- ✅ Screen stays awake

### Performance
- ✅ No memory leaks
- ✅ Proper cleanup on exit
- ✅ Timer cleanup
- ✅ WebView cleanup
