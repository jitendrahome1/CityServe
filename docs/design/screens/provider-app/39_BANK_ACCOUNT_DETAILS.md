# Screen 39: Bank Account Details

## Overview

- **Screen ID**: 39
- **Screen Name**: Bank Account Details
- **User Role**: Provider
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 38 (Withdraw Funds) → Tap "Add New Bank Account" / "Change Account"
  - From: Screen 48 (Provider App Settings) → Tap "Bank Accounts"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ←  Bank Accounts                    ⋮  │ Header
├─────────────────────────────────────────┤
│                                         │
│  💳 Saved Bank Accounts                 │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 🏦  HDFC Bank              ⭐   │    │ Primary Account Card
│  │     ••••••••5678                │    │
│  │     John Doe                    │    │
│  │     IFSC: HDFC0001234          │    │
│  │                                 │    │
│  │     Verified ✓      [Set Default]│   │
│  │                                 │    │
│  │     [Edit]  [Remove]            │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 🏦  ICICI Bank                  │    │ Saved Account Card
│  │     ••••••••9012                │    │
│  │     John Doe                    │    │
│  │     IFSC: ICIC0002345          │    │
│  │                                 │    │
│  │     Verified ✓      [Set Default]│   │
│  │                                 │    │
│  │     [Edit]  [Remove]            │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ + Add New Bank Account          │    │ Add New Button
│  └────────────────────────────────┘    │
│                                         │
│  ℹ️ Information                         │
│  • You can add up to 3 bank accounts   │
│  • Withdrawals go to default account   │
│  • Account verification takes 1-2 mins │
│  • Cannot delete account with pending  │
│    withdrawals                         │
│                                         │
└─────────────────────────────────────────┘

WHEN ADDING NEW ACCOUNT:

┌─────────────────────────────────────────┐
│ ←  Add Bank Account                     │ Header
├─────────────────────────────────────────┤
│                                         │
│  Account Holder Details                 │
│  ┌────────────────────────────────┐    │
│  │ Full Name (as per bank)         │    │ Text Input
│  │ John Doe                        │    │
│  └────────────────────────────────┘    │
│  ⓘ Must match bank records exactly      │
│                                         │
│  Bank Details                           │
│  ┌────────────────────────────────┐    │
│  │ Bank Name ▼                     │    │ Dropdown
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Account Number                  │    │ Text Input
│  │ 123456789012                    │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Re-enter Account Number         │    │ Text Input
│  │ 123456789012                    │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ IFSC Code                       │    │ Text Input
│  │ HDFC0001234        [Find IFSC]  │    │
│  └────────────────────────────────┘    │
│  Branch: Connaught Place, New Delhi     │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ Account Type ▼                  │    │ Dropdown
│  │ Savings                         │    │
│  └────────────────────────────────┘    │
│  Options: Savings, Current              │
│                                         │
│  ☐ Set as default account               │ Checkbox
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   Verify & Add Account           │   │ Primary CTA
│  └─────────────────────────────────┘   │
│                                         │
│  🔒 Your bank details are encrypted     │
│      and stored securely                │
│                                         │
└─────────────────────────────────────────┘

VERIFICATION IN PROGRESS:

┌─────────────────────────────────────────┐
│      Verifying Bank Account...          │
├─────────────────────────────────────────┤
│                                         │
│           ⏳ (Animated)                 │
│                                         │
│   Verifying your bank account details   │
│                                         │
│   ✓ Account holder name verified        │
│   ✓ IFSC code validated                 │
│   ⏳ Initiating penny drop...            │
│                                         │
│   This usually takes 30-60 seconds      │
│                                         │
│   Please wait...                        │
│                                         │
└─────────────────────────────────────────┘

VERIFICATION SUCCESS:

┌─────────────────────────────────────────┐
│         ✓ Account Verified!             │
├─────────────────────────────────────────┤
│                                         │
│          ✅ (Success Icon)              │
│                                         │
│   Your bank account has been            │
│   successfully verified and added       │
│                                         │
│   🏦 HDFC Bank                           │
│      ••••••••5678                       │
│      John Doe                           │
│                                         │
│   You can now use this account for      │
│   withdrawals                           │
│                                         │
│   ┌─────────────────────────────────┐  │
│   │      Make This Default           │  │ Secondary Button
│   └─────────────────────────────────┘  │
│                                         │
│   ┌─────────────────────────────────┐  │
│   │          Done                    │  │ Primary Button
│   └─────────────────────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Saved Accounts List
- Display all saved bank accounts (max 3)
- Default account marked with ⭐
- Masked account numbers (show last 4 digits)
- Verification status badge
- Quick actions: Edit, Remove, Set Default

### 2. Add New Account Form
- Account holder name (must match bank records)
- Bank selection (dropdown with popular banks)
- Account number (with confirmation field)
- IFSC code (with lookup helper)
- Account type selection (Savings/Current)
- Set as default option

### 3. Bank Verification
- Penny drop verification (₹1 deposit test)
- Real-time verification status
- Auto-validation of IFSC code
- Name matching with bank records

### 4. Account Management
- Edit existing accounts (limited fields)
- Remove accounts (with confirmation)
- Set/change default account
- Cannot delete account with pending withdrawals

### 5. Security Features
- Encrypted storage
- Masked account numbers in list view
- Re-enter account number for confirmation
- Bank logo and branch display

## Component Breakdown

### 1. Header (Navigation Bar)
```swift
struct BankAccountsHeader: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showingMenu: Bool

    var body: some View {
        HStack {
            // Back Button
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }

            Text("Bank Accounts")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(Color("TextPrimary"))

            Spacer()

            // Menu Button (Edit/Help)
            Button(action: { showingMenu = true }) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
```

**Design Specs**:
- Height: 56pt
- Background: White
- Title: Inter SemiBold 18pt, #1A1A1A
- Back/Menu icons: 18pt, #1A1A1A
- Padding: 16pt horizontal, 12pt vertical

### 2. Bank Account Card
```swift
struct BankAccountCard: View {
    let account: BankAccount
    let isDefault: Bool
    let onSetDefault: () -> Void
    let onEdit: () -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Bank Header
            HStack {
                Image(account.bankLogo)
                    .resizable()
                    .frame(width: 32, height: 32)

                Text(account.bankName)
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()

                if isDefault {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("SecondaryOrange"))
                        .font(.system(size: 16))
                }
            }

            // Account Number (Masked)
            Text("••••••••\(account.lastFourDigits)")
                .font(.custom("SF Mono", size: 18))
                .foregroundColor(Color("TextSecondary"))

            // Account Holder Name
            Text(account.holderName)
                .font(.custom("Inter-Medium", size: 14))
                .foregroundColor(Color("TextSecondary"))

            // IFSC Code
            Text("IFSC: \(account.ifscCode)")
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color("TextTertiary"))

            Divider()
                .padding(.vertical, 4)

            // Verification Status + Set Default
            HStack {
                // Verified Badge
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.shield.fill")
                        .foregroundColor(Color("SuccessGreen"))
                        .font(.system(size: 12))
                    Text("Verified")
                        .font(.custom("Inter-Medium", size: 12))
                        .foregroundColor(Color("SuccessGreen"))
                }

                Spacer()

                if !isDefault {
                    Button(action: onSetDefault) {
                        Text("Set Default")
                            .font(.custom("Inter-SemiBold", size: 12))
                            .foregroundColor(Color("PrimaryTeal"))
                    }
                }
            }

            Divider()
                .padding(.vertical, 4)

            // Actions
            HStack(spacing: 16) {
                Button(action: onEdit) {
                    Label("Edit", systemImage: "pencil")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                }

                Spacer()

                Button(action: onRemove) {
                    Label("Remove", systemImage: "trash")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("ErrorRed"))
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isDefault ? Color("PrimaryTeal") : Color("BorderLight"), lineWidth: isDefault ? 2 : 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
    }
}
```

**Design Specs**:
- Padding: 16pt
- Corner radius: 12pt
- Border: 1pt #E8E8E8 (2pt #0D7377 if default)
- Shadow: 0px 2px 8px rgba(0,0,0,0.04)
- Bank logo: 32x32pt
- Account number: SF Mono 18pt (monospaced)
- Default star: #FF6B35, 16pt

### 3. Add New Account Form
```swift
struct AddBankAccountForm: View {
    @StateObject private var viewModel: BankAccountViewModel
    @State private var accountHolderName = ""
    @State private var selectedBank: Bank?
    @State private var accountNumber = ""
    @State private var confirmAccountNumber = ""
    @State private var ifscCode = ""
    @State private var accountType = "Savings"
    @State private var setAsDefault = false
    @State private var showingBankPicker = false
    @State private var showingIFSCFinder = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Account Holder Details Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Account Holder Details")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(Color("TextPrimary"))

                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Full Name (as per bank)", text: $accountHolderName)
                            .textFieldStyle(CustomTextFieldStyle())
                            .textInputAutocapitalization(.words)

                        HStack(spacing: 4) {
                            Image(systemName: "info.circle")
                                .font(.system(size: 12))
                                .foregroundColor(Color("TextTertiary"))
                            Text("Must match bank records exactly")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("TextTertiary"))
                        }
                    }
                }

                // Bank Details Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Bank Details")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(Color("TextPrimary"))

                    // Bank Selector
                    Button(action: { showingBankPicker = true }) {
                        HStack {
                            if let bank = selectedBank {
                                Image(bank.logo)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text(bank.name)
                                    .font(.custom("Inter-Medium", size: 16))
                                    .foregroundColor(Color("TextPrimary"))
                            } else {
                                Text("Select Bank")
                                    .font(.custom("Inter-Regular", size: 16))
                                    .foregroundColor(Color("TextTertiary"))
                            }
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color("TextTertiary"))
                        }
                        .padding(12)
                        .background(Color("BackgroundSecondary"))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("BorderLight"), lineWidth: 1)
                        )
                    }

                    // Account Number
                    TextField("Account Number", text: $accountNumber)
                        .textFieldStyle(CustomTextFieldStyle())
                        .keyboardType(.numberPad)

                    // Confirm Account Number
                    TextField("Re-enter Account Number", text: $confirmAccountNumber)
                        .textFieldStyle(CustomTextFieldStyle())
                        .keyboardType(.numberPad)

                    if !confirmAccountNumber.isEmpty && accountNumber != confirmAccountNumber {
                        HStack(spacing: 4) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundColor(Color("ErrorRed"))
                            Text("Account numbers don't match")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("ErrorRed"))
                        }
                    }

                    // IFSC Code
                    HStack(spacing: 8) {
                        TextField("IFSC Code", text: $ifscCode)
                            .textFieldStyle(CustomTextFieldStyle())
                            .textInputAutocapitalization(.characters)
                            .onChange(of: ifscCode) { newValue in
                                viewModel.validateIFSC(newValue)
                            }

                        Button(action: { showingIFSCFinder = true }) {
                            Text("Find IFSC")
                                .font(.custom("Inter-SemiBold", size: 12))
                                .foregroundColor(Color("PrimaryTeal"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color("PrimaryTeal").opacity(0.1))
                                .cornerRadius(6)
                        }
                    }

                    // Branch Info (after IFSC validation)
                    if let branch = viewModel.branchInfo {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("SuccessGreen"))
                            Text("Branch: \(branch.name), \(branch.city)")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("SuccessGreen"))
                        }
                    }

                    // Account Type
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Account Type")
                            .font(.custom("Inter-Medium", size: 14))
                            .foregroundColor(Color("TextSecondary"))

                        HStack(spacing: 12) {
                            ForEach(["Savings", "Current"], id: \.self) { type in
                                Button(action: { accountType = type }) {
                                    HStack {
                                        Image(systemName: accountType == type ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(accountType == type ? Color("PrimaryTeal") : Color("TextTertiary"))
                                        Text(type)
                                            .font(.custom("Inter-Medium", size: 14))
                                            .foregroundColor(accountType == type ? Color("PrimaryTeal") : Color("TextPrimary"))
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(accountType == type ? Color("PrimaryTeal").opacity(0.1) : Color.clear)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(accountType == type ? Color("PrimaryTeal") : Color("BorderLight"), lineWidth: 1)
                                    )
                                }
                            }
                        }
                    }
                }

                // Set as Default
                Toggle(isOn: $setAsDefault) {
                    Text("Set as default account")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("TextPrimary"))
                }
                .tint(Color("PrimaryTeal"))

                // Submit Button
                Button(action: { viewModel.verifyAndAddAccount() }) {
                    HStack {
                        if viewModel.isVerifying {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        Text(viewModel.isVerifying ? "Verifying..." : "Verify & Add Account")
                            .font(.custom("Inter-SemiBold", size: 16))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .foregroundColor(.white)
                    .background(isFormValid ? Color("PrimaryTeal") : Color("DisabledGray"))
                    .cornerRadius(8)
                }
                .disabled(!isFormValid || viewModel.isVerifying)

                // Security Notice
                HStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .foregroundColor(Color("SuccessGreen"))
                    Text("Your bank details are encrypted and stored securely")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))
                }
                .padding(12)
                .background(Color("SuccessGreen").opacity(0.1))
                .cornerRadius(8)
            }
            .padding(16)
        }
    }

    var isFormValid: Bool {
        !accountHolderName.isEmpty &&
        selectedBank != nil &&
        accountNumber.count >= 9 &&
        accountNumber.count <= 18 &&
        accountNumber == confirmAccountNumber &&
        ifscCode.count == 11 &&
        viewModel.branchInfo != nil
    }
}
```

### 4. Verification Progress Modal
```swift
struct BankVerificationModal: View {
    let verificationState: VerificationState

    var body: some View {
        VStack(spacing: 24) {
            switch verificationState {
            case .verifying(let steps):
                Text("Verifying Bank Account...")
                    .font(.custom("Inter-SemiBold", size: 18))
                    .foregroundColor(Color("TextPrimary"))

                // Animated Loader
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(Color("PrimaryTeal"))
                    .padding(.vertical, 16)

                VStack(alignment: .leading, spacing: 12) {
                    ForEach(steps) { step in
                        HStack(spacing: 12) {
                            if step.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("SuccessGreen"))
                            } else {
                                ProgressView()
                                    .scaleEffect(0.8)
                            }

                            Text(step.description)
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(step.isCompleted ? Color("SuccessGreen") : Color("TextSecondary"))
                        }
                    }
                }

                Text("This usually takes 30-60 seconds")
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(Color("TextTertiary"))
                    .padding(.top, 8)

                Text("Please wait...")
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(Color("TextSecondary"))

            case .success(let account):
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 64))
                    .foregroundColor(Color("SuccessGreen"))

                Text("Account Verified!")
                    .font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(Color("TextPrimary"))

                Text("Your bank account has been successfully verified and added")
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))
                    .multilineTextAlignment(.center)

                // Account Details
                VStack(spacing: 8) {
                    Text(account.bankName)
                        .font(.custom("Inter-SemiBold", size: 16))
                    Text("••••••••\(account.lastFourDigits)")
                        .font(.custom("SF Mono", size: 16))
                    Text(account.holderName)
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                }
                .padding(.vertical, 12)

            case .failed(let error):
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 64))
                    .foregroundColor(Color("ErrorRed"))

                Text("Verification Failed")
                    .font(.custom("Inter-Bold", size: 20))
                    .foregroundColor(Color("TextPrimary"))

                Text(error.localizedDescription)
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
            }
        }
        .padding(24)
        .frame(maxWidth: 320)
        .background(Color.white)
        .cornerRadius(16)
    }
}
```

## Interactions

### 1. View Saved Accounts
- **Trigger**: Screen loads
- **Action**: Display list of saved bank accounts
- **Visual**: Cards with masked account numbers, verification badges
- **Haptic**: None

### 2. Add New Account
- **Trigger**: Tap "+ Add New Bank Account" button
- **Action**: Navigate to Add Account form
- **Visual**: Slide-up transition
- **Haptic**: Light impact

### 3. Fill Account Details
- **Trigger**: Type in form fields
- **Action**:
  - Real-time IFSC validation
  - Account number matching check
  - Form validation for submit button
- **Visual**: Green checkmarks for valid fields, red errors for invalid
- **Haptic**: Notification (error) on mismatch

### 4. Find IFSC Code
- **Trigger**: Tap "Find IFSC" button
- **Action**: Open IFSC lookup modal (search by bank/branch/city)
- **Visual**: Modal overlay
- **Haptic**: Light impact

### 5. Verify & Add Account
- **Trigger**: Tap "Verify & Add Account" button
- **Action**:
  1. Show verification progress modal
  2. Initiate penny drop (₹1 deposit to verify)
  3. Display real-time verification steps
  4. Show success/failure state
- **Visual**: Animated loader → Checkmarks → Success screen
- **Haptic**: Success (on completion)
- **Duration**: 30-60 seconds typical

### 6. Set Default Account
- **Trigger**: Tap "Set Default" on an account card
- **Action**:
  - Show confirmation: "Set [Bank Name] as default withdrawal account?"
  - Update default account
  - Move to top of list
- **Visual**: Star icon appears, card border turns teal
- **Haptic**: Light impact

### 7. Edit Account
- **Trigger**: Tap "Edit" button on account card
- **Action**: Open edit form (limited to account holder name only)
- **Visual**: Modal form
- **Haptic**: Light impact

### 8. Remove Account
- **Trigger**: Tap "Remove" button
- **Action**:
  - Show confirmation: "Remove [Bank Name] account?"
  - Check for pending withdrawals
  - Delete account if no pending transactions
- **Visual**: Red destructive alert
- **Haptic**: Warning (heavy impact)
- **Error**: "Cannot remove account with pending withdrawals"

## States

### 1. Default State (Account List)
- Display saved accounts (if any)
- Show "+ Add New Account" button
- Information panel with limits and tips

### 2. Empty State (No Accounts)
```
┌─────────────────────────────────────────┐
│                                         │
│          💳 (Illustration)              │
│                                         │
│      No Bank Accounts Added             │
│                                         │
│   Add your bank account to receive      │
│   your earnings directly                │
│                                         │
│   ┌─────────────────────────────────┐  │
│   │   + Add Your First Account       │  │
│   └─────────────────────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
```

### 3. Adding Account (Form State)
- Input fields active
- Real-time validation feedback
- Submit button disabled until form valid

### 4. Verifying State
- Modal overlay with progress
- Animated steps: Name check → IFSC validation → Penny drop
- "Please wait..." message
- Cannot dismiss modal during verification

### 5. Verification Success
- Success icon and message
- Account details display
- "Make This Default" button (if not first account)
- "Done" button to close

### 6. Verification Failed
- Error icon and message
- Reason for failure (invalid IFSC, name mismatch, etc.)
- "Try Again" button
- "Contact Support" link

### 7. Max Accounts Reached (3/3)
- "+ Add New Account" button disabled
- Message: "Maximum 3 accounts allowed. Remove an account to add a new one."

### 8. Loading State
- Skeleton cards while fetching accounts
- Shimmer effect

## API Integration

### 1. Get Bank Accounts
```
GET /providers/{providerId}/bank-accounts

Headers:
- Authorization: Bearer {firebase_id_token}

Response:
{
  "success": true,
  "data": {
    "accounts": [
      {
        "id": "ba_abc123",
        "bankName": "HDFC Bank",
        "bankLogo": "https://...",
        "accountNumber": "123456785678", // Masked on client
        "lastFourDigits": "5678",
        "ifscCode": "HDFC0001234",
        "branchName": "Connaught Place",
        "branchCity": "New Delhi",
        "accountType": "savings",
        "holderName": "John Doe",
        "isVerified": true,
        "isDefault": true,
        "createdAt": "2025-01-15T10:30:00Z",
        "verifiedAt": "2025-01-15T10:32:00Z"
      }
    ],
    "maxAccounts": 3
  }
}
```

### 2. Add Bank Account
```
POST /providers/{providerId}/bank-accounts

Headers:
- Authorization: Bearer {firebase_id_token}
- Content-Type: application/json

Request:
{
  "holderName": "John Doe",
  "bankName": "HDFC Bank",
  "accountNumber": "123456785678",
  "ifscCode": "HDFC0001234",
  "accountType": "savings",
  "setAsDefault": false
}

Response:
{
  "success": true,
  "data": {
    "verificationId": "ver_xyz789",
    "status": "verifying"
  },
  "message": "Bank account verification initiated"
}
```

### 3. Verify IFSC Code
```
GET /utils/verify-ifsc/{ifscCode}

Response:
{
  "success": true,
  "data": {
    "ifsc": "HDFC0001234",
    "bank": "HDFC Bank",
    "branch": "Connaught Place",
    "city": "New Delhi",
    "state": "Delhi",
    "address": "22, Connaught Place, New Delhi - 110001",
    "isValid": true
  }
}
```

### 4. Check Verification Status
```
GET /providers/{providerId}/bank-accounts/{accountId}/verification-status

Response:
{
  "success": true,
  "data": {
    "status": "verified", // "verifying", "verified", "failed"
    "steps": [
      {
        "name": "name_verification",
        "status": "completed",
        "completedAt": "2025-01-15T10:31:00Z"
      },
      {
        "name": "ifsc_validation",
        "status": "completed",
        "completedAt": "2025-01-15T10:31:15Z"
      },
      {
        "name": "penny_drop",
        "status": "completed",
        "completedAt": "2025-01-15T10:32:00Z"
      }
    ],
    "account": { /* account details if verified */ },
    "error": null
  }
}
```

### 5. Set Default Account
```
PUT /providers/{providerId}/bank-accounts/{accountId}/set-default

Response:
{
  "success": true,
  "message": "Default account updated successfully"
}
```

### 6. Update Bank Account
```
PUT /providers/{providerId}/bank-accounts/{accountId}

Request:
{
  "holderName": "John Michael Doe" // Only allowed field
}

Response:
{
  "success": true,
  "data": {
    "account": { /* updated account */ }
  }
}
```

### 7. Delete Bank Account
```
DELETE /providers/{providerId}/bank-accounts/{accountId}

Response:
{
  "success": true,
  "message": "Bank account removed successfully"
}

// OR if pending withdrawals exist:
{
  "success": false,
  "error": {
    "code": "PENDING_WITHDRAWALS",
    "message": "Cannot remove account with pending withdrawals"
  }
}
```

## Navigation

### Entry Points
1. **From Screen 38** (Withdraw Funds):
   - Tap "Add New Bank Account" button → Navigate to Add Account form
   - Tap "Change Account" dropdown → Navigate to Account List

2. **From Screen 48** (Provider App Settings):
   - Tap "Bank Accounts" menu item → Navigate to Account List

3. **From Screen 40** (Payout History):
   - Tap "Manage Accounts" link → Navigate to Account List

### Exit Points
1. **Back Button**: Return to previous screen (Screen 38 or 48)
2. **Done** (after adding account): Return to Screen 38 (Withdraw Funds)
3. **Account Selected**: Return to Screen 38 with selected account

### Deep Links
- `urbannest://provider/bank-accounts` → Account List
- `urbannest://provider/bank-accounts/add` → Add Account Form
- `urbannest://provider/bank-accounts/{id}` → Account Details

## Accessibility

### VoiceOver Labels
- "Back to previous screen" (back button)
- "Bank account card, [Bank Name], ending in [last 4 digits], [Default] [Verified]"
- "Set as default account button"
- "Edit account details button"
- "Remove bank account button"
- "Add new bank account button"
- "Account holder name text field"
- "Select bank dropdown"
- "Account number text field, secure entry"
- "IFSC code text field"
- "Find IFSC code button"
- "Account type: Savings, selected" / "Account type: Current, not selected"
- "Set as default account toggle, [on/off]"
- "Verify and add account button, [enabled/disabled]"

### Dynamic Type
- All text scales with system font size
- Minimum touch targets: 44x44pt maintained
- Layout adjusts for larger text (stack vertically if needed)

### Color Contrast
- All text meets WCAG AA standards (4.5:1)
- Default account border: Teal #0D7377 (distinct from non-default)
- Error text: Red #EA5455 (high contrast)
- Success text: Green #28C76F (high contrast)

### Keyboard Navigation (Web)
- Tab order: Form fields → Buttons → Account cards
- Enter to submit forms
- Escape to close modals

## Analytics Events

### Track Screen View
```javascript
analytics.logEvent('screen_view', {
  screen_name: 'bank_accounts',
  screen_class: 'BankAccountsView',
  user_role: 'provider'
});
```

### Track Add Account Start
```javascript
analytics.logEvent('add_bank_account_started', {
  existing_accounts_count: 2,
  is_first_account: false
});
```

### Track Form Field Interaction
```javascript
analytics.logEvent('ifsc_lookup_used', {
  search_method: 'branch_name' // or 'ifsc_code'
});
```

### Track Verification
```javascript
analytics.logEvent('bank_verification_initiated', {
  bank_name: 'HDFC Bank',
  account_type: 'savings'
});

analytics.logEvent('bank_verification_completed', {
  bank_name: 'HDFC Bank',
  verification_time_seconds: 45,
  status: 'success' // or 'failed'
});
```

### Track Set Default
```javascript
analytics.logEvent('default_bank_account_changed', {
  from_bank: 'ICICI Bank',
  to_bank: 'HDFC Bank'
});
```

### Track Account Removal
```javascript
analytics.logEvent('bank_account_removed', {
  bank_name: 'ICICI Bank',
  was_default: false,
  remaining_accounts: 1
});
```

## Testing Checklist

### Functional Tests
- [ ] Load existing bank accounts correctly
- [ ] Display empty state when no accounts
- [ ] Add new account with valid details
- [ ] Penny drop verification completes successfully
- [ ] Set default account updates star icon
- [ ] Edit account holder name only (other fields read-only)
- [ ] Remove account with confirmation
- [ ] Prevent removal of account with pending withdrawals
- [ ] Cannot add more than 3 accounts
- [ ] IFSC code validation works correctly
- [ ] Account number confirmation matching
- [ ] Form submit disabled with invalid inputs

### UI/UX Tests
- [ ] Masked account numbers display correctly (••••5678)
- [ ] Default account card has teal border and star
- [ ] Verification modal shows progress steps
- [ ] Success animation plays on verification
- [ ] Error states display helpful messages
- [ ] Bank logos load and display correctly
- [ ] Smooth transitions between states

### Edge Cases
- [ ] Network error during verification
- [ ] Invalid IFSC code entered
- [ ] Name mismatch with bank records
- [ ] Account number already exists
- [ ] Penny drop fails (insufficient bank balance)
- [ ] Verification timeout after 2 minutes
- [ ] Maximum accounts reached (3/3)
- [ ] Delete only account (should allow)
- [ ] Delete default account (set another as default)

### Accessibility Tests
- [ ] VoiceOver announces all elements correctly
- [ ] Dynamic Type scales text properly
- [ ] Minimum 44pt touch targets maintained
- [ ] Color contrast meets WCAG AA
- [ ] Keyboard navigation works (web)
- [ ] Focus indicators visible

### Performance Tests
- [ ] Account list loads within 1 second
- [ ] IFSC validation responds within 500ms
- [ ] Verification completes within 60 seconds
- [ ] Images (bank logos) cached properly
- [ ] No memory leaks during verification

## Design Notes

### Platform-Specific Considerations

#### iOS
- Use `SecureField` for account number input (masked entry)
- Keychain storage for encrypted account details
- Native UIDatePicker style for account type selection
- System sharing for exporting account details (if needed)
- Native alert dialogs for confirmations

#### Android
- Use `PasswordTransformationMethod` for account number masking
- Android Keystore for encrypted storage
- Material Design dropdown for bank selection
- Bottom sheet for IFSC finder
- Material dialogs for confirmations

#### Web
- Input type="password" for account number (with toggle to show)
- Local storage with encryption for caching
- Responsive layout for mobile/tablet/desktop
- Autocomplete="off" for sensitive fields
- HTTPS mandatory for production

### Security Considerations
1. **Encryption**: All bank details encrypted at rest using AES-256
2. **Transmission**: HTTPS/TLS only, certificate pinning
3. **Masking**: Display only last 4 digits in list view
4. **Verification**: Mandatory penny drop before activation
5. **Audit Log**: Track all add/edit/delete operations
6. **2FA**: Consider OTP verification for sensitive operations
7. **PCI Compliance**: Never log full account numbers
8. **Rate Limiting**: Max 3 verification attempts per hour

### Bank Integration Notes
- **Penny Drop API**: Razorpay Fund Account Validation
- **IFSC Database**: Use RBI-maintained list (updated quarterly)
- **Popular Banks**: Pre-load logos for top 20 Indian banks
- **Processing Time**: Penny drop typically 10-30 seconds
- **Failure Rate**: ~2-3% due to invalid details or bank downtime
- **Retry Logic**: Auto-retry once on timeout, then manual retry

### Information Architecture
- **Max Accounts**: 3 (prevents account farming, simplifies UX)
- **Default Account**: Mandatory for at least one account
- **Verification Status**: Must be "verified" before withdrawals
- **Edit Restrictions**: Only account holder name editable (prevents fraud)
- **Deletion Rules**: Cannot delete if pending withdrawals exist

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
