# Availability Calendar

## Overview
- **Screen ID**: 30
- **Screen Name**: Availability Calendar
- **User Role**: Service Provider
- **Platform**: iOS, Android
- **Navigation**: From Provider Dashboard → Tap "Manage Availability" or from bottom tab "Calendar"

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  Availability               + Block Days │
├──────────────────────────────────────────┤
│                                          │
│  January 2025                     < >    │  ← Month navigation
│  ───────────────────────────────────     │
│                                          │
│  Sun  Mon  Tue  Wed  Thu  Fri  Sat      │
│                  1    2    3    4        │
│   5    6    7    8    9   10   11        │
│  12   13   14   15   16   17   18        │
│  19   20   21   22   23   24   25        │
│  26   27   28   29   30   31             │
│                                          │
│  Legend:                                 │
│  ● Available    ○ Blocked   ◐ Booked    │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ Today • 15 January                 │ │  ← Selected Date
│  │ Status: ● Available                │ │
│  │                                    │ │
│  │ Working Hours: 9:00 AM - 6:00 PM  │ │
│  │ Max Jobs: 3 per day               │ │
│  │                                    │ │
│  │ Bookings Today:                   │ │
│  │ • 10:00 AM - AC Repair (#BK123)   │ │
│  │ • 2:00 PM - Plumbing (#BK456)     │ │
│  │                                    │ │
│  │ [Edit Availability]                │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Quick Actions                           │
│  ┌──────────┐ ┌──────────┐ ┌─────────┐│
│  │ Set      │ │ Block    │ │ Copy    ││
│  │ Hours    │ │ Week     │ │ Week    ││
│  └──────────┘ └──────────┘ └─────────┘│
│                                          │
└──────────────────────────────────────────┘
```

## Key Features

### Calendar View
- Monthly calendar grid
- Color-coded date indicators:
  - **Green dot (●)**: Available for bookings
  - **Red dot (○)**: Blocked/unavailable
  - **Half-filled (◐)**: Partially booked (has bookings but can take more)
  - **Blue dot (●)**: Fully booked
  - **Gray**: Past dates
- Current date highlighted with border
- Selected date highlighted with background

### Date Status Indicators

**Color System:**
```swift
enum DateStatus {
    case available      // Green (#28C76F)
    case blocked       // Red (#EA5455)
    case partiallyBooked // Orange (#FF6B35)
    case fullyBooked   // Blue (#0D7377)
    case past          // Gray (#999999)
}

func colorForDate(_ date: Date, bookings: [Booking]) -> Color {
    if date < Date() { return .gray400 }

    let dayBookings = bookings.filter { $0.date.isSameDay(as: date) }
    let isBlocked = blockedDates.contains(date)
    let maxJobs = availability.maxJobsPerDay

    if isBlocked { return .error }
    if dayBookings.count >= maxJobs { return .brandPrimary }
    if dayBookings.count > 0 { return .secondary }
    return .success
}
```

### Date Detail Card

When a date is selected, shows:
- Date and day of week
- Status (Available/Blocked/Booked)
- Working hours for that day
- Maximum jobs allowed
- List of existing bookings
- Edit availability button

### Month Navigation
- Swipe left/right to change months
- Tap arrows to navigate
- Shows current month/year
- Can jump to specific month via picker

### Quick Actions

**Set Hours:**
- Quickly set working hours for selected date
- Option to apply to recurring days

**Block Week:**
- Block entire week from bookings
- Useful for vacations

**Copy Week:**
- Copy current week's availability to future weeks
- Bulk operation for repetitive schedules

## Component Breakdown

### Calendar Grid

```swift
struct CalendarGrid: View {
    @StateObject var viewModel: AvailabilityViewModel
    @State private var selectedDate: Date = Date()
    @State private var currentMonth: Date = Date()

    var body: some View {
        VStack(spacing: 16) {
            // Month header
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
                    CalendarDayCell(
                        date: date,
                        isSelected: date.isSameDay(as: selectedDate),
                        status: viewModel.statusForDate(date),
                        bookingCount: viewModel.bookingsForDate(date).count,
                        onTap: { selectedDate = date }
                    )
                }
            }
            .padding(.horizontal, 16)

            // Legend
            CalendarLegend()

            // Selected date detail
            if let selected = selectedDate {
                DateDetailCard(
                    date: selected,
                    status: viewModel.statusForDate(selected),
                    availability: viewModel.availabilityForDate(selected),
                    bookings: viewModel.bookingsForDate(selected),
                    onEditTap: { showEditAvailability(for: selected) }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}
```

### Calendar Day Cell

```swift
struct CalendarDayCell: View {
    let date: Date
    let isSelected: Bool
    let status: DateStatus
    let bookingCount: Int
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Text("\(date.day)")
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isToday ? .brandPrimary : .gray800)

                // Status indicator
                StatusDot(status: status)
                    .frame(width: 6, height: 6)

                // Booking count badge
                if bookingCount > 0 {
                    Text("\(bookingCount)")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 14, height: 14)
                        .background(Color.brandPrimary)
                        .clipShape(Circle())
                }
            }
            .frame(width: 44, height: 60)
            .background(isSelected ? Color.brandPrimary.opacity(0.1) : Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isToday ? Color.brandPrimary : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
}
```

### Month Navigation Header

```swift
struct MonthNavigationHeader: View {
    @Binding var month: Date
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack {
            Text(monthYearString)
                .font(.custom("Inter-SemiBold", size: 20))
                .foregroundColor(.gray900)

            Spacer()

            HStack(spacing: 8) {
                Button(action: onPrevious) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray600)
                        .frame(width: 32, height: 32)
                        .background(Color.gray100)
                        .clipShape(Circle())
                }

                Button(action: onNext) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray600)
                        .frame(width: 32, height: 32)
                        .background(Color.gray100)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal, 16)
    }

    var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: month)
    }
}
```

### Date Detail Card

```swift
struct DateDetailCard: View {
    let date: Date
    let status: DateStatus
    let availability: DayAvailability?
    let bookings: [Booking]
    let onEditTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(dateString)
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(.gray900)

                    HStack(spacing: 8) {
                        StatusDot(status: status)
                        Text(statusText)
                            .font(.system(size: 14))
                            .foregroundColor(statusColor)
                    }
                }

                Spacer()
            }

            Divider()

            // Availability details
            if let availability = availability {
                VStack(alignment: .leading, spacing: 8) {
                    DetailRow(
                        icon: "clock",
                        label: "Working Hours",
                        value: "\(availability.startTime) - \(availability.endTime)"
                    )

                    DetailRow(
                        icon: "list.number",
                        label: "Max Jobs",
                        value: "\(availability.maxJobs) per day"
                    )
                }
            }

            // Bookings
            if !bookings.isEmpty {
                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Bookings Today")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(.gray600)

                    ForEach(bookings) { booking in
                        BookingRow(booking: booking)
                    }
                }
            }

            // Edit button
            PrimaryButton(
                title: "Edit Availability",
                action: onEditTap
            )
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2, y: 2)
        .padding(.horizontal, 16)
    }

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter.string(from: date)
    }

    var statusText: String {
        switch status {
        case .available: return "Available"
        case .blocked: return "Blocked"
        case .partiallyBooked: return "Partially Booked"
        case .fullyBooked: return "Fully Booked"
        case .past: return "Past Date"
        }
    }

    var statusColor: Color {
        switch status {
        case .available: return .success
        case .blocked: return .error
        case .partiallyBooked: return .secondary
        case .fullyBooked: return .brandPrimary
        case .past: return .gray400
        }
    }
}
```

### Quick Action Buttons

```swift
struct QuickActionButtons: View {
    let onSetHours: () -> Void
    let onBlockWeek: () -> Void
    let onCopyWeek: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.custom("Inter-Medium", size: 14))
                .foregroundColor(.gray600)

            HStack(spacing: 12) {
                QuickActionButton(
                    icon: "clock",
                    title: "Set Hours",
                    action: onSetHours
                )

                QuickActionButton(
                    icon: "calendar.badge.minus",
                    title: "Block Week",
                    action: onBlockWeek
                )

                QuickActionButton(
                    icon: "doc.on.doc",
                    title: "Copy Week",
                    action: onCopyWeek
                )
            }
        }
        .padding(.horizontal, 16)
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.brandPrimary)

                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray700)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 72)
            .background(Color.gray50)
            .cornerRadius(8)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
```

## Interactions

### Tap Date
```swift
func selectDate(_ date: Date) {
    withAnimation(.spring()) {
        selectedDate = date
    }

    // Fetch bookings for selected date
    Task {
        await viewModel.fetchBookings(for: date)
    }

    // Haptic feedback
    HapticManager.impact(.light)
}
```

### Edit Availability
```swift
func showEditAvailability(for date: Date) {
    presentSheet(
        SetAvailabilitySheet(
            date: date,
            availability: viewModel.availabilityForDate(date),
            onSave: { newAvailability in
                Task {
                    await viewModel.updateAvailability(date: date, availability: newAvailability)
                    ToastManager.show("Availability updated")
                }
            }
        )
    )
}
```

### Block Week
```swift
func blockWeek() {
    let weekDates = selectedDate.datesInWeek

    AlertManager.show(
        title: "Block Entire Week?",
        message: "You won't receive booking requests for \(weekDates.first!.formatted) - \(weekDates.last!.formatted)",
        primaryButton: "Block Week",
        secondaryButton: "Cancel",
        primaryAction: {
            Task {
                await viewModel.blockDates(weekDates, reason: "Provider blocked")
                ToastManager.show("Week blocked successfully")
            }
        }
    )
}
```

### Copy Week Availability
```swift
func copyWeek() {
    presentSheet(
        CopyWeekSheet(
            sourceWeek: selectedDate.weekOfYear,
            onConfirm: { targetWeeks in
                Task {
                    let success = await viewModel.copyAvailability(
                        from: selectedDate.weekOfYear,
                        to: targetWeeks
                    )

                    if success {
                        ToastManager.show("Availability copied to \(targetWeeks.count) weeks")
                    }
                }
            }
        )
    )
}
```

### Month Navigation
```swift
func navigateMonth(direction: Int) {
    withAnimation(.easeInOut(duration: 0.3)) {
        if direction > 0 {
            currentMonth = currentMonth.nextMonth
        } else {
            currentMonth = currentMonth.previousMonth
        }
    }

    // Fetch availability for new month
    Task {
        await viewModel.fetchAvailability(for: currentMonth)
    }
}
```

### Block Days (Top Right)
```swift
func showBlockDatesSheet() {
    navigationController?.push(BlockDatesView(
        currentMonth: currentMonth,
        onDatesBlocked: { blockedDates in
            Task {
                await viewModel.refreshCalendar()
            }
        }
    ))
}
```

## States

### Default State
- Calendar loaded with current month
- Today's date highlighted
- All dates showing correct status indicators
- Selected date detail card visible

### Loading State
```swift
struct LoadingCalendar: View {
    var body: some View {
        VStack(spacing: 16) {
            ShimmerView()
                .frame(height: 40) // Month header

            // Calendar skeleton
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(0..<35, id: \.self) { _ in
                    ShimmerView()
                        .frame(width: 44, height: 60)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 16)

            ShimmerView()
                .frame(height: 200) // Detail card skeleton
                .cornerRadius(12)
                .padding(.horizontal, 16)
        }
    }
}
```

### Empty State
- No bookings for selected date
- Message: "No bookings scheduled for this day"
- Show availability status only

### Error State
- Failed to load availability
- Error banner: "Unable to load calendar. Please try again."
- Retry button

### Blocked Date State
- Date shows red dot
- Detail card shows "Blocked" status
- Options to unblock or edit reason

## API Integration

### Fetch Monthly Availability
```typescript
GET /providers/{providerId}/availability
Query Parameters:
  - month: "2025-01"
  - year: 2025

Response:
{
  "success": true,
  "data": {
    "availability": [
      {
        "date": "2025-01-15",
        "status": "available",
        "workingHours": {
          "start": "09:00",
          "end": "18:00"
        },
        "maxJobs": 3,
        "currentBookings": 1
      }
    ],
    "blockedDates": ["2025-01-20", "2025-01-21"],
    "bookings": [
      {
        "id": "BK123",
        "date": "2025-01-15",
        "time": "10:00",
        "service": "AC Repair",
        "status": "confirmed"
      }
    ]
  }
}
```

### Update Availability
```typescript
PUT /providers/{providerId}/availability
Body:
{
  "date": "2025-01-15",
  "workingHours": {
    "start": "09:00",
    "end": "18:00"
  },
  "maxJobs": 3,
  "isAvailable": true
}

Response:
{
  "success": true,
  "message": "Availability updated"
}
```

### Block Dates
```typescript
POST /providers/{providerId}/block-dates
Body:
{
  "dates": ["2025-01-20", "2025-01-21", "2025-01-22"],
  "reason": "Vacation"
}

Response:
{
  "success": true,
  "message": "Dates blocked successfully"
}
```

### Copy Week Availability
```typescript
POST /providers/{providerId}/copy-availability
Body:
{
  "sourceWeek": "2025-W03",
  "targetWeeks": ["2025-W04", "2025-W05"]
}

Response:
{
  "success": true,
  "message": "Availability copied to 2 weeks"
}
```

## Navigation

### Entry Points
- Provider Dashboard → "Manage Availability" button
- Bottom Tab Bar → "Calendar" tab
- Job Requests → "Check Availability"

### Exit Points
- Tap "Edit Availability" → Screen 31 (Set Availability)
- Tap "+ Block Days" → Screen 32 (Block Dates)
- Tap booking in detail card → Screen 27 (Job Detail)
- Back button → Return to previous screen

## Accessibility

### VoiceOver Labels
- Calendar day cells: "15 January, Available, 2 bookings"
- Month navigation: "Previous month, January 2025, Next month"
- Status indicators: "Available for bookings" / "Blocked" / "Fully booked"
- Quick action buttons: "Set working hours", "Block entire week", "Copy week availability"

### Dynamic Type Support
- All text scales with system font size
- Calendar grid maintains touch targets at all sizes
- Minimum cell size: 44x44pt

### Touch Targets
- Calendar day cells: 44x60pt
- Navigation buttons: 44x44pt
- Action buttons: 48pt height minimum

### Color Contrast
- Status indicators use both color AND shapes
- Text maintains 4.5:1 contrast ratio
- Selected date has background + border

## Analytics Events

Track the following events:

```typescript
// Screen view
analytics.track('screen_view', {
  screen_name: 'availability_calendar',
  provider_id: providerId,
  current_month: '2025-01'
})

// Date selected
analytics.track('calendar_date_selected', {
  date: '2025-01-15',
  status: 'available',
  booking_count: 2
})

// Edit availability
analytics.track('edit_availability_clicked', {
  date: '2025-01-15',
  previous_status: 'available'
})

// Block week
analytics.track('block_week_initiated', {
  week_start: '2025-01-13',
  week_end: '2025-01-19'
})

// Copy week
analytics.track('copy_week_initiated', {
  source_week: '2025-W03',
  target_week_count: 2
})

// Month changed
analytics.track('calendar_month_changed', {
  from_month: '2025-01',
  to_month: '2025-02',
  method: 'swipe' // or 'arrow'
})
```

## Testing Checklist

- [ ] Calendar loads current month correctly
- [ ] Date status indicators show correct colors
- [ ] Today's date is highlighted
- [ ] Tap date shows detail card with smooth animation
- [ ] Booking count badges display correctly
- [ ] Month navigation works (swipe + arrows)
- [ ] Quick actions trigger appropriate sheets
- [ ] Past dates are disabled/grayed out
- [ ] Blocked dates show red indicator
- [ ] Fully booked dates show blue indicator
- [ ] Empty state shows when no bookings
- [ ] Loading state displays during API calls
- [ ] Error handling works for failed requests
- [ ] Refresh updates calendar data
- [ ] VoiceOver navigation works correctly
- [ ] Dynamic Type scales appropriately
- [ ] Works in landscape orientation (iPad)
- [ ] Offline mode shows cached availability
- [ ] Real-time updates when new booking received
- [ ] Performance with 6+ months of data

## Design Notes

### iOS Specific
- Use native calendar grid layout
- Swipe gestures for month navigation
- Pull to refresh calendar
- Haptic feedback on interactions

### Android Specific
- Material Design calendar component
- Floating action button for quick actions
- Date picker dialog for month selection

### Performance
- Cache availability for current + next 3 months
- Lazy load bookings on date selection
- Debounce API calls during rapid month changes
- Optimize re-renders with proper state management

### Future Enhancements
- Week view toggle
- Year view for quick navigation
- Recurring availability patterns
- Sync with device calendar
- Export availability to calendar file
- Bulk edit multiple dates
- Templates for common schedules (weekdays only, weekends only, etc.)
