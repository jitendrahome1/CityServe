# Booking Confirmation

## Overview
- **Screen ID**: 17
- **Screen Name**: Booking Confirmation
- **User Flow**: Final screen after successful payment - confirms booking created
- **Navigation**:
  - Entry: From Payment Processing (on payment success)
  - Exit: To Home or Booking Detail
  - Back: Disabled (cannot go back)

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│                                     ✕    │ ← Close Button (top right)
├──────────────────────────────────────────┤
│                                          │
│              ✅                          │ ← Success Animation
│                                          │
│         Booking Confirmed!               │ ← Main Heading
│                                          │
│         Your service is scheduled        │ ← Subheading
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  📦  AC Repair & Service           │ │ ← Service Card
│  │                                    │ │
│  │  📅  Monday, Dec 25, 2024          │ │
│  │  ⏰  10:00 AM - 11:00 AM           │ │
│  │                                    │ │
│  │  📍  Home                          │ │
│  │      123 MG Road, Kormangala       │ │
│  │      Bangalore - 560034            │ │
│  │                                    │ │
│  │  💰  ₹949                          │ │
│  │      Paid via Debit Card           │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Booking ID: #BK123456                  │ ← Booking Reference
│                                          │
│  👨‍🔧 Provider Details                    │ ← Section Header
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  [Photo]  Rajesh Kumar             │ │ ← Provider Card
│  │           ⭐ 4.8 (234 reviews)     │ │
│  │           🔧 AC Specialist          │ │
│  │                                    │ │
│  │           📞 Call    💬 Chat       │ │ ← Action Buttons
│  └────────────────────────────────────┘ │
│                                          │
│  📋 What happens next?                  │ ← Timeline Section
│                                          │
│  ✓ Provider will arrive at your         │
│    location on scheduled time            │
│                                          │
│  ✓ You'll receive updates via SMS       │
│    and notifications                     │
│                                          │
│  ✓ You can track your booking in        │
│    "My Bookings" section                 │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  📅 Add to Calendar                │ │ ← Add to Calendar
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  View Booking Details              │ │ ← Primary CTA
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Back to Home                      │ │ ← Secondary CTA
│  └────────────────────────────────────┘ │
│                                          │
│         Need help? Contact Support      │ ← Support Link
│                                          │
└──────────────────────────────────────────┘
```

## Layout Specifications

### Dimensions
- **Screen Width**: 390pt (iPhone 14)
- **Safe Area Top**: 47pt (status bar + notch)
- **Safe Area Bottom**: 34pt (home indicator)
- **Content Width**: 358pt (16pt padding each side)
- **Background**: White (#FFFFFF) / Dark (#1E1E1E)

### Close Button
- **Position**: Top-right corner
- **Size**: 44x44pt (touch target)
- **Icon**: 24x24pt xmark, #666666
- **Action**: Navigate to Home screen
- **Padding**: 8pt from top-right edge

### Success Animation
- **Icon**: checkmark.circle.fill
- **Size**: 100x100pt
- **Color**: #28C76F (success green)
- **Animation**:
  - Entry: Scale from 0 to 1, spring animation (0.6s)
  - Checkmark: Draw path animation inside circle (0.4s, delayed 0.2s)
  - Confetti: Optional particle effect around icon (0.8s)
- **Position**: Center horizontally, 80pt from top
- **Margin Bottom**: 24pt

### Main Heading
- **Typography**: Inter Bold 28pt
- **Color**: #1E1E1E / #E0E0E0 (dark mode)
- **Alignment**: Center
- **Margin Bottom**: 8pt
- **Animation**: Fade in + slide up, 0.4s delay

### Subheading
- **Typography**: SF Pro Regular 16pt
- **Color**: #666666 / #A0A0A0 (dark mode)
- **Alignment**: Center
- **Margin Bottom**: 32pt
- **Animation**: Fade in + slide up, 0.5s delay

### Booking Summary Card
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Border Radius**: 16pt
- **Shadow**: 0 4px 12px rgba(0,0,0,0.08)
- **Padding**: 20pt
- **Margin**: 0 16pt 20pt 16pt
- **Border**: 1pt solid #E0E0E0 / #3A3A3A

#### Card Sections
**Service Name:**
- **Icon**: 24x24pt, service category icon
- **Typography**: Inter SemiBold 18pt, #1E1E1E
- **Margin Bottom**: 16pt

**Date & Time:**
- **Icon**: 16x16pt calendar.fill, #0D7377
- **Date Typography**: SF Pro Medium 15pt, #1E1E1E
- **Icon**: 16x16pt clock.fill, #0D7377
- **Time Typography**: SF Pro Medium 15pt, #1E1E1E
- **Spacing**: 8pt between date and time rows

**Address:**
- **Icon**: 16x16pt mappin.fill, #0D7377
- **Label**: Inter Medium 14pt, #0D7377 (e.g., "Home")
- **Address**: SF Pro Regular 14pt, #666666
- **Line Spacing**: 1.4
- **Margin Top**: 12pt

**Payment:**
- **Icon**: 16x16pt creditcard.fill, #28C76F
- **Amount**: Inter SemiBold 18pt, #0D7377
- **Method**: SF Pro Regular 13pt, #666666
- **Margin Top**: 16pt
- **Border Top**: 1pt solid #E0E0E0, padding top 16pt

### Booking ID
- **Typography**: SF Pro Mono Medium 14pt
- **Color**: #666666 / #A0A0A0
- **Alignment**: Center
- **Margin**: 16pt top, 24pt bottom
- **Copyable**: Long press to copy
- **Copy Indicator**: Toast "Booking ID copied"

### Section Headers
- **Typography**: Inter SemiBold 18pt
- **Color**: #1E1E1E / #E0E0E0
- **Icon**: 24x24pt emoji before text
- **Margin**: 24pt top, 16pt bottom
- **Padding**: 0 16pt

### Provider Card
- **Background**: White / Dark (#2A2A2A)
- **Border Radius**: 12pt
- **Shadow**: 0 2px 8px rgba(0,0,0,0.06)
- **Padding**: 16pt
- **Margin**: 0 16pt 24pt 16pt

#### Provider Card Content
**Photo:**
- **Size**: 56x56pt
- **Border Radius**: 28pt (circular)
- **Border**: 2pt solid #E0E0E0
- **Position**: Left aligned

**Name:**
- **Typography**: Inter SemiBold 17pt
- **Color**: #1E1E1E / #E0E0E0
- **Position**: Right of photo, 12pt margin

**Rating:**
- **Star Icon**: 14x14pt star.fill, #FFD700 (gold)
- **Rating**: SF Pro Medium 14pt, #1E1E1E
- **Review Count**: SF Pro Regular 13pt, #666666
- **Position**: Below name, 4pt margin

**Specialization:**
- **Icon**: 14x14pt wrench.fill, #0D7377
- **Typography**: SF Pro Regular 13pt, #666666
- **Position**: Below rating, 4pt margin

**Action Buttons:**
- **Height**: 40pt
- **Border Radius**: 8pt
- **Layout**: Two buttons, equal width with 12pt gap
- **Call Button**:
  - Background: #0D7377
  - Icon: 16x16pt phone.fill, White
  - Text: Inter Medium 14pt, White
- **Chat Button**:
  - Background: White / Dark (#3A3A3A)
  - Border: 1pt solid #0D7377
  - Icon: 16x16pt message.fill, #0D7377
  - Text: Inter Medium 14pt, #0D7377
- **Margin Top**: 16pt

### Timeline Section
- **Margin**: 0 16pt
- **Padding**: 16pt
- **Background**: #F5F5F5 / #2A2A2A
- **Border Radius**: 12pt

#### Timeline Items
- **Checkmark**: 16x16pt checkmark.circle.fill, #28C76F
- **Typography**: SF Pro Regular 14pt, #1E1E1E
- **Line Spacing**: 1.5
- **Item Spacing**: 12pt between items
- **Left Padding**: 24pt (for checkmark alignment)

### Add to Calendar Button
- **Height**: 52pt
- **Border Radius**: 12pt
- **Background**: White / Dark (#2A2A2A)
- **Border**: 1.5pt solid #0D7377
- **Icon**: 20x20pt calendar.badge.plus, #0D7377
- **Text**: Inter Medium 15pt, #0D7377
- **Margin**: 24pt horizontal, 20pt top
- **Shadow**: 0 2px 6px rgba(13,115,119,0.15)

### Primary CTA (View Booking Details)
- **Height**: 56pt
- **Border Radius**: 12pt
- **Background**: #0D7377 (gradient to #14A0A5)
- **Text**: Inter SemiBold 16pt, White
- **Margin**: 16pt horizontal, 16pt top
- **Shadow**: 0 4px 12px rgba(13,115,119,0.3)

### Secondary CTA (Back to Home)
- **Height**: 52pt
- **Border Radius**: 12pt
- **Background**: Transparent
- **Border**: 1.5pt solid #E0E0E0 / #3A3A3A
- **Text**: Inter Medium 15pt, #666666 / #A0A0A0
- **Margin**: 16pt horizontal, 12pt top

### Support Link
- **Typography**: Inter Medium 14pt
- **Color**: #0D7377
- **Underline**: None
- **Alignment**: Center
- **Margin**: 20pt top, 24pt bottom
- **Icon**: 16x16pt questionmark.circle, left of text

## Components Used

### Existing Components
1. **FixedBottomCTA** (adapted for non-fixed version)
2. **SecondaryButton** (Back to Home)

### New Components Needed
1. **BookingConfirmationHeader** (success icon + text)
2. **BookingSummaryCard** (detailed booking info)
3. **ProviderInfoCard** (provider details + actions)
4. **TimelineCard** (what happens next)
5. **CopyableText** (booking ID with copy functionality)

## Interactions

### Close Button Tap
- **Action**: Navigate to Home screen
- **Confirmation**: None (booking already confirmed)
- **Haptic**: Medium impact
- **Animation**: Dismiss current screen, slide to home

### Booking ID Long Press
- **Action**: Copy booking ID to clipboard
- **Feedback**: Toast message "Booking ID copied"
- **Haptic**: Success feedback
- **Duration**: Hold for 0.5s to trigger

### Provider Call Button
- **Action**: Initiate phone call to provider
- **Confirmation**: iOS system call alert
- **Permission**: Phone permission required
- **Haptic**: Medium impact
- **Analytics**: Log "provider_call_initiated"

### Provider Chat Button
- **Action**: Navigate to chat screen with provider
- **Data Passed**: Provider ID, Booking ID
- **Haptic**: Light impact
- **Animation**: Push (slide from right)

### Add to Calendar Button
- **Action**: Open iOS Calendar with event
- **Event Details**:
  - Title: "[Service Name] - UrbanNest"
  - Date/Time: Booking slot
  - Location: Service address
  - Notes: Booking ID, Provider name
- **Permission**: Calendar access required
- **Success**: Toast "Added to calendar"
- **Haptic**: Success feedback

### View Booking Details Button
- **Action**: Navigate to Booking Detail/Tracking screen
- **Data Passed**: Booking ID
- **Haptic**: Medium impact
- **Animation**: Push (slide from right)
- **Badge**: "Track in real-time" label

### Back to Home Button
- **Action**: Navigate to Home screen
- **Clear Stack**: Reset navigation to home
- **Haptic**: Light impact
- **Animation**: Pop to root (slide from left)

### Support Link Tap
- **Action**: Open support options bottom sheet
- **Options**:
  - Call Support
  - Chat with Support
  - View FAQs
  - Cancel
- **Haptic**: Light impact

## States

### Default State
- **Booking**: Successfully created
- **Payment**: Completed
- **Provider**: Assigned (if applicable)
- **All Data**: Loaded and displayed

### Provider Not Assigned Yet
- **Provider Card**: Show "Finding provider..."
- **Icon**: Animated search icon
- **Message**: "We're finding the best provider for you"
- **Timeline**: Adjust text to mention provider assignment

### Provider Assignment Failed
- **Provider Card**: Show fallback
- **Message**: "Provider will be assigned soon"
- **Support**: Contact support option prominent
- **No Call/Chat**: Buttons disabled

### Loading State (Initial)
- **Show**: Skeleton loaders for cards
- **Duration**: While fetching booking details
- **Animation**: Shimmer effect

### Calendar Permission Denied
- **Alert**: "Calendar access required"
- **Message**: "Please enable calendar access in Settings to add this booking"
- **Actions**: [Open Settings, Cancel]

### Error State (Failed to Load Details)
- **Icon**: Exclamation mark
- **Message**: "Unable to load booking details"
- **Booking ID**: Still show for reference
- **Actions**: [Retry, Contact Support]

## Animation Sequence

### Entry Animation (0-1.5 seconds)
1. **0.0s**: Screen fades in
2. **0.2s**: Success checkmark scales in (spring animation)
3. **0.4s**: Main heading fades in + slides up
4. **0.5s**: Subheading fades in + slides up
5. **0.6s**: Booking summary card fades in + slides up
6. **0.8s**: Booking ID appears
7. **1.0s**: Provider card slides in from bottom
8. **1.2s**: Timeline section fades in
9. **1.4s**: Buttons fade in from bottom

### Interactive Animations
- **Button Press**: Scale to 0.96, opacity 0.8
- **Provider Card**: Subtle shadow increase on press
- **Calendar Add**: Button pulses green on success
- **Copy ID**: Booking ID flashes green briefly

## Dark Mode Variants

### Colors
- **Background**: #1E1E1E
- **Card Background**: #2A2A2A
- **Card Border**: #3A3A3A
- **Text Primary**: #E0E0E0
- **Text Secondary**: #A0A0A0
- **Text Tertiary**: #666666
- **Success Icon**: #28C76F (same)
- **Primary Color**: #14A0A5 (lighter teal)
- **Divider**: #3A3A3A

### Contrast Adjustments
- All text maintains WCAG AA compliance
- Provider photo border lighter (#3A3A3A)
- Card shadows reduced opacity (0.05 instead of 0.08)
- Timeline background: #2A2A2A instead of #F5F5F5

## Accessibility

### VoiceOver Labels
- **Success Icon**: "Booking confirmed successfully"
- **Booking Summary**: "Booking details. AC Repair & Service. Monday, December 25, 2024. 10 AM to 11 AM. Location: Home, 123 MG Road. Payment: ₹949 paid via Debit Card"
- **Booking ID**: "Booking reference number BK123456. Long press to copy"
- **Provider Card**: "Provider: Rajesh Kumar. Rating: 4.8 stars from 234 reviews. AC Specialist"
- **Call Button**: "Call provider, button"
- **Chat Button**: "Chat with provider, button"
- **Add to Calendar**: "Add booking to calendar, button"
- **View Details**: "View booking details, button"
- **Back to Home**: "Back to home screen, button"

### VoiceOver Hints
- **Booking ID**: "Long press to copy to clipboard"
- **Call Button**: "Double tap to initiate call to provider"
- **Chat Button**: "Double tap to open chat with provider"
- **Calendar**: "Double tap to add this booking to your calendar"

### Dynamic Type Support
- All text scales from -2 to +3
- Card heights adjust dynamically
- Minimum touch target 44x44pt maintained
- Icons remain fixed size for clarity

### Color Contrast
- Main Heading (28pt Bold): 12.1:1 ratio ✓
- Subheading (16pt): 4.6:1 ratio ✓
- Card Text (15pt): 8.2:1 ratio ✓
- Button Text (16pt White on Teal): 5.2:1 ratio ✓
- Support Link (14pt Teal): 4.5:1 ratio ✓

### Reduced Motion
- If enabled, disable:
  - Success icon spring animation
  - Card slide-in animations
  - Confetti effect
- Replace with:
  - Simple fade-in transitions
  - No scale animations

## Analytics Events

### Screen View
```json
{
  "screen_name": "booking_confirmation",
  "booking_id": "BK123456",
  "service_id": "SVC789",
  "amount": 949,
  "payment_method": "card",
  "provider_assigned": true,
  "provider_id": "PRV456"
}
```

### Booking ID Copied
```json
{
  "event": "booking_id_copied",
  "booking_id": "BK123456",
  "source": "confirmation_screen"
}
```

### Provider Action
```json
{
  "event": "provider_call_initiated",
  "booking_id": "BK123456",
  "provider_id": "PRV456",
  "source": "confirmation_screen"
}
```
OR
```json
{
  "event": "provider_chat_initiated",
  "booking_id": "BK123456",
  "provider_id": "PRV456",
  "source": "confirmation_screen"
}
```

### Add to Calendar
```json
{
  "event": "booking_added_to_calendar",
  "booking_id": "BK123456",
  "date": "2024-12-25",
  "time_slot": "10:00-11:00"
}
```

### View Booking Details
```json
{
  "event": "view_booking_details_clicked",
  "booking_id": "BK123456",
  "source": "confirmation_screen"
}
```

### Back to Home
```json
{
  "event": "back_to_home_clicked",
  "booking_id": "BK123456",
  "time_on_screen": 45.2
}
```

### Support Contacted
```json
{
  "event": "support_contacted",
  "source": "confirmation_screen",
  "contact_method": "call", // or chat
  "booking_id": "BK123456"
}
```

## SwiftUI Implementation

### View Structure
```swift
struct BookingConfirmationView: View {
    @StateObject private var viewModel: BookingConfirmationViewModel
    @State private var showSuccessAnimation = false
    @Environment(\.dismiss) var dismiss

    init(bookingId: String, transactionId: String) {
        _viewModel = StateObject(wrappedValue: BookingConfirmationViewModel(
            bookingId: bookingId,
            transactionId: transactionId
        ))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Success Header
                BookingConfirmationHeader(showAnimation: $showSuccessAnimation)
                    .padding(.top, 80)
                    .padding(.bottom, 32)

                // Booking Summary Card
                if let booking = viewModel.booking {
                    BookingSummaryCard(booking: booking)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                        .opacity(showSuccessAnimation ? 1 : 0)
                        .offset(y: showSuccessAnimation ? 0 : 20)
                        .animation(.easeOut(duration: 0.4).delay(0.6), value: showSuccessAnimation)

                    // Booking ID
                    CopyableBookingID(bookingId: booking.id)
                        .padding(.bottom, 24)

                    // Provider Card
                    if let provider = viewModel.provider {
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(icon: "👨‍🔧", title: "Provider Details")

                            ProviderInfoCard(
                                provider: provider,
                                onCall: { callProvider() },
                                onChat: { chatWithProvider() }
                            )
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                        .opacity(showSuccessAnimation ? 1 : 0)
                        .offset(y: showSuccessAnimation ? 0 : 20)
                        .animation(.easeOut(duration: 0.4).delay(1.0), value: showSuccessAnimation)
                    } else if viewModel.isLoadingProvider {
                        ProviderLoadingCard()
                            .padding(.horizontal, 16)
                            .padding(.bottom, 24)
                    }

                    // Timeline
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(icon: "📋", title: "What happens next?")

                        TimelineCard(items: [
                            "Provider will arrive at your location on scheduled time",
                            "You'll receive updates via SMS and notifications",
                            "You can track your booking in \"My Bookings\" section"
                        ])
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    .opacity(showSuccessAnimation ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(1.2), value: showSuccessAnimation)

                    // Add to Calendar
                    Button(action: addToCalendar) {
                        HStack(spacing: 12) {
                            Image(systemName: "calendar.badge.plus")
                                .font(.system(size: 20))
                            Text("Add to Calendar")
                                .font(.custom("Inter-Medium", size: 15))
                        }
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.primary, lineWidth: 1.5)
                        )
                        .shadow(color: Color.primary.opacity(0.15), radius: 3, x: 0, y: 2)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)

                    // View Booking Details
                    PrimaryButton(
                        title: "View Booking Details",
                        action: viewBookingDetails
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)

                    // Back to Home
                    SecondaryButton(
                        title: "Back to Home",
                        action: backToHome
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)

                    // Support Link
                    Button(action: contactSupport) {
                        HStack(spacing: 6) {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 16))
                            Text("Need help? Contact Support")
                                .font(.custom("Inter-Medium", size: 14))
                        }
                        .foregroundColor(.primary)
                    }
                    .padding(.bottom, 32)
                }
            }
        }
        .background(Color.gray100.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: CloseButton { backToHome() })
        .onAppear {
            loadBookingDetails()
            showSuccessAnimation = true

            Analytics.logScreenView("booking_confirmation", parameters: [
                "booking_id": viewModel.bookingId
            ])
        }
    }

    // MARK: - Actions

    private func loadBookingDetails() {
        Task {
            await viewModel.loadBookingDetails()
        }
    }

    private func callProvider() {
        guard let phoneNumber = viewModel.provider?.phone else { return }

        HapticFeedback.medium()

        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)

            Analytics.logEvent("provider_call_initiated", parameters: [
                "booking_id": viewModel.bookingId,
                "provider_id": viewModel.provider?.id ?? ""
            ])
        }
    }

    private func chatWithProvider() {
        guard let provider = viewModel.provider else { return }

        HapticFeedback.light()

        Analytics.logEvent("provider_chat_initiated", parameters: [
            "booking_id": viewModel.bookingId,
            "provider_id": provider.id
        ])

        navigationController?.push(
            ChatView(
                bookingId: viewModel.bookingId,
                providerId: provider.id
            )
        )
    }

    private func addToCalendar() {
        guard let booking = viewModel.booking else { return }

        CalendarManager.shared.requestAccess { granted in
            if granted {
                let success = CalendarManager.shared.addBookingToCalendar(booking)
                if success {
                    HapticFeedback.success()
                    ToastManager.show("Added to calendar")

                    Analytics.logEvent("booking_added_to_calendar", parameters: [
                        "booking_id": booking.id
                    ])
                } else {
                    ToastManager.show("Failed to add to calendar", type: .error)
                }
            } else {
                showCalendarPermissionAlert()
            }
        }
    }

    private func viewBookingDetails() {
        HapticFeedback.medium()

        Analytics.logEvent("view_booking_details_clicked", parameters: [
            "booking_id": viewModel.bookingId,
            "source": "confirmation_screen"
        ])

        navigationController?.push(
            BookingDetailView(bookingId: viewModel.bookingId)
        )
    }

    private func backToHome() {
        HapticFeedback.light()

        Analytics.logEvent("back_to_home_clicked", parameters: [
            "booking_id": viewModel.bookingId
        ])

        // Pop to root (Home)
        navigationController?.popToRootViewController(animated: true)
    }

    private func contactSupport() {
        HapticFeedback.light()

        let sheet = SupportOptionsSheet(
            bookingId: viewModel.bookingId,
            context: "Booking Confirmation"
        )
        presentSheet(sheet)
    }

    private func showCalendarPermissionAlert() {
        AlertManager.show(
            title: "Calendar Access Required",
            message: "Please enable calendar access in Settings to add this booking",
            primaryButton: "Open Settings",
            primaryAction: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            },
            secondaryButton: "Cancel"
        )
    }
}
```

### ViewModel
```swift
class BookingConfirmationViewModel: ObservableObject {
    @Published var booking: Booking?
    @Published var provider: Provider?
    @Published var isLoadingProvider: Bool = false
    @Published var error: Error?

    let bookingId: String
    let transactionId: String

    private let bookingService: BookingService
    private let providerService: ProviderService

    init(bookingId: String, transactionId: String) {
        self.bookingId = bookingId
        self.transactionId = transactionId
        self.bookingService = BookingService()
        self.providerService = ProviderService()
    }

    func loadBookingDetails() async {
        do {
            // Fetch booking details
            booking = try await bookingService.getBookingById(bookingId)

            // Fetch provider if assigned
            if let providerId = booking?.providerId {
                isLoadingProvider = true
                provider = try await providerService.getProviderById(providerId)
                isLoadingProvider = false
            } else {
                // Listen for provider assignment
                listenForProviderAssignment()
            }
        } catch {
            self.error = error
        }
    }

    private func listenForProviderAssignment() {
        // Real-time listener for provider assignment (Firebase)
        bookingService.observeBooking(bookingId) { [weak self] updatedBooking in
            self?.booking = updatedBooking

            if let providerId = updatedBooking.providerId, self?.provider == nil {
                Task {
                    self?.provider = try await self?.providerService.getProviderById(providerId)
                    self?.isLoadingProvider = false
                }
            }
        }
    }
}
```

### Component: BookingConfirmationHeader
```swift
struct BookingConfirmationHeader: View {
    @Binding var showAnimation: Bool

    var body: some View {
        VStack(spacing: 24) {
            // Success Icon
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.success)
                .scaleEffect(showAnimation ? 1 : 0)
                .animation(.spring(response: 0.6, dampingFraction: 0.6), value: showAnimation)

            VStack(spacing: 8) {
                // Main Heading
                Text("Booking Confirmed!")
                    .font(.custom("Inter-Bold", size: 28))
                    .foregroundColor(.textPrimary)
                    .opacity(showAnimation ? 1 : 0)
                    .offset(y: showAnimation ? 0 : 10)
                    .animation(.easeOut(duration: 0.4).delay(0.4), value: showAnimation)

                // Subheading
                Text("Your service is scheduled")
                    .font(.system(size: 16))
                    .foregroundColor(.textSecondary)
                    .opacity(showAnimation ? 1 : 0)
                    .offset(y: showAnimation ? 0 : 10)
                    .animation(.easeOut(duration: 0.4).delay(0.5), value: showAnimation)
            }
        }
    }
}
```

### Component: BookingSummaryCard
```swift
struct BookingSummaryCard: View {
    let booking: Booking

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Service Name
            HStack(spacing: 12) {
                Image(systemName: booking.service.icon)
                    .font(.system(size: 24))
                    .foregroundColor(.primary)

                Text(booking.service.name)
                    .font(.custom("Inter-SemiBold", size: 18))
                    .foregroundColor(.textPrimary)
            }

            Divider()

            // Date & Time
            VStack(spacing: 8) {
                InfoRow(
                    icon: "calendar.fill",
                    text: booking.date.formatted(date: .long, time: .omitted)
                )

                InfoRow(
                    icon: "clock.fill",
                    text: "\(booking.timeSlot.startTime) - \(booking.timeSlot.endTime)"
                )
            }

            Divider()

            // Address
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: "mappin.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.primary)

                    Text(booking.address.label)
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(.primary)
                }

                Text(booking.address.fullAddress)
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)
                    .lineSpacing(1.4)
                    .padding(.leading, 24)
            }

            Divider()

            // Payment
            HStack {
                Image(systemName: "creditcard.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.success)

                VStack(alignment: .leading, spacing: 2) {
                    Text("₹\(Int(booking.amount))")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(.primary)

                    Text("Paid via \(booking.paymentMethod)")
                        .font(.system(size: 13))
                        .foregroundColor(.textSecondary)
                }

                Spacer()
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }
}

struct InfoRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.primary)
                .frame(width: 16)

            Text(text)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.textPrimary)
        }
    }
}
```

### Component: CopyableBookingID
```swift
struct CopyableBookingID: View {
    let bookingId: String
    @State private var showCopied = false

    var body: some View {
        Text("Booking ID: #\(bookingId)")
            .font(.custom("SFMono-Medium", size: 14))
            .foregroundColor(.textSecondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.gray100)
            .cornerRadius(6)
            .onLongPressGesture(minimumDuration: 0.5) {
                copyBookingID()
            }
            .overlay(
                Text("Copied!")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.success)
                    .cornerRadius(6)
                    .offset(y: -40)
                    .opacity(showCopied ? 1 : 0)
                    .animation(.easeInOut(duration: 0.2), value: showCopied)
            )
    }

    private func copyBookingID() {
        UIPasteboard.general.string = bookingId
        HapticFeedback.success()

        showCopied = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showCopied = false
        }

        Analytics.logEvent("booking_id_copied", parameters: [
            "booking_id": bookingId,
            "source": "confirmation_screen"
        ])
    }
}
```

## Navigation Flow

### Entry Point
- **From**: Payment Processing screen
- **Trigger**: Payment success
- **Animation**: Replace navigation stack (cannot go back)
- **Data Passed**:
  - Booking ID
  - Transaction ID

### Exit Points

**Primary Path:**
1. View Booking Details → Booking Detail/Tracking screen
2. Back to Home → Home screen (pop to root)

**Secondary Paths:**
- Close button (top-right) → Home screen
- Call Provider → iOS Phone app
- Chat Provider → Chat screen
- Add to Calendar → iOS Calendar app
- Contact Support → Support bottom sheet

### Navigation Behavior
- **Back Button**: Hidden (cannot go back to payment)
- **Swipe Back**: Disabled
- **Home Indicator**: Enabled
- **Close Button**: Always visible

## Push Notifications

### Booking Confirmed
```
Title: "Booking Confirmed! 🎉"
Body: "Your AC Repair is scheduled for Dec 25 at 10:00 AM"
Action: Open Booking Detail
```

### Provider Assigned
```
Title: "Provider Assigned"
Body: "Rajesh Kumar will be your service provider. ⭐ 4.8"
Action: View Provider Profile
```

### Reminder (1 day before)
```
Title: "Service Reminder"
Body: "Your AC Repair is scheduled tomorrow at 10:00 AM"
Action: View Booking
```

### Reminder (1 hour before)
```
Title: "Service Starting Soon"
Body: "Your provider will arrive in 1 hour. Get ready!"
Action: Track Provider
```

## Success Metrics

### Conversion Metrics
- Booking confirmation rate: 100% (payment success)
- View details rate: > 60%
- Add to calendar rate: > 40%
- Provider contact rate: < 10% (ideally low - indicates clarity)

### User Experience
- Time on screen: 30-60 seconds average
- Immediate navigation: < 20% (users should read details)
- Support contact: < 5% (indicates good clarity)

### Retention
- Return booking rate: Track 7-day, 30-day repeat bookings
- App rating prompt: Show after 2 successful bookings

## Testing Checklist

### Functional Testing
- ✅ Load booking details on entry
- ✅ Display all booking information correctly
- ✅ Show provider details (if assigned)
- ✅ Handle provider not assigned yet state
- ✅ Copy booking ID on long press
- ✅ Call provider opens phone app
- ✅ Chat provider navigates to chat
- ✅ Add to calendar creates event
- ✅ View details navigates correctly
- ✅ Back to home resets navigation
- ✅ Close button works
- ✅ Support link opens options

### Edge Cases
- ✅ Provider assigned during session (real-time update)
- ✅ Failed to load booking details
- ✅ Calendar permission denied
- ✅ Network error during load
- ✅ Provider info missing
- ✅ Payment succeeded but booking creation delayed

### Visual Testing
- ✅ Success animation plays smoothly
- ✅ All elements visible on small screen (iPhone SE)
- ✅ Dark mode looks good
- ✅ Dynamic Type support works
- ✅ VoiceOver navigation logical
- ✅ Landscape orientation (if supported)

### Performance
- ✅ Screen loads quickly (< 1s)
- ✅ Animation doesn't drop frames
- ✅ No memory leaks
- ✅ Provider real-time listener properly cleaned up
