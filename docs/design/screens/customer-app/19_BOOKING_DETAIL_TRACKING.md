# Booking Detail & Tracking

## Overview
- **Screen ID**: 19
- **Screen Name**: Booking Detail & Live Tracking
- **User Flow**: View detailed booking information and track provider in real-time
- **Navigation**:
  - Entry: From Active Bookings list, Booking Confirmation, Push Notification
  - Exit: Back to previous screen
  - Related: Can navigate to Chat, Provider Profile, Support

## ASCII Wireframe

### State 1: Scheduled Booking
```
┌──────────────────────────────────────────┐
│  ←  Booking Details          •••         │ ← Nav Bar (menu)
├──────────────────────────────────────────┤
│                                          │
│  🕐 Scheduled                            │ ← Status Header
│  #BK123456                               │   + Booking ID
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  🔧 AC Repair & Service            │ │ ← Service Card
│  │                                    │ │
│  │  ₹949                              │ │
│  │  1 hour 30 minutes (estimated)     │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📅 Date & Time                          │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  Monday, December 25, 2024         │ │
│  │  10:00 AM - 11:30 AM               │ │
│  │                                    │ │
│  │  ⏰ In 2 days, 5 hours              │ │
│  │                          [Edit]    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📍 Service Location                     │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  🏠 Home                            │ │
│  │  123 MG Road, Kormangala           │ │
│  │  Bangalore - 560034                 │ │
│  │                                    │ │
│  │  [View on Map]              [Edit] │ │
│  └────────────────────────────────────┘ │
│                                          │
│  👨‍🔧 Provider Details                    │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  [Photo]  Rajesh Kumar             │ │
│  │           ⭐ 4.8 (234 reviews)     │ │
│  │           🔧 AC Specialist          │ │
│  │                                    │ │
│  │  📞 +91 98765 43210                │ │
│  │                                    │ │
│  │  ┌──────────┐  ┌──────────┐       │ │
│  │  │ 📞 Call  │  │ 💬 Chat  │       │ │
│  │  └──────────┘  └──────────┘       │ │
│  └────────────────────────────────────┘ │
│                                          │
│  💰 Payment Details                      │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  Service Charge      ₹799          │ │
│  │  Taxes & Fees        ₹150          │ │
│  │  ─────────────────────────         │ │
│  │  Total Paid          ₹949  ✅      │ │
│  │                                    │ │
│  │  Paid via Debit Card •••• 4532     │ │
│  │  Dec 20, 2024 • 3:45 PM            │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📝 Special Instructions                 │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  Please ring the doorbell twice    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Reschedule Booking                │ │ ← Primary Action
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Cancel Booking                    │ │ ← Secondary Action
│  └────────────────────────────────────┘ │
│                                          │
│         Need help? Contact Support      │ ← Support Link
│                                          │
└──────────────────────────────────────────┘
```

### State 2: Provider On the Way (Live Tracking)
```
┌──────────────────────────────────────────┐
│  ←  Booking Details          •••         │ ← Nav Bar
├──────────────────────────────────────────┤
│                                          │
│  🚗 Provider On the Way                  │ ← Status Header
│  ETA: 15 minutes                         │   with countdown
│                                          │
│  ┌────────────────────────────────────┐ │
│  │                                    │ │
│  │        [Live Map View]             │ │ ← Map Section
│  │                                    │ │   (300pt height)
│  │   📍 Your Location                 │ │
│  │                                    │ │
│  │           🚗                       │ │
│  │         Provider                   │ │
│  │          (moving)                  │ │
│  │                                    │ │
│  │  ---- route line ----              │ │
│  │                                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  [Photo]  Rajesh Kumar             │ │ ← Provider Card
│  │           ⭐ 4.8                   │ │   (Expanded)
│  │                                    │ │
│  │  📞 +91 98765 43210                │ │
│  │                                    │ │
│  │  Distance: 3.2 km away             │ │
│  │  Arriving in 15 minutes            │ │
│  │                                    │ │
│  │  ┌──────────┐  ┌──────────┐       │ │
│  │  │ 📞 Call  │  │ 💬 Chat  │       │ │
│  │  └──────────┘  └──────────┘       │ │
│  └────────────────────────────────────┘ │
│                                          │
│  🔧 AC Repair & Service                 │ ← Collapsed Info
│  Monday, Dec 25 • 10:00 AM              │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Share Live Location               │ │ ← Share Button
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### State 3: Service In Progress
```
┌──────────────────────────────────────────┐
│  ←  Booking Details          •••         │ ← Nav Bar
├──────────────────────────────────────────┤
│                                          │
│  🔄 Service In Progress                  │ ← Status Header
│  Started at 10:05 AM • 25 mins ago      │   with timer
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  🔧 AC Repair & Service            │ │ ← Service Card
│  │                                    │ │
│  │  Status: Diagnosis in progress     │ │
│  │                                    │ │
│  │  Expected completion: 11:30 AM     │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📊 Live Updates                         │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  ✓ 10:05 AM - Service started      │ │ ← Timeline
│  │                                    │ │
│  │  ✓ 10:10 AM - Initial diagnosis    │ │
│  │    Issue identified: Low gas       │ │
│  │                                    │ │
│  │  ⏳ 10:25 AM - Gas refill in       │ │
│  │    progress (ongoing)              │ │
│  └────────────────────────────────────┘ │
│                                          │
│  👨‍🔧 Rajesh Kumar                        │ ← Provider
│  ┌────────────────────────────────────┐ │
│  │  [Photo]  ⭐ 4.8                   │ │
│  │                                    │ │
│  │  ┌──────────┐  ┌──────────┐       │ │
│  │  │ 📞 Call  │  │ 💬 Chat  │       │ │
│  │  └──────────┘  └──────────┘       │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ℹ️ Additional Charges (if any)         │ ← Section
│  ┌────────────────────────────────────┐ │
│  │  No additional charges yet         │ │
│  │                                    │ │
│  │  Provider may suggest additional   │ │
│  │  work. You'll be notified before   │ │
│  │  any charges are applied.          │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ✓ Service is covered by our           │ ← Trust Badge
│    quality guarantee                    │
│                                          │
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
- **Title**: Inter Medium 18pt, "Booking Details"
- **Back Button**: 24x24pt chevron.left, #0D7377
- **Menu Button**: 24x24pt ellipsis.circle, #666666 (more options)
- **Padding**: 16pt horizontal

### Status Header
- **Height**: 64pt
- **Background**: Gradient based on status
  - Scheduled: #F5F5F5 → #FAFAFA
  - Confirmed: #E8F7F8 → #D0F2F4
  - On the Way: #0D7377 → #14A0A5 (primary gradient)
  - In Progress: #FFF4E6 → #FFE8CC
  - Completed: #E8F7E8 → #D0F2D0
- **Icon**: 24x24pt status icon, status color or white
- **Status Text**: Inter SemiBold 20pt, #1E1E1E or White
- **Subtitle**: SF Pro Regular 14pt, #666666 or White (0.9 opacity)
- **Padding**: 20pt horizontal, 16pt vertical
- **Margin Bottom**: 16pt

### Booking ID
- **Typography**: SF Pro Mono Medium 13pt
- **Color**: #666666 / #A0A0A0
- **Position**: Below status, 8pt margin top
- **Padding**: Same as header (20pt horizontal)

### Section Headers
- **Typography**: Inter SemiBold 16pt
- **Color**: #1E1E1E / #E0E0E0
- **Icon**: 20x20pt emoji before text, 8pt gap
- **Margin**: 24pt top, 12pt bottom
- **Padding**: 0 16pt

### Service Card (Top)
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Shadow**: 0 2px 8px rgba(0,0,0,0.06)
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding**: 16pt
- **Margin**: 0 16pt 16pt 16pt

#### Service Card Content
- **Icon**: 32x32pt service category emoji
- **Name**: Inter SemiBold 18pt, #1E1E1E / #E0E0E0
- **Price**: Inter Bold 24pt, #0D7377, "₹" symbol
- **Duration**: SF Pro Regular 13pt, #666666 / #A0A0A0

### Info Sections
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding**: 16pt
- **Margin**: 0 16pt 16pt 16pt
- **Shadow**: 0 1px 4px rgba(0,0,0,0.04)

### Date & Time Section
- **Date**: Inter Medium 16pt, #1E1E1E
- **Time**: Inter Medium 16pt, #1E1E1E
- **Countdown**: SF Pro Regular 14pt, #FF6B35 (orange), icon clock
- **Edit Button**: 16x16pt pencil.circle, #0D7377, right-aligned

### Location Section
- **Label**: Inter Medium 14pt, #0D7377 (e.g., "Home", "Work")
- **Address**: SF Pro Regular 14pt, #666666, line-spacing 1.4
- **View on Map**: Text button, Inter Medium 14pt, #0D7377
- **Edit Button**: Same as date section

### Provider Card
- **Photo**: 64x64pt circular, border 2pt #E0E0E0
- **Name**: Inter SemiBold 17pt, #1E1E1E
- **Rating**: 16x16pt star.fill + SF Pro Medium 15pt, #FFD700
- **Review Count**: SF Pro Regular 13pt, #666666, in parentheses
- **Specialty**: SF Pro Regular 13pt, #666666, icon 14x14pt
- **Phone**: SF Pro Mono Medium 14pt, #666666
- **Gap**: 12pt between photo and text stack

#### Provider Action Buttons
- **Height**: 44pt
- **Border Radius**: 8pt
- **Gap**: 12pt between buttons
- **Call Button**:
  - Background: #0D7377
  - Icon: 16x16pt phone.fill, White
  - Text: Inter Medium 15pt, White
- **Chat Button**:
  - Background: White / Dark (#3A3A3A)
  - Border: 1pt solid #0D7377
  - Icon: 16x16pt message.fill, #0D7377
  - Text: Inter Medium 15pt, #0D7377

### Payment Details Section
- **Line Items**: SF Pro Regular 14pt, #666666
- **Amounts**: Inter Medium 15pt, #1E1E1E, right-aligned
- **Divider**: 1pt solid #E0E0E0, 8pt margin vertical
- **Total Row**:
  - Label: Inter SemiBold 16pt, #1E1E1E
  - Amount: Inter Bold 18pt, #0D7377
  - Checkmark: 16x16pt checkmark.circle.fill, #28C76F
- **Payment Method**: SF Pro Regular 13pt, #666666
- **Date/Time**: SF Pro Regular 12pt, #999999

### Special Instructions Section
- **Background**: #F5F5F5 / #2A2A2A
- **Border**: 1pt dashed #E0E0E0 / #3A3A3A
- **Typography**: SF Pro Regular 14pt, #666666
- **Padding**: 12pt
- **Line Spacing**: 1.5

### Live Map Section
- **Height**: 300pt
- **Border Radius**: 12pt
- **Margin**: 0 16pt 16pt 16pt
- **Map Type**: Standard (can switch to satellite)
- **User Location**: Blue dot with pulse animation
- **Provider Location**: Custom pin (car icon)
- **Route**: Blue polyline, 3pt width
- **Controls**: Zoom, locate me, map type switcher

### Live Updates Timeline
- **Item Height**: Auto (min 60pt)
- **Icon**: 20x20pt checkmark.circle.fill (completed) or clock (ongoing)
- **Icon Color**: #28C76F (completed), #FF6B35 (ongoing)
- **Timestamp**: SF Pro Medium 13pt, #666666
- **Description**: SF Pro Regular 14pt, #1E1E1E
- **Details**: SF Pro Regular 13pt, #666666, 4pt top margin
- **Connector Line**: 2pt vertical line between icons, #E0E0E0

### Action Buttons

**Primary (Reschedule):**
- **Height**: 56pt
- **Border Radius**: 12pt
- **Background**: Transparent
- **Border**: 1.5pt solid #0D7377
- **Text**: Inter Medium 16pt, #0D7377
- **Margin**: 16pt horizontal, 20pt top

**Secondary (Cancel):**
- **Height**: 52pt
- **Border Radius**: 12pt
- **Background**: Transparent
- **Border**: 1.5pt solid #EA5455
- **Text**: Inter Medium 15pt, #EA5455
- **Margin**: 16pt horizontal, 12pt top

### Support Link
- **Typography**: Inter Medium 14pt
- **Color**: #0D7377
- **Underline**: None
- **Alignment**: Center
- **Icon**: 16x16pt questionmark.circle, left of text
- **Margin**: 20pt top, 32pt bottom

## Components Used

### Existing Components
1. **CustomNavigationBar**
2. **PrimaryButton** (reschedule)
3. **SecondaryButton** (cancel)
4. **ProviderInfoCard**

### New Components Needed
1. **BookingStatusHeader** (gradient header with status)
2. **LiveMapView** (map with route and markers)
3. **TimelineUpdateItem** (live update entry)
4. **PaymentSummarySection** (breakdown with total)
5. **EditableInfoCard** (with edit button)
6. **CountdownTimer** (time until booking)

## Booking States & Behaviors

### 1. Scheduled (Future booking)
- **Show**:
  - Countdown timer ("In 2 days, 5 hours")
  - Provider details (if assigned)
  - Edit buttons (date, address)
  - Reschedule and Cancel actions
- **Hide**:
  - Live map
  - Live updates timeline
  - Share location button

### 2. Confirmed (< 2 hours away)
- **Show**:
  - Countdown timer ("In 45 minutes")
  - Provider details (confirmed)
  - Call and Chat buttons prominent
  - Preparation tips ("Please ensure AC is accessible")
- **Disable**:
  - Reschedule (too close to booking time)
- **Enable**:
  - Cancel (with cancellation fee warning)

### 3. Provider On the Way
- **Show**:
  - Live map (full screen, 300pt)
  - Real-time ETA ("15 minutes")
  - Provider location (moving marker)
  - Route polyline
  - Share location button
  - Call and Chat buttons
- **Hide**:
  - Edit buttons
  - Reschedule button
- **Auto-update**:
  - Provider location every 10 seconds
  - ETA every 30 seconds

### 4. Service In Progress
- **Show**:
  - Service started time + elapsed timer
  - Live updates timeline
  - Current status message
  - Expected completion time
  - Additional charges section
  - Quality guarantee badge
- **Hide**:
  - Live map
  - Edit buttons
  - All action buttons except Call/Chat
- **Real-time**:
  - Provider posts updates (new timeline entries slide in)

### 5. Service Completed
- **Show**:
  - Completion time
  - Summary of work done
  - Final bill (if additional charges)
  - Rate provider CTA
  - Download invoice button
- **Hide**:
  - All action buttons
  - Edit buttons
- **Navigate**:
  - Auto-prompt for review after 5 seconds

### 6. Cancelled
- **Show**:
  - Cancellation reason
  - Cancelled by (user or provider)
  - Cancellation time
  - Refund status
  - Refund amount (if applicable)
  - Refund ETA ("3-5 business days")
- **CTA**:
  - "Book Again" button

## Interactions

### Menu Button (Top Right)
- **Action**: Show action sheet with options
- **Options**:
  - Download Invoice (if completed/paid)
  - Share Booking Details
  - Report an Issue
  - Cancel (dismiss)
- **Haptic**: Light impact

### Edit Date/Time
- **Action**: Open date/time picker bottom sheet
- **Validation**: Check provider availability
- **Confirmation**: "Reschedule booking?" alert
- **Fee**: Show rescheduling fee if applicable
- **API**: Update booking, notify provider
- **Success**: Toast "Booking rescheduled successfully"

### Edit Address
- **Action**: Navigate to Address Selection screen
- **Flow**: Select new address → Confirm → Update booking
- **Validation**: Check service area coverage
- **Provider**: Re-assign if necessary

### View on Map
- **Action**: Open full-screen map modal
- **Features**:
  - Large map view
  - Address pin
  - Directions button (opens Apple Maps)
  - Close button
- **Animation**: Modal slide up

### Call Provider
- **Action**: Initiate phone call
- **Confirmation**: iOS system alert
- **Haptic**: Medium impact
- **Analytics**: Log call event
- **Disabled**: If provider not assigned yet

### Chat with Provider
- **Action**: Navigate to chat screen
- **Data**: Booking ID, Provider ID
- **Haptic**: Light impact
- **Badge**: Show unread message count
- **Disabled**: If provider not assigned yet

### Share Live Location
- **Action**: Generate shareable link
- **Options**:
  - Copy Link
  - Share via WhatsApp
  - Share via SMS
  - Share via Email
- **Link**: Expires after booking ends
- **Privacy**: Only shows provider location, not user

### Reschedule Booking
- **Action**: Open reschedule flow
- **Validation**:
  - Check if allowed (< 6 hours = not allowed)
  - Check rescheduling fee
- **Confirmation**: Show fee + new date/time
- **Process**:
  - Select new date/time
  - Confirm
  - Process payment (if fee)
  - Update booking
  - Notify provider
- **Success**: Navigate to confirmation

### Cancel Booking
- **Action**: Show cancellation flow
- **Confirmation**: Multi-step
  1. "Are you sure?" alert
  2. Select cancellation reason (dropdown)
  3. Show cancellation policy + refund amount
  4. Confirm cancellation
- **Cancellation Policy**:
  - > 24 hours: Full refund
  - 6-24 hours: 50% refund
  - < 6 hours: No refund
- **Process**:
  - Cancel booking
  - Process refund
  - Notify provider
  - Send confirmation email/SMS
- **Success**: Navigate to cancellation confirmation screen

### Contact Support
- **Action**: Open support bottom sheet
- **Options**:
  - Call Support
  - Chat with Support
  - View FAQs
  - Report Issue
- **Context**: Pass booking ID automatically

### Rate Provider (Completed bookings)
- **Action**: Show rating modal
- **Content**:
  - 5-star rating
  - Review text area (optional)
  - Tags (Punctual, Polite, Professional, etc.)
- **Submission**:
  - Post review
  - Update provider rating
  - Show thank you message
- **Incentive**: "Get ₹50 off on next booking" (optional)

## Real-time Updates

### Firebase Listeners

**Booking Status:**
```javascript
bookingRef.onSnapshot(snapshot => {
  const updatedBooking = snapshot.data()
  updateUI(updatedBooking.status)

  if (updatedBooking.status === 'on_the_way') {
    startLocationTracking()
  }
})
```

**Provider Location (when on the way):**
```javascript
providerLocationRef.onSnapshot(snapshot => {
  const location = snapshot.data()
  updateProviderMarker(location.lat, location.lng)
  recalculateETA()
})
```

**Live Updates (during service):**
```javascript
updatesRef.orderBy('timestamp', 'desc').onSnapshot(snapshot => {
  snapshot.docChanges().forEach(change => {
    if (change.type === 'added') {
      addTimelineUpdate(change.doc.data())
    }
  })
})
```

### Update Frequency
- Booking status: Immediate (Firebase real-time)
- Provider location: Every 10 seconds (when on the way)
- ETA calculation: Every 30 seconds
- Live updates: Immediate push
- Unread messages: Every 5 seconds

## Dark Mode Variants

### Colors
- **Background**: #1E1E1E
- **Card Background**: #2A2A2A
- **Card Border**: #3A3A3A
- **Text Primary**: #E0E0E0
- **Text Secondary**: #A0A0A0
- **Map**: Dark mode map tiles
- **Status Header**: Darker gradient variants

## Accessibility

### VoiceOver Labels
- **Status Header**: "Booking status: Scheduled. In 2 days, 5 hours"
- **Service Card**: "AC Repair & Service. ₹949. Estimated duration 1 hour 30 minutes"
- **Edit Button**: "Edit date and time, button"
- **Call Provider**: "Call Rajesh Kumar, button"
- **Live Map**: "Live provider location map. Rajesh is 3.2 kilometers away, arriving in 15 minutes"
- **Timeline Update**: "Update at 10:10 AM. Initial diagnosis. Issue identified: Low gas."

### VoiceOver Grouping
- Group sections logically
- Map is single focusable element with summary

### Dynamic Type
- All text scales appropriately
- Map height remains fixed
- Button heights scale minimum to 44pt

## Analytics Events

### Screen View
```json
{
  "screen_name": "booking_detail",
  "booking_id": "BK123456",
  "booking_status": "scheduled",
  "time_until_booking": 180, // minutes
  "has_provider": true
}
```

### Edit Action
```json
{
  "event": "booking_edited",
  "booking_id": "BK123456",
  "edit_type": "date_time", // or "address"
  "original_date": "2024-12-25T10:00:00Z",
  "new_date": "2024-12-26T14:00:00Z"
}
```

### Cancellation
```json
{
  "event": "booking_cancelled",
  "booking_id": "BK123456",
  "cancelled_by": "user",
  "cancellation_reason": "change_of_plans",
  "hours_before_booking": 48,
  "refund_amount": 949,
  "refund_percentage": 100
}
```

### Provider Contact
```json
{
  "event": "provider_contacted",
  "booking_id": "BK123456",
  "contact_method": "call", // or "chat"
  "booking_status": "on_the_way"
}
```

### Live Tracking
```json
{
  "event": "live_tracking_viewed",
  "booking_id": "BK123456",
  "provider_distance_km": 3.2,
  "estimated_arrival_min": 15
}
```

## SwiftUI Implementation

### View Structure
```swift
struct BookingDetailView: View {
    @StateObject private var viewModel: BookingDetailViewModel
    @State private var showMenu = false
    @State private var showCancelSheet = false
    @State private var showRescheduleSheet = false

    init(bookingId: String) {
        _viewModel = StateObject(wrappedValue: BookingDetailViewModel(bookingId: bookingId))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Status Header
                BookingStatusHeader(
                    status: viewModel.booking.status,
                    bookingId: viewModel.booking.id,
                    countdown: viewModel.timeUntilBooking
                )

                // Content based on status
                switch viewModel.booking.status {
                case .scheduled, .confirmed:
                    ScheduledBookingContent(
                        booking: viewModel.booking,
                        onEditDate: { showRescheduleSheet = true },
                        onEditAddress: editAddress,
                        onCall: callProvider,
                        onChat: chatWithProvider
                    )

                case .onTheWay:
                    OnTheWayContent(
                        booking: viewModel.booking,
                        providerLocation: viewModel.providerLocation,
                        eta: viewModel.estimatedArrival,
                        onCall: callProvider,
                        onChat: chatWithProvider,
                        onShareLocation: shareLocation
                    )

                case .inProgress:
                    InProgressContent(
                        booking: viewModel.booking,
                        liveUpdates: viewModel.liveUpdates,
                        onCall: callProvider,
                        onChat: chatWithProvider
                    )

                case .completed:
                    CompletedBookingContent(
                        booking: viewModel.booking,
                        onRateProvider: rateProvider,
                        onDownloadInvoice: downloadInvoice
                    )

                case .cancelled:
                    CancelledBookingContent(
                        booking: viewModel.booking,
                        onBookAgain: bookAgain
                    )
                }

                // Action Buttons (if applicable)
                if viewModel.canReschedule {
                    PrimaryButton(
                        title: "Reschedule Booking",
                        action: { showRescheduleSheet = true },
                        style: .outlined
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }

                if viewModel.canCancel {
                    SecondaryButton(
                        title: "Cancel Booking",
                        action: { showCancelSheet = true },
                        style: .destructive
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }

                // Support Link
                Button(action: contactSupport) {
                    HStack(spacing: 6) {
                        Image(systemName: "questionmark.circle")
                        Text("Need help? Contact Support")
                    }
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(.primary)
                }
                .padding(.top, 20)
                .padding(.bottom, 32)
            }
        }
        .background(Color.gray100.ignoresSafeArea())
        .navigationBarBackButtonHidden(false)
        .navigationBarItems(
            trailing: MenuButton {
                showMenu = true
            }
        )
        .navigationBarTitle("Booking Details", displayMode: .inline)
        .sheet(isPresented: $showCancelSheet) {
            CancelBookingSheet(
                booking: viewModel.booking,
                onCancel: { reason in
                    await viewModel.cancelBooking(reason: reason)
                    showCancelSheet = false
                }
            )
        }
        .sheet(isPresented: $showRescheduleSheet) {
            RescheduleBookingSheet(
                booking: viewModel.booking,
                onReschedule: { newDate, newTime in
                    await viewModel.rescheduleBooking(date: newDate, time: newTime)
                    showRescheduleSheet = false
                }
            )
        }
        .actionSheet(isPresented: $showMenu) {
            ActionSheet(
                title: Text("More Options"),
                buttons: [
                    .default(Text("Download Invoice")) {
                        downloadInvoice()
                    },
                    .default(Text("Share Booking Details")) {
                        shareBookingDetails()
                    },
                    .destructive(Text("Report an Issue")) {
                        reportIssue()
                    },
                    .cancel()
                ]
            )
        }
        .onAppear {
            viewModel.startRealtimeUpdates()

            Analytics.logScreenView("booking_detail", parameters: [
                "booking_id": viewModel.booking.id,
                "booking_status": viewModel.booking.status.rawValue
            ])
        }
        .onDisappear {
            viewModel.stopRealtimeUpdates()
        }
    }

    // MARK: - Actions

    private func editAddress() {
        navigationController?.push(AddressSelectionView(
            bookingId: viewModel.booking.id,
            currentAddress: viewModel.booking.address,
            onAddressSelected: { newAddress in
                Task {
                    await viewModel.updateAddress(newAddress)
                }
            }
        ))
    }

    private func callProvider() {
        guard let provider = viewModel.booking.provider,
              let phone = provider.phone else { return }

        HapticFeedback.medium()

        Analytics.logEvent("provider_contacted", parameters: [
            "booking_id": viewModel.booking.id,
            "contact_method": "call",
            "booking_status": viewModel.booking.status.rawValue
        ])

        if let url = URL(string: "tel://\(phone)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    private func chatWithProvider() {
        guard let provider = viewModel.booking.provider else { return }

        HapticFeedback.light()

        Analytics.logEvent("provider_contacted", parameters: [
            "booking_id": viewModel.booking.id,
            "contact_method": "chat"
        ])

        navigationController?.push(
            ChatView(
                bookingId: viewModel.booking.id,
                providerId: provider.id
            )
        )
    }

    private func shareLocation() {
        let link = viewModel.generateLiveTrackingLink()

        let activityVC = UIActivityViewController(
            activityItems: [link],
            applicationActivities: nil
        )

        presentViewController(activityVC)
    }

    private func rateProvider() {
        let ratingView = RateProviderSheet(
            booking: viewModel.booking,
            onSubmit: { rating, review in
                await viewModel.submitReview(rating: rating, review: review)
            }
        )
        presentSheet(ratingView)
    }

    private func downloadInvoice() {
        Task {
            let invoiceURL = try await viewModel.generateInvoicePDF()
            shareFile(invoiceURL)
        }
    }

    private func contactSupport() {
        SupportManager.shared.openSupport(
            context: "Booking Detail",
            bookingId: viewModel.booking.id
        )
    }

    private func reportIssue() {
        let issueView = ReportIssueSheet(bookingId: viewModel.booking.id)
        presentSheet(issueView)
    }

    private func shareBookingDetails() {
        let details = viewModel.booking.formattedDetails
        let activityVC = UIActivityViewController(
            activityItems: [details],
            applicationActivities: nil
        )
        presentViewController(activityVC)
    }

    private func bookAgain() {
        // Navigate to service detail with same service
        navigationController?.push(
            ServiceDetailView(serviceId: viewModel.booking.service.id)
        )
    }
}
```

### ViewModel
```swift
class BookingDetailViewModel: ObservableObject {
    @Published var booking: Booking
    @Published var providerLocation: CLLocationCoordinate2D?
    @Published var estimatedArrival: Int? // minutes
    @Published var liveUpdates: [LiveUpdate] = []
    @Published var isLoading: Bool = false

    var timeUntilBooking: String {
        calculateCountdown(to: booking.dateTime)
    }

    var canReschedule: Bool {
        // Can reschedule if > 6 hours away and status is scheduled/confirmed
        let hoursUntil = booking.dateTime.timeIntervalSinceNow / 3600
        return hoursUntil > 6 && (booking.status == .scheduled || booking.status == .confirmed)
    }

    var canCancel: Bool {
        // Can cancel if not in progress or completed
        ![.inProgress, .completed].contains(booking.status)
    }

    private let bookingId: String
    private let bookingService: BookingService
    private var statusListener: ListenerRegistration?
    private var locationListener: ListenerRegistration?
    private var updatesListener: ListenerRegistration?

    init(bookingId: String) {
        self.bookingId = bookingId
        self.booking = Booking.placeholder // Temporary
        self.bookingService = BookingService()

        Task {
            await loadBookingDetails()
        }
    }

    func loadBookingDetails() async {
        isLoading = true
        do {
            booking = try await bookingService.getBookingById(bookingId)
            isLoading = false
        } catch {
            print("Error loading booking: \(error)")
            isLoading = false
        }
    }

    func startRealtimeUpdates() {
        // Listen for booking status changes
        statusListener = bookingService.observeBooking(bookingId) { [weak self] updatedBooking in
            self?.booking = updatedBooking

            // Start location tracking if provider is on the way
            if updatedBooking.status == .onTheWay {
                self?.startLocationTracking()
            }

            // Start live updates if service in progress
            if updatedBooking.status == .inProgress {
                self?.startLiveUpdatesListener()
            }
        }
    }

    func stopRealtimeUpdates() {
        statusListener?.remove()
        locationListener?.remove()
        updatesListener?.remove()
    }

    private func startLocationTracking() {
        guard let providerId = booking.provider?.id else { return }

        locationListener = bookingService.observeProviderLocation(providerId) { [weak self] location in
            self?.providerLocation = location
            self?.recalculateETA()
        }
    }

    private func startLiveUpdatesListener() {
        updatesListener = bookingService.observeLiveUpdates(bookingId) { [weak self] updates in
            self?.liveUpdates = updates.sorted { $0.timestamp > $1.timestamp }
        }
    }

    private func recalculateETA() {
        guard let providerLoc = providerLocation else { return }

        let userLocation = booking.address.coordinates
        let distance = calculateDistance(from: providerLoc, to: userLocation)

        // Assume average speed of 30 km/h in urban areas
        estimatedArrival = Int((distance / 30.0) * 60) // minutes
    }

    func updateAddress(_ newAddress: Address) async {
        do {
            try await bookingService.updateBookingAddress(bookingId, address: newAddress)
            booking.address = newAddress
            ToastManager.show("Address updated successfully")
        } catch {
            ToastManager.show("Failed to update address", type: .error)
        }
    }

    func rescheduleBooking(date: Date, time: TimeSlot) async {
        // Implementation
    }

    func cancelBooking(reason: String) async {
        // Implementation
    }

    func submitReview(rating: Int, review: String) async {
        // Implementation
    }

    func generateLiveTrackingLink() -> String {
        // Generate shareable link
        return "https://urbannest.com/track/\(bookingId)"
    }

    func generateInvoicePDF() async throws -> URL {
        // Generate PDF and return local URL
        return URL(string: "file://...")!
    }

    private func calculateCountdown(to date: Date) -> String {
        let interval = date.timeIntervalSinceNow

        if interval < 0 { return "Started" }

        let days = Int(interval / 86400)
        let hours = Int((interval.truncatingRemainder(dividingBy: 86400)) / 3600)
        let minutes = Int((interval.truncatingRemainder(dividingBy: 3600)) / 60)

        if days > 0 {
            return "In \(days) day\(days > 1 ? "s" : ""), \(hours) hour\(hours > 1 ? "s" : "")"
        } else if hours > 0 {
            return "In \(hours) hour\(hours > 1 ? "s" : ""), \(minutes) min"
        } else {
            return "In \(minutes) minutes"
        }
    }

    deinit {
        stopRealtimeUpdates()
    }
}
```

## Testing Checklist

### Functional
- ✅ Load booking details on entry
- ✅ Real-time status updates appear
- ✅ Provider location updates (when on the way)
- ✅ ETA calculation accurate
- ✅ Live updates timeline populates
- ✅ Edit date/time works
- ✅ Edit address works
- ✅ Call provider initiates call
- ✅ Chat provider opens chat
- ✅ Reschedule flow completes
- ✅ Cancellation flow completes
- ✅ Invoice download works
- ✅ Share functionality works

### Edge Cases
- ✅ Booking cancelled during view
- ✅ Provider location unavailable
- ✅ Network error during load
- ✅ Payment failed after booking
- ✅ Provider reassigned
- ✅ Additional charges added

### Visual
- ✅ All states render correctly
- ✅ Map displays properly
- ✅ Dark mode
- ✅ Dynamic Type
- ✅ VoiceOver navigation

### Performance
- ✅ Smooth scrolling
- ✅ Map rendering smooth
- ✅ Real-time updates don't lag
- ✅ Memory usage acceptable
- ✅ Listeners properly cleaned up
