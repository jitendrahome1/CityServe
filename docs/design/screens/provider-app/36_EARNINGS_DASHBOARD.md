# Earnings Dashboard

## Overview
- **Screen ID**: 36
- **Screen Name**: Earnings Dashboard
- **User Role**: Service Provider
- **Platform**: iOS, Android
- **Navigation**: From Provider Dashboard → Tap "Earnings" or from bottom tab "Wallet"

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  Earnings                         🔔 ⓘ   │
├──────────────────────────────────────────┤
│                                          │
│  💰 Total Earnings                       │
│                                          │
│      ₹45,230.50                          │  ← Large total
│      ↑ ₹2,340 this week (+5.4%)          │
│                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                          │
│  💳 Available Balance                    │
│  ┌────────────────────────────────────┐ │
│  │  ₹3,850.00                         │ │  ← Withdrawable
│  │                                    │ │
│  │  [Withdraw Funds]                  │ │
│  │                                    │ │
│  │  Next payout: 17 Jan 2025          │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📊 Earnings Breakdown                   │
│  ┌─────────────┬─────────────┬────────┐│
│  │ Today       │ This Week   │ Month  ││  ← Time filters
│  │ ₹722        │ ₹2,340      │₹12,450 ││
│  └─────────────┴─────────────┴────────┘│
│                                          │
│  📈 This Month's Trend                   │
│  ┌────────────────────────────────────┐ │
│  │      [Earnings Chart]              │ │  ← Line chart
│  │  ₹                                 │ │
│  │  15k│     ╱‾╲                     │ │
│  │  10k│   ╱    ╲    ╱‾              │ │
│  │   5k│ ╱        ╲╱                 │ │
│  │     └──────────────────────────   │ │
│  │      Week1 Week2 Week3 Week4      │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📝 Recent Transactions                  │
│  ┌────────────────────────────────────┐ │
│  │ ✓ AC Repair               +₹722.50│ │
│  │   15 Jan, 4:45 PM                  │ │
│  │                                    │ │
│  │ ✓ Plumbing Service        +₹450.00│ │
│  │   14 Jan, 2:30 PM                  │ │
│  │                                    │ │
│  │ ↓ Withdrawal              -₹5,000 │ │
│  │   13 Jan, Processing...            │ │
│  │                                    │ │
│  │ ✓ Electrical Work         +₹380.00│ │
│  │   12 Jan, 10:15 AM                 │ │
│  │                                    │ │
│  │  [View All Transactions]           │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Quick Stats                             │
│  ┌──────────┐ ┌──────────┐ ┌─────────┐│
│  │ Pending  │ │ This     │ │ Average ││
│  │ ₹1,200   │ │ Year     │ │ Per Job ││
│  │ 2 jobs   │ │ ₹1.2L    │ │ ₹580    ││
│  └──────────┘ └──────────┘ └─────────┘│
│                                          │
└──────────────────────────────────────────┘
```

## Key Features

### Total Earnings Display

**Prominent Display:**
- Lifetime total earnings
- Large, bold typography
- Current week increase/decrease
- Percentage change indicator
- Color-coded trend (green up, red down)

**Calculation:**
- Sum of all completed jobs
- Net amount after platform commission
- Excludes pending/refunded amounts
- Real-time updates

### Available Balance Card

**Withdrawable Amount:**
- Currently available for withdrawal
- After holding period (24-48 hours post-job)
- Clear, prominent display
- Quick withdraw button

**Payout Information:**
- Next scheduled payout date
- Automatic payout threshold (₹1000)
- Bank account status indicator
- Processing time estimate

### Time Period Filters

**Quick Filters:**
- **Today**: Last 24 hours
- **This Week**: Monday-Sunday current week
- **This Month**: Current calendar month
- **Custom**: Date range picker

**Display Updates:**
- Chart adjusts to selected period
- Transaction list filters
- Stats recalculate
- Smooth transitions

### Earnings Trend Chart

**Line Chart:**
- Visual earnings over time
- Interactive data points
- Hover/tap for exact values
- Week/day breakdown based on period
- Smooth animations

**Insights:**
- Peak earning days/weeks
- Trend direction (up/down/stable)
- Comparison to previous period
- Average daily/weekly earnings

### Recent Transactions List

**Transaction Types:**
- **Earnings**: Jobs completed (+amount, green)
- **Withdrawals**: Payouts to bank (-amount, blue)
- **Refunds**: Cancelled jobs (-amount, red)
- **Bonuses**: Platform incentives (+amount, gold)
- **Penalties**: Late cancellations (-amount, red)

**Transaction Details:**
- Service type/description
- Amount with +/- indicator
- Date and time
- Status (completed, processing, failed)
- Tap to view full details

### Quick Stats Cards

**Pending Earnings:**
- Amount from completed jobs
- Waiting for holding period to end
- Number of jobs
- Expected availability date

**Yearly Total:**
- Current year cumulative
- Comparison to last year
- Milestone progress (if any)

**Average Per Job:**
- Mean earnings per completed job
- Helps track service value
- Excludes outliers
- Trend indicator

## Component Breakdown

### Total Earnings Header

```swift
struct TotalEarningsHeader: View {
    let totalEarnings: Double
    let weeklyChange: Double
    let percentageChange: Double

    var body: some View {
        VStack(spacing: 12) {
            Text("💰 Total Earnings")
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(.gray600)

            Text("₹\(totalEarnings, specifier: "%.2f")")
                .font(.custom("Inter-Bold", size: 40))
                .foregroundColor(.gray900)

            HStack(spacing: 6) {
                Image(systemName: weeklyChange >= 0 ? "arrow.up.right" : "arrow.down.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(weeklyChange >= 0 ? .success : .error)

                Text("₹\(abs(weeklyChange), specifier: "%.0f") this week")
                    .font(.system(size: 14))
                    .foregroundColor(.gray700)

                Text("(\(percentageChange >= 0 ? "+" : "")\(percentageChange, specifier: "%.1f")%)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(weeklyChange >= 0 ? .success : .error)
            }
        }
        .padding(.vertical, 24)
    }
}
```

### Available Balance Card

```swift
struct AvailableBalanceCard: View {
    let availableBalance: Double
    let nextPayoutDate: Date
    let onWithdraw: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("💳 Available Balance")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(.gray900)

            Text("₹\(availableBalance, specifier: "%.2f")")
                .font(.custom("Inter-Bold", size: 32))
                .foregroundColor(.brandPrimary)

            PrimaryButton(
                title: "Withdraw Funds",
                action: onWithdraw,
                isDisabled: availableBalance < 100
            )

            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.system(size: 12))
                    .foregroundColor(.gray500)

                Text("Next payout: \(nextPayoutDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.system(size: 12))
                    .foregroundColor(.gray600)
            }

            if availableBalance < 100 {
                HStack(spacing: 6) {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.brandPrimary)

                    Text("Minimum ₹100 required for withdrawal")
                        .font(.system(size: 11))
                        .foregroundColor(.gray500)
                }
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}
```

### Time Period Filters

```swift
struct TimePeriodFilters: View {
    @Binding var selectedPeriod: TimePeriod
    let todayAmount: Double
    let weekAmount: Double
    let monthAmount: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📊 Earnings Breakdown")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(.gray900)

            HStack(spacing: 12) {
                PeriodCard(
                    title: "Today",
                    amount: todayAmount,
                    isSelected: selectedPeriod == .today,
                    onTap: { selectedPeriod = .today }
                )

                PeriodCard(
                    title: "This Week",
                    amount: weekAmount,
                    isSelected: selectedPeriod == .week,
                    onTap: { selectedPeriod = .week }
                )

                PeriodCard(
                    title: "Month",
                    amount: monthAmount,
                    isSelected: selectedPeriod == .month,
                    onTap: { selectedPeriod = .month }
                )
            }
        }
    }
}

struct PeriodCard: View {
    let title: String
    let amount: Double
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 6) {
                Text(title)
                    .font(.system(size: 12))
                    .foregroundColor(isSelected ? .white : .gray600)

                Text("₹\(amount, specifier: "%.0f")")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(isSelected ? .white : .gray900)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(isSelected ? Color.brandPrimary : Color.white)
            .cornerRadius(8)
            .shadow(color: isSelected ? Color.brandPrimary.opacity(0.3) : Color.black.opacity(0.05), radius: isSelected ? 4 : 2, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

enum TimePeriod {
    case today, week, month, custom
}
```

### Earnings Chart

```swift
struct EarningsChart: View {
    let data: [ChartDataPoint]
    let period: TimePeriod

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📈 \(period == .month ? "This Month's" : "Earnings") Trend")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(.gray900)

            // Chart implementation (using Charts framework or custom)
            Chart {
                ForEach(data) { point in
                    LineMark(
                        x: .value("Period", point.label),
                        y: .value("Amount", point.value)
                    )
                    .foregroundStyle(Color.brandPrimary)
                    .interpolationMethod(.catmullRom)

                    PointMark(
                        x: .value("Period", point.label),
                        y: .value("Amount", point.value)
                    )
                    .foregroundStyle(Color.brandPrimary)
                }
            }
            .frame(height: 200)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}
```

### Recent Transactions List

```swift
struct RecentTransactionsList: View {
    let transactions: [Transaction]
    let onViewAll: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("📝 Recent Transactions")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(.gray900)

                Spacer()

                Button(action: onViewAll) {
                    Text("View All")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.brandPrimary)
                }
            }

            VStack(spacing: 12) {
                ForEach(transactions.prefix(5)) { transaction in
                    TransactionRow(transaction: transaction)
                }

                Button(action: onViewAll) {
                    Text("View All Transactions")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(.brandPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.brandPrimary.opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack {
            // Icon
            Image(systemName: transaction.type.icon)
                .font(.system(size: 16))
                .foregroundColor(transaction.type.color)
                .frame(width: 32, height: 32)
                .background(transaction.type.color.opacity(0.1))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(.gray900)

                Text(transaction.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.system(size: 12))
                    .foregroundColor(.gray500)

                if transaction.status != .completed {
                    Text(transaction.status.displayName)
                        .font(.system(size: 11))
                        .foregroundColor(.warning)
                }
            }

            Spacer()

            Text("\(transaction.amount >= 0 ? "+" : "")₹\(abs(transaction.amount), specifier: "%.2f")")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(transaction.amount >= 0 ? .success : .error)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
    }
}

enum TransactionType {
    case earning, withdrawal, refund, bonus, penalty

    var icon: String {
        switch self {
        case .earning: return "checkmark.circle.fill"
        case .withdrawal: return "arrow.down.circle.fill"
        case .refund: return "arrow.uturn.backward.circle.fill"
        case .bonus: return "gift.fill"
        case .penalty: return "exclamationmark.triangle.fill"
        }
    }

    var color: Color {
        switch self {
        case .earning: return .success
        case .withdrawal: return .brandPrimary
        case .refund: return .error
        case .bonus: return .warning
        case .penalty: return .error
        }
    }
}

enum TransactionStatus {
    case completed, processing, failed

    var displayName: String {
        switch self {
        case .completed: return "Completed"
        case .processing: return "Processing..."
        case .failed: return "Failed"
        }
    }
}
```

## Interactions

### Withdraw Funds
```swift
func withdrawFunds() {
    guard availableBalance >= 100 else {
        AlertManager.showError("Minimum ₹100 required for withdrawal")
        return
    }

    navigationController?.push(WithdrawFundsView(
        availableBalance: availableBalance,
        onWithdrawalComplete: {
            // Refresh earnings data
            Task {
                await viewModel.refreshEarnings()
            }
        }
    ))
}
```

### View Transaction Details
```swift
func viewTransaction(_ transaction: Transaction) {
    presentSheet(TransactionDetailSheet(transaction: transaction))
}
```

### Filter by Period
```swift
func filterByPeriod(_ period: TimePeriod) {
    withAnimation {
        selectedPeriod = period
    }

    Task {
        await viewModel.fetchEarnings(for: period)
    }

    analytics.track("earnings_period_changed", ["period": period.rawValue])
}
```

## States

### Default State
- All data loaded and displayed
- Chart showing current month
- Recent transactions visible
- Withdraw button enabled if balance sufficient

### Loading State
- Skeleton loading for chart
- Shimmer for transaction cards
- Available balance loading indicator

### Empty State
- No earnings yet
- Motivational message
- Call-to-action to accept jobs

### Error State
- Failed to load earnings
- Retry button
- Error message

## API Integration

### Fetch Earnings Summary
```typescript
GET /providers/{providerId}/earnings
Query Parameters:
  - period: "today" | "week" | "month" | "year"
  - startDate: "2025-01-01" (for custom)
  - endDate: "2025-01-31"

Response:
{
  "success": true,
  "data": {
    "totalEarnings": 45230.50,
    "availableBalance": 3850.00,
    "pendingEarnings": 1200.00,
    "weeklyChange": 2340.00,
    "percentageChange": 5.4,
    "todayEarnings": 722.50,
    "weekEarnings": 2340.00,
    "monthEarnings": 12450.00,
    "yearEarnings": 120000.00,
    "averagePerJob": 580.00,
    "nextPayoutDate": "2025-01-17",
    "chartData": [
      { "label": "Week 1", "value": 2500 },
      { "label": "Week 2", "value": 3200 }
    ],
    "recentTransactions": [...]
  }
}
```

## Navigation

### Entry Points
- Provider Dashboard → "Earnings" card
- Bottom Tab Bar → "Wallet" tab
- Screen 35 (Success) → "View Earnings"

### Exit Points
- Tap "Withdraw Funds" → Screen 38 (Withdraw Funds)
- Tap "View All Transactions" → Screen 37 (Transaction History)
- Tap transaction → Transaction detail modal

## Accessibility

### VoiceOver
- Total: "Total earnings, 45,230 rupees and 50 paise"
- Balance: "Available balance, 3,850 rupees, Withdraw funds button"
- Chart: "Earnings chart showing upward trend"
- Transactions: "AC Repair, earned 722 rupees, 15 January"

### Touch Targets
- All buttons: 44pt minimum height
- Chart data points: 44x44pt tap area
- Transaction rows: 60pt minimum

## Analytics

```typescript
analytics.track('earnings_dashboard_viewed', {
  total_earnings: 45230.50,
  available_balance: 3850.00,
  period: 'month'
})

analytics.track('withdraw_initiated', {
  from_screen: 'earnings_dashboard',
  amount: 3850.00
})

analytics.track('transaction_viewed', {
  transaction_type: 'earning',
  amount: 722.50
})
```

## Testing Checklist

- [ ] Earnings calculate correctly
- [ ] Chart displays accurate data
- [ ] Time filters work
- [ ] Transactions list loads
- [ ] Withdraw button validation
- [ ] Empty state shows
- [ ] Loading states smooth
- [ ] Error handling works
- [ ] Refresh pulls new data
- [ ] Number formatting correct (Indian comma system)

## Design Notes

- Clear visual hierarchy (balance most prominent)
- Intuitive time filtering
- Quick access to withdrawal
- Transaction history easily accessible
- Chart provides visual insight
- Motivating display of earnings growth
