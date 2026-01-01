# Transaction History

## Overview
- **Screen ID**: 37
- **Screen Name**: Transaction History
- **User Role**: Service Provider
- **Platform**: iOS, Android
- **Navigation**: From Earnings Dashboard (Screen 36) → Tap "View All Transactions"

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ←  Transaction History      🔍 📊 ⋮     │
├──────────────────────────────────────────┤
│                                          │
│  🗓️ January 2025                  ▼     │  ← Month selector
│                                          │
│  Filters: All Types                      │
│  ┌─────┬────────┬────────┬──────────┐  │
│  │ All │Earnings│Withdraw│ Refunds  │  │  ← Type tabs
│  └─────┴────────┴────────┴──────────┘  │
│                                          │
│  Total: ₹12,450.00 (34 transactions)    │
│                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                          │
│  Today • 15 Jan                          │
│  ┌────────────────────────────────────┐ │
│  │ ✓ AC Repair               +₹722.50│ │
│  │   #BK789012 • 4:45 PM              │ │
│  │   [View Details]                   │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Yesterday • 14 Jan                      │
│  ┌────────────────────────────────────┐ │
│  │ ✓ Plumbing Service        +₹450.00│ │
│  │   #BK789011 • 2:30 PM              │ │
│  └────────────────────────────────────┘ │
│  ┌────────────────────────────────────┐ │
│  │ ✓ Electrical Work         +₹380.00│ │
│  │   #BK789010 • 11:20 AM             │ │
│  └────────────────────────────────────┘ │
│                                          │
│  13 Jan                                  │
│  ┌────────────────────────────────────┐ │
│  │ ↓ Withdrawal to Bank     -₹5,000  │ │
│  │   TXN123456 • Processing...        │ │
│  │   Expected: 15 Jan                 │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ ✓ Cleaning Service        +₹600.00│ │
│  │   #BK789009 • 3:15 PM              │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ⟳ Load More                             │
│                                          │
└──────────────────────────────────────────┘
```

## Key Features

### Month/Date Selector
- Current month displayed
- Dropdown to select different months
- Quick navigation (Previous/Next month arrows)
- Custom date range picker option
- Shows transaction count for each month

### Transaction Type Filters

**Filter Options:**
- **All**: Show all transaction types
- **Earnings**: Completed job payments only
- **Withdrawals**: Payouts to bank account
- **Refunds**: Cancelled bookings
- **Bonuses**: Platform incentives
- **Penalties**: Deductions/fees

**Active Filter:**
- Highlighted tab/chip
- Transaction count per type
- Smooth filter transitions

### Transaction Grouping

**Date-based Sections:**
- Today, Yesterday labels
- Date headers (13 Jan, 12 Jan, etc.)
- Chronological order (newest first)
- Section totals (optional)

### Transaction Card Details

**Information Displayed:**
- Transaction type icon and color
- Service name / description
- Job/Transaction ID
- Date and time
- Amount with +/- indicator
- Status (Completed, Processing, Failed)
- Quick action button (View Details)

**Visual Indicators:**
- Green (+) for earnings
- Blue (-) for withdrawals
- Red (↓) for refunds
- Gold (★) for bonuses
- Orange (!) for penalties

### Search Functionality

**Search By:**
- Job ID/Booking ID
- Service name
- Amount
- Date range
- Customer name (earnings only)
- Transaction ID (withdrawals)

**Search Features:**
- Real-time filtering
- Highlight matching text
- Clear search button
- Recent searches saved

### Export Options

**Export Formats:**
- PDF statement
- Excel/CSV file
- Email receipt
- Share to accounting apps

**Export Scope:**
- Selected month
- Custom date range
- Specific transaction types
- All transactions

### Statistics Summary

**Top Bar Stats:**
- Total for period
- Transaction count
- Average per transaction
- Net change from previous period

## Component Breakdown

### Month Selector

```swift
struct MonthSelector: View {
    @Binding var selectedMonth: Date
    @State private var showMonthPicker = false

    var body: some View {
        HStack {
            Button(action: previousMonth) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16))
                    .foregroundColor(.gray600)
            }

            Button(action: { showMonthPicker = true }) {
                HStack(spacing: 6) {
                    Text(monthYearString)
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(.gray900)

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.gray500)
                }
            }

            Button(action: nextMonth) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 16))
                    .foregroundColor(.gray600)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $showMonthPicker) {
            MonthPickerSheet(selectedMonth: $selectedMonth)
        }
    }

    var monthYearString: String {
        selectedMonth.formatted(.dateTime.month(.wide).year())
    }

    func previousMonth() {
        selectedMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedMonth) ?? selectedMonth
    }

    func nextMonth() {
        selectedMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) ?? selectedMonth
    }
}
```

### Type Filter Tabs

```swift
struct TransactionTypeFilters: View {
    @Binding var selectedType: TransactionFilterType
    let counts: [TransactionFilterType: Int]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(TransactionFilterType.allCases, id: \.self) { type in
                    FilterChip(
                        title: type.displayName,
                        count: counts[type] ?? 0,
                        isSelected: selectedType == type,
                        onTap: { selectedType = type }
                    )
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct FilterChip: View {
    let title: String
    let count: Int
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Text(title)
                    .font(.system(size: 14, weight: isSelected ? .semibold : .regular))

                if count > 0 {
                    Text("(\(count))")
                        .font(.system(size: 12))
                }
            }
            .foregroundColor(isSelected ? .white : .gray700)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color.brandPrimary : Color.gray100)
            .cornerRadius(20)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

enum TransactionFilterType: CaseIterable {
    case all, earnings, withdrawals, refunds, bonuses, penalties

    var displayName: String {
        switch self {
        case .all: return "All"
        case .earnings: return "Earnings"
        case .withdrawals: return "Withdrawals"
        case .refunds: return "Refunds"
        case .bonuses: return "Bonuses"
        case .penalties: return "Penalties"
        }
    }
}
```

### Period Summary Bar

```swift
struct PeriodSummaryBar: View {
    let total: Double
    let count: Int
    let selectedType: TransactionFilterType

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(selectedType == .all ? "Total" : selectedType.displayName)
                    .font(.system(size: 12))
                    .foregroundColor(.gray600)

                Text("₹\(abs(total), specifier: "%.2f")")
                    .font(.custom("Inter-SemiBold", size: 20))
                    .foregroundColor(total >= 0 ? .success : .error)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("Transactions")
                    .font(.system(size: 12))
                    .foregroundColor(.gray600)

                Text("\(count)")
                    .font(.custom("Inter-SemiBold", size: 20))
                    .foregroundColor(.gray900)
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}
```

### Transaction List with Sections

```swift
struct GroupedTransactionList: View {
    let transactions: [Transaction]

    var groupedTransactions: [(String, [Transaction])] {
        Dictionary(grouping: transactions) { transaction in
            if Calendar.current.isDateInToday(transaction.date) {
                return "Today"
            } else if Calendar.current.isDateInYesterday(transaction.date) {
                return "Yesterday"
            } else {
                return transaction.date.formatted(date: .abbreviated, time: .omitted)
            }
        }
        .sorted { $0.key > $1.key }
        .map { ($0.key, $0.value.sorted { $0.date > $1.date }) }
    }

    var body: some View {
        LazyVStack(spacing: 16, pinnedViews: [.sectionHeaders]) {
            ForEach(groupedTransactions, id: \.0) { section in
                Section {
                    ForEach(section.1) { transaction in
                        TransactionCard(transaction: transaction)
                    }
                } header: {
                    SectionHeader(title: section.0)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.custom("Inter-SemiBold", size: 14))
            .foregroundColor(.gray600)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemBackground))
    }
}
```

### Transaction Card

```swift
struct TransactionCard: View {
    let transaction: Transaction
    @State private var showDetails = false

    var body: some View {
        Button(action: { showDetails = true }) {
            HStack(spacing: 12) {
                // Icon
                Image(systemName: transaction.type.icon)
                    .font(.system(size: 18))
                    .foregroundColor(transaction.type.color)
                    .frame(width: 40, height: 40)
                    .background(transaction.type.color.opacity(0.1))
                    .clipShape(Circle())

                // Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.description)
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(.gray900)
                        .lineLimit(1)

                    HStack(spacing: 8) {
                        Text(transaction.referenceId)
                            .font(.system(size: 12))
                            .foregroundColor(.gray500)

                        Text("•")
                            .foregroundColor(.gray400)

                        Text(transaction.date.formatted(date: .omitted, time: .shortened))
                            .font(.system(size: 12))
                            .foregroundColor(.gray500)
                    }

                    if transaction.status != .completed {
                        HStack(spacing: 4) {
                            Circle()
                                .fill(transaction.status == .processing ? Color.warning : Color.error)
                                .frame(width: 6, height: 6)

                            Text(transaction.status.displayName)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(transaction.status == .processing ? .warning : .error)
                        }
                    }
                }

                Spacer()

                // Amount
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(transaction.amount >= 0 ? "+" : "")₹\(abs(transaction.amount), specifier: "%.2f")")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(transaction.amount >= 0 ? .success : .error)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(.gray400)
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.03), radius: 2, y: 1)
        }
        .buttonStyle(ScaleButtonStyle())
        .sheet(isPresented: $showDetails) {
            TransactionDetailSheet(transaction: transaction)
        }
    }
}
```

## Interactions

### Filter by Type
```swift
func filterTransactions(by type: TransactionFilterType) {
    withAnimation {
        selectedType = type
    }

    Task {
        await viewModel.fetchTransactions(
            month: selectedMonth,
            type: type == .all ? nil : type
        )
    }

    analytics.track("transactions_filtered", ["type": type.rawValue])
}
```

### Search Transactions
```swift
func searchTransactions(_ query: String) {
    guard !query.isEmpty else {
        // Reset to full list
        viewModel.resetFilter()
        return
    }

    let filtered = allTransactions.filter { transaction in
        transaction.description.localizedCaseInsensitiveContains(query) ||
        transaction.referenceId.localizedCaseInsensitiveContains(query) ||
        String(format: "%.2f", transaction.amount).contains(query)
    }

    viewModel.filteredTransactions = filtered

    analytics.track("transactions_searched", ["query_length": query.count])
}
```

### Export Transactions
```swift
func exportTransactions(format: ExportFormat) {
    isExporting = true

    Task {
        do {
            let fileURL = await viewModel.exportTransactions(
                month: selectedMonth,
                format: format
            )

            isExporting = false

            // Present share sheet
            presentShareSheet(url: fileURL)

            analytics.track("transactions_exported", [
                "format": format.rawValue,
                "count": filteredTransactions.count
            ])
        } catch {
            isExporting = false
            AlertManager.showError("Failed to export transactions")
        }
    }
}

enum ExportFormat {
    case pdf, excel, csv
}
```

## States

### Default State
- Transactions loaded for current month
- All types filter selected
- Grouped by date sections
- Scroll position at top

### Loading State
- Skeleton shimmer for transaction cards
- Loading indicator in list
- Pull to refresh support

### Empty State
- No transactions for selected period
- Helpful message
- Suggestion to adjust filters
- Clear filter button if filtered

### Search Active State
- Search bar expanded
- Results filtered in real-time
- Result count shown
- Clear search button visible

### Export Loading State
- Export button shows spinner
- "Generating..." text
- Disable interactions

## API Integration

### Fetch Transactions
```typescript
GET /providers/{providerId}/transactions
Query Parameters:
  - month: "2025-01"
  - type: "earnings" | "withdrawals" | "refunds" | "bonuses" | "penalties"
  - limit: 50
  - offset: 0

Response:
{
  "success": true,
  "data": {
    "transactions": [
      {
        "id": "TXN123456",
        "type": "earning",
        "description": "AC Repair & Service",
        "referenceId": "BK789012",
        "amount": 722.50,
        "date": "2025-01-15T16:45:00Z",
        "status": "completed",
        "metadata": {
          "customerId": "CUST123",
          "customerName": "Amit Kumar"
        }
      }
    ],
    "summary": {
      "total": 12450.00,
      "count": 34,
      "byType": {
        "earnings": { "count": 28, "total": 15200.00 },
        "withdrawals": { "count": 3, "total": -5000.00 },
        "refunds": { "count": 2, "total": -800.00 },
        "bonuses": { "count": 1, "total": 500.00 }
      }
    },
    "hasMore": true
  }
}
```

### Export Transactions
```typescript
POST /providers/{providerId}/transactions/export
Body:
{
  "month": "2025-01",
  "format": "pdf" | "excel" | "csv",
  "type": "all" | "earnings" | etc.
}

Response:
{
  "success": true,
  "downloadUrl": "https://storage.../statement_jan2025.pdf",
  "expiresAt": "2025-01-16T00:00:00Z"
}
```

## Navigation

### Entry Points
- Screen 36 (Earnings Dashboard) → "View All"
- Provider Dashboard → "Transactions"
- From notification → Deep link to specific transaction

### Exit Points
- Tap transaction → Transaction detail modal
- Tap "Export" → Share sheet
- Back button → Return to previous screen

## Accessibility

### VoiceOver
- Section headers: "Today, Section header, 3 transactions"
- Transaction: "AC Repair, earned 722 rupees, 15 January 4:45 PM, View details"
- Filter: "Earnings filter, 28 transactions, Not selected, Button"

### Touch Targets
- Filter chips: 44pt height minimum
- Transaction cards: 72pt minimum height
- Export/search buttons: 44x44pt

## Analytics

```typescript
analytics.track('transaction_history_viewed', {
  month: '2025-01',
  filter_type: 'all',
  transaction_count: 34
})

analytics.track('transaction_detail_viewed', {
  transaction_id: 'TXN123456',
  type: 'earning',
  amount: 722.50
})

analytics.track('transactions_filtered', {
  from_type: 'all',
  to_type: 'earnings',
  result_count: 28
})
```

## Testing Checklist

- [ ] Transactions load correctly
- [ ] Date grouping works
- [ ] Filters apply correctly
- [ ] Search functionality works
- [ ] Month navigation works
- [ ] Export generates files
- [ ] Pull to refresh works
- [ ] Pagination/load more works
- [ ] Empty state shows
- [ ] Loading states smooth
- [ ] Transaction details open
- [ ] Amount formatting correct

## Design Notes

- Clear date-based organization
- Easy filtering and search
- Quick access to details
- Export for accounting
- Smooth scrolling performance
- Infinite scroll with pagination
