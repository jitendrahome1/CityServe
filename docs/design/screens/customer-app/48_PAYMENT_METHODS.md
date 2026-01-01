# Screen 48: Payment Methods

## Overview

- **Screen ID**: 48
- **Screen Name**: Payment Methods
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 46 (Edit Profile) → Tap "Manage Payment Methods"
  - From: Screen 21 (Profile Dashboard) → "Payment Methods"
  - From: Booking payment screen → "Manage Cards"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  ← Payment Methods          + Add       │ Header
├─────────────────────────────────────────┤
│                                         │
│  💳 Cards                               │ Section
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  💳 •••• 4242            VISA    │   │ Card Item
│  │  Expires: 12/25          ⭐      │   │ (Primary)
│  │  John Smith                      │   │
│  │  [Edit]  [Delete]                │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  💳 •••• 5678        Mastercard  │   │
│  │  Expires: 08/24                  │   │
│  │  John Smith                      │   │
│  │  [Edit]  [Delete]  [Set Default]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  💰 UPI                                 │ Section
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  📱 john@paytm          ⭐       │   │ UPI Item
│  │  Verified UPI ID                 │   │ (Primary)
│  │  [Edit]  [Delete]                │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  📱 9876543210@ybl               │   │
│  │  PhonePe                         │   │
│  │  [Edit]  [Delete]  [Set Default]│   │
│  └─────────────────────────────────┘   │
│                                         │
│  👛 Wallets                             │ Section
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  Paytm Wallet                    │   │ Wallet Item
│  │  Balance: ₹ 1,250                │   │
│  │  +91 98765 43210                 │   │
│  │  [Recharge]  [Remove]            │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  Mobikwik                        │   │
│  │  Balance: ₹ 500                  │   │
│  │  +91 98765 43210                 │   │
│  │  [Recharge]  [Remove]            │   │
│  └─────────────────────────────────┘   │
│                                         │
│  🏦 Bank Accounts (Saved for Refunds)  │ Section
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  HDFC Bank - ••••5678            │   │ Bank Item
│  │  John Smith                      │   │
│  │  [Edit]  [Delete]                │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │     + Add Payment Method         │   │ Add Button
│  └─────────────────────────────────┘   │
│                                         │
│  🔒 All payment information is          │ Security Note
│     encrypted and secure                │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Credit/Debit Cards
- Card number (last 4 digits)
- Card type (Visa, Mastercard, Amex, Rupay)
- Expiry date
- Cardholder name
- Primary card badge (⭐)
- Edit/Delete/Set Default actions

### 2. UPI IDs
- UPI ID (e.g., john@paytm, 9876543210@ybl)
- Provider (Paytm, PhonePe, Google Pay, BHIM)
- Verified badge
- Primary UPI badge
- Edit/Delete/Set Default actions

### 3. Wallets
- Wallet name (Paytm, Mobikwik, FreeCharge)
- Current balance
- Linked phone number
- Recharge/Remove actions
- Auto-sync balance

### 4. Bank Accounts
- Bank name
- Account number (masked, last 4 digits)
- Account holder name
- Used for refunds
- Edit/Delete actions

### 5. Add Payment Method
- Prominent "+" button in header
- Card-style button at bottom
- Opens modal with options:
  - Add Card
  - Add UPI
  - Add Wallet
  - Add Bank Account

### 6. Security Features
- Encrypted storage
- CVV not stored
- Tokenization for cards
- Razorpay integration
- PCI-DSS compliant

### 7. Payment Method Limits
- Cards: Max 5
- UPI IDs: Max 3
- Wallets: Max 3
- Bank Accounts: Max 3

## Component Breakdown

```swift
struct PaymentMethodsView: View {
    @StateObject private var viewModel = PaymentMethodsViewModel()
    @State private var showAddPayment = false
    @State private var selectedMethodType: PaymentMethodType?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Cards Section
                if !viewModel.cards.isEmpty {
                    PaymentSection(title: "💳 Cards") {
                        ForEach(viewModel.cards) { card in
                            CardItem(
                                card: card,
                                isPrimary: card.id == viewModel.primaryCardId,
                                onEdit: { viewModel.editCard(card) },
                                onDelete: { viewModel.deleteCard(card) },
                                onSetDefault: { viewModel.setPrimaryCard(card) }
                            )
                        }
                    }
                }

                // UPI Section
                if !viewModel.upiIds.isEmpty {
                    PaymentSection(title: "💰 UPI") {
                        ForEach(viewModel.upiIds) { upi in
                            UPIItem(
                                upi: upi,
                                isPrimary: upi.id == viewModel.primaryUPIId,
                                onEdit: { viewModel.editUPI(upi) },
                                onDelete: { viewModel.deleteUPI(upi) },
                                onSetDefault: { viewModel.setPrimaryUPI(upi) }
                            )
                        }
                    }
                }

                // Wallets Section
                if !viewModel.wallets.isEmpty {
                    PaymentSection(title: "👛 Wallets") {
                        ForEach(viewModel.wallets) { wallet in
                            WalletItem(
                                wallet: wallet,
                                onRecharge: { viewModel.rechargeWallet(wallet) },
                                onRemove: { viewModel.removeWallet(wallet) }
                            )
                        }
                    }
                }

                // Bank Accounts Section
                if !viewModel.bankAccounts.isEmpty {
                    PaymentSection(title: "🏦 Bank Accounts (Saved for Refunds)") {
                        ForEach(viewModel.bankAccounts) { account in
                            BankAccountItem(
                                account: account,
                                onEdit: { viewModel.editBankAccount(account) },
                                onDelete: { viewModel.deleteBankAccount(account) }
                            )
                        }
                    }
                }

                // Add Button
                AddPaymentMethodButton(onTap: { showAddPayment = true })

                // Security Note
                HStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color("SuccessGreen"))

                    Text("All payment information is encrypted and secure")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextSecondary"))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color("SuccessGreen").opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 16)
        }
        .navigationTitle("Payment Methods")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showAddPayment = true }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color("PrimaryTeal"))
                }
            }
        }
        .actionSheet(isPresented: $showAddPayment) {
            ActionSheet(
                title: Text("Add Payment Method"),
                buttons: [
                    .default(Text("Add Card")) {
                        selectedMethodType = .card
                    },
                    .default(Text("Add UPI")) {
                        selectedMethodType = .upi
                    },
                    .default(Text("Add Wallet")) {
                        selectedMethodType = .wallet
                    },
                    .default(Text("Add Bank Account")) {
                        selectedMethodType = .bankAccount
                    },
                    .cancel()
                ]
            )
        }
        .sheet(item: $selectedMethodType) { type in
            AddPaymentMethodView(type: type, onSave: { method in
                viewModel.addPaymentMethod(method)
                selectedMethodType = nil
            })
        }
        .onAppear {
            viewModel.loadPaymentMethods()
        }
    }
}

struct PaymentSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))
                .padding(.horizontal, 16)

            VStack(spacing: 12) {
                content
            }
            .padding(.horizontal, 16)

            Divider()
                .padding(.horizontal, 16)
        }
    }
}

struct CardItem: View {
    let card: SavedCard
    let isPrimary: Bool
    let onEdit: () -> Void
    let onDelete: () -> Void
    let onSetDefault: () -> Void

    @State private var showDeleteConfirmation = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "creditcard.fill")
                    .font(.system(size: 20))
                    .foregroundColor(card.cardType.color)

                Text("•••• \(card.last4Digits)")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                Text(card.cardType.displayName)
                    .font(.custom("Inter-Medium", size: 13))
                    .foregroundColor(Color("TextSecondary"))

                if isPrimary {
                    Image(systemName: "star.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color("SecondaryOrange"))
                }
            }

            HStack {
                Text("Expires: \(card.expiryMonth)/\(card.expiryYear)")
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color("TextSecondary"))

                Spacer()
            }

            Text(card.cardholderName)
                .font(.custom("Inter-Regular", size: 13))
                .foregroundColor(Color("TextSecondary"))

            Divider()

            HStack(spacing: 16) {
                Button(action: onEdit) {
                    HStack(spacing: 4) {
                        Image(systemName: "pencil")
                            .font(.system(size: 14))
                        Text("Edit")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("PrimaryTeal"))
                }

                Button(action: { showDeleteConfirmation = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "trash")
                            .font(.system(size: 14))
                        Text("Delete")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("ErrorRed"))
                }

                Spacer()

                if !isPrimary {
                    Button(action: onSetDefault) {
                        Text("Set Default")
                            .font(.custom("Inter-Medium", size: 13))
                            .foregroundColor(Color("SecondaryOrange"))
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isPrimary ? Color("SecondaryOrange") : Color("BorderLight"), lineWidth: isPrimary ? 2 : 1)
        )
        .alert("Delete Card", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to remove this card?")
        }
    }
}

struct UPIItem: View {
    let upi: SavedUPI
    let isPrimary: Bool
    let onEdit: () -> Void
    let onDelete: () -> Void
    let onSetDefault: () -> Void

    @State private var showDeleteConfirmation = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "apps.iphone")
                    .font(.system(size: 20))
                    .foregroundColor(Color("PrimaryTeal"))

                Text(upi.upiId)
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                if isPrimary {
                    Image(systemName: "star.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color("SecondaryOrange"))
                }
            }

            if upi.isVerified {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color("SuccessGreen"))
                    Text("Verified UPI ID")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("SuccessGreen"))
                }
            }

            Text(upi.provider)
                .font(.custom("Inter-Regular", size: 13))
                .foregroundColor(Color("TextSecondary"))

            Divider()

            HStack(spacing: 16) {
                Button(action: onEdit) {
                    HStack(spacing: 4) {
                        Image(systemName: "pencil")
                            .font(.system(size: 14))
                        Text("Edit")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("PrimaryTeal"))
                }

                Button(action: { showDeleteConfirmation = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "trash")
                            .font(.system(size: 14))
                        Text("Delete")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("ErrorRed"))
                }

                Spacer()

                if !isPrimary {
                    Button(action: onSetDefault) {
                        Text("Set Default")
                            .font(.custom("Inter-Medium", size: 13))
                            .foregroundColor(Color("SecondaryOrange"))
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isPrimary ? Color("SecondaryOrange") : Color("BorderLight"), lineWidth: isPrimary ? 2 : 1)
        )
        .alert("Delete UPI", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to remove this UPI ID?")
        }
    }
}

struct WalletItem: View {
    let wallet: SavedWallet
    let onRecharge: () -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(wallet.name)
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()
            }

            HStack {
                Text("Balance:")
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color("TextSecondary"))
                Text("₹ \(wallet.balance)")
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("SuccessGreen"))
            }

            Text(wallet.linkedPhone)
                .font(.custom("Inter-Regular", size: 13))
                .foregroundColor(Color("TextSecondary"))

            Divider()

            HStack(spacing: 16) {
                Button(action: onRecharge) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 14))
                        Text("Recharge")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("PrimaryTeal"))
                }

                Button(action: onRemove) {
                    HStack(spacing: 4) {
                        Image(systemName: "trash")
                            .font(.system(size: 14))
                        Text("Remove")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("ErrorRed"))
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BorderLight"), lineWidth: 1)
        )
    }
}

struct BankAccountItem: View {
    let account: SavedBankAccount
    let onEdit: () -> Void
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "building.columns.fill")
                    .font(.system(size: 20))
                    .foregroundColor(Color("PrimaryTeal"))

                Text("\(account.bankName) - ••••\(account.last4Digits)")
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()
            }

            Text(account.accountHolderName)
                .font(.custom("Inter-Regular", size: 13))
                .foregroundColor(Color("TextSecondary"))

            Divider()

            HStack(spacing: 16) {
                Button(action: onEdit) {
                    HStack(spacing: 4) {
                        Image(systemName: "pencil")
                            .font(.system(size: 14))
                        Text("Edit")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("PrimaryTeal"))
                }

                Button(action: onDelete) {
                    HStack(spacing: 4) {
                        Image(systemName: "trash")
                            .font(.system(size: 14))
                        Text("Delete")
                            .font(.custom("Inter-Medium", size: 13))
                    }
                    .foregroundColor(Color("ErrorRed"))
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BorderLight"), lineWidth: 1)
        )
    }
}

struct AddPaymentMethodButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color("PrimaryTeal"))

                Text("Add Payment Method")
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("PrimaryTeal"))

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(Color("PrimaryTeal").opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("PrimaryTeal"), lineWidth: 1, style: StrokeStyle(dash: [5]))
            )
        }
        .padding(.horizontal, 16)
    }
}

struct SavedCard: Identifiable {
    let id: String
    let last4Digits: String
    let cardType: CardType
    let expiryMonth: String
    let expiryYear: String
    let cardholderName: String
}

struct SavedUPI: Identifiable {
    let id: String
    let upiId: String
    let provider: String
    let isVerified: Bool
}

struct SavedWallet: Identifiable {
    let id: String
    let name: String
    let balance: String
    let linkedPhone: String
}

struct SavedBankAccount: Identifiable {
    let id: String
    let bankName: String
    let last4Digits: String
    let accountHolderName: String
}

enum CardType {
    case visa
    case mastercard
    case amex
    case rupay

    var displayName: String {
        switch self {
        case .visa: return "VISA"
        case .mastercard: return "Mastercard"
        case .amex: return "Amex"
        case .rupay: return "RuPay"
        }
    }

    var color: Color {
        switch self {
        case .visa: return Color.blue
        case .mastercard: return Color.orange
        case .amex: return Color.green
        case .rupay: return Color.purple
        }
    }
}

enum PaymentMethodType: Identifiable {
    case card
    case upi
    case wallet
    case bankAccount

    var id: String { String(describing: self) }
}
```

## Interactions

### Payment Method Actions
1. **Tap Edit**: Opens edit form
2. **Tap Delete**: Shows confirmation, removes method
3. **Tap Set Default**: Makes method primary

### Add Payment Method
1. **Tap + (Header)**: Shows action sheet
2. **Select Method Type**: Opens corresponding form
3. **Fill Form**: Razorpay SDK integration for cards
4. **Save**: Validates, tokenizes, saves

### Wallet Recharge
1. **Tap Recharge**: Opens payment screen
2. **Enter Amount**: Min ₹100, max ₹10,000
3. **Pay**: Process payment, update balance

## States

### Empty State
```swift
VStack(spacing: 20) {
    Image(systemName: "creditcard")
        .font(.system(size: 70))
        .foregroundColor(Color("TextTertiary"))

    Text("No Payment Methods")
        .font(.custom("Inter-SemiBold", size: 18))

    Text("Add a payment method for faster checkout")
        .font(.custom("Inter-Regular", size: 14))
        .foregroundColor(Color("TextSecondary"))

    Button("Add Payment Method") { }
}
```

## API Integration

### Get Payment Methods
```
GET /customers/{customerId}/payment-methods

Response:
{
  "success": true,
  "data": {
    "cards": [{
      "id": "card_001",
      "last4Digits": "4242",
      "cardType": "visa",
      "expiryMonth": "12",
      "expiryYear": "25",
      "cardholderName": "John Smith",
      "isPrimary": true
    }],
    "upiIds": [{
      "id": "upi_001",
      "upiId": "john@paytm",
      "provider": "Paytm",
      "isVerified": true,
      "isPrimary": true
    }],
    "wallets": [{
      "id": "wallet_001",
      "name": "Paytm Wallet",
      "balance": "1250",
      "linkedPhone": "+919876543210"
    }],
    "bankAccounts": [{
      "id": "bank_001",
      "bankName": "HDFC Bank",
      "last4Digits": "5678",
      "accountHolderName": "John Smith"
    }]
  }
}
```

### Add Card (Razorpay)
```
POST /customers/{customerId}/payment-methods/card

Request:
{
  "razorpayTokenId": "tok_xyz123",
  "cardholderName": "John Smith",
  "setAsPrimary": true
}

Response:
{
  "success": true,
  "data": {
    "cardId": "card_002"
  }
}
```

### Delete Payment Method
```
DELETE /customers/{customerId}/payment-methods/{methodId}

Response:
{
  "success": true,
  "message": "Payment method removed"
}
```

## Testing Checklist

- [ ] Payment methods load correctly
- [ ] Add card via Razorpay SDK works
- [ ] Card tokenization works
- [ ] Edit card updates details
- [ ] Delete card confirmation works
- [ ] Set default card works
- [ ] UPI ID validation works
- [ ] Wallet balance syncs
- [ ] Wallet recharge works
- [ ] Max limits enforced

## Design Notes

### Security
- Never store CVV
- Use Razorpay tokenization for cards
- Encrypt sensitive data
- PCI-DSS compliance

### Edge Cases
- Cannot delete last payment method
- Handle expired cards
- Wallet sync failures

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
