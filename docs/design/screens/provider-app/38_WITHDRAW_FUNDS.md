# Withdraw Funds

## Overview
- **Screen ID**: 38
- **Screen Name**: Withdraw Funds
- **User Role**: Service Provider
- **Platform**: iOS, Android
- **Navigation**: From Earnings Dashboard (Screen 36) → Tap "Withdraw Funds"

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ✕  Withdraw Funds                       │
├──────────────────────────────────────────┤
│                                          │
│  💳 Available Balance                    │
│                                          │
│      ₹3,850.00                           │  ← Available amount
│                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                          │
│  💰 Withdrawal Amount *                  │
│  ┌────────────────────────────────────┐ │
│  │ ₹  3,850                           │ │  ← Amount input
│  └────────────────────────────────────┘ │
│                                          │
│  Quick Select                            │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌────────┐│
│  │₹1,000│ │₹2,500│ │₹5,000│ │ Max    ││
│  └──────┘ └──────┘ └──────┘ └────────┘│
│                                          │
│  You will receive: ₹3,850.00             │
│  (No withdrawal fees)                    │
│                                          │
│  🏦 Bank Account *                       │
│  ┌────────────────────────────────────┐ │
│  │ ☑ HDFC Bank ••••5678          ▼    │ │  ← Account selector
│  │   Jitendra Kumar                   │ │
│  └────────────────────────────────────┘ │
│                                          │
│  [+ Add New Bank Account]                │
│                                          │
│  ⏱️ Processing Time                      │
│  ┌────────────────────────────────────┐ │
│  │ Funds will be credited within      │ │
│  │ 1-2 business days                  │ │
│  │                                    │ │
│  │ Estimated arrival: 17 Jan 2025     │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ℹ️ Important Information                │
│  ┌────────────────────────────────────┐ │
│  │ • Minimum withdrawal: ₹100         │ │
│  │ • Maximum per day: ₹50,000         │ │
│  │ • No withdrawal fees               │ │
│  │ • Withdrawals processed Mon-Fri    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │      Confirm Withdrawal            │ │  ← Primary button
│  └────────────────────────────────────┘ │
│                                          │
│              Cancel                      │
│                                          │
└──────────────────────────────────────────┘
```

## Key Features

### Available Balance Display
- Clearly shows withdrawable amount
- Excludes pending/on-hold funds
- Updates in real-time
- Large, prominent display

### Withdrawal Amount Input

**Input Field:**
- Currency symbol prefix (₹)
- Numeric keyboard
- Thousand separator formatting
- Max value validation

**Quick Select Buttons:**
- Pre-defined amounts (₹1000, ₹2500, ₹5000)
- "Max" button (fills available balance)
- One-tap convenience
- Responsive highlighting

**Amount Validation:**
- Minimum: ₹100
- Maximum: ₹50,000 per day
- Cannot exceed available balance
- Real-time error messages

### Withdrawal Fee Display

**Transparent Pricing:**
- Show withdrawal fees (if any)
- Net amount to be received
- Clear calculation breakdown
- UrbanNest: No fees for standard withdrawals

### Bank Account Selection

**Account Display:**
- Bank name and logo
- Last 4 digits of account number
- Account holder name
- Default account marked

**Multiple Accounts:**
- Dropdown selector
- Add new account option
- Set default account
- Verify account status indicator

### Processing Information

**Timeline:**
- Estimated processing time (1-2 business days)
- Expected arrival date
- Business hours note (Mon-Fri)
- Weekend/holiday delays mentioned

**Status Updates:**
- Real-time withdrawal status
- Notification when processed
- Notification when credited
- Issue alerts

### Important Information Panel

**Key Points:**
- Minimum/maximum limits
- Processing schedule
- Fee structure
- Daily/weekly limits
- Security notes

## Component Breakdown

### Available Balance Header

```swift
struct AvailableBalanceHeader: View {
    let availableBalance: Double
    let pendingAmount: Double

    var body: some View {
        VStack(spacing: 12) {
            Text("💳 Available Balance")
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(.gray600)

            Text("₹\(availableBalance, specifier: "%.2f")")
                .font(.custom("Inter-Bold", size: 36))
                .foregroundColor(.brandPrimary)

            if pendingAmount > 0 {
                HStack(spacing: 6) {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.warning)

                    Text("₹\(pendingAmount, specifier: "%.2f") pending (available in 24hrs)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray600)
                }
            }
        }
        .padding(.vertical, 24)
    }
}
```

### Amount Input with Quick Select

```swift
struct WithdrawalAmountInput: View {
    @Binding var amount: String
    let availableBalance: Double
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("💰 Withdrawal Amount")
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(.gray800)

                Text("*")
                    .foregroundColor(.error)
            }

            HStack(spacing: 12) {
                Text("₹")
                    .font(.custom("Inter-SemiBold", size: 20))
                    .foregroundColor(.gray700)

                TextField("0", text: $amount)
                    .font(.custom("Inter-SemiBold", size: 24))
                    .keyboardType(.numberPad)
                    .onChange(of: amount) { newValue in
                        validateAmount(newValue)
                    }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(errorMessage != nil ? Color.error : Color.gray200, lineWidth: errorMessage != nil ? 2 : 1)
            )

            if let error = errorMessage {
                Text(error)
                    .font(.system(size: 12))
                    .foregroundColor(.error)
            }

            // Quick select buttons
            QuickSelectButtons(amount: $amount, availableBalance: availableBalance)

            // Net amount display
            if let amountValue = Double(amount), amountValue > 0 {
                HStack {
                    Text("You will receive:")
                        .font(.system(size: 14))
                        .foregroundColor(.gray600)

                    Spacer()

                    Text("₹\(amountValue, specifier: "%.2f")")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(.success)
                }
                .padding(.vertical, 8)

                Text("(No withdrawal fees)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray500)
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }

    func validateAmount(_ value: String) {
        guard let numericValue = Double(value) else {
            errorMessage = nil
            return
        }

        if numericValue < 100 {
            errorMessage = "Minimum withdrawal is ₹100"
        } else if numericValue > 50000 {
            errorMessage = "Maximum withdrawal per day is ₹50,000"
        } else if numericValue > availableBalance {
            errorMessage = "Amount exceeds available balance"
        } else {
            errorMessage = nil
        }
    }
}

struct QuickSelectButtons: View {
    @Binding var amount: String
    let availableBalance: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Quick Select")
                .font(.system(size: 12))
                .foregroundColor(.gray600)

            HStack(spacing: 8) {
                QuickSelectButton(amount: "1000", label: "₹1,000") {
                    amount = "1000"
                }

                QuickSelectButton(amount: "2500", label: "₹2,500") {
                    amount = "2500"
                }

                QuickSelectButton(amount: "5000", label: "₹5,000") {
                    amount = "5000"
                }

                QuickSelectButton(amount: String(format: "%.0f", availableBalance), label: "Max") {
                    amount = String(format: "%.0f", availableBalance)
                }
            }
        }
    }
}

struct QuickSelectButton: View {
    let amount: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.brandPrimary)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
                .background(Color.brandPrimary.opacity(0.1))
                .cornerRadius(6)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
```

### Bank Account Selector

```swift
struct BankAccountSelector: View {
    @Binding var selectedAccount: BankAccount?
    let accounts: [BankAccount]
    let onAddNew: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("🏦 Bank Account")
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(.gray800)

                Text("*")
                    .foregroundColor(.error)
            }

            if let account = selectedAccount {
                Menu {
                    ForEach(accounts) { acc in
                        Button(action: { selectedAccount = acc }) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(acc.bankName) ••••\(acc.lastFourDigits)")
                                    Text(acc.accountHolderName)
                                        .font(.caption)
                                }

                                if acc.isDefault {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack {
                        if account.isVerified {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(.success)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(account.bankName) ••••\(account.lastFourDigits)")
                                .font(.custom("Inter-Medium", size: 15))
                                .foregroundColor(.gray900)

                            Text(account.accountHolderName)
                                .font(.system(size: 13))
                                .foregroundColor(.gray600)
                        }

                        Spacer()

                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.gray500)
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray200, lineWidth: 1)
                    )
                }
            }

            Button(action: onAddNew) {
                HStack(spacing: 8) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.brandPrimary)

                    Text("Add New Bank Account")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(.brandPrimary)
                }
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}
```

### Processing Info Card

```swift
struct ProcessingInfoCard: View {
    let estimatedArrival: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("⏱️ Processing Time")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(.gray900)

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.brandPrimary)

                    Text("Funds will be credited within 1-2 business days")
                        .font(.system(size: 14))
                        .foregroundColor(.gray700)
                }

                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                        .foregroundColor(.success)

                    Text("Estimated arrival: \(estimatedArrival.formatted(date: .abbreviated, time: .omitted))")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.success)
                }
            }
        }
        .padding(16)
        .background(Color.brandPrimary.opacity(0.05))
        .cornerRadius(12)
    }
}
```

### Important Information Panel

```swift
struct ImportantInfoPanel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.brandPrimary)

                Text("Important Information")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(.gray800)
            }

            VStack(alignment: .leading, spacing: 8) {
                InfoRow(text: "Minimum withdrawal: ₹100")
                InfoRow(text: "Maximum per day: ₹50,000")
                InfoRow(text: "No withdrawal fees")
                InfoRow(text: "Withdrawals processed Mon-Fri")
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

struct InfoRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .foregroundColor(.gray600)

            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.gray700)
        }
    }
}
```

## Interactions

### Confirm Withdrawal

```swift
func confirmWithdrawal() {
    // Validate all inputs
    guard validateInputs() else { return }

    // Show confirmation
    AlertManager.show(
        title: "Confirm Withdrawal?",
        message: "₹\(amount) will be transferred to \(selectedAccount.bankName) ••••\(selectedAccount.lastFourDigits). This usually takes 1-2 business days.",
        primaryButton: "Confirm",
        secondaryButton: "Cancel",
        primaryAction: {
            processWithdrawal()
        }
    )
}

func validateInputs() -> Bool {
    guard let amountValue = Double(amount) else {
        AlertManager.showError("Please enter a valid amount")
        return false
    }

    guard amountValue >= 100 else {
        AlertManager.showError("Minimum withdrawal is ₹100")
        return false
    }

    guard amountValue <= 50000 else {
        AlertManager.showError("Maximum withdrawal per day is ₹50,000")
        return false
    }

    guard amountValue <= availableBalance else {
        AlertManager.showError("Insufficient balance")
        return false
    }

    guard selectedAccount != nil else {
        AlertManager.showError("Please select a bank account")
        return false
    }

    return true
}

func processWithdrawal() {
    isLoading = true

    Task {
        do {
            let result = await viewModel.initiateWithdrawal(
                amount: Double(amount)!,
                accountId: selectedAccount!.id
            )

            isLoading = false

            if result.success {
                showSuccessScreen(result)

                analytics.track("withdrawal_initiated", [
                    "amount": Double(amount)!,
                    "account_type": selectedAccount!.bankName
                ])

                HapticManager.notification(.success)
            } else {
                AlertManager.showError("Withdrawal failed. Please try again.")
            }
        } catch {
            isLoading = false
            AlertManager.showError(error.localizedDescription)
        }
    }
}

func showSuccessScreen(_ result: WithdrawalResult) {
    let successView = WithdrawalSuccessView(
        amount: Double(amount)!,
        transactionId: result.transactionId,
        estimatedArrival: result.estimatedArrival,
        onDone: {
            dismiss()
        }
    )

    presentFullScreen(successView)
}
```

### Add Bank Account

```swift
func addBankAccount() {
    navigationController?.push(BankAccountDetailsView(
        onAccountAdded: { newAccount in
            accounts.append(newAccount)
            selectedAccount = newAccount
        }
    ))
}
```

## States

### Default State
- Amount field empty
- Default bank account selected
- Confirm button disabled
- All info displayed

### Amount Entered State
- Amount validated in real-time
- Confirm button enabled if valid
- Net amount calculated
- Error shown if invalid

### Loading State
- Confirm button shows spinner
- "Processing withdrawal..." text
- All inputs disabled
- Cannot dismiss

### Success State
- Navigate to success screen
- Show transaction ID
- Display estimated arrival
- Option to view transactions

### Error State
- Error message shown
- Retry option available
- All inputs enabled
- Previous values retained

## API Integration

### Initiate Withdrawal
```typescript
POST /providers/{providerId}/withdrawals
Body:
{
  "amount": 3850.00,
  "bankAccountId": "ACC123",
  "currency": "INR"
}

Response:
{
  "success": true,
  "data": {
    "transactionId": "WD123456",
    "amount": 3850.00,
    "fee": 0,
    "netAmount": 3850.00,
    "status": "pending",
    "estimatedArrival": "2025-01-17",
    "createdAt": "2025-01-15T10:30:00Z"
  }
}
```

### Get Withdrawal Limits
```typescript
GET /providers/{providerId}/withdrawal-limits

Response:
{
  "success": true,
  "data": {
    "dailyLimit": 50000,
    "dailyUsed": 0,
    "dailyRemaining": 50000,
    "minimumAmount": 100,
    "availableBalance": 3850.00,
    "pendingAmount": 1200.00
  }
}
```

## Navigation

### Entry Points
- Screen 36 (Earnings Dashboard) → "Withdraw Funds"
- Notification → "Withdraw now"

### Exit Points
- Tap "Confirm" → Success screen → Dismiss
- Tap "Add Account" → Screen 39 (Bank Account Details)
- Tap Cancel → Dismiss sheet

## Accessibility

### VoiceOver
- Balance: "Available balance, 3,850 rupees"
- Amount: "Withdrawal amount, Required, Text field"
- Quick select: "1,000 rupees, Button"
- Account: "HDFC Bank ending in 5678, Selected, Button"

### Touch Targets
- All buttons: 44pt height minimum
- Input fields: 48pt height

## Analytics

```typescript
analytics.track('withdrawal_screen_opened', {
  available_balance: 3850.00,
  source: 'earnings_dashboard'
})

analytics.track('withdrawal_initiated', {
  amount: 3850.00,
  bank: 'HDFC',
  has_fee: false
})

analytics.track('withdrawal_failed', {
  error: 'insufficient_balance',
  attempted_amount: 5000
})
```

## Testing Checklist

- [ ] Amount validation works
- [ ] Quick select fills amount
- [ ] Bank account selector works
- [ ] Add account navigation works
- [ ] Minimum amount enforced
- [ ] Maximum amount enforced
- [ ] Balance check works
- [ ] Confirmation dialog shows
- [ ] Success screen displays
- [ ] Error handling works
- [ ] Number formatting correct
- [ ] Loading states smooth

## Design Notes

- Clear, prominent balance
- Easy amount entry with quick select
- Transparent fee structure
- Bank account verification status
- Processing timeline upfront
- Secure confirmation flow
