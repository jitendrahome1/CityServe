# 13 - Date & Time Selection

**Screen ID:** 13
**Screen Name:** Date & Time Selection
**User Flow:** Address Selection → Date & Time Selection → Booking Summary
**Entry Point:** After selecting address, user picks service date and time
**Next Screen:** Booking Summary (14)

---

## Overview

The date & time selection screen allows users to choose when they want the service performed. It displays available dates in a calendar view and time slots for the selected date, with real-time availability updates.

**Purpose:**
- Display available service dates (today, tomorrow, future)
- Show time slots with availability status
- Enable same-day, next-day, or scheduled bookings
- Show provider availability (optional)
- Handle slot expiration and conflicts
- Provide clear pricing for different time slots (if surge pricing)

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ‹  Select Date & Time                 │ ← Top Bar
├────────────────────────────────────────┤
│                                        │
│  When would you like the service?      │ ← Title
│                                        │
│  Select Date                           │ ← Section Header
│  ┌─────┬─────┬─────┬─────┬─────┐     │
│  │ Wed │ Thu │ Fri │ Sat │ Sun │     │ ← Date Pills
│  │ 15  │ 16  │ 17  │ 18  │ 19  │     │   (Horizontal Scroll)
│  │ Jan │ Jan │ Jan │ Jan │ Jan │     │
│  └─────┴─────┴─────┴─────┴─────┘     │
│                                        │
│  Select Time Slot                      │ ← Section Header
│  🌅 Morning (6 AM - 12 PM)            │ ← Time Period
│  ┌──────────┐ ┌──────────┐ ┌────────┐│
│  │ 6:00 AM  │ │ 8:00 AM  │ │10:00 AM││ ← Time Slots
│  │ ✓ Avail  │ │ ✓ Avail  │ │ Full   ││   (Grid 2 columns)
│  └──────────┘ └──────────┘ └────────┘│
│                                        │
│  ☀️  Afternoon (12 PM - 5 PM)         │
│  ┌──────────┐ ┌──────────┐ ┌────────┐│
│  │ 12:00 PM │ │ 2:00 PM  │ │ 4:00 PM││
│  │ ✓ Avail  │ │ ✓ Avail  │ │ ✓Avail ││
│  └──────────┘ └──────────┘ └────────┘│
│                                        │
│  🌆 Evening (5 PM - 9 PM)             │
│  ┌──────────┐ ┌──────────┐            │
│  │ 6:00 PM  │ │ 8:00 PM  │            │
│  │ ✓ Avail  │ │ Full     │            │
│  └──────────┘ └──────────┘            │
│                                        │
│  ℹ️  Service duration: 30-45 minutes   │ ← Info
│                                        │
│  ┌────────────────────────────────┐   │
│  │ Continue                       │   │ ← Bottom CTA
│  └────────────────────────────────┘   │
│                                        │
└────────────────────────────────────────┘
```

---

## Layout Specifications

### Screen Dimensions
```
Device: iPhone 14 (390x844pt)
Safe Area Top: 47pt
Safe Area Bottom: 34pt (+ 80pt for CTA = 114pt)
Content Area: 390x730pt
Scrollable: Yes (vertical)
```

### Background
```
Color: #F5F5F5 (light gray) / #1E1E1E (dark)
```

### Top Navigation Bar
```
Position: Fixed at top
Height: 56pt
Background: White (#FFFFFF) / #2A2A2A
Border Bottom: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 2px 4px rgba(0,0,0,0.04)

Left Section:
├─ Back Button:
│   ├─ Icon: chevron.left
│   ├─ Size: 24x24pt
│   ├─ Tap Target: 44x44pt
│   └─ Action: Return to Address Selection

Title:
├─ Text: "Select Date & Time"
├─ Font: Inter SemiBold, 18pt
├─ Color: #1E1E1E / #E0E0E0
└─ Position: Center
```

### Title Section
```
Position: 16pt below top bar
Padding: 20pt horizontal

Text:
├─ Text: "When would you like the service?"
├─ Font: Inter SemiBold, 20pt
├─ Color: #1E1E1E / #E0E0E0
├─ Line Height: 1.3
└─ Margin Bottom: 8pt
```

### Select Date Section
```
Position: 20pt below title
Padding: 0pt (horizontal scroll extends to edges)

Section Header:
├─ Text: "Select Date"
├─ Font: Inter SemiBold, 16pt
├─ Color: #1E1E1E / #E0E0E0
├─ Padding: 0 20pt
└─ Margin Bottom: 12pt

Date Pills (Horizontal Scroll):
├─ Layout: Horizontal ScrollView
├─ Snap: Yes (snap to each pill)
├─ Padding Left: 20pt, Right: 20pt
├─ Gap: 12pt between pills
├─ Show Indicator: No (hide scrollbar)
└─ Date Range: Today + next 13 days (14 days total)

Date Pill:
├─ Width: 72pt
├─ Height: 88pt
├─ Border Radius: 16pt
├─ Background:
│   ├─ Selected: #0D7377 (brand primary)
│   ├─ Today: White with teal border
│   ├─ Unselected: White / #2A2A2A
│   └─ Disabled: #F5F5F5 (grayed out)
├─ Border:
│   ├─ Selected: None
│   ├─ Today: 2pt solid #0D7377
│   ├─ Unselected: 1pt solid #E0E0E0 / #3A3A3A
│   └─ Disabled: 1pt solid #E0E0E0
├─ Shadow:
│   ├─ Selected: 0 4px 12px rgba(13,115,119,0.2)
│   └─ Unselected: 0 2px 6px rgba(0,0,0,0.06)
└─ Tap: Select this date (if not disabled)

Pill Content (VStack):
├─ Day Name:
│   ├─ Text: "Wed" or "Today" (if today)
│   ├─ Font: SF Pro Medium, 13pt
│   ├─ Color: White (selected), #0D7377 (today), #666666 (unselected)
│   └─ Position: Top, 12pt padding
│
├─ Date Number:
│   ├─ Text: "15"
│   ├─ Font: Inter SemiBold, 24pt
│   ├─ Color: White (selected), #1E1E1E (unselected)
│   └─ Position: Center
│
└─ Month:
    ├─ Text: "Jan"
    ├─ Font: SF Pro Regular, 12pt
    ├─ Color: White 80% (selected), #999999 (unselected)
    └─ Position: Bottom, 12pt padding

Badge (if applicable):
├─ Position: Top-right corner
├─ Text: "Fast" (same-day) or "Busy"
├─ Font: SF Pro Bold, 9pt
├─ Color: White
├─ Background: #FF6B35 (orange) or #FFC107 (yellow)
├─ Padding: 3pt vertical, 6pt horizontal
├─ Border Radius: 8pt
└─ Shadow: 0 1px 3px rgba(0,0,0,0.2)
```

### Select Time Slot Section
```
Position: 24pt below date pills
Padding: 20pt horizontal

Section Header:
├─ Text: "Select Time Slot"
├─ Font: Inter SemiBold, 16pt
├─ Color: #1E1E1E / #E0E0E0
└─ Margin Bottom: 16pt

Time Period Headers:
├─ Icon + Text: "🌅 Morning (6 AM - 12 PM)"
├─ Font: SF Pro SemiBold, 15pt
├─ Color: #666666 / #A0A0A0
├─ Margin Top: 20pt (between periods)
└─ Margin Bottom: 12pt

Periods:
├─ Morning: 6 AM - 12 PM
├─ Afternoon: 12 PM - 5 PM
├─ Evening: 5 PM - 9 PM
└─ Night: 9 PM - 6 AM (if applicable)

Time Slot Grid:
├─ Layout: 2 columns (LazyVGrid)
├─ Gap: 12pt horizontal, 12pt vertical
├─ Padding: 0pt (within sections)
└─ Slots: 2-hour intervals (6 AM, 8 AM, 10 AM, etc.)

Time Slot Card:
├─ Width: (390 - 40 - 12) / 2 = 169pt
├─ Height: 68pt
├─ Border Radius: 12pt
├─ Background:
│   ├─ Available: White / #2A2A2A
│   ├─ Selected: #0D7377 (brand primary)
│   ├─ Full: #F5F5F5 / #2A2A2A (disabled)
│   └─ Surge: #FFF5F0 (light orange tint)
├─ Border:
│   ├─ Available: 1pt solid #E0E0E0 / #3A3A3A
│   ├─ Selected: 2pt solid #0D7377
│   ├─ Full: 1pt solid #E0E0E0
│   └─ Surge: 2pt solid #FF6B35
├─ Shadow:
│   ├─ Available: 0 2px 6px rgba(0,0,0,0.06)
│   ├─ Selected: 0 4px 12px rgba(13,115,119,0.2)
│   └─ Full: None
└─ Tap: Select slot (if available)

Card Content (VStack):
├─ Time:
│   ├─ Text: "6:00 AM" or "2:00 PM"
│   ├─ Font: SF Pro SemiBold, 16pt
│   ├─ Color: White (selected), #1E1E1E (available), #999999 (full)
│   └─ Position: Top, 12pt padding
│
└─ Status:
    ├─ Available:
    │   ├─ Icon: checkmark.circle.fill, 14x14pt, #28C76F
    │   ├─ Text: "Available"
    │   ├─ Font: SF Pro Regular, 12pt
    │   ├─ Color: #28C76F
    │   └─ Layout: HStack, 4pt gap
    │
    ├─ Selected:
    │   ├─ Icon: checkmark.circle.fill, 14x14pt, White
    │   ├─ Text: "Selected"
    │   ├─ Color: White
    │   └─ Layout: HStack
    │
    ├─ Full:
    │   ├─ Icon: xmark.circle.fill, 14x14pt, #EA5455
    │   ├─ Text: "Full"
    │   ├─ Color: #999999
    │   └─ Non-tappable
    │
    └─ Surge Pricing (if applicable):
        ├─ Icon: arrow.up.circle.fill, 14x14pt, #FF6B35
        ├─ Text: "+₹50" (surge amount)
        ├─ Color: #FF6B35
        └─ Tooltip: "High demand time"

Checkmark (if selected):
├─ Position: Top-right corner
├─ Icon: checkmark.circle.fill
├─ Size: 24x24pt
├─ Color: #28C76F (success green) or White
└─ Background: Circle if needed for contrast
```

### Info Section
```
Position: 20pt below last time slot
Padding: 20pt horizontal
Background: #F8F8F8 / #2A2A2A
Border Radius: 12pt
Padding: 16pt
Margin: 0 20pt

Layout (HStack):
├─ Icon: info.circle.fill
│   ├─ Size: 20x20pt
│   ├─ Color: #0D7377
│   └─ Position: Top-aligned
│
└─ Text (VStack):
    ├─ "Service duration: 30-45 minutes"
    ├─ "Provider will arrive within the selected time slot"
    ├─ Font: SF Pro Regular, 13pt
    ├─ Color: #666666 / #A0A0A0
    └─ Line Height: 1.4
```

### Bottom Spacer
```
Height: 120pt
```

### Fixed Bottom CTA
```
Position: Fixed at bottom
Height: 80pt + safe area = 114pt
Background: White / #2A2A2A
Border Top: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 -4px 16px rgba(0,0,0,0.12)
Padding: 16pt horizontal, 16pt top

Button:
├─ Width: Full (358pt)
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Background:
│   ├─ Enabled: #0D7377
│   └─ Disabled: #E0E0E0
├─ Shadow:
│   ├─ Enabled: 0 4px 12px rgba(13,115,119,0.3)
│   └─ Disabled: None
└─ Tap: Navigate to Booking Summary

Text:
├─ Text: "Continue"
├─ Font: Inter SemiBold, 17pt
├─ Color: White
└─ Letter Spacing: 0.3pt

States:
├─ Disabled: No date or time selected
├─ Enabled: Both date and time selected
└─ Animation: Scale 0.98 on press

Alternative (if slot selected):
├─ Show selected date & time in button
├─ Text: "Continue • Jan 15, 8:00 AM"
└─ Makes selection clear
```

---

## Component Breakdown

### 1. Date Pill Selector
```
Component: HorizontalDateSelector
Features:
├─ Horizontal scrollable pills
├─ Snap to each date
├─ Highlight today with badge
├─ Show availability status (busy, full, etc.)
└─ Auto-scroll to today on load
```

### 2. Time Slot Card
```
Component: TimeSlotCard (reusable)
Props:
├─ slot: TimeSlot model
├─ isSelected: Bool
├─ isAvailable: Bool
├─ surgeAmount: Double? (optional)
├─ onTap: Select this slot
└─ Status variants: Available, Selected, Full, Surge

States:
├─ Available: Tappable, white background
├─ Selected: Teal background, checkmark
├─ Full: Grayed out, non-tappable
└─ Surge: Orange border, +amount shown
```

---

## Animations & Transitions

### Screen Entry
```
Duration: 400ms

Sequence:
0ms   - Screen slides in from right
100ms - Title fades in
200ms - Date pills fade in + slide left (20pt)
300ms - Time slots fade in sequentially (50ms each)
400ms - Info section fades in
```

### Date Selection
```
Trigger: Tap a date pill
Duration: 300ms

Animation:
├─ Previous date: Background teal → white, shrink slightly
├─ New date: Background white → teal, scale up (1.05)
├─ Shadow: Appears on selected
├─ Scroll: Auto-scroll to center selected date
├─ Time slots: Fade out (100ms) → update for new date → Fade in (200ms)
└─ Haptic: Light impact

Loading:
├─ Time slots show skeleton (shimmer) while fetching
└─ Duration: 500ms-1s
```

### Time Slot Selection
```
Trigger: Tap a time slot
Duration: 250ms

Animation:
├─ Previous slot: Background teal → white, border 2pt → 1pt
├─ New slot: Background white → teal, border 1pt → 2pt
├─ Checkmark: Appears with scale (0.8 → 1.0)
├─ Text color: Changes to white
├─ Shadow: Increases on selected
├─ Continue button: Enabled (gray → teal)
└─ Haptic: Medium impact
```

### Continue Button State Change
```
Trigger: Time slot selected
Duration: 200ms

Animation:
├─ Background: #E0E0E0 → #0D7377 (gradient transition)
├─ Shadow: Appears
├─ Slight scale pulse: 1.0 → 1.02 → 1.0
└─ Haptic: Success (light)
```

---

## States

### Default State (Initial)
```
Visual:
├─ Date pills: Today's date pre-selected
├─ Time slots: Loading for today's slots
├─ Continue button: Disabled (gray)
└─ Scroll: Auto-scroll to today in date list
```

### Date Selected, No Time
```
Visual:
├─ Date pill: Selected (teal)
├─ Time slots: Displayed for selected date
├─ No slot selected: All slots available state
├─ Continue button: Disabled (gray)
└─ User must select time slot
```

### Date & Time Selected (Ready)
```
Visual:
├─ Date pill: Selected (teal)
├─ Time slot: Selected (teal with checkmark)
├─ Continue button: Enabled (teal with shadow)
└─ User can proceed to booking summary
```

### Loading Slots
```
Trigger: Date changed, fetching new slots
Visual:
├─ Time slots section: Skeleton shimmer (6-8 cards)
├─ Duration: 500ms-1s
├─ Continue button: Disabled
└─ User cannot select slots until loaded
```

### No Availability
```
Trigger: Selected date has no available slots
Visual:
├─ Empty state:
│   ├─ Icon: Illustration (calendar with X)
│   ├─ Message: "No slots available on this date"
│   ├─ Subtitle: "Please choose another day"
│   └─ CTA: None (select different date)
├─ All slots: Grayed out with "Full" status
└─ Continue button: Disabled
```

### Slot Expired
```
Trigger: User stays on screen too long, slot gets booked
Visual:
├─ Alert: "This slot is no longer available. Please choose another."
├─ Selected slot: Changes to "Full" status
├─ Selection: Cleared
├─ Continue button: Disabled
└─ User: Must select new slot
```

### Surge Pricing Active
```
Trigger: High demand time slot selected
Visual:
├─ Slot card: Orange border
├─ Status: "+₹50" (surge amount)
├─ Info tooltip: "High demand time"
├─ Continue button: Shows total price (base + surge)
└─ User: Can see price impact before proceeding
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E
Top Bar: #2A2A2A
Date Pill Unselected: #2A2A2A
Date Pill Selected: #0D7377
Time Slot Available: #2A2A2A
Time Slot Selected: #0D7377
Time Slot Full: #2A2A2A (darker)
Info Section: #2A2A2A
Text Primary: #E0E0E0
Text Secondary: #A0A0A0
Border: #3A3A3A
Checkmark Green: #28C76F (same)
Full Icon Red: #EA5455 (same)
Surge Orange: #FF6B35 (same)
```

---

## Accessibility

### VoiceOver

**Labels:**
```
Back: "Back, button"
Date Pill: "Wednesday January 15th, button, selected" / "unselected"
Today Badge: "Today, January 15th"
Time Slot: "8:00 AM, available, button" / "selected, button" / "full, unavailable"
Surge Slot: "8:00 AM, available, surge pricing ₹50, button"
Info: "Service duration 30 to 45 minutes"
Continue: "Continue, button" / "disabled, button"
```

**Announcements:**
```
On date select: "January 15th selected, loading time slots"
On slots load: "6 time slots available"
On slot select: "8:00 AM selected"
On slot full: "This slot is full, please choose another"
On no availability: "No slots available on this date"
```

### Dynamic Type

**Scaling:** -2 to +3
```
Title: 20pt → 17pt (min) to 24pt (max)
Date day: 13pt → 11pt (min) to 16pt (max)
Date number: 24pt → 20pt (min) to 28pt (max)
Time slot: 16pt → 14pt (min) to 19pt (max)
Status: 12pt → 10pt (min) to 15pt (max)

Layout:
├─ At +2: Slot height 68pt → 80pt
├─ At +3: May switch to single column slots
└─ Date pill height adjusts (88pt → 100pt)
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct DateTimeSelectionView: View {
    let serviceId: String
    let addressId: String

    @StateObject private var viewModel: DateTimeViewModel
    @State private var selectedDate: Date = Date()
    @State private var selectedSlot: TimeSlot?
    @State private var isLoadingSlots: Bool = false

    init(serviceId: String, addressId: String) {
        self.serviceId = serviceId
        self.addressId = addressId
        _viewModel = StateObject(wrappedValue: DateTimeViewModel(serviceId: serviceId))
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.gray100.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Title
                    Text("When would you like the service?")
                        .font(.custom("Inter-SemiBold", size: 20))
                        .padding(.horizontal, 20)
                        .padding(.top, 72)
                        .padding(.bottom, 20)

                    // Date Selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Select Date")
                            .font(.custom("Inter-SemiBold", size: 16))
                            .padding(.horizontal, 20)

                        HorizontalDateSelector(
                            selectedDate: $selectedDate,
                            dateRange: viewModel.availableDates
                        )
                    }

                    // Time Slots
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Select Time Slot")
                            .font(.custom("Inter-SemiBold", size: 16))
                            .padding(.horizontal, 20)
                            .padding(.top, 24)

                        if isLoadingSlots {
                            TimeSlotsSkeleton()
                        } else if viewModel.timeSlots.isEmpty {
                            NoSlotsAvailableView()
                        } else {
                            TimeSlotsGrid(
                                slots: viewModel.timeSlots,
                                selectedSlot: $selectedSlot
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    // Info Section
                    InfoSection()
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                    Spacer(minLength: 120)
                }
            }

            // Top Bar
            CustomNavigationBar(
                title: "Select Date & Time",
                leftItems: [.back]
            )

            // Bottom CTA
            VStack {
                Spacer()
                FixedBottomCTA(
                    title: "Continue",
                    action: continueToBookingSummary,
                    isDisabled: selectedSlot == nil
                )
            }
        }
        .onChange(of: selectedDate) { newDate in
            loadSlotsForDate(newDate)
        }
        .onAppear {
            loadSlotsForDate(selectedDate)
        }
    }

    private func loadSlotsForDate(_ date: Date) {
        isLoadingSlots = true
        selectedSlot = nil // Clear selection

        Task {
            await viewModel.loadTimeSlots(for: date)
            isLoadingSlots = false
        }
    }

    private func continueToBookingSummary() {
        guard let slot = selectedSlot else { return }

        // Navigate to Booking Summary
        // Pass: serviceId, addressId, date, time slot
    }
}
```

---

## Assets Required

### SF Symbols
```
- chevron.left
- checkmark.circle.fill
- xmark.circle.fill
- arrow.up.circle.fill
- info.circle.fill
```

### Emojis (for time periods)
```
- 🌅 Morning
- ☀️ Afternoon
- 🌆 Evening
- 🌙 Night (if applicable)
```

---

## Navigation Flow

### Entry
```
From Address Selection → Tap "Continue"
Transition: Slide in from right
Data: { serviceId, addressId, serviceName }
```

### Exit
```
1. Continue → Booking Summary (14)
   └─ Transition: Slide in from right
   └─ Data: { serviceId, addressId, date, slotId, slotTime }

2. Back → Address Selection
   └─ Transition: Slide out to right (pop)
```

---

## Testing Checklist

- [ ] Date pills scroll and snap correctly
- [ ] Today's date highlighted
- [ ] Date selection works
- [ ] Time slots load for selected date
- [ ] Time slot selection works
- [ ] Full slots are non-tappable
- [ ] Surge pricing displays correctly
- [ ] Continue button enables/disables correctly
- [ ] Slot expiration handled
- [ ] No availability state shows
- [ ] Info section displays correctly
- [ ] Dark mode renders correctly
- [ ] VoiceOver works
- [ ] Dynamic Type scales
- [ ] Works on all devices

---

## Analytics

```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "date_time_selection",
    "service_id": serviceId
])

Analytics.logEvent("date_selected", parameters: [
    "date": selectedDate.formatted(),
    "is_today": Calendar.current.isDateInToday(selectedDate),
    "days_from_today": daysBetween
])

Analytics.logEvent("time_slot_selected", parameters: [
    "slot_time": selectedSlot.time,
    "slot_period": selectedSlot.period, // "morning", "afternoon", etc.
    "is_surge": selectedSlot.hasSurge
])

Analytics.logEvent("continue_tapped", parameters: [
    "date": selectedDate.formatted(),
    "time": selectedSlot.time
])
```

---

**This date & time screen must show clear availability, make selection easy, and handle edge cases like slot expiration gracefully.**
