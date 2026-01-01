# Screen 40: Payout History

## Overview

- **Screen ID**: 40
- **Screen Name**: Payout History
- **User Role**: Provider
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 36 (Earnings Dashboard) → Tap "View All Payouts"
  - From: Screen 38 (Withdraw Funds) → Tap "View Payout History"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ←  Payout History              🔍 ⋮    │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ₹ 45,230.50                     │    │ Total Withdrawn Card
│  │ Total Withdrawn                 │    │
│  │                                 │    │
│  │ [Jan 2025 ▼]                    │    │ Month Filter
│  └────────────────────────────────┘    │
│                                         │
│  Filters: [All ▼] [Bank ▼] [Status ▼]  │ Filter Pills
│                                         │
│  ───────── This Month ─────────         │ Section Header
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ✅ Completed                    │    │ Payout Card
│  │                                 │    │
│  │ ₹ 5,430.00                      │    │
│  │ Withdrawn to HDFC Bank          │    │
│  │ ••••5678                        │    │
│  │                                 │    │
│  │ Dec 30, 2025 • 2:34 PM          │    │
│  │ TXN ID: WD123456789             │    │
│  │                                 │    │
│  │ [Download Receipt] [View Details]│   │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ⏳ Processing                   │    │ Processing Card
│  │                                 │    │
│  │ ₹ 3,850.00                      │    │
│  │ Withdrawn to HDFC Bank          │    │
│  │ ••••5678                        │    │
│  │                                 │    │
│  │ Dec 28, 2025 • 10:15 AM         │    │
│  │ Expected: Dec 31, 2025          │    │
│  │                                 │    │
│  │ [Track Status]                  │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───────── Last Month ─────────         │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ✅ Completed                    │    │
│  │                                 │    │
│  │ ₹ 12,580.50                     │    │
│  │ Withdrawn to ICICI Bank         │    │
│  │ ••••9012                        │    │
│  │                                 │    │
│  │ Nov 30, 2025 • 4:20 PM          │    │
│  │ TXN ID: WD123456780             │    │
│  │                                 │    │
│  │ [Download Receipt] [View Details]│   │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ❌ Failed                       │    │ Failed Card
│  │                                 │    │
│  │ ₹ 2,000.00                      │    │
│  │ HDFC Bank ••••5678              │    │
│  │                                 │    │
│  │ Nov 15, 2025 • 11:30 AM         │    │
│  │ Reason: Invalid bank details    │    │
│  │                                 │    │
│  │ [Retry Withdrawal] [Contact Support]│
│  └────────────────────────────────┘    │
│                                         │
│  [Load More]                            │
│                                         │
└─────────────────────────────────────────┘

PAYOUT DETAIL MODAL:

┌─────────────────────────────────────────┐
│               Payout Details         ✕  │
├─────────────────────────────────────────┤
│                                         │
│             ✅ Completed                 │
│                                         │
│          ₹ 5,430.00                     │
│                                         │
│  Transaction Information                │
│  ┌────────────────────────────────┐    │
│  │ Transaction ID                  │    │
│  │ WD123456789         [Copy]      │    │
│  │                                 │    │
│  │ Status                          │    │
│  │ Completed ✓                     │    │
│  │                                 │    │
│  │ Initiated On                    │    │
│  │ Dec 28, 2025 at 10:15 AM        │    │
│  │                                 │    │
│  │ Completed On                    │    │
│  │ Dec 30, 2025 at 2:34 PM         │    │
│  │                                 │    │
│  │ Processing Time                 │    │
│  │ 2 business days                 │    │
│  └────────────────────────────────┘    │
│                                         │
│  Bank Account Details                   │
│  ┌────────────────────────────────┐    │
│  │ Bank Name                       │    │
│  │ HDFC Bank                       │    │
│  │                                 │    │
│  │ Account Number                  │    │
│  │ ••••••••5678                    │    │
│  │                                 │    │
│  │ Account Holder                  │    │
│  │ John Doe                        │    │
│  │                                 │    │
│  │ IFSC Code                       │    │
│  │ HDFC0001234                     │    │
│  └────────────────────────────────┘    │
│                                         │
│  Breakdown                              │
│  ┌────────────────────────────────┐    │
│  │ Withdrawal Amount    ₹ 5,430.00 │    │
│  │ Processing Fee            ₹ 0.00│    │
│  │ GST (18%)                 ₹ 0.00│    │
│  │ ─────────────────────────────── │    │
│  │ Total Credited       ₹ 5,430.00 │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Download Receipt            │   │ Primary Button
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Contact Support             │   │ Secondary Button
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘

EMPTY STATE:

┌─────────────────────────────────────────┐
│                                         │
│          💸 (Illustration)              │
│                                         │
│      No Payouts Yet                     │
│                                         │
│   You haven't made any withdrawals yet  │
│   Your earnings are waiting for you!    │
│                                         │
│   Available Balance: ₹ 3,850.00         │
│                                         │
│   ┌─────────────────────────────────┐  │
│   │      Withdraw Funds              │  │
│   └─────────────────────────────────┘  │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Total Withdrawn Summary
- Total amount withdrawn (lifetime or filtered period)
- Month/date range filter dropdown
- Quick stats: Total payouts, success rate

### 2. Filter Options
- **Type**: All, Completed, Processing, Failed
- **Bank Account**: All banks or specific bank
- **Status**: All, Successful, Pending, Failed
- **Date Range**: This month, Last month, Last 3 months, Custom

### 3. Payout Cards
- Status badge (Completed ✅ / Processing ⏳ / Failed ❌)
- Amount displayed prominently
- Bank account details (masked)
- Transaction date and time
- Transaction ID
- Contextual actions based on status

### 4. Payout Details Modal
- Full transaction information
- Timeline (initiated → processing → completed)
- Bank account details
- Breakdown (amount, fees, GST, total)
- Download receipt option
- Contact support option

### 5. Status-Specific Actions
- **Completed**: Download receipt, View details
- **Processing**: Track status
- **Failed**: Retry withdrawal, Contact support

### 6. Search & Export
- Search by transaction ID
- Export payouts to CSV/PDF
- Email receipt to registered email

## Component Breakdown

### 1. Header (Navigation Bar)
```swift
struct PayoutHistoryHeader: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showingSearch: Bool
    @Binding var showingMenu: Bool

    var body: some View {
        HStack {
            // Back Button
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }

            Text("Payout History")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(Color("TextPrimary"))

            Spacer()

            // Search Button
            Button(action: { showingSearch = true }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }

            // Menu Button
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

### 2. Total Withdrawn Card
```swift
struct TotalWithdrawnCard: View {
    let totalAmount: Double
    @Binding var selectedPeriod: TimePeriod

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("₹ \(totalAmount.formatted())")
                        .font(.custom("Inter-Bold", size: 32))
                        .foregroundColor(Color("TextPrimary"))

                    Text("Total Withdrawn")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                }

                Spacer()
            }

            // Period Selector
            Menu {
                ForEach(TimePeriod.allCases, id: \.self) { period in
                    Button(action: { selectedPeriod = period }) {
                        HStack {
                            Text(period.rawValue)
                            if selectedPeriod == period {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedPeriod.rawValue)
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("PrimaryTeal"))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(Color("PrimaryTeal"))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color("PrimaryTeal").opacity(0.1))
                .cornerRadius(6)
            }
        }
        .padding(16)
        .background(
            LinearGradient(
                colors: [Color("PrimaryTeal").opacity(0.1), Color("PrimaryTeal").opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("PrimaryTeal").opacity(0.3), lineWidth: 1)
        )
    }
}

enum TimePeriod: String, CaseIterable {
    case thisMonth = "This Month"
    case lastMonth = "Last Month"
    case last3Months = "Last 3 Months"
    case last6Months = "Last 6 Months"
    case thisYear = "This Year"
    case allTime = "All Time"
}
```

### 3. Filter Bar
```swift
struct PayoutFilterBar: View {
    @Binding var selectedStatus: PayoutStatus?
    @Binding var selectedBank: String?
    @Binding var selectedType: PayoutType?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // Status Filter
                Menu {
                    Button("All Statuses") { selectedStatus = nil }
                    ForEach(PayoutStatus.allCases, id: \.self) { status in
                        Button(status.displayName) { selectedStatus = status }
                    }
                } label: {
                    FilterPill(
                        title: selectedStatus?.displayName ?? "All",
                        icon: "line.3.horizontal.decrease.circle",
                        isActive: selectedStatus != nil
                    )
                }

                // Bank Filter
                Menu {
                    Button("All Banks") { selectedBank = nil }
                    // List of banks from saved accounts
                } label: {
                    FilterPill(
                        title: selectedBank ?? "Bank",
                        icon: "building.columns",
                        isActive: selectedBank != nil
                    )
                }

                // Type Filter
                Menu {
                    Button("All Types") { selectedType = nil }
                    ForEach(PayoutType.allCases, id: \.self) { type in
                        Button(type.rawValue) { selectedType = type }
                    }
                } label: {
                    FilterPill(
                        title: selectedType?.rawValue ?? "Type",
                        icon: "arrow.up.arrow.down",
                        isActive: selectedType != nil
                    )
                }

                // Clear Filters (if any active)
                if selectedStatus != nil || selectedBank != nil || selectedType != nil {
                    Button(action: clearFilters) {
                        HStack(spacing: 4) {
                            Image(systemName: "xmark.circle.fill")
                            Text("Clear")
                        }
                        .font(.custom("Inter-Medium", size: 12))
                        .foregroundColor(Color("ErrorRed"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color("ErrorRed").opacity(0.1))
                        .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }

    func clearFilters() {
        selectedStatus = nil
        selectedBank = nil
        selectedType = nil
    }
}

struct FilterPill: View {
    let title: String
    let icon: String
    let isActive: Bool

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12))
            Text(title)
                .font(.custom("Inter-Medium", size: 14))
        }
        .foregroundColor(isActive ? Color("PrimaryTeal") : Color("TextSecondary"))
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(isActive ? Color("PrimaryTeal").opacity(0.1) : Color("BackgroundSecondary"))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isActive ? Color("PrimaryTeal") : Color.clear, lineWidth: 1)
        )
    }
}
```

### 4. Payout Card
```swift
struct PayoutCard: View {
    let payout: Payout
    let onViewDetails: () -> Void
    let onDownloadReceipt: () -> Void
    let onRetry: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Status Badge
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: payout.status.icon)
                        .font(.system(size: 12))
                    Text(payout.status.displayName)
                        .font(.custom("Inter-SemiBold", size: 12))
                }
                .foregroundColor(payout.status.color)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(payout.status.color.opacity(0.1))
                .cornerRadius(6)

                Spacer()

                if payout.status == .processing {
                    ProgressView()
                        .scaleEffect(0.8)
                        .tint(Color("WarningYellow"))
                }
            }

            // Amount
            Text("₹ \(payout.amount.formatted())")
                .font(.custom("Inter-Bold", size: 24))
                .foregroundColor(Color("TextPrimary"))

            // Bank Details
            VStack(alignment: .leading, spacing: 4) {
                Text("Withdrawn to \(payout.bankName)")
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(Color("TextSecondary"))

                Text("••••\(payout.lastFourDigits)")
                    .font(.custom("SF Mono", size: 14))
                    .foregroundColor(Color("TextTertiary"))
            }

            Divider()
                .padding(.vertical, 4)

            // Transaction Info
            VStack(alignment: .leading, spacing: 4) {
                Text(payout.initiatedAt.formatted())
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(Color("TextTertiary"))

                if payout.status == .processing {
                    HStack(spacing: 4) {
                        Text("Expected:")
                            .font(.custom("Inter-Regular", size: 12))
                        Text(payout.expectedCompletionDate.formatted())
                            .font(.custom("Inter-Medium", size: 12))
                    }
                    .foregroundColor(Color("WarningYellow"))
                } else if payout.status == .completed {
                    HStack(spacing: 4) {
                        Text("TXN ID:")
                            .font(.custom("Inter-Regular", size: 12))
                        Text(payout.transactionId)
                            .font(.custom("SF Mono", size: 12))
                    }
                    .foregroundColor(Color("TextTertiary"))
                } else if payout.status == .failed {
                    HStack(spacing: 4) {
                        Image(systemName: "exclamationmark.circle")
                            .font(.system(size: 12))
                        Text("Reason: \(payout.failureReason ?? "Unknown error")")
                            .font(.custom("Inter-Regular", size: 12))
                    }
                    .foregroundColor(Color("ErrorRed"))
                }
            }

            // Actions
            HStack(spacing: 12) {
                switch payout.status {
                case .completed:
                    Button(action: onDownloadReceipt) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.down.doc")
                            Text("Download Receipt")
                        }
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color("PrimaryTeal"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color("PrimaryTeal").opacity(0.1))
                        .cornerRadius(8)
                    }

                    Button(action: onViewDetails) {
                        Text("View Details")
                            .font(.custom("Inter-Medium", size: 14))
                            .foregroundColor(Color("TextSecondary"))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color("BackgroundSecondary"))
                            .cornerRadius(8)
                    }

                case .processing:
                    Button(action: onViewDetails) {
                        HStack(spacing: 6) {
                            Image(systemName: "timer")
                            Text("Track Status")
                        }
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color("WarningYellow"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color("WarningYellow").opacity(0.1))
                        .cornerRadius(8)
                    }

                case .failed:
                    Button(action: onRetry) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.clockwise")
                            Text("Retry Withdrawal")
                        }
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color("PrimaryTeal"))
                        .cornerRadius(8)
                    }

                    Button(action: onViewDetails) {
                        Text("Contact Support")
                            .font(.custom("Inter-Medium", size: 14))
                            .foregroundColor(Color("ErrorRed"))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color("ErrorRed").opacity(0.1))
                            .cornerRadius(8)
                    }
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
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
    }
}

enum PayoutStatus: String, CaseIterable {
    case completed
    case processing
    case failed

    var displayName: String {
        switch self {
        case .completed: return "Completed"
        case .processing: return "Processing"
        case .failed: return "Failed"
        }
    }

    var icon: String {
        switch self {
        case .completed: return "checkmark.circle.fill"
        case .processing: return "clock.fill"
        case .failed: return "xmark.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .completed: return Color("SuccessGreen")
        case .processing: return Color("WarningYellow")
        case .failed: return Color("ErrorRed")
        }
    }
}
```

### 5. Payout Details Modal
```swift
struct PayoutDetailsModal: View {
    let payout: Payout
    @Environment(\.dismiss) var dismiss
    let onDownloadReceipt: () -> Void
    let onContactSupport: () -> Void

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Status & Amount Header
                    VStack(spacing: 12) {
                        // Status Badge
                        HStack(spacing: 6) {
                            Image(systemName: payout.status.icon)
                            Text(payout.status.displayName)
                        }
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(payout.status.color)
                        .padding(.horizontal, 14)
                        .padding(.vertical: 7)
                        .background(payout.status.color.opacity(0.15))
                        .cornerRadius(20)

                        // Amount
                        Text("₹ \(payout.amount.formatted())")
                            .font(.custom("Inter-Bold", size: 36))
                            .foregroundColor(Color("TextPrimary"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)

                    // Transaction Information
                    DetailSection(title: "Transaction Information") {
                        VStack(spacing: 16) {
                            DetailRow(
                                label: "Transaction ID",
                                value: payout.transactionId,
                                isCopyable: true
                            )

                            DetailRow(
                                label: "Status",
                                value: payout.status.displayName,
                                valueColor: payout.status.color,
                                icon: payout.status.icon
                            )

                            DetailRow(
                                label: "Initiated On",
                                value: payout.initiatedAt.formatted(date: .long, time: .shortened)
                            )

                            if payout.status == .completed, let completedAt = payout.completedAt {
                                DetailRow(
                                    label: "Completed On",
                                    value: completedAt.formatted(date: .long, time: .shortened)
                                )

                                DetailRow(
                                    label: "Processing Time",
                                    value: "\(payout.processingDays) business days"
                                )
                            } else if payout.status == .processing {
                                DetailRow(
                                    label: "Expected Completion",
                                    value: payout.expectedCompletionDate.formatted(date: .long, time: .omitted),
                                    valueColor: Color("WarningYellow")
                                )
                            } else if payout.status == .failed, let failedAt = payout.failedAt {
                                DetailRow(
                                    label: "Failed On",
                                    value: failedAt.formatted(date: .long, time: .shortened),
                                    valueColor: Color("ErrorRed")
                                )

                                DetailRow(
                                    label: "Failure Reason",
                                    value: payout.failureReason ?? "Unknown error",
                                    valueColor: Color("ErrorRed")
                                )
                            }
                        }
                    }

                    // Bank Account Details
                    DetailSection(title: "Bank Account Details") {
                        VStack(spacing: 16) {
                            DetailRow(label: "Bank Name", value: payout.bankName)
                            DetailRow(label: "Account Number", value: "••••••••\(payout.lastFourDigits)")
                            DetailRow(label: "Account Holder", value: payout.accountHolderName)
                            DetailRow(label: "IFSC Code", value: payout.ifscCode)
                        }
                    }

                    // Breakdown
                    DetailSection(title: "Breakdown") {
                        VStack(spacing: 12) {
                            BreakdownRow(label: "Withdrawal Amount", value: payout.amount)
                            BreakdownRow(label: "Processing Fee", value: payout.processingFee)
                            BreakdownRow(label: "GST (18%)", value: payout.gst)

                            Divider()
                                .padding(.vertical, 4)

                            HStack {
                                Text("Total Credited")
                                    .font(.custom("Inter-SemiBold", size: 16))
                                    .foregroundColor(Color("TextPrimary"))
                                Spacer()
                                Text("₹ \(payout.totalCredited.formatted())")
                                    .font(.custom("Inter-Bold", size: 18))
                                    .foregroundColor(Color("SuccessGreen"))
                            }
                        }
                    }

                    // Action Buttons
                    VStack(spacing: 12) {
                        Button(action: onDownloadReceipt) {
                            HStack {
                                Image(systemName: "arrow.down.doc")
                                Text("Download Receipt")
                            }
                            .font(.custom("Inter-SemiBold", size: 16))
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .foregroundColor(.white)
                            .background(Color("PrimaryTeal"))
                            .cornerRadius(8)
                        }

                        Button(action: onContactSupport) {
                            Text("Contact Support")
                                .font(.custom("Inter-Medium", size: 16))
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .foregroundColor(Color("PrimaryTeal"))
                                .background(Color("PrimaryTeal").opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.top, 8)
                }
                .padding(16)
            }
            .navigationTitle("Payout Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("TextSecondary"))
                    }
                }
            }
        }
    }
}

struct DetailSection<Content: View>: View {
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

            VStack(spacing: 0) {
                content
            }
            .padding(16)
            .background(Color("BackgroundSecondary"))
            .cornerRadius(12)
        }
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    var valueColor: Color = Color("TextPrimary")
    var icon: String? = nil
    var isCopyable: Bool = false

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextSecondary"))
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 6) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 12))
                        .foregroundColor(valueColor)
                }

                Text(value)
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(valueColor)
                    .multilineTextAlignment(.trailing)

                if isCopyable {
                    Button(action: {
                        UIPasteboard.general.string = value
                    }) {
                        Image(systemName: "doc.on.doc")
                            .font(.system(size: 12))
                            .foregroundColor(Color("PrimaryTeal"))
                    }
                }
            }
        }
    }
}

struct BreakdownRow: View {
    let label: String
    let value: Double

    var body: some View {
        HStack {
            Text(label)
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextSecondary"))
            Spacer()
            Text("₹ \(value.formatted())")
                .font(.custom("Inter-Medium", size: 14))
                .foregroundColor(Color("TextPrimary"))
        }
    }
}
```

## Interactions

### 1. Load Payout History
- **Trigger**: Screen loads
- **Action**: Fetch payout history from API
- **Visual**: Skeleton loading cards
- **Haptic**: None

### 2. Filter by Period
- **Trigger**: Tap month/period dropdown
- **Action**: Show period selector menu
- **Visual**: Menu with checkmark on selected period
- **Haptic**: Light impact
- **Result**: Refresh list with filtered data

### 3. Apply Filters
- **Trigger**: Tap filter pills (Status, Bank, Type)
- **Action**: Show filter options menu
- **Visual**: Active filters highlighted in teal
- **Haptic**: Light impact
- **Result**: Filter payout list

### 4. Clear Filters
- **Trigger**: Tap "Clear" button (appears when filters active)
- **Action**: Reset all filters to default
- **Visual**: Pills return to inactive state
- **Haptic**: Light impact

### 5. View Payout Details
- **Trigger**: Tap "View Details" on payout card
- **Action**: Open payout details modal
- **Visual**: Modal slides up from bottom
- **Haptic**: Medium impact
- **Content**: Full transaction info, timeline, breakdown

### 6. Download Receipt
- **Trigger**: Tap "Download Receipt" button
- **Action**:
  1. Generate PDF receipt
  2. Save to device
  3. Show share sheet
- **Visual**: Loading indicator → Success checkmark
- **Haptic**: Success
- **Format**: PDF with UrbanNest branding

### 7. Copy Transaction ID
- **Trigger**: Tap "Copy" button next to transaction ID
- **Action**: Copy ID to clipboard
- **Visual**: Brief "Copied!" toast
- **Haptic**: Light impact

### 8. Track Status (Processing Payouts)
- **Trigger**: Tap "Track Status" on processing payout
- **Action**: Open details modal showing timeline
- **Visual**: Progress timeline with estimated completion
- **Haptic**: Light impact

### 9. Retry Failed Withdrawal
- **Trigger**: Tap "Retry Withdrawal" on failed payout
- **Action**:
  - Navigate to Screen 38 (Withdraw Funds)
  - Pre-fill amount from failed transaction
  - Show "Retrying previous withdrawal" banner
- **Visual**: Smooth navigation
- **Haptic**: Light impact

### 10. Contact Support
- **Trigger**: Tap "Contact Support" button
- **Action**:
  - Open support chat/ticket with payout details pre-filled
  - Include transaction ID, amount, date automatically
- **Visual**: Navigate to support screen
- **Haptic**: Light impact

### 11. Search Transaction
- **Trigger**: Tap search icon in header
- **Action**: Show search bar
- **Visual**: Search bar slides down
- **Haptic**: Light impact
- **Search**: By transaction ID, amount, bank name, date

### 12. Export History
- **Trigger**: Tap menu (⋮) → "Export History"
- **Action**:
  - Show format options (CSV, PDF)
  - Generate file with filtered payouts
  - Share/download
- **Visual**: Sheet with export options
- **Haptic**: Light impact

### 13. Pull to Refresh
- **Trigger**: Pull down on payout list
- **Action**: Refresh payout history
- **Visual**: Standard iOS refresh control
- **Haptic**: None

### 14. Load More
- **Trigger**: Scroll to bottom, tap "Load More"
- **Action**: Fetch next page of payouts (pagination)
- **Visual**: Loading indicator
- **Haptic**: None

## States

### 1. Default State (With Payouts)
- Total withdrawn card at top
- Filter bar below
- Grouped payout cards (by month/week)
- Load more button at bottom

### 2. Empty State (No Payouts)
```
Empty illustration
"No Payouts Yet"
Explanation text
Available balance display
"Withdraw Funds" CTA → Screen 38
```

### 3. Loading State
- Skeleton cards (shimmer effect)
- Total amount placeholder
- 5-6 skeleton payout cards

### 4. Filtered State (No Results)
```
"No payouts found"
"Try adjusting your filters"
[Clear Filters] button
```

### 5. Processing Payout State
- Yellow "Processing" badge
- Timer icon
- "Expected: [date]" display
- "Track Status" CTA

### 6. Failed Payout State
- Red "Failed" badge
- Error icon
- Failure reason display
- "Retry Withdrawal" + "Contact Support" CTAs

### 7. Search Active State
- Search bar visible at top
- Results filtered as user types
- "No results for '[query]'" if empty

### 8. Detail Modal Open
- Full-screen modal overlay
- Scrollable content
- Close (X) button in header
- Actions at bottom

## API Integration

### 1. Get Payout History
```
GET /providers/{providerId}/payouts

Query Parameters:
- period: "this_month" | "last_month" | "last_3_months" | "custom"
- status: "completed" | "processing" | "failed" | null
- bank_account_id: string | null
- page: number (default: 1)
- limit: number (default: 20)
- search: string | null

Headers:
- Authorization: Bearer {firebase_id_token}

Response:
{
  "success": true,
  "data": {
    "totalWithdrawn": 45230.50,
    "totalPayouts": 28,
    "successRate": 96.4,
    "payouts": [
      {
        "id": "payout_abc123",
        "amount": 5430.00,
        "processingFee": 0.00,
        "gst": 0.00,
        "totalCredited": 5430.00,
        "status": "completed", // "processing", "failed"
        "bankAccountId": "ba_xyz789",
        "bankName": "HDFC Bank",
        "lastFourDigits": "5678",
        "accountHolderName": "John Doe",
        "ifscCode": "HDFC0001234",
        "transactionId": "WD123456789",
        "initiatedAt": "2025-12-28T10:15:00Z",
        "completedAt": "2025-12-30T14:34:00Z",
        "expectedCompletionDate": null,
        "failedAt": null,
        "failureReason": null,
        "processingDays": 2
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 2,
      "totalRecords": 28,
      "hasMore": true
    }
  }
}
```

### 2. Get Payout Details
```
GET /providers/{providerId}/payouts/{payoutId}

Response:
{
  "success": true,
  "data": {
    "payout": { /* full payout object */ },
    "timeline": [
      {
        "status": "initiated",
        "timestamp": "2025-12-28T10:15:00Z",
        "description": "Withdrawal request initiated"
      },
      {
        "status": "processing",
        "timestamp": "2025-12-28T10:16:30Z",
        "description": "Transfer to bank in progress"
      },
      {
        "status": "completed",
        "timestamp": "2025-12-30T14:34:00Z",
        "description": "Amount credited to your account"
      }
    ]
  }
}
```

### 3. Download Receipt
```
GET /providers/{providerId}/payouts/{payoutId}/receipt

Query Parameters:
- format: "pdf" | "email"

Response (PDF):
- Content-Type: application/pdf
- Binary PDF data

Response (Email):
{
  "success": true,
  "message": "Receipt sent to your registered email"
}
```

### 4. Retry Failed Withdrawal
```
POST /providers/{providerId}/payouts/{payoutId}/retry

Response:
{
  "success": true,
  "data": {
    "newPayoutId": "payout_def456",
    "status": "processing"
  },
  "message": "Withdrawal retry initiated successfully"
}
```

### 5. Export Payout History
```
GET /providers/{providerId}/payouts/export

Query Parameters:
- format: "csv" | "pdf"
- period: same as list endpoint
- status: same as list endpoint

Response:
- Content-Type: text/csv or application/pdf
- Binary file data
```

## Navigation

### Entry Points
1. **From Screen 36** (Earnings Dashboard):
   - Tap "View All Payouts" → Navigate to Payout History

2. **From Screen 38** (Withdraw Funds):
   - Tap "View Payout History" link → Navigate to Payout History

3. **From Screen 48** (Provider App Settings):
   - Tap "Payout History" menu item → Navigate to Payout History

4. **Deep Link**:
   - `urbannest://provider/payouts` → Payout History
   - `urbannest://provider/payouts/{id}` → Specific payout details modal

### Exit Points
1. **Back Button**: Return to previous screen (36 or 38)
2. **Withdraw Funds CTA** (empty state): Navigate to Screen 38
3. **Retry Withdrawal**: Navigate to Screen 38 with pre-filled amount
4. **Contact Support**: Navigate to Support Chat screen
5. **Close Modal**: Dismiss payout details modal

## Accessibility

### VoiceOver Labels
- "Back to previous screen" (back button)
- "Search payouts" (search icon)
- "More options menu" (ellipsis menu)
- "Total withdrawn: ₹45,230.50"
- "Filter by month: This Month, double-tap to change"
- "Filter by status, currently showing All"
- "Payout card, Completed, ₹5,430 to HDFC Bank ending in 5678, December 30 at 2:34 PM"
- "Processing payout, ₹3,850, expected December 31"
- "Failed payout, ₹2,000, tap to retry or contact support"
- "Download receipt button"
- "View details button"
- "Track status button"
- "Retry withdrawal button"
- "Transaction ID WD123456789, double-tap to copy"

### Dynamic Type
- All text scales with system font size
- Minimum touch targets: 44x44pt
- Layout reflows for larger text sizes

### Color Contrast
- Status badges: High contrast backgrounds
- Completed: Green #28C76F on light green background
- Processing: Yellow #FFC107 on light yellow background
- Failed: Red #EA5455 on light red background

### Keyboard Navigation (Web)
- Tab through filters, cards, buttons
- Enter to open details modal
- Arrow keys to navigate between cards

## Analytics Events

### Track Screen View
```javascript
analytics.logEvent('screen_view', {
  screen_name: 'payout_history',
  screen_class: 'PayoutHistoryView',
  user_role: 'provider'
});
```

### Track Filter Usage
```javascript
analytics.logEvent('payout_filter_applied', {
  filter_type: 'status', // 'bank', 'period', 'type'
  filter_value: 'completed',
  results_count: 15
});
```

### Track Payout Detail View
```javascript
analytics.logEvent('payout_details_viewed', {
  payout_id: 'payout_abc123',
  payout_status: 'completed',
  payout_amount: 5430.00
});
```

### Track Receipt Download
```javascript
analytics.logEvent('payout_receipt_downloaded', {
  payout_id: 'payout_abc123',
  format: 'pdf' // or 'email'
});
```

### Track Retry
```javascript
analytics.logEvent('payout_retry_initiated', {
  original_payout_id: 'payout_failed123',
  failure_reason: 'invalid_bank_details',
  amount: 2000.00
});
```

### Track Export
```javascript
analytics.logEvent('payout_history_exported', {
  format: 'csv', // or 'pdf'
  period: 'last_3_months',
  record_count: 45
});
```

## Testing Checklist

### Functional Tests
- [ ] Load payout history correctly
- [ ] Display correct total withdrawn amount
- [ ] Filter by period (This month, Last month, etc.)
- [ ] Filter by status (Completed, Processing, Failed)
- [ ] Filter by bank account
- [ ] Clear all filters
- [ ] Search by transaction ID
- [ ] Open payout details modal
- [ ] Copy transaction ID to clipboard
- [ ] Download receipt (PDF)
- [ ] Email receipt
- [ ] Track processing payout status
- [ ] Retry failed withdrawal
- [ ] Contact support with pre-filled details
- [ ] Export to CSV
- [ ] Export to PDF
- [ ] Load more (pagination)
- [ ] Pull to refresh

### UI/UX Tests
- [ ] Empty state displays correctly
- [ ] Loading skeleton cards show during fetch
- [ ] Status badges colored correctly (green/yellow/red)
- [ ] Masked account numbers (••••5678)
- [ ] Date formatting is readable
- [ ] Smooth modal animations
- [ ] Filter pills highlight when active
- [ ] Timeline shows correct processing steps

### Edge Cases
- [ ] No payouts exist (empty state)
- [ ] Only 1 payout exists
- [ ] 100+ payouts (pagination)
- [ ] Filters return no results
- [ ] Search returns no results
- [ ] Network error during load
- [ ] Network error during download
- [ ] Receipt generation fails
- [ ] Transaction ID copy on old iOS (< 14)
- [ ] Very long bank names (truncate)
- [ ] Multiple failed payouts in a row
- [ ] Processing payout exceeds expected date
- [ ] Payout amount is ₹0 (edge case in refund)

### Accessibility Tests
- [ ] VoiceOver announces all elements
- [ ] Dynamic Type scales correctly
- [ ] Color contrast meets WCAG AA
- [ ] Touch targets minimum 44pt
- [ ] Keyboard navigation works (web)

### Performance Tests
- [ ] List scrolls smoothly with 50+ items
- [ ] PDF generation completes in < 3 seconds
- [ ] CSV export handles 500+ records
- [ ] Images (if any) load quickly
- [ ] No memory leaks on modal open/close

## Design Notes

### Platform-Specific Considerations

#### iOS
- Native share sheet for PDF receipts
- SF Symbols for icons
- Native date/time formatting
- Haptic feedback on interactions
- Native alert dialogs for confirmations
- Swipe actions on cards (future: swipe to download receipt)

#### Android
- Material Design bottom sheet for details modal
- Material icons
- Native share intent
- Material dialogs
- Snackbar for "Copied!" toast

#### Web
- Responsive breakpoints: Mobile (< 768px), Tablet (768-1024px), Desktop (> 1024px)
- Table view on desktop (instead of cards)
- Hover states on interactive elements
- Download attribute for receipt files

### Financial Data Display
- Always show 2 decimal places for amounts
- Use Indian number formatting (₹ 1,23,456.78)
- Processing fees: Currently ₹0 (may change in future)
- GST: 18% on processing fees (if applicable)
- Total credited = Amount - Fee - GST

### Receipt Format (PDF)
- UrbanNest logo and branding
- Transaction ID (barcode/QR code)
- Provider details (name, ID)
- Payout details (amount, bank, date)
- Breakdown (amount, fees, GST, total)
- Bank details (masked account number)
- Timeline (initiated → completed)
- Footer: "This is a computer-generated receipt"

### Export Formats

**CSV Structure**:
```
Date,Transaction ID,Bank,Account Number,Amount,Fee,GST,Total,Status
"Dec 30, 2025 2:34 PM",WD123456789,HDFC Bank,••••5678,5430.00,0.00,0.00,5430.00,Completed
```

**PDF Structure**:
- Header: UrbanNest branding + date range
- Table: Date | TXN ID | Bank | Amount | Status
- Footer: Total withdrawn, processing fees, page numbers

### Processing Timeline
- **Initiation**: Immediate (on button tap)
- **Bank Transfer**: 4-24 hours (depending on bank)
- **Completion**: 1-2 business days typically
- **Weekends**: May take 3-4 days
- **Expected Date**: Calculated as initiation date + 2 business days

### Error Handling
- **Network Error**: "Failed to load payout history. Tap to retry."
- **Invalid Filter**: Silently fall back to "All"
- **PDF Generation Error**: "Failed to generate receipt. Please try again."
- **Retry Failed**: "Cannot retry this withdrawal. Please create a new one."

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
