# Payment Method Selection

## Overview
- **Screen ID**: 15
- **Screen Name**: Payment Method Selection
- **User Flow**: After reviewing booking summary, user selects how to pay
- **Navigation**:
  - Entry: From Booking Summary (tap "Proceed to Payment")
  - Exit: To Payment Processing screen (after selecting method)
  - Back: Returns to Booking Summary

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ←  Payment Method              [Help]   │ ← Navigation Bar
├──────────────────────────────────────────┤
│                                          │
│  Choose Payment Method                   │ ← Title
│                                          │
│  💳 Cards & UPI                          │ ← Section Header
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 💳  •••• •••• •••• 4532           │ │ ← Saved Card
│  │     HDFC Bank Debit Card           │ │
│  │                               ✓    │ │ (Selected)
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 🟣  rahul@oksbi                    │ │ ← Saved UPI
│  │     UPI ID                          │ │
│  │                                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ ➕  Add New Card / UPI ID          │ │ ← Add New
│  └────────────────────────────────────┘ │
│                                          │
│  🏦 Wallets & Bank                       │ ← Section Header
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 📱  Paytm                          │ │ ← Wallet Option
│  │     Link Paytm Wallet        →     │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 🏦  Net Banking                    │ │ ← Net Banking
│  │     Pay via your bank        →     │ │
│  └────────────────────────────────────┘ │
│                                          │
│  💵 Other Options                        │ ← Section Header
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 💰  Cash on Delivery               │ │ ← COD Option
│  │     Pay after service completion    │ │
│  │                                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  🔒 100% Secure Payments                │ ← Trust Indicator
│  Powered by Razorpay                     │
│                                          │
├──────────────────────────────────────────┤
│  ┌────────────────────────────────────┐ │ ← Fixed Bottom CTA
│  │     Pay ₹949                        │ │
│  └────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

## Layout Specifications

### Dimensions
- **Screen Width**: 390pt (iPhone 14)
- **Safe Area Top**: 47pt (status bar + notch)
- **Safe Area Bottom**: 34pt (home indicator)
- **Content Width**: 358pt (16pt padding each side)

### Navigation Bar
- **Height**: 56pt
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Title**: Inter SemiBold 18pt, #1E1E1E / #E0E0E0
- **Back Button**: 24x24pt chevron.left icon, #0D7377
- **Help Button**: Inter Medium 14pt, #0D7377, tap to show help sheet
- **Padding**: 16pt horizontal

### Title Section
- **Padding Top**: 24pt from nav bar
- **Title**: Inter SemiBold 24pt, #1E1E1E / #E0E0E0
- **Padding Bottom**: 24pt

### Section Headers
- **Typography**: Inter SemiBold 16pt, #666666 / #A0A0A0
- **Icon**: 20x20pt emoji
- **Padding**: 16pt top, 12pt bottom
- **Spacing Between Sections**: 24pt

### Payment Method Cards
- **Card Height**: 72pt
- **Border Radius**: 12pt
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Border**:
  - Default: 1pt solid #E0E0E0 / #3A3A3A
  - Selected: 2pt solid #0D7377
  - Hover: Shadow 0 2px 8px rgba(13,115,119,0.15)
- **Padding**: 16pt horizontal, 16pt vertical
- **Spacing Between Cards**: 12pt
- **Shadow**: 0 1px 3px rgba(0,0,0,0.08)

### Card Content Layout
- **Icon**: 24x24pt, left aligned
- **Title**: Inter Medium 16pt, #1E1E1E / #E0E0E0
- **Subtitle**: SF Pro Regular 13pt, #666666 / #A0A0A0, 4pt top margin
- **Checkmark**: 20x20pt, #0D7377, right aligned (selected state only)
- **Arrow**: 16x16pt chevron.right, #999999, right aligned (for expandable)

### Add New Card Button
- **Border**: 1.5pt dashed #0D7377
- **Background**: #F0FAFB / Dark (#1A3D3E)
- **Icon**: 20x20pt plus.circle.fill, #0D7377
- **Text**: Inter Medium 15pt, #0D7377
- **Height**: 56pt

### Trust Indicator
- **Background**: #F5F5F5 / Dark (#2A2A2A)
- **Border Radius**: 8pt
- **Padding**: 12pt
- **Icon**: 16x16pt lock.shield.fill, #28C76F
- **Text**: SF Pro Regular 12pt, #666666 / #A0A0A0
- **Powered by**: SF Pro Regular 11pt, #999999
- **Margin**: 20pt top, 20pt bottom

### Fixed Bottom CTA
- **Height**: 56pt + 16pt padding + safe area (106pt total)
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Border Top**: 1pt solid #E0E0E0 / #3A3A3A
- **Button**:
  - Height: 56pt
  - Border Radius: 12pt
  - Background: #0D7377 (gradient to #14A0A5)
  - Text: Inter SemiBold 16pt, White
  - Shadow: 0 4px 12px rgba(13,115,119,0.3)
  - Margin: 16pt horizontal
  - Padding Top: 16pt

## Components Used

### Reusable Components
1. **CustomNavigationBar** (title, back button, help action)
2. **PaymentMethodCard** (saved card/UPI display)
3. **AddPaymentMethodButton** (dashed border, plus icon)
4. **WalletOptionCard** (wallet/net banking options)
5. **CODOptionCard** (cash on delivery option)
6. **TrustBadge** (security indicator)
7. **FixedBottomCTA** (pay button with amount)

### New Components Needed
1. **PaymentMethodIcon** - Displays card brand (Visa, Mastercard, UPI, etc.)
2. **CardLastFour** - Displays masked card number (•••• 4532)
3. **SelectionIndicator** - Checkmark for selected payment method

## Interactions

### Payment Method Card Tap
- **Action**: Select payment method
- **Visual Feedback**:
  - Border changes to 2pt solid #0D7377
  - Checkmark appears (fade in, 200ms)
  - Previous selection deselects (checkmark fades out)
- **Haptic**: Light impact
- **State Update**: Updates selectedPaymentMethod in ViewModel

### Add New Card/UPI Tap
- **Action**: Open bottom sheet to add payment method
- **Animation**: Slide up from bottom (300ms ease-out)
- **Backdrop**: Semi-transparent black (0.4 opacity)
- **Sheet Content**:
  - Tabs: "Card" | "UPI"
  - Form fields based on selected tab
  - Save button
- **Haptic**: Medium impact

### Wallet Option Tap
- **Action**: Initiate wallet linking flow
- **For Paytm**: Opens Paytm SDK
- **For PhonePe/GooglePay**: Deep link to app
- **Loading State**: Show spinner during linking
- **Error Handling**: Show error toast if linking fails

### Net Banking Tap
- **Action**: Navigate to bank selection screen
- **Animation**: Push (slide from right)
- **Screen**: List of popular banks + search
- **Haptic**: Medium impact

### COD Option Tap
- **Action**: Select COD as payment method
- **Validation**: Check if COD allowed for this booking
- **Visual**: Same selection pattern as cards
- **Note**: May have additional confirmation step

### Pay Button Tap
- **Action**: Proceed to payment processing
- **Validation**:
  - Payment method must be selected
  - Amount must be valid (> 0)
- **Disabled State**:
  - Opacity 0.5
  - No tap action
  - No haptic
- **Enabled State**:
  - Navigate to Payment Processing screen
  - Pass selected payment method
  - Haptic: Success feedback
  - Animation: Push transition

### Help Button Tap
- **Action**: Show payment help bottom sheet
- **Content**:
  - FAQs about payment security
  - Accepted payment methods
  - Refund policy
  - Contact support
- **Animation**: Slide up from bottom

## States

### Default State
- **Saved Methods**: Display user's saved cards/UPI
- **No Selection**: No payment method selected initially
- **Pay Button**: Disabled (grayed out)

### Selected State
- **Card Selected**: Blue border, checkmark visible
- **Pay Button**: Enabled, shows total amount
- **Other Methods**: Normal state (deselected)

### Loading State (Add Payment Method)
- **Show**: Activity indicator overlay
- **Disable**: All interactions
- **Duration**: Until method added or error

### Empty State (No Saved Methods)
- **Cards Section**: Show only "Add New Card/UPI" button
- **Wallets Section**: Normal display
- **Message**: "Add a payment method to continue"

### Error State
- **Scenario 1**: Payment method expired
  - Show alert: "This card has expired. Please add a new payment method."
  - Remove expired method from list
- **Scenario 2**: COD not available
  - Disable COD option
  - Show tooltip: "COD not available for bookings above ₹2000"
- **Scenario 3**: Network error
  - Show error banner at top
  - Retry button

### Success State (Method Added)
- **Animation**: New method card slides in from right
- **Auto-Select**: Newly added method is selected automatically
- **Toast**: "Payment method added successfully"
- **Haptic**: Success feedback

## Payment Method Types

### 1. Saved Credit/Debit Card
```
┌────────────────────────────────────┐
│ 💳  •••• •••• •••• 4532           │
│     HDFC Bank Debit Card           │
│     Expires 12/26             ✓    │
└────────────────────────────────────┘
```
- **Icon**: Card brand logo (Visa, Mastercard, RuPay)
- **Number**: Last 4 digits, others masked
- **Bank**: Card issuing bank name
- **Expiry**: Month/Year (validate not expired)
- **Default**: Can mark one as default

### 2. UPI ID
```
┌────────────────────────────────────┐
│ 🟣  rahul@oksbi                    │
│     UPI ID                          │
│                                    │
└────────────────────────────────────┘
```
- **Icon**: UPI logo (purple circle)
- **UPI ID**: Full UPI ID shown
- **Type**: "UPI ID"
- **Validation**: Must be verified before saving

### 3. Paytm Wallet
```
┌────────────────────────────────────┐
│ 📱  Paytm                          │
│     Balance: ₹1,245          →     │
└────────────────────────────────────┘
```
- **Icon**: Paytm logo
- **Balance**: Show current wallet balance
- **Arrow**: Indicates navigation to Paytm
- **State**: "Linked" or "Link Paytm Wallet"

### 4. Net Banking
```
┌────────────────────────────────────┐
│ 🏦  Net Banking                    │
│     Pay via your bank        →     │
└────────────────────────────────────┘
```
- **Icon**: Bank building
- **Description**: Generic text
- **Arrow**: Navigate to bank selection
- **Popular Banks**: Show top 5 on next screen

### 5. Cash on Delivery
```
┌────────────────────────────────────┐
│ 💰  Cash on Delivery               │
│     Pay after service completion    │
│     (₹50 extra charge applies)      │
└────────────────────────────────────┘
```
- **Icon**: Money bag
- **Description**: When payment happens
- **Extra Charge**: If applicable, shown in red
- **Availability**: Based on business rules

## Dark Mode Variants

### Colors
- **Background**: #1E1E1E
- **Card Background**: #2A2A2A
- **Card Border**: #3A3A3A
- **Selected Border**: #14A0A5 (lighter teal)
- **Text Primary**: #E0E0E0
- **Text Secondary**: #A0A0A0
- **Disabled Text**: #666666
- **Trust Indicator BG**: #2A2A2A
- **Add New Card BG**: #1A3D3E

### Contrast Adjustments
- All text maintains WCAG AA compliance
- Checkmark remains #0D7377 (sufficient contrast on dark)
- Pay button uses lighter gradient (#14A0A5 to #1ABBC1)

## Accessibility

### VoiceOver Labels
- **Payment Method Card**: "HDFC Bank Debit Card ending in 4532, selected, button"
- **Add New Button**: "Add new card or UPI ID, button"
- **Wallet Option**: "Paytm wallet, balance ₹1,245, link, button"
- **Net Banking**: "Net Banking, pay via your bank, button"
- **COD Option**: "Cash on Delivery, pay after service completion, button"
- **Pay Button**: "Pay ₹949, button, disabled" (when no method selected)
- **Help Button**: "Payment help, button"

### VoiceOver Hints
- **Card**: "Double tap to select this payment method"
- **Add New**: "Double tap to add a new card or UPI ID"
- **Pay Button**: "Double tap to proceed to payment"

### Dynamic Type Support
- All text scales from -2 to +3
- Card height increases to accommodate larger text (min 72pt → max 96pt)
- Minimum touch target maintained at 44x44pt
- Icon sizes remain fixed for clarity

### Color Contrast
- Title (24pt): 10.5:1 ratio ✓
- Card Title (16pt): 9.2:1 ratio ✓
- Subtitle (13pt): 4.8:1 ratio ✓
- Selected Border: 3.5:1 ratio ✓ (non-text)
- Pay Button Text: 9.5:1 ratio ✓

### Reduced Motion
- If enabled, disable:
  - Card slide-in animations
  - Checkmark fade animations
  - Bottom sheet slide-up (use fade instead)
- Replace with:
  - Instant state changes
  - Opacity transitions only

## Analytics Events

### Screen View
```json
{
  "screen_name": "payment_method_selection",
  "booking_id": "BK123456",
  "total_amount": 949,
  "has_saved_methods": true,
  "saved_methods_count": 2
}
```

### Payment Method Selected
```json
{
  "event": "payment_method_selected",
  "method_type": "card", // card, upi, wallet, netbanking, cod
  "is_saved": true,
  "card_brand": "visa", // if card
  "wallet_name": "paytm", // if wallet
  "booking_id": "BK123456"
}
```

### Add Payment Method Initiated
```json
{
  "event": "add_payment_method_initiated",
  "method_type": "card", // or upi
  "source_screen": "payment_method_selection"
}
```

### Payment Method Added
```json
{
  "event": "payment_method_added",
  "method_type": "card",
  "card_brand": "mastercard",
  "save_for_future": true
}
```

### Help Accessed
```json
{
  "event": "payment_help_accessed",
  "source_screen": "payment_method_selection"
}
```

### Proceed to Payment
```json
{
  "event": "proceed_to_payment_clicked",
  "payment_method": "card",
  "amount": 949,
  "booking_id": "BK123456"
}
```

## SwiftUI Implementation

### View Structure
```swift
struct PaymentMethodSelectionView: View {
    @StateObject private var viewModel = PaymentViewModel()
    @State private var selectedMethodId: String?
    @State private var showAddPaymentSheet: Bool = false
    @State private var showHelpSheet: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.gray100
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Title
                    Text("Choose Payment Method")
                        .font(.custom("Inter-SemiBold", size: 24))
                        .foregroundColor(.textPrimary)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, 24)

                    // Cards & UPI Section
                    if !viewModel.savedMethods.isEmpty {
                        PaymentSectionHeader(
                            icon: "💳",
                            title: "Cards & UPI"
                        )

                        ForEach(viewModel.savedMethods) { method in
                            SavedPaymentMethodCard(
                                method: method,
                                isSelected: selectedMethodId == method.id,
                                onTap: { selectPaymentMethod(method) }
                            )
                        }
                    }

                    // Add New Button
                    AddPaymentMethodButton {
                        showAddPaymentSheet = true
                    }

                    // Wallets Section
                    PaymentSectionHeader(
                        icon: "🏦",
                        title: "Wallets & Bank"
                    )

                    WalletOptionCard(
                        name: "Paytm",
                        icon: "📱",
                        balance: viewModel.paytmBalance,
                        isLinked: viewModel.isPaytmLinked,
                        onTap: linkPaytmWallet
                    )

                    NetBankingOptionCard {
                        navigateToNetBanking()
                    }

                    // Other Options
                    PaymentSectionHeader(
                        icon: "💵",
                        title: "Other Options"
                    )

                    CODOptionCard(
                        isAvailable: viewModel.isCODAvailable,
                        extraCharge: viewModel.codExtraCharge,
                        isSelected: selectedMethodId == "cod",
                        onTap: selectCOD
                    )

                    // Trust Indicator
                    TrustBadge()
                        .padding(.top, 20)
                        .padding(.bottom, 20)

                    // Bottom spacing for fixed CTA
                    Spacer()
                        .frame(height: 106)
                }
                .padding(.horizontal, 16)
            }

            // Fixed Bottom CTA
            FixedBottomCTA(
                title: "Pay ₹\(viewModel.totalAmount)",
                action: proceedToPayment,
                isDisabled: selectedMethodId == nil
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: BackButton { dismiss() },
            trailing: HelpButton { showHelpSheet = true }
        )
        .navigationBarTitle("Payment Method", displayMode: .inline)
        .sheet(isPresented: $showAddPaymentSheet) {
            AddPaymentMethodSheet(
                onMethodAdded: { newMethod in
                    viewModel.addPaymentMethod(newMethod)
                    selectedMethodId = newMethod.id
                    showAddPaymentSheet = false
                }
            )
        }
        .sheet(isPresented: $showHelpSheet) {
            PaymentHelpSheet()
        }
        .onAppear {
            viewModel.loadSavedPaymentMethods()
            viewModel.checkCODAvailability()
            Analytics.logScreenView("payment_method_selection")
        }
    }

    // MARK: - Actions

    private func selectPaymentMethod(_ method: PaymentMethod) {
        selectedMethodId = method.id
        HapticFeedback.light()

        Analytics.logEvent("payment_method_selected", parameters: [
            "method_type": method.type.rawValue,
            "is_saved": true
        ])
    }

    private func selectCOD() {
        guard viewModel.isCODAvailable else {
            showCODNotAvailableAlert()
            return
        }
        selectedMethodId = "cod"
        HapticFeedback.light()

        Analytics.logEvent("payment_method_selected", parameters: [
            "method_type": "cod"
        ])
    }

    private func linkPaytmWallet() {
        Task {
            do {
                let linked = try await viewModel.linkPaytmWallet()
                if linked {
                    selectedMethodId = "paytm"
                    ToastManager.show("Paytm wallet linked successfully")
                }
            } catch {
                ToastManager.show("Failed to link Paytm wallet", type: .error)
            }
        }
    }

    private func proceedToPayment() {
        guard let methodId = selectedMethodId else { return }

        HapticFeedback.success()

        Analytics.logEvent("proceed_to_payment_clicked", parameters: [
            "payment_method": methodId,
            "amount": viewModel.totalAmount
        ])

        // Navigate to Payment Processing
        navigationController?.push(
            PaymentProcessingView(
                bookingId: viewModel.bookingId,
                paymentMethodId: methodId,
                amount: viewModel.totalAmount
            )
        )
    }

    private func showCODNotAvailableAlert() {
        AlertManager.show(
            title: "COD Not Available",
            message: "Cash on Delivery is not available for bookings above ₹2000.",
            primaryButton: "OK"
        )
    }
}
```

### ViewModel
```swift
class PaymentViewModel: ObservableObject {
    @Published var savedMethods: [PaymentMethod] = []
    @Published var paytmBalance: Double?
    @Published var isPaytmLinked: Bool = false
    @Published var isCODAvailable: Bool = true
    @Published var codExtraCharge: Double = 0
    @Published var totalAmount: Double
    @Published var isLoading: Bool = false

    let bookingId: String
    private let paymentService: PaymentService

    init(bookingId: String, totalAmount: Double) {
        self.bookingId = bookingId
        self.totalAmount = totalAmount
        self.paymentService = PaymentService()
    }

    func loadSavedPaymentMethods() {
        isLoading = true
        Task {
            do {
                savedMethods = try await paymentService.fetchSavedPaymentMethods()
                isLoading = false
            } catch {
                print("Error loading payment methods: \(error)")
                isLoading = false
            }
        }
    }

    func checkCODAvailability() {
        // Business rule: COD not available for bookings > ₹2000
        isCODAvailable = totalAmount <= 2000

        // Extra charge for COD if enabled
        if isCODAvailable && totalAmount > 500 {
            codExtraCharge = 50
        }
    }

    func addPaymentMethod(_ method: PaymentMethod) {
        savedMethods.append(method)
        ToastManager.show("Payment method added successfully")
        HapticFeedback.success()
    }

    func linkPaytmWallet() async throws -> Bool {
        // Integrate with Paytm SDK
        let linked = try await paymentService.linkPaytmWallet()
        if linked {
            isPaytmLinked = true
            paytmBalance = try await paymentService.fetchPaytmBalance()
        }
        return linked
    }
}
```

### Data Models
```swift
struct PaymentMethod: Identifiable {
    let id: String
    let type: PaymentType
    let displayName: String
    let last4: String? // For cards
    let upiId: String? // For UPI
    let cardBrand: CardBrand? // Visa, Mastercard, etc.
    let bankName: String?
    let expiryMonth: Int?
    let expiryYear: Int?
    let isDefault: Bool

    var isExpired: Bool {
        guard let month = expiryMonth, let year = expiryYear else {
            return false
        }
        let now = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: now)
        let currentMonth = calendar.component(.month, from: now)

        return year < currentYear || (year == currentYear && month < currentMonth)
    }
}

enum PaymentType: String {
    case card
    case upi
    case wallet
    case netBanking
    case cod
}

enum CardBrand: String {
    case visa
    case mastercard
    case rupay
    case amex

    var icon: String {
        switch self {
        case .visa: return "creditcard.fill"
        case .mastercard: return "creditcard.fill"
        case .rupay: return "creditcard.fill"
        case .amex: return "creditcard.fill"
        }
    }
}
```

### Component: SavedPaymentMethodCard
```swift
struct SavedPaymentMethodCard: View {
    let method: PaymentMethod
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Icon
                Image(systemName: iconName)
                    .font(.system(size: 24))
                    .foregroundColor(.primary)
                    .frame(width: 24, height: 24)

                // Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(method.displayName)
                        .font(.custom("Inter-Medium", size: 16))
                        .foregroundColor(.textPrimary)

                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundColor(.textSecondary)
                }

                Spacer()

                // Checkmark (if selected)
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isSelected ? Color.primary : Color.gray300,
                        lineWidth: isSelected ? 2 : 1
                    )
            )
            .shadow(
                color: Color.black.opacity(0.08),
                radius: 1.5,
                x: 0,
                y: 1
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .padding(.bottom, 12)
    }

    private var iconName: String {
        switch method.type {
        case .card:
            return "creditcard.fill"
        case .upi:
            return "circle.fill"
        default:
            return "creditcard"
        }
    }

    private var subtitle: String {
        switch method.type {
        case .card:
            if let last4 = method.last4, let bank = method.bankName {
                return "•••• •••• •••• \(last4) - \(bank)"
            }
            return "•••• •••• •••• \(method.last4 ?? "")"
        case .upi:
            return method.upiId ?? "UPI ID"
        default:
            return ""
        }
    }
}
```

## Navigation Flow

### Entry Points
- **From**: Booking Summary screen
- **Trigger**: Tap "Proceed to Payment" button
- **Animation**: Push (slide from right)
- **Data Passed**:
  - Booking ID
  - Total amount
  - Booking details (for validation)

### Exit Points

**Success Path:**
1. Select payment method → Pay button enabled
2. Tap Pay button → Navigate to Payment Processing
3. Pass: payment method ID, booking ID, amount

**Alternative Paths:**
- Tap Back button → Return to Booking Summary
- Add payment method → Open bottom sheet (modal)
- Link wallet → External app → Return here
- Net banking → Navigate to bank selection screen

**Error Paths:**
- Network error → Show retry option
- Payment method expired → Prompt to remove/add new
- COD not available → Show alert, disable option

### Bottom Sheet: Add Payment Method
```
Presented modally over current screen
- Tab switcher: Card | UPI
- Form fields based on tab
- Save button
- Cancel option
```

### Bottom Sheet: Payment Help
```
Presented modally
- FAQs list
- Security information
- Contact support button
- Close button
```

## API Integration

### Fetch Saved Payment Methods
```
GET /api/v1/users/{userId}/payment-methods

Response:
{
  "methods": [
    {
      "id": "pm_123",
      "type": "card",
      "last4": "4532",
      "brand": "visa",
      "bank": "HDFC Bank",
      "expiryMonth": 12,
      "expiryYear": 2026,
      "isDefault": true
    },
    {
      "id": "pm_124",
      "type": "upi",
      "upiId": "rahul@oksbi"
    }
  ]
}
```

### Check COD Availability
```
POST /api/v1/bookings/{bookingId}/check-cod-availability

Request:
{
  "amount": 949,
  "serviceId": "SVC123"
}

Response:
{
  "available": true,
  "extraCharge": 50,
  "reason": null
}
```

### Link Wallet (Paytm)
```
POST /api/v1/users/{userId}/link-wallet

Request:
{
  "walletType": "paytm",
  "phone": "9876543210"
}

Response:
{
  "linked": true,
  "balance": 1245,
  "walletId": "wlt_789"
}
```

### Add Payment Method (Card)
```
POST /api/v1/users/{userId}/payment-methods

Request:
{
  "type": "card",
  "cardNumber": "4532123456784321",
  "expiryMonth": 12,
  "expiryYear": 2027,
  "cvv": "123",
  "saveForFuture": true
}

Response:
{
  "id": "pm_125",
  "type": "card",
  "last4": "4321",
  "brand": "visa",
  "bank": "SBI",
  "expiryMonth": 12,
  "expiryYear": 2027
}
```

## Security Considerations

### Data Handling
- **Never store**: Full card numbers, CVV
- **Tokenization**: Use Razorpay tokens for cards
- **Encryption**: All API calls over HTTPS
- **PCI Compliance**: Follow PCI-DSS standards

### UI Security
- **Mask Card Numbers**: Always show •••• except last 4
- **No Screenshots**: Disable for payment screens (if possible)
- **Session Timeout**: 10 minutes on this screen
- **Biometric Confirmation**: Optional for high-value payments

### Validation
- **Expiry Check**: Validate card not expired
- **Luhn Algorithm**: Validate card number format
- **UPI Format**: Validate UPI ID format (xxx@xxx)
- **Amount Limit**: Check daily/transaction limits

## Success Metrics

### Conversion Metrics
- Payment method selection rate: > 85%
- Add new method completion rate: > 60%
- COD selection rate: < 30%
- Saved method usage rate: > 70%

### Performance Metrics
- Screen load time: < 1 second
- Payment method save time: < 2 seconds
- Wallet link time: < 3 seconds

### User Experience
- Drop-off rate: < 10%
- Help access rate: < 5%
- Error encounter rate: < 2%

## Error Messages

### Common Errors
1. **Expired Card**:
   - "This card has expired. Please add a new payment method."
   - Action: Remove + Add New

2. **COD Not Available**:
   - "Cash on Delivery is not available for bookings above ₹2000."
   - Action: Select another method

3. **Network Error**:
   - "Unable to load payment methods. Please check your connection."
   - Action: Retry button

4. **Wallet Link Failed**:
   - "Failed to link Paytm wallet. Please try again."
   - Action: Retry

5. **Invalid Card**:
   - "Invalid card details. Please check and try again."
   - Action: Edit and resubmit

## Testing Checklist

### Functional Testing
- ✅ Load saved payment methods
- ✅ Select/deselect payment method
- ✅ Add new card (valid + invalid)
- ✅ Add new UPI ID (valid + invalid)
- ✅ Link Paytm wallet
- ✅ Select net banking
- ✅ Select COD (when available)
- ✅ Proceed to payment with selection
- ✅ Pay button disabled without selection
- ✅ Back navigation preserves selection

### Edge Cases
- ✅ No saved methods
- ✅ All saved methods expired
- ✅ COD not available
- ✅ Wallet link timeout
- ✅ Network error during load
- ✅ Session timeout
- ✅ Amount changes during selection

### Visual Testing
- ✅ Light mode
- ✅ Dark mode
- ✅ iPhone SE (small)
- ✅ iPhone 14 (medium)
- ✅ iPhone 14 Pro Max (large)
- ✅ Dynamic Type (-2, 0, +3)
- ✅ VoiceOver navigation

### Performance
- ✅ Load time < 1s
- ✅ Smooth scrolling
- ✅ No memory leaks
- ✅ Proper cleanup on exit
