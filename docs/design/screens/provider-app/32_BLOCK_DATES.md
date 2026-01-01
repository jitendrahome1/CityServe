# Block Dates

## Overview
- **Screen ID**: 32
- **Screen Name**: Block Dates
- **User Role**: Service Provider
- **Platform**: iOS, Android
- **Navigation**: From Availability Calendar (Screen 30) → Tap "+ Block Days" button

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ✕  Block Dates                   Block  │
├──────────────────────────────────────────┤
│                                          │
│  🗓️ Select Dates to Block                │
│                                          │
│  January 2025                     < >    │
│  ───────────────────────────────────     │
│                                          │
│  Sun  Mon  Tue  Wed  Thu  Fri  Sat      │
│                  1    2    3    4        │
│   5    6    7    8    9   10   11        │
│  12   13   14   15   16   17   18        │
│  19  [20] [21] [22] [23]  24   25        │  ← Selected dates
│  26   27   28   29   30   31             │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ Selected: 4 dates                  │ │
│  │ 20-23 January 2025                 │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Quick Select                            │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌────────┐│
│  │Today │ │Week  │ │Month │ │Custom  ││
│  └──────┘ └──────┘ └──────┘ └────────┘│
│                                          │
│  📝 Reason for Blocking *                │
│  ┌────────────────────────────────────┐ │
│  │ Vacation              ▼            │ │  ← Dropdown
│  └────────────────────────────────────┘ │
│                                          │
│  Options:                                │
│  • Vacation / Holiday                    │
│  • Sick Leave                            │
│  • Personal Emergency                    │
│  • Training / Workshop                   │
│  • Out of Station                        │
│  • Other (specify)                       │
│                                          │
│  Additional Notes (Optional)             │
│  ┌────────────────────────────────────┐ │
│  │ Going to Goa for vacation...       │ │
│  │                                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ⚠️ Existing Bookings                   │
│  ┌────────────────────────────────────┐ │
│  │ You have 2 confirmed bookings      │ │
│  │ on selected dates:                 │ │
│  │                                    │ │
│  │ • 21 Jan, 10:00 AM - AC Repair     │ │
│  │   #BK12345  ₹550                   │ │
│  │   [View] [Cancel Booking]          │ │
│  │                                    │ │
│  │ • 22 Jan, 2:00 PM - Plumbing       │ │
│  │   #BK67890  ₹450                   │ │
│  │   [View] [Cancel Booking]          │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ☑ Notify customers about cancellation   │
│  ☑ Provide full refund                   │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │        Block Selected Dates        │ │  ← Primary button
│  └────────────────────────────────────┘ │
│                                          │
│              Cancel                      │
│                                          │
└──────────────────────────────────────────┘
```

## Key Features

### Multi-Date Selection
- Tap dates to select/deselect
- Selected dates highlighted in brand color
- Visual indication of selection count
- Date range selection by dragging (optional)
- Can select individual dates or consecutive ranges

### Quick Select Buttons

**Today:**
- Instantly select current date
- One-tap quick block

**Week:**
- Select current week (Mon-Sun or Sun-Sat based on locale)
- Useful for weekend trips

**Month:**
- Select entire current month
- Bulk blocking for long vacations

**Custom:**
- Opens date range picker
- Select start and end date
- All dates in between auto-selected

### Blocking Reasons

Pre-defined reasons for analytics and tracking:
- **Vacation / Holiday**: Personal time off
- **Sick Leave**: Health-related absence
- **Personal Emergency**: Urgent personal matters
- **Training / Workshop**: Professional development
- **Out of Station**: Travel/relocation
- **Other**: Custom reason (requires text input)

### Existing Bookings Handling

**If No Bookings:**
- Direct block without warnings
- Dates immediately unavailable

**If Existing Bookings:**
- Warning section appears
- Shows list of affected bookings
- Options for each booking:
  - View booking details
  - Cancel booking (triggers refund)
  - Reassign to another provider (future feature)
- Checkboxes for customer notification and refund

**Cancellation Flow:**
- Notify customers automatically
- Option for full refund (recommended)
- Option for partial refund (with reason)
- Option to not refund (requires admin approval)
- Penalty may apply for frequent cancellations

### Validation Rules
- Must select at least one date
- Can only block future dates (not past)
- Must provide reason
- Must handle existing bookings if any
- Maximum 90 days can be blocked at once

## Component Breakdown

### Block Calendar Grid

```swift
struct BlockCalendarGrid: View {
    @StateObject var viewModel: BlockDatesViewModel
    @State private var selectedDates: Set<Date> = []
    @State private var currentMonth: Date = Date()

    var body: some View {
        VStack(spacing: 16) {
            // Header
            Text("🗓️ Select Dates to Block")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(.gray900)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)

            // Month navigation
            MonthNavigationHeader(
                month: $currentMonth,
                onPrevious: { currentMonth = currentMonth.previousMonth },
                onNext: { currentMonth = currentMonth.nextMonth }
            )

            // Weekday labels
            WeekdayLabels()

            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                ForEach(daysInMonth(currentMonth), id: \.self) { date in
                    BlockCalendarDayCell(
                        date: date,
                        isSelected: selectedDates.contains(date),
                        isPast: date < Date().startOfDay,
                        hasBooking: viewModel.hasBooking(on: date),
                        onTap: {
                            toggleDateSelection(date)
                        }
                    )
                }
            }
            .padding(.horizontal, 16)

            // Selection summary
            if !selectedDates.isEmpty {
                SelectionSummaryCard(
                    selectedDates: selectedDates,
                    onClear: { selectedDates.removeAll() }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }

    func toggleDateSelection(_ date: Date) {
        guard date >= Date().startOfDay else {
            ToastManager.show("Cannot block past dates")
            return
        }

        withAnimation(.spring()) {
            if selectedDates.contains(date) {
                selectedDates.remove(date)
            } else {
                selectedDates.insert(date)
            }
        }

        HapticManager.impact(.light)

        // Fetch bookings for newly selected dates
        if selectedDates.contains(date) {
            Task {
                await viewModel.fetchBookings(for: date)
            }
        }
    }
}

struct BlockCalendarDayCell: View {
    let date: Date
    let isSelected: Bool
    let isPast: Bool
    let hasBooking: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Text("\(date.day)")
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(textColor)

                // Booking indicator
                if hasBooking {
                    Circle()
                        .fill(Color.error)
                        .frame(width: 6, height: 6)
                }
            }
            .frame(width: 44, height: 44)
            .background(backgroundColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: isSelected ? 2 : 0)
            )
        }
        .disabled(isPast)
        .buttonStyle(ScaleButtonStyle())
    }

    var textColor: Color {
        if isPast { return .gray300 }
        if isSelected { return .white }
        return .gray800
    }

    var backgroundColor: Color {
        if isPast { return .gray100 }
        if isSelected { return .brandPrimary }
        return .white
    }

    var borderColor: Color {
        isSelected ? .brandPrimary : .clear
    }
}
```

### Selection Summary Card

```swift
struct SelectionSummaryCard: View {
    let selectedDates: Set<Date>
    let onClear: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Selected: \(selectedDates.count) date\(selectedDates.count == 1 ? "" : "s")")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(.gray900)

                Text(dateRangeText)
                    .font(.system(size: 12))
                    .foregroundColor(.gray600)
            }

            Spacer()

            Button(action: onClear) {
                Text("Clear")
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(.brandPrimary)
            }
        }
        .padding(12)
        .background(Color.brandPrimary.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }

    var dateRangeText: String {
        let sorted = selectedDates.sorted()
        guard let first = sorted.first, let last = sorted.last else { return "" }

        if first == last {
            return first.formatted(date: .long, time: .omitted)
        } else {
            return "\(first.formatted(date: .abbreviated, time: .omitted)) - \(last.formatted(date: .abbreviated, time: .omitted))"
        }
    }
}
```

### Quick Select Buttons

```swift
struct QuickSelectButtons: View {
    @Binding var selectedDates: Set<Date>
    @State private var showCustomRangePicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Select")
                .font(.custom("Inter-Medium", size: 14))
                .foregroundColor(.gray600)

            HStack(spacing: 8) {
                QuickSelectButton(title: "Today") {
                    selectedDates = [Date().startOfDay]
                }

                QuickSelectButton(title: "Week") {
                    selectedDates = Set(Date().datesInCurrentWeek)
                }

                QuickSelectButton(title: "Month") {
                    selectedDates = Set(Date().datesInCurrentMonth)
                }

                QuickSelectButton(title: "Custom") {
                    showCustomRangePicker = true
                }
            }
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $showCustomRangePicker) {
            CustomRangePickerSheet(
                selectedDates: $selectedDates,
                onDismiss: { showCustomRangePicker = false }
            )
        }
    }
}

struct QuickSelectButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.brandPrimary)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
                .background(Color.brandPrimary.opacity(0.1))
                .cornerRadius(6)
        }
    }
}
```

### Blocking Reason Selector

```swift
struct BlockingReasonSelector: View {
    @Binding var selectedReason: BlockReason
    @Binding var customReason: String
    @State private var showCustomInput = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("📝 Reason for Blocking")
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(.gray800)

                Text("*")
                    .foregroundColor(.error)
            }

            Menu {
                ForEach(BlockReason.allCases, id: \.self) { reason in
                    Button(action: {
                        selectedReason = reason
                        showCustomInput = reason == .other
                    }) {
                        HStack {
                            Text(reason.displayName)
                            if selectedReason == reason {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedReason.displayName)
                        .font(.system(size: 14))
                        .foregroundColor(.gray800)

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.gray500)
                }
                .padding(12)
                .background(Color.white)
                .cornerRadius(8)
            }

            // Custom reason input
            if showCustomInput {
                TextField("Please specify reason", text: $customReason)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(8)
            }

            // Additional notes
            VStack(alignment: .leading, spacing: 8) {
                Text("Additional Notes (Optional)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray600)

                TextEditor(text: $customReason)
                    .font(.system(size: 14))
                    .frame(height: 80)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

enum BlockReason: CaseIterable {
    case vacation
    case sickLeave
    case emergency
    case training
    case outOfStation
    case other

    var displayName: String {
        switch self {
        case .vacation: return "Vacation / Holiday"
        case .sickLeave: return "Sick Leave"
        case .emergency: return "Personal Emergency"
        case .training: return "Training / Workshop"
        case .outOfStation: return "Out of Station"
        case .other: return "Other (specify)"
        }
    }
}
```

### Existing Bookings Warning

```swift
struct ExistingBookingsWarning: View {
    let bookings: [Booking]
    @Binding var notifyCustomers: Bool
    @Binding var provideRefund: Bool
    let onViewBooking: (Booking) -> Void
    let onCancelBooking: (Booking) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.error)

                Text("Existing Bookings")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(.error)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("You have \(bookings.count) confirmed booking\(bookings.count == 1 ? "" : "s") on selected dates:")
                    .font(.system(size: 14))
                    .foregroundColor(.gray700)

                ForEach(bookings) { booking in
                    BookingConflictRow(
                        booking: booking,
                        onView: { onViewBooking(booking) },
                        onCancel: { onCancelBooking(booking) }
                    )
                }
            }

            Divider()

            // Cancellation options
            VStack(alignment: .leading, spacing: 12) {
                Toggle(isOn: $notifyCustomers) {
                    Text("Notify customers about cancellation")
                        .font(.system(size: 14))
                        .foregroundColor(.gray700)
                }
                .tint(.brandPrimary)

                Toggle(isOn: $provideRefund) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Provide full refund")
                            .font(.system(size: 14))
                            .foregroundColor(.gray700)

                        Text("Recommended to avoid negative reviews")
                            .font(.system(size: 12))
                            .foregroundColor(.gray500)
                    }
                }
                .tint(.brandPrimary)
            }

            // Warning message
            HStack(spacing: 8) {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.warning)

                Text("Frequent cancellations may affect your rating and eligibility for new jobs")
                    .font(.system(size: 12))
                    .foregroundColor(.warning)
            }
            .padding(8)
            .background(Color.warning.opacity(0.1))
            .cornerRadius(6)
        }
        .padding(16)
        .background(Color.error.opacity(0.05))
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}

struct BookingConflictRow: View {
    let booking: Booking
    let onView: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(booking.date.formatted(date: .abbreviated, time: .omitted)), \(booking.time)")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(.gray900)

                    Text("\(booking.serviceName) • #\(booking.id)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray600)
                }

                Spacer()

                Text("₹\(booking.amount)")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(.brandPrimary)
            }

            HStack(spacing: 8) {
                Button(action: onView) {
                    Text("View")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.brandPrimary)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(Color.brandPrimary.opacity(0.1))
                        .cornerRadius(4)
                }

                Button(action: onCancel) {
                    Text("Cancel Booking")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.error)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(Color.error.opacity(0.1))
                        .cornerRadius(4)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
    }
}
```

## Interactions

### Block Dates Action
```swift
func blockSelectedDates() {
    // Validate selection
    guard !selectedDates.isEmpty else {
        AlertManager.showError("Please select at least one date to block")
        return
    }

    // Validate reason
    guard selectedReason != .other || !customReason.isEmpty else {
        AlertManager.showError("Please specify reason for blocking")
        return
    }

    // Check for existing bookings
    let affectedBookings = viewModel.bookings.filter { booking in
        selectedDates.contains(booking.date.startOfDay)
    }

    if !affectedBookings.isEmpty {
        showBookingConflictConfirmation(affectedBookings)
    } else {
        proceedWithBlocking()
    }
}

func showBookingConflictConfirmation(_ bookings: [Booking]) {
    AlertManager.show(
        title: "Cancel \(bookings.count) Booking\(bookings.count == 1 ? "" : "s")?",
        message: "Blocking these dates will cancel existing bookings. Customers will be notified\(provideRefund ? " and refunded" : "").",
        primaryButton: "Block & Cancel",
        secondaryButton: "Go Back",
        destructive: true,
        primaryAction: {
            proceedWithBlocking()
        }
    )
}

func proceedWithBlocking() {
    isLoading = true

    Task {
        do {
            let result = await viewModel.blockDates(
                dates: Array(selectedDates),
                reason: selectedReason,
                customReason: selectedReason == .other ? customReason : nil,
                notifyCustomers: notifyCustomers,
                provideRefund: provideRefund
            )

            isLoading = false

            if result.success {
                // Show success message
                let message = result.cancelledBookings > 0 ?
                    "\(selectedDates.count) dates blocked. \(result.cancelledBookings) bookings cancelled." :
                    "\(selectedDates.count) dates blocked successfully"

                ToastManager.show(message)
                HapticManager.notification(.success)

                // Track analytics
                analytics.track("dates_blocked", [
                    "count": selectedDates.count,
                    "reason": selectedReason.displayName,
                    "cancelled_bookings": result.cancelledBookings
                ])

                // Dismiss and refresh calendar
                dismiss()
            } else {
                AlertManager.showError("Failed to block dates. Please try again.")
            }
        } catch {
            isLoading = false
            AlertManager.showError(error.localizedDescription)
        }
    }
}
```

### Cancel Individual Booking
```swift
func cancelBooking(_ booking: Booking) {
    AlertManager.show(
        title: "Cancel Booking #\(booking.id)?",
        message: "Customer will be notified and refunded ₹\(booking.amount)",
        primaryButton: "Cancel Booking",
        secondaryButton: "Keep Booking",
        destructive: true,
        primaryAction: {
            Task {
                let success = await viewModel.cancelBooking(
                    booking,
                    reason: "Provider unavailable",
                    refund: true
                )

                if success {
                    ToastManager.show("Booking cancelled")
                }
            }
        }
    )
}
```

## States

### Default State
- Calendar showing current month
- No dates selected
- Reason dropdown showing "Select reason"
- No existing bookings warning

### Dates Selected State
- Selected dates highlighted in brand color
- Selection summary card visible
- Block button enabled

### Has Conflicts State
- Warning banner showing existing bookings
- List of affected bookings
- Options for notification and refund

### Loading State
- Block button shows spinner
- "Blocking dates..." text
- Inputs disabled

### Success State
- Success toast message
- Haptic feedback
- Dismiss sheet
- Refresh calendar

## API Integration

### Block Dates
```typescript
POST /providers/{providerId}/block-dates
Body:
{
  "dates": ["2025-01-20", "2025-01-21", "2025-01-22", "2025-01-23"],
  "reason": "vacation",
  "customReason": "Going to Goa for vacation",
  "notifyCustomers": true,
  "provideRefund": true,
  "affectedBookings": ["BK12345", "BK67890"]
}

Response:
{
  "success": true,
  "message": "4 dates blocked successfully",
  "cancelledBookings": 2,
  "refundedAmount": 1000
}
```

### Fetch Bookings for Dates
```typescript
POST /providers/{providerId}/bookings/check-dates
Body:
{
  "dates": ["2025-01-20", "2025-01-21"]
}

Response:
{
  "success": true,
  "bookings": [
    {
      "id": "BK12345",
      "date": "2025-01-21",
      "time": "10:00",
      "serviceName": "AC Repair",
      "customerName": "Amit Kumar",
      "amount": 550,
      "status": "confirmed"
    }
  ]
}
```

## Navigation

### Entry Points
- Screen 30 (Availability Calendar) → "+ Block Days" button
- Provider Dashboard → "Block Dates" quick action

### Exit Points
- Tap "Block" → Block dates → Dismiss → Refresh Screen 30
- Tap Close / Cancel → Confirm discard → Dismiss
- Tap "View" on booking → Navigate to Screen 27 (Job Detail)

## Accessibility

### VoiceOver Labels
- Calendar cells: "20 January, Not selected, Has 1 booking"
- Block button: "Block selected dates, Button"
- Reason dropdown: "Reason for blocking, Vacation, Picker"

### Touch Targets
- All calendar cells: 44x44pt minimum
- Buttons: 48pt height minimum

## Analytics Events

```typescript
analytics.track('block_dates_opened', {
  source: 'calendar'
})

analytics.track('dates_blocked', {
  count: 4,
  reason: 'vacation',
  has_conflicts: true,
  cancelled_bookings: 2,
  refunded: true
})

analytics.track('booking_cancelled_from_block', {
  booking_id: 'BK12345',
  refund_amount: 550
})
```

## Testing Checklist

- [ ] Cannot select past dates
- [ ] Multiple date selection works
- [ ] Quick select buttons work
- [ ] Reason dropdown required
- [ ] Existing bookings warning shows
- [ ] Cancel booking confirmation
- [ ] Notification toggle works
- [ ] Refund toggle works
- [ ] Block button validation
- [ ] Loading state displays
- [ ] Success message shows
- [ ] Calendar refreshes after block
- [ ] Cancel confirmation if changes

## Design Notes

- Use destructive color for block action with conflicts
- Clear visual hierarchy for warnings
- Smooth animations for date selection
- Consider batch operations for performance
