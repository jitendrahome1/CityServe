# Active Bookings

## Overview
- **Screen ID**: 18
- **Screen Name**: Active Bookings
- **User Flow**: View all active/upcoming service bookings
- **Navigation**:
  - Entry: From Bottom Tab Bar "Bookings" tab, or Home screen "Active Bookings" card
  - Exit: To Booking Detail screen (tap booking card)
  - Back: Bottom tab navigation

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  My Bookings              [Filter]       │ ← Navigation Bar
├──────────────────────────────────────────┤
│                                          │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐   │ ← Tab Switcher
│  │ Active  │ │ Past    │ │ Cancelled│   │
│  └─────────┘ └─────────┘ └─────────┘   │
│    (selected)                            │
│                                          │
│  Today                                   │ ← Date Section
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 🔧 AC Repair & Service             │ │ ← Booking Card 1
│  │                                    │ │   (Confirmed)
│  │ 📅 Today, Dec 25 • ⏰ 10:00 AM    │ │
│  │                                    │ │
│  │ 👨‍🔧 Rajesh Kumar                   │ │
│  │ ⭐ 4.8                             │ │
│  │                                    │ │
│  │ ✅ Confirmed                       │ │
│  │ Provider on the way                │ │
│  │                                    │ │
│  │ ┌──────────────┐ ┌──────────────┐│ │
│  │ │ 📞 Call      │ │ Track        ││ │
│  │ └──────────────┘ └──────────────┘│ │
│  └────────────────────────────────────┘ │
│                                          │
│  Tomorrow                                │ ← Date Section
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 🚿 Plumbing Service                │ │ ← Booking Card 2
│  │                                    │ │   (Pending)
│  │ 📅 Dec 26 • ⏰ 2:00 PM            │ │
│  │                                    │ │
│  │ ⏳ Finding provider...             │ │
│  │                                    │ │
│  │ 🕐 Scheduled                       │ │
│  │                                    │ │
│  │ ┌────────────────────────────────┐│ │
│  │ │ View Details              →    ││ │
│  │ └────────────────────────────────┘│ │
│  └────────────────────────────────────┘ │
│                                          │
│  Next Week                               │ ← Date Section
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ ✂️ Salon at Home                   │ │ ← Booking Card 3
│  │                                    │ │   (Scheduled)
│  │ 📅 Dec 30 • ⏰ 11:00 AM           │ │
│  │                                    │ │
│  │ 👩‍🦰 Priya Sharma                  │ │
│  │ ⭐ 4.9                             │ │
│  │                                    │ │
│  │ 🕐 Scheduled                       │ │
│  │                                    │ │
│  │ ┌────────────────────────────────┐│ │
│  │ │ View Details              →    ││ │
│  │ └────────────────────────────────┘│ │
│  └────────────────────────────────────┘ │
│                                          │
├──────────────────────────────────────────┤
│  🏠   📋   📅   👤                       │ ← Bottom Tab Bar
│ Home Services Bookings Profile          │
│              (selected)                  │
└──────────────────────────────────────────┘
```

## Layout Specifications

### Dimensions
- **Screen Width**: 390pt (iPhone 14)
- **Safe Area Top**: 47pt (status bar + notch)
- **Safe Area Bottom**: 49pt (tab bar) + 34pt (home indicator) = 83pt
- **Content Width**: 358pt (16pt padding each side)

### Navigation Bar
- **Height**: 56pt
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Title**: Inter SemiBold 20pt, #1E1E1E / #E0E0E0, left-aligned
- **Filter Button**: 24x24pt slider.horizontal.3 icon, #0D7377
- **Padding**: 16pt horizontal
- **Border Bottom**: 1pt solid #E0E0E0 / #3A3A3A

### Tab Switcher
- **Height**: 44pt
- **Background**: #F5F5F5 / #2A2A2A
- **Border Radius**: 10pt
- **Margin**: 16pt horizontal, 16pt top, 20pt bottom
- **Layout**: 3 equal-width tabs

#### Individual Tab
- **Height**: 36pt
- **Border Radius**: 8pt
- **Padding**: 8pt horizontal
- **Typography**: Inter Medium 14pt
- **Colors**:
  - Selected: Background #FFFFFF / #3A3A3A, Text #0D7377, Shadow 0 2px 4px rgba(0,0,0,0.1)
  - Unselected: Background transparent, Text #666666 / #A0A0A0
- **Animation**: Slide + fade on switch, 200ms ease-in-out

### Date Section Headers
- **Typography**: Inter SemiBold 16pt, #1E1E1E / #E0E0E0
- **Padding**: 16pt horizontal, 20pt top, 12pt bottom
- **Sticky**: Yes (sticks to top while scrolling that section)
- **Background**: White (#FFFFFF) / Dark (#1E1E1E) with 0.95 opacity blur

### Booking Cards

#### Card Container
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Border Radius**: 16pt
- **Shadow**: 0 2px 8px rgba(0,0,0,0.08)
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding**: 16pt
- **Margin**: 0 16pt 16pt 16pt
- **Left Border**: 4pt solid [status color]
  - Confirmed (On the way): #0D7377 (teal)
  - In Progress: #FF6B35 (orange)
  - Scheduled: #666666 (gray)
  - Pending: #FFC107 (yellow)

#### Service Name
- **Icon**: 28x28pt, service category emoji
- **Typography**: Inter SemiBold 17pt, #1E1E1E / #E0E0E0
- **Layout**: Icon + text, 12pt gap
- **Margin Bottom**: 12pt

#### Date & Time Row
- **Icon**: 14x14pt calendar/clock icons, #666666
- **Typography**: SF Pro Medium 14pt, #666666 / #A0A0A0
- **Layout**: Inline with bullet separator (•)
- **Margin Bottom**: 12pt

#### Provider Section (if assigned)
- **Photo**: 40x40pt circular, border 1pt #E0E0E0
- **Name**: Inter Medium 15pt, #1E1E1E / #E0E0E0
- **Rating**: 14x14pt star icon + SF Pro Regular 13pt, #666666
- **Layout**: Horizontal, photo + name/rating stack
- **Margin**: 12pt top, 12pt bottom

#### Status Badge
- **Height**: 28pt
- **Border Radius**: 6pt
- **Padding**: 6pt horizontal, 4pt vertical
- **Icon**: 14x14pt status icon
- **Typography**: Inter Medium 13pt
- **Layout**: Icon + text, 4pt gap
- **Colors**:
  - Confirmed: Background #E8F7F8, Text #0D7377, Icon checkmark.circle.fill
  - In Progress: Background #FFF4E6, Text #FF6B35, Icon clock.arrow.circlepath
  - Scheduled: Background #F5F5F5, Text #666666, Icon calendar.circle
  - Pending: Background #FFF8E1, Text #FFC107, Icon hourglass

#### Status Message
- **Typography**: SF Pro Regular 13pt, #666666 / #A0A0A0
- **Margin**: 4pt top, 12pt bottom
- **Examples**:
  - "Provider on the way"
  - "Finding provider..."
  - "Service scheduled"

#### Action Buttons

**Two-Button Layout (Confirmed bookings):**
- **Height**: 40pt
- **Border Radius**: 8pt
- **Gap**: 12pt between buttons
- **Layout**: Two equal-width buttons

**Call Button:**
- Background: #0D7377
- Icon: 16x16pt phone.fill, White
- Text: Inter Medium 14pt, White

**Track Button:**
- Background: White / Dark (#3A3A3A)
- Border: 1pt solid #0D7377
- Icon: 16x16pt location.fill, #0D7377
- Text: Inter Medium 14pt, #0D7377

**Single-Button Layout (Scheduled/Pending bookings):**
- **Height**: 44pt
- **Border Radius**: 8pt
- **Background**: Transparent
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Text**: Inter Medium 14pt, #666666 / #A0A0A0
- **Arrow**: 16x16pt chevron.right, #999999
- **Full Width**: Yes

### Bottom Tab Bar
- **Height**: 49pt + safe area
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Border Top**: 1pt solid #E0E0E0 / #3A3A3A
- **Icons**: 24x24pt
- **Typography**: SF Pro Regular 10pt
- **Selected Color**: #0D7377
- **Unselected Color**: #999999
- **Badge**: Red dot (8pt) for notifications

## Components Used

### Existing Components
1. **BottomTabBar** (navigation)
2. **CustomNavigationBar** (title + filter)
3. **SegmentedControl** (tab switcher)

### New Components Needed
1. **BookingCard** (displays booking summary)
2. **StatusBadge** (shows booking status)
3. **ProviderMiniCard** (provider info in booking card)
4. **SectionHeader** (sticky date headers)
5. **EmptyStateView** (no bookings state)

## Booking Statuses

### Status Definitions

1. **Scheduled** 🕐
   - Booking created, date in future
   - Provider may or may not be assigned
   - User can modify/cancel

2. **Confirmed** ✅
   - Provider assigned
   - Provider accepted the job
   - < 2 hours until booking time

3. **On the Way** 🚗
   - Provider started journey
   - Live tracking available
   - < 30 minutes to arrival

4. **In Progress** 🔄
   - Provider at location
   - Service being performed
   - Live updates shown

5. **Pending** ⏳
   - Awaiting provider assignment
   - Admin reviewing special requests
   - Payment pending (if COD)

6. **Completed** ✔️
   - Service finished
   - Payment completed
   - Review pending (moves to Past tab)

7. **Cancelled** ❌
   - Cancelled by user or provider
   - Refund processed (if applicable)
   - Shown in Cancelled tab

## Interactions

### Tab Switch
- **Action**: Switch between Active, Past, Cancelled
- **Animation**:
  - Selected tab slides/fades in (200ms)
  - Content cross-fades (250ms)
- **Haptic**: Light impact
- **Data Load**: Fetch new data if not cached

### Booking Card Tap
- **Action**: Navigate to Booking Detail screen
- **Animation**: Push (slide from right)
- **Haptic**: Medium impact
- **Data Passed**: Booking ID
- **Visual**: Card scales to 0.97 on press

### Call Button Tap
- **Action**: Call provider phone number
- **Confirmation**: iOS system call dialog
- **Haptic**: Medium impact
- **Analytics**: Log "provider_call_initiated"
- **Requirement**: Phone permission

### Track Button Tap
- **Action**: Navigate to live tracking map
- **Animation**: Modal slide up from bottom
- **Haptic**: Medium impact
- **Data**: Provider location, route, ETA
- **Requirement**: Location permission

### View Details Button Tap
- **Action**: Navigate to Booking Detail screen
- **Same as**: Card tap
- **Animation**: Push transition

### Filter Button Tap
- **Action**: Show filter bottom sheet
- **Options**:
  - All Services
  - By Service Category (AC, Plumbing, Electrical, etc.)
  - By Status
  - By Date Range
- **Apply**: Updates list with filters
- **Haptic**: Light impact

### Pull to Refresh
- **Action**: Refresh booking list
- **Animation**: Standard iOS pull-to-refresh
- **Indicator**: Activity spinner
- **Haptic**: Light impact on release
- **Updates**: Fetch latest booking statuses

### Swipe Actions (Card)
- **Swipe Left**: Reveal actions
  - **Reschedule**: Blue background, calendar icon
  - **Cancel**: Red background, xmark icon
- **Swipe Right**: Quick call (if provider assigned)
  - **Call**: Teal background, phone icon
- **Action**: Execute on full swipe
- **Confirmation**: Show for cancel action

## States

### Default State (Has Active Bookings)
- **Tab**: Active selected by default
- **Content**: List of active bookings grouped by date
- **Sections**: Today, Tomorrow, This Week, Later
- **Pull-to-Refresh**: Available

### Empty State (No Active Bookings)
```
Icon: Calendar with checkmark (80x80pt)
Title: "No Active Bookings"
Message: "You don't have any upcoming services. Book a service to get started!"
CTA: "Browse Services" button
```
- **Illustration**: Friendly empty state icon
- **CTA Action**: Navigate to Service Categories

### Loading State
- **Show**: Skeleton cards (3 cards)
- **Animation**: Shimmer effect
- **Duration**: While fetching data
- **Fallback**: Show after 5 seconds if stuck

### Error State (Network Error)
```
Icon: WiFi with slash (60x60pt)
Title: "Connection Error"
Message: "Unable to load your bookings. Please check your internet connection."
CTA: "Retry" button
```

### Filtered State
- **Badge**: Show "Filtered" badge near title
- **Clear**: Tap badge to clear filters
- **Count**: Show "Showing X bookings"
- **Empty**: "No bookings match your filters"

### Real-time Updates
- **Status Changes**: Update card status in real-time (Firebase listener)
- **New Booking**: Animate new card sliding in from top
- **Cancelled Booking**: Fade out and slide to Cancelled tab
- **Provider Assigned**: Update card with provider info (fade in)

## Dark Mode Variants

### Colors
- **Background**: #1E1E1E
- **Card Background**: #2A2A2A
- **Card Border**: #3A3A3A
- **Tab Switcher BG**: #2A2A2A
- **Selected Tab BG**: #3A3A3A
- **Text Primary**: #E0E0E0
- **Text Secondary**: #A0A0A0
- **Status Badge**: Darker backgrounds, same text colors
- **Shadows**: Reduced opacity (0.05 instead of 0.08)

## Accessibility

### VoiceOver Labels
- **Tab**: "Active bookings, tab, 1 of 3, selected"
- **Booking Card**: "AC Repair & Service. Today at 10 AM. Confirmed. Provider Rajesh Kumar, rating 4.8. Double tap to view details."
- **Call Button**: "Call provider, button"
- **Track Button**: "Track provider location, button"
- **View Details**: "View booking details, button"
- **Status Badge**: "Status: Confirmed. Provider on the way."

### VoiceOver Hints
- **Card**: "Double tap to view full booking details"
- **Call**: "Double tap to call provider"
- **Track**: "Double tap to see provider location on map"

### VoiceOver Groups
- Group card content logically:
  1. Service info (name, date, time)
  2. Provider info (name, rating)
  3. Status info (badge, message)
  4. Actions (buttons)

### Dynamic Type Support
- All text scales from -2 to +3
- Card height adjusts dynamically
- Minimum button touch target: 44x44pt
- Icons remain fixed size

### Color Contrast
- All text meets WCAG AA (4.5:1 minimum)
- Status badges have sufficient contrast
- Selected tab clearly distinguishable

### Reduced Motion
- Disable tab slide animations
- Disable card entry animations
- Use fade transitions only
- Maintain skeleton loading (static, no shimmer)

## Analytics Events

### Screen View
```json
{
  "screen_name": "active_bookings",
  "tab": "active",
  "bookings_count": 3,
  "has_confirmed": true,
  "has_pending": true
}
```

### Tab Switched
```json
{
  "event": "bookings_tab_switched",
  "from_tab": "active",
  "to_tab": "past"
}
```

### Booking Card Tapped
```json
{
  "event": "booking_card_tapped",
  "booking_id": "BK123456",
  "booking_status": "confirmed",
  "service_type": "ac_repair",
  "source": "active_bookings"
}
```

### Provider Called
```json
{
  "event": "provider_called_from_bookings",
  "booking_id": "BK123456",
  "provider_id": "PRV789",
  "booking_status": "confirmed"
}
```

### Track Provider Tapped
```json
{
  "event": "track_provider_tapped",
  "booking_id": "BK123456",
  "provider_id": "PRV789",
  "time_until_booking": 45 // minutes
}
```

### Filter Applied
```json
{
  "event": "bookings_filter_applied",
  "filter_type": "service_category",
  "filter_value": "plumbing",
  "results_count": 2
}
```

### Pull to Refresh
```json
{
  "event": "bookings_refreshed",
  "tab": "active",
  "new_bookings": 1
}
```

### Swipe Action
```json
{
  "event": "booking_swipe_action",
  "action": "cancel", // or reschedule, call
  "booking_id": "BK123456",
  "booking_status": "scheduled"
}
```

## SwiftUI Implementation

### View Structure
```swift
struct ActiveBookingsView: View {
    @StateObject private var viewModel = BookingsViewModel()
    @State private var selectedTab: BookingTab = .active
    @State private var showFilter = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray100
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Tab Switcher
                    BookingTabSwitcher(selectedTab: $selectedTab)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 20)

                    // Content
                    Group {
                        switch selectedTab {
                        case .active:
                            if viewModel.activeBookings.isEmpty {
                                EmptyBookingsView(type: .active) {
                                    navigateToBrowse()
                                }
                            } else {
                                ActiveBookingsList(
                                    bookings: viewModel.groupedActiveBookings,
                                    onCardTap: navigateToDetail,
                                    onCall: callProvider,
                                    onTrack: trackProvider
                                )
                            }

                        case .past:
                            PastBookingsList(
                                bookings: viewModel.pastBookings,
                                onCardTap: navigateToDetail
                            )

                        case .cancelled:
                            CancelledBookingsList(
                                bookings: viewModel.cancelledBookings,
                                onCardTap: navigateToDetail
                            )
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("My Bookings")
                        .font(.custom("Inter-SemiBold", size: 20))
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showFilter = true }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                }
            }
            .refreshable {
                await viewModel.refreshBookings()
            }
            .sheet(isPresented: $showFilter) {
                FilterBookingsSheet(
                    filters: $viewModel.filters,
                    onApply: {
                        viewModel.applyFilters()
                        showFilter = false
                    }
                )
            }
            .onAppear {
                loadBookings()
                startRealtimeListener()

                Analytics.logScreenView("active_bookings", parameters: [
                    "tab": selectedTab.rawValue,
                    "bookings_count": viewModel.activeBookings.count
                ])
            }
            .onChange(of: selectedTab) { newTab in
                Analytics.logEvent("bookings_tab_switched", parameters: [
                    "from_tab": selectedTab.rawValue,
                    "to_tab": newTab.rawValue
                ])
            }
        }
    }

    // MARK: - Actions

    private func loadBookings() {
        Task {
            await viewModel.loadActiveBookings()
        }
    }

    private func startRealtimeListener() {
        viewModel.startRealtimeUpdates()
    }

    private func navigateToDetail(_ booking: Booking) {
        HapticFeedback.medium()

        Analytics.logEvent("booking_card_tapped", parameters: [
            "booking_id": booking.id,
            "booking_status": booking.status.rawValue,
            "service_type": booking.service.category.rawValue
        ])

        navigationController?.push(
            BookingDetailView(bookingId: booking.id)
        )
    }

    private func callProvider(_ booking: Booking) {
        guard let provider = booking.provider,
              let phoneNumber = provider.phone else { return }

        HapticFeedback.medium()

        Analytics.logEvent("provider_called_from_bookings", parameters: [
            "booking_id": booking.id,
            "provider_id": provider.id,
            "booking_status": booking.status.rawValue
        ])

        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    private func trackProvider(_ booking: Booking) {
        HapticFeedback.medium()

        Analytics.logEvent("track_provider_tapped", parameters: [
            "booking_id": booking.id,
            "provider_id": booking.provider?.id ?? ""
        ])

        let trackingView = ProviderTrackingView(bookingId: booking.id)
        presentFullScreenModal(trackingView)
    }

    private func navigateToBrowse() {
        // Switch to Services tab
        tabBarController?.selectedIndex = 1
    }
}
```

### ViewModel
```swift
enum BookingTab: String {
    case active
    case past
    case cancelled
}

class BookingsViewModel: ObservableObject {
    @Published var activeBookings: [Booking] = []
    @Published var pastBookings: [Booking] = []
    @Published var cancelledBookings: [Booking] = []
    @Published var filters: BookingFilters = BookingFilters()
    @Published var isLoading: Bool = false

    var groupedActiveBookings: [BookingGroup] {
        groupBookingsByDate(activeBookings)
    }

    private let bookingService: BookingService
    private var realtimeListener: ListenerRegistration?

    init() {
        self.bookingService = BookingService()
    }

    func loadActiveBookings() async {
        isLoading = true

        do {
            activeBookings = try await bookingService.fetchActiveBookings()
            isLoading = false
        } catch {
            print("Error loading bookings: \(error)")
            isLoading = false
        }
    }

    func refreshBookings() async {
        await loadActiveBookings()
        // Also refresh past and cancelled if needed
    }

    func startRealtimeUpdates() {
        realtimeListener = bookingService.observeBookings { [weak self] updatedBookings in
            self?.updateBookingsList(updatedBookings)
        }
    }

    func applyFilters() {
        // Filter bookings based on filters object
        // Update published arrays
    }

    private func updateBookingsList(_ updatedBookings: [Booking]) {
        DispatchQueue.main.async {
            // Update bookings with animation
            withAnimation {
                self.activeBookings = updatedBookings.filter { $0.isActive }
                self.pastBookings = updatedBookings.filter { $0.isPast }
                self.cancelledBookings = updatedBookings.filter { $0.isCancelled }
            }
        }
    }

    private func groupBookingsByDate(_ bookings: [Booking]) -> [BookingGroup] {
        let calendar = Calendar.current
        let now = Date()

        var groups: [BookingGroup] = []

        // Today
        let today = bookings.filter { calendar.isDateInToday($0.date) }
        if !today.isEmpty {
            groups.append(BookingGroup(title: "Today", bookings: today))
        }

        // Tomorrow
        let tomorrow = bookings.filter { calendar.isDateInTomorrow($0.date) }
        if !tomorrow.isEmpty {
            groups.append(BookingGroup(title: "Tomorrow", bookings: tomorrow))
        }

        // This Week (excluding today and tomorrow)
        let thisWeek = bookings.filter {
            calendar.isDate($0.date, equalTo: now, toGranularity: .weekOfYear) &&
            !calendar.isDateInToday($0.date) &&
            !calendar.isDateInTomorrow($0.date)
        }
        if !thisWeek.isEmpty {
            groups.append(BookingGroup(title: "This Week", bookings: thisWeek))
        }

        // Later (future weeks)
        let later = bookings.filter {
            $0.date > calendar.date(byAdding: .weekOfYear, value: 1, to: now) ?? now
        }
        if !later.isEmpty {
            groups.append(BookingGroup(title: "Later", bookings: later))
        }

        return groups
    }

    deinit {
        realtimeListener?.remove()
    }
}

struct BookingGroup: Identifiable {
    let id = UUID()
    let title: String
    let bookings: [Booking]
}

struct BookingFilters {
    var serviceCategory: ServiceCategory?
    var status: BookingStatus?
    var dateRange: DateRange?
}
```

### Component: BookingCard
```swift
struct BookingCard: View {
    let booking: Booking
    let onTap: () -> Void
    let onCall: (() -> Void)?
    let onTrack: (() -> Void)?

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                // Service Name
                HStack(spacing: 12) {
                    Text(booking.service.icon)
                        .font(.system(size: 28))

                    Text(booking.service.name)
                        .font(.custom("Inter-SemiBold", size: 17))
                        .foregroundColor(.textPrimary)
                }

                // Date & Time
                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)

                    Text(booking.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.textSecondary)

                    Text("•")
                        .foregroundColor(.textSecondary)

                    Image(systemName: "clock")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)

                    Text(booking.timeSlot.displayTime)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.textSecondary)
                }

                // Provider (if assigned)
                if let provider = booking.provider {
                    HStack(spacing: 10) {
                        AsyncImage(url: URL(string: provider.photoURL)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray300
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray300, lineWidth: 1))

                        VStack(alignment: .leading, spacing: 2) {
                            Text(provider.name)
                                .font(.custom("Inter-Medium", size: 15))
                                .foregroundColor(.textPrimary)

                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.yellow)

                                Text(String(format: "%.1f", provider.rating))
                                    .font(.system(size: 13))
                                    .foregroundColor(.textSecondary)
                            }
                        }

                        Spacer()
                    }
                }

                // Status
                VStack(alignment: .leading, spacing: 4) {
                    StatusBadge(status: booking.status)

                    if let statusMessage = booking.statusMessage {
                        Text(statusMessage)
                            .font(.system(size: 13))
                            .foregroundColor(.textSecondary)
                    }
                }

                // Action Buttons
                if let onCall = onCall, let onTrack = onTrack {
                    HStack(spacing: 12) {
                        Button(action: onCall) {
                            HStack(spacing: 6) {
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 14))
                                Text("Call")
                                    .font(.custom("Inter-Medium", size: 14))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.primary)
                            .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())

                        Button(action: onTrack) {
                            HStack(spacing: 6) {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 14))
                                Text("Track")
                                    .font(.custom("Inter-Medium", size: 14))
                            }
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.primary, lineWidth: 1)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    Button(action: onTap) {
                        HStack {
                            Text("View Details")
                                .font(.custom("Inter-Medium", size: 14))
                                .foregroundColor(.textSecondary)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.textTertiary)
                        }
                        .frame(height: 44)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray300, lineWidth: 1)
            )
            .overlay(
                // Status color left border
                Rectangle()
                    .fill(booking.status.color)
                    .frame(width: 4)
                    .cornerRadius(2, corners: [.topLeft, .bottomLeft]),
                alignment: .leading
            )
            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
```

### Component: StatusBadge
```swift
struct StatusBadge: View {
    let status: BookingStatus

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: status.icon)
                .font(.system(size: 12))

            Text(status.displayName)
                .font(.custom("Inter-Medium", size: 13))
        }
        .foregroundColor(status.textColor)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(status.backgroundColor)
        .cornerRadius(6)
    }
}

extension BookingStatus {
    var color: Color {
        switch self {
        case .confirmed, .onTheWay:
            return Color.primary
        case .inProgress:
            return Color.secondary
        case .scheduled:
            return Color.gray500
        case .pending:
            return Color.warning
        default:
            return Color.gray400
        }
    }

    var backgroundColor: Color {
        switch self {
        case .confirmed, .onTheWay:
            return Color(hex: "#E8F7F8")
        case .inProgress:
            return Color(hex: "#FFF4E6")
        case .scheduled:
            return Color.gray100
        case .pending:
            return Color(hex: "#FFF8E1")
        default:
            return Color.gray100
        }
    }

    var textColor: Color {
        switch self {
        case .confirmed, .onTheWay:
            return Color.primary
        case .inProgress:
            return Color.secondary
        case .scheduled:
            return Color.textSecondary
        case .pending:
            return Color.warning
        default:
            return Color.textSecondary
        }
    }

    var icon: String {
        switch self {
        case .confirmed:
            return "checkmark.circle.fill"
        case .onTheWay:
            return "car.fill"
        case .inProgress:
            return "clock.arrow.circlepath"
        case .scheduled:
            return "calendar.circle"
        case .pending:
            return "hourglass"
        default:
            return "circle"
        }
    }

    var displayName: String {
        switch self {
        case .confirmed:
            return "Confirmed"
        case .onTheWay:
            return "On the Way"
        case .inProgress:
            return "In Progress"
        case .scheduled:
            return "Scheduled"
        case .pending:
            return "Pending"
        default:
            return rawValue.capitalized
        }
    }
}
```

## Performance Optimization

### Data Loading
- Paginate past bookings (load 10 at a time)
- Cache booking data locally (CoreData/UserDefaults)
- Real-time updates only for active bookings
- Lazy load provider photos

### UI Optimization
- Virtualized list (LazyVStack)
- Reuse booking cards
- Minimize re-renders (Equatable conformance)
- Debounce filter changes (300ms)

## Testing Checklist

### Functional
- ✅ Load active bookings on tab open
- ✅ Switch between tabs (Active, Past, Cancelled)
- ✅ Tap booking card navigates to detail
- ✅ Call provider initiates phone call
- ✅ Track provider shows tracking map
- ✅ Pull to refresh updates list
- ✅ Filter bookings by category/status/date
- ✅ Real-time status updates appear
- ✅ Empty states show correctly
- ✅ Error states show and recover

### Visual
- ✅ Light mode
- ✅ Dark mode
- ✅ iPhone SE (small screen)
- ✅ iPhone 14 Pro Max (large screen)
- ✅ Dynamic Type scaling
- ✅ VoiceOver navigation

### Edge Cases
- ✅ No bookings (empty state)
- ✅ Provider not assigned yet
- ✅ Very long service names
- ✅ Multiple bookings same time
- ✅ Network error during load
- ✅ Booking cancelled during view
