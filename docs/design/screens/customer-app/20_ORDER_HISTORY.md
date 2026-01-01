# Order History

## Overview
- **Screen ID**: 20
- **Screen Name**: Order History (Past Bookings)
- **User Flow**: View all completed service bookings with reviews and invoices
- **Navigation**:
  - Entry: From Active Bookings → "Past" tab
  - Exit: To Booking Detail, Review screen
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
│                (selected)                │
│                                          │
│  December 2024                           │ ← Month Section
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ ✅ Completed                       │ │ ← Booking Card 1
│  │                                    │ │
│  │ 🔧 AC Repair & Service             │ │
│  │                                    │ │
│  │ 📅 Dec 20, 2024 • 10:00 AM        │ │
│  │ 👨‍🔧 Rajesh Kumar  ⭐ 4.8           │ │
│  │                                    │ │
│  │ 💰 ₹949                            │ │
│  │                                    │ │
│  │ ⭐⭐⭐⭐⭐  You rated 5 stars        │ │
│  │ "Excellent service! Very prompt"   │ │
│  │                                    │ │
│  │ ┌──────────────┐ ┌──────────────┐│ │
│  │ │ 📄 Invoice   │ │ Book Again   ││ │
│  │ └──────────────┘ └──────────────┘│ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ ✅ Completed                       │ │ ← Booking Card 2
│  │                                    │ │   (No review yet)
│  │ 🚿 Plumbing Service                │ │
│  │                                    │ │
│  │ 📅 Dec 15, 2024 • 2:00 PM         │ │
│  │ 👨‍🔧 Amit Verma  ⭐ 4.6            │ │
│  │                                    │ │
│  │ 💰 ₹649                            │ │
│  │                                    │ │
│  │ ⭐ Rate your experience            │ │
│  │                                    │ │
│  │ ┌────────────────────────────────┐│ │
│  │ │ Leave a Review            →    ││ │
│  │ └────────────────────────────────┘│ │
│  └────────────────────────────────────┘ │
│                                          │
│  November 2024                           │ ← Month Section
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ ✅ Completed                       │ │ ← Booking Card 3
│  │                                    │ │
│  │ ✂️ Salon at Home                   │ │
│  │                                    │ │
│  │ 📅 Nov 28, 2024 • 11:00 AM        │ │
│  │ 👩‍🦰 Priya Sharma  ⭐ 4.9          │ │
│  │                                    │ │
│  │ 💰 ₹1,299                          │ │
│  │                                    │ │
│  │ ⭐⭐⭐⭐ You rated 4 stars          │ │
│  │                                    │ │
│  │ ┌──────────────┐ ┌──────────────┐│ │
│  │ │ 📄 Invoice   │ │ Book Again   ││ │
│  │ └──────────────┘ └──────────────┘│ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Load More                    →    │ │ ← Load More
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
- **Layout**: 3 equal-width tabs (Active, Past, Cancelled)
- **Selected Tab**: Background #FFFFFF / #3A3A3A, Text #0D7377
- **Unselected Tab**: Background transparent, Text #666666 / #A0A0A0

### Month Section Headers
- **Typography**: Inter SemiBold 16pt, #1E1E1E / #E0E0E0
- **Padding**: 16pt horizontal, 20pt top, 12pt bottom
- **Sticky**: Yes (sticks to top while scrolling)
- **Background**: White (#FFFFFF) / Dark (#1E1E1E) with 0.95 opacity blur
- **Border Bottom**: 1pt solid #E0E0E0 / #3A3A3A (while sticky)

### Booking Cards

#### Card Container
- **Background**: White (#FFFFFF) / Dark (#2A2A2A)
- **Border Radius**: 16pt
- **Shadow**: 0 2px 8px rgba(0,0,0,0.08)
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding**: 16pt
- **Margin**: 0 16pt 16pt 16pt
- **Left Border**: 4pt solid #28C76F (success green - completed)

#### Status Badge
- **Height**: 24pt
- **Border Radius**: 4pt
- **Padding**: 4pt horizontal, 2pt vertical
- **Icon**: 12x12pt checkmark.circle.fill, #28C76F
- **Text**: Inter Medium 12pt, #28C76F
- **Background**: #E8F7E8 / #1E3D1E (dark mode)
- **Margin Bottom**: 12pt

#### Service Info
- **Icon**: 28x28pt service category emoji
- **Name**: Inter SemiBold 17pt, #1E1E1E / #E0E0E0
- **Layout**: Icon + text, 12pt gap
- **Margin Bottom**: 12pt

#### Date & Time Row
- **Icon**: 14x14pt calendar icon, #666666
- **Typography**: SF Pro Medium 14pt, #666666 / #A0A0A0
- **Format**: "Dec 20, 2024 • 10:00 AM"
- **Bullet Separator**: "•"
- **Margin Bottom**: 8pt

#### Provider Row
- **Photo**: 32x32pt circular (smaller than active bookings)
- **Name**: Inter Medium 14pt, #1E1E1E / #E0E0E0
- **Rating**: 12x12pt star + SF Pro Regular 13pt, #666666
- **Layout**: Horizontal, photo + name + rating
- **Margin Bottom**: 12pt

#### Price
- **Typography**: Inter SemiBold 18pt, #0D7377
- **Symbol**: "₹"
- **Margin Bottom**: 12pt

#### Review Section (if reviewed)
- **Border Top**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding Top**: 12pt
- **Stars**: 16x16pt each, #FFD700 (gold)
- **Text**: SF Pro Regular 13pt, #666666
- **Layout**: Stars inline, text below
- **Review Text**: SF Pro Regular 13pt, #666666, italic
- **Max Lines**: 2 (truncated with "...")
- **Margin Bottom**: 12pt

#### Review CTA (if not reviewed)
- **Border Top**: 1pt solid #E0E0E0 / #3A3A3A
- **Padding Top**: 12pt
- **Icon**: 20x20pt star, #FFC107 (warning yellow)
- **Text**: Inter Medium 14pt, #666666
- **Margin Bottom**: 12pt

#### Action Buttons
- **Height**: 40pt
- **Border Radius**: 8pt
- **Gap**: 12pt between buttons
- **Layout**: Two equal-width buttons

**Invoice Button:**
- Background: White / Dark (#3A3A3A)
- Border: 1pt solid #E0E0E0 / #3A3A3A
- Icon: 16x16pt doc.text, #666666
- Text: Inter Medium 14pt, #666666

**Book Again Button:**
- Background: #0D7377
- Icon: 16x16pt arrow.clockwise, White
- Text: Inter Medium 14pt, White

**Leave Review Button (full width):**
- Height: 44pt
- Background: Transparent
- Border: 1pt solid #E0E0E0 / #3A3A3A
- Text: Inter Medium 14pt, #666666
- Arrow: 16x16pt chevron.right, #999999

### Load More Button
- **Height**: 48pt
- **Border Radius**: 12pt
- **Background**: White / Dark (#2A2A2A)
- **Border**: 1pt solid #E0E0E0 / #3A3A3A
- **Text**: Inter Medium 15pt, #666666 / #A0A0A0
- **Arrow**: 16x16pt chevron.right, #999999
- **Margin**: 0 16pt 24pt 16pt

## Components Used

### Existing Components
1. **BottomTabBar**
2. **CustomNavigationBar**
3. **SegmentedControl** (tab switcher)
4. **StatusBadge**

### New Components Needed
1. **PastBookingCard** (completed booking display)
2. **RatingDisplay** (star rating visual)
3. **ReviewPreview** (truncated review text)
4. **MonthSectionHeader** (sticky header)
5. **EmptyHistoryView** (no past bookings state)

## Interactions

### Tab Switch to Past
- **Action**: Load past bookings
- **Animation**: Content cross-fade (250ms)
- **Haptic**: Light impact
- **Data**: Fetch from API if not cached

### Booking Card Tap
- **Action**: Navigate to Booking Detail screen
- **Animation**: Push (slide from right)
- **Haptic**: Medium impact
- **Data**: Pass booking ID
- **Visual**: Card scales to 0.97 on press

### Invoice Button Tap
- **Action**: Download and view invoice PDF
- **Flow**:
  1. Show loading indicator
  2. Generate/fetch PDF from backend
  3. Present PDF viewer (iOS native)
  4. Share/Save options available
- **Haptic**: Light impact
- **Analytics**: Log "invoice_downloaded"
- **Error Handling**: Show toast if failed

### Book Again Tap
- **Action**: Navigate to Service Detail screen
- **Data Passed**: Same service ID
- **Pre-fill**: Same address, similar time (if available)
- **Haptic**: Medium impact
- **Animation**: Push transition
- **Analytics**: Log "book_again_clicked"

### Leave Review Tap
- **Action**: Open review modal
- **Modal Content**:
  - Provider name + photo
  - Service name
  - Star rating selector (1-5)
  - Review text area (optional)
  - Tags (Punctual, Professional, Polite, etc.)
  - Submit button
- **Validation**: Minimum 1 star required
- **Submission**:
  - Post review to backend
  - Update card with review
  - Show thank you message
  - Offer incentive ("Get ₹50 off next booking")
- **Haptic**: Success on submit

### Review Text Tap (expand)
- **Action**: Expand full review text
- **Animation**: Card expands smoothly
- **Tap Again**: Collapse back to 2 lines
- **Haptic**: Light impact

### Filter Button Tap
- **Action**: Show filter bottom sheet
- **Filters**:
  - Service Category (AC, Plumbing, Electrical, etc.)
  - Date Range (Last month, Last 3 months, Last year, Custom)
  - Price Range (₹0-500, ₹500-1000, ₹1000+)
  - Rating (5 stars, 4+, 3+, All)
- **Apply**: Update list with filtered results
- **Badge**: Show "Filtered" indicator when active
- **Clear**: "Clear All Filters" button in sheet

### Load More Tap
- **Action**: Load next page of bookings
- **Pagination**: 10 bookings per page
- **Loading**: Show spinner in button
- **End**: Hide button when no more bookings
- **Haptic**: Light impact

### Pull to Refresh
- **Action**: Refresh past bookings list
- **Animation**: Standard iOS pull-to-refresh
- **Indicator**: Activity spinner
- **Haptic**: Light impact on release
- **Updates**: Fetch latest data from server

### Search (in filter)
- **Action**: Search past bookings
- **Search By**:
  - Service name
  - Provider name
  - Booking ID
  - Date
- **Live Search**: Results update as you type (debounced 300ms)
- **Clear**: X button to clear search

## States

### Default State (Has Past Bookings)
- **Content**: List of completed bookings grouped by month
- **Sections**: Current month, previous months
- **Pull-to-Refresh**: Available
- **Load More**: Available if > 10 bookings

### Empty State (No Past Bookings)
```
Icon: Calendar with checkmark (80x80pt)
Title: "No Past Bookings"
Message: "You haven't completed any services yet. Your booking history will appear here."
CTA: "Browse Services" button
```
- **Illustration**: Friendly empty state icon
- **CTA Action**: Navigate to Service Categories
- **Color**: Light gray (#F5F5F5)

### Loading State (Initial Load)
- **Show**: Skeleton cards (3 cards)
- **Animation**: Shimmer effect
- **Duration**: While fetching data
- **Fallback**: Show after 5 seconds if stuck

### Loading State (Pagination)
- **Show**: Spinner inside "Load More" button
- **Text**: "Loading..."
- **Disable**: Button disabled during load

### Error State (Network Error)
```
Icon: WiFi with slash (60x60pt)
Title: "Connection Error"
Message: "Unable to load your booking history. Please check your internet connection."
CTA: "Retry" button
```

### Filtered State
- **Badge**: Show "Filtered" badge near title
- **Count**: Show "Showing X of Y bookings"
- **Clear**: Tap badge to clear all filters
- **Empty**: "No bookings match your filters" if no results

### Search Results
- **Highlight**: Matching text highlighted in results
- **Empty**: "No bookings found for '{query}'"
- **Clear**: X button in search bar
- **Count**: Show number of results

## Dark Mode Variants

### Colors
- **Background**: #1E1E1E
- **Card Background**: #2A2A2A
- **Card Border**: #3A3A3A
- **Tab Switcher BG**: #2A2A2A
- **Selected Tab BG**: #3A3A3A
- **Text Primary**: #E0E0E0
- **Text Secondary**: #A0A0A0
- **Completed Border**: #28C76F (same)
- **Review Stars**: #FFD700 (same)
- **Shadows**: Reduced opacity (0.05)

## Accessibility

### VoiceOver Labels
- **Tab**: "Past bookings, tab, 2 of 3, selected"
- **Month Header**: "December 2024, heading"
- **Booking Card**: "Completed booking. AC Repair & Service. December 20, 2024 at 10 AM. Provider Rajesh Kumar, rated 4.8. You paid ₹949. You rated 5 stars."
- **Invoice Button**: "Download invoice, button"
- **Book Again**: "Book this service again, button"
- **Leave Review**: "Leave a review, button"

### VoiceOver Hints
- **Card**: "Double tap to view full booking details"
- **Invoice**: "Double tap to download and view invoice"
- **Book Again**: "Double tap to book this service again"
- **Review**: "Double tap to rate your experience"

### VoiceOver Groups
- Group card content logically:
  1. Status + Service info
  2. Date, time, provider
  3. Price
  4. Review (if exists)
  5. Actions (buttons)

### Dynamic Type Support
- All text scales from -2 to +3
- Card heights adjust dynamically
- Minimum button touch target: 44x44pt
- Icons remain fixed size
- Review text truncation adjusts with text size

### Color Contrast
- All text meets WCAG AA (4.5:1 minimum)
- Status badges have sufficient contrast
- Stars visible in both modes

### Reduced Motion
- Disable card entry animations
- Disable tab slide animations
- Use fade transitions only
- Maintain skeleton loading (static, no shimmer)

## Analytics Events

### Screen View
```json
{
  "screen_name": "past_bookings",
  "bookings_count": 15,
  "unreviewed_count": 3,
  "date_range_months": 6
}
```

### Booking Card Tapped
```json
{
  "event": "past_booking_viewed",
  "booking_id": "BK123456",
  "service_type": "ac_repair",
  "completed_date": "2024-12-20",
  "has_review": true
}
```

### Invoice Downloaded
```json
{
  "event": "invoice_downloaded",
  "booking_id": "BK123456",
  "amount": 949,
  "download_format": "pdf"
}
```

### Book Again Clicked
```json
{
  "event": "book_again_clicked",
  "booking_id": "BK123456",
  "service_id": "SVC789",
  "original_booking_date": "2024-12-20"
}
```

### Review Submitted
```json
{
  "event": "review_submitted",
  "booking_id": "BK123456",
  "provider_id": "PRV456",
  "rating": 5,
  "has_text_review": true,
  "tags": ["punctual", "professional"]
}
```

### Filter Applied
```json
{
  "event": "past_bookings_filtered",
  "filter_type": "service_category",
  "filter_value": "plumbing",
  "results_count": 5
}
```

### Search Performed
```json
{
  "event": "past_bookings_searched",
  "query": "plumbing",
  "results_count": 3
}
```

## SwiftUI Implementation

### View Structure
```swift
struct PastBookingsView: View {
    @StateObject private var viewModel = PastBookingsViewModel()
    @State private var showFilter = false
    @State private var showReviewSheet = false
    @State private var selectedBooking: Booking?

    var body: some View {
        ZStack {
            Color.gray100
                .ignoresSafeArea()

            if viewModel.pastBookings.isEmpty {
                EmptyHistoryView {
                    navigateToBrowse()
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        ForEach(viewModel.groupedBookings) { group in
                            Section(header: MonthSectionHeader(month: group.month)) {
                                ForEach(group.bookings) { booking in
                                    PastBookingCard(
                                        booking: booking,
                                        onTap: { navigateToDetail(booking) },
                                        onInvoiceTap: { downloadInvoice(booking) },
                                        onBookAgain: { bookAgain(booking) },
                                        onReviewTap: {
                                            selectedBooking = booking
                                            showReviewSheet = true
                                        }
                                    )
                                }
                            }
                        }

                        if viewModel.hasMore {
                            LoadMoreButton {
                                await viewModel.loadMore()
                            }
                        }
                    }
                }
                .refreshable {
                    await viewModel.refresh()
                }
            }
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
        .sheet(isPresented: $showReviewSheet) {
            if let booking = selectedBooking {
                ReviewSubmissionSheet(
                    booking: booking,
                    onSubmit: { rating, review, tags in
                        await viewModel.submitReview(
                            for: booking,
                            rating: rating,
                            review: review,
                            tags: tags
                        )
                        showReviewSheet = false
                    }
                )
            }
        }
        .onAppear {
            loadPastBookings()

            Analytics.logScreenView("past_bookings", parameters: [
                "bookings_count": viewModel.pastBookings.count,
                "unreviewed_count": viewModel.unreviewedCount
            ])
        }
    }

    private func loadPastBookings() {
        Task {
            await viewModel.loadPastBookings()
        }
    }

    private func navigateToDetail(_ booking: Booking) {
        HapticFeedback.medium()

        Analytics.logEvent("past_booking_viewed", parameters: [
            "booking_id": booking.id,
            "service_type": booking.service.category.rawValue,
            "has_review": booking.review != nil
        ])

        navigationController?.push(
            BookingDetailView(bookingId: booking.id)
        )
    }

    private func downloadInvoice(_ booking: Booking) {
        HapticFeedback.light()

        Analytics.logEvent("invoice_downloaded", parameters: [
            "booking_id": booking.id,
            "amount": booking.amount
        ])

        Task {
            do {
                let invoiceURL = try await viewModel.generateInvoice(for: booking)
                presentPDFViewer(invoiceURL)
            } catch {
                ToastManager.show("Failed to download invoice", type: .error)
            }
        }
    }

    private func bookAgain(_ booking: Booking) {
        HapticFeedback.medium()

        Analytics.logEvent("book_again_clicked", parameters: [
            "booking_id": booking.id,
            "service_id": booking.service.id
        ])

        navigationController?.push(
            ServiceDetailView(
                serviceId: booking.service.id,
                prefillAddress: booking.address
            )
        )
    }

    private func navigateToBrowse() {
        tabBarController?.selectedIndex = 1
    }
}
```

### ViewModel
```swift
class PastBookingsViewModel: ObservableObject {
    @Published var pastBookings: [Booking] = []
    @Published var filters: BookingFilters = BookingFilters()
    @Published var isLoading: Bool = false
    @Published var hasMore: Bool = true

    var groupedBookings: [BookingGroup] {
        groupBookingsByMonth(pastBookings)
    }

    var unreviewedCount: Int {
        pastBookings.filter { $0.review == nil }.count
    }

    private let bookingService: BookingService
    private var currentPage: Int = 0
    private let pageSize: Int = 10

    init() {
        self.bookingService = BookingService()
    }

    func loadPastBookings() async {
        isLoading = true
        currentPage = 0

        do {
            pastBookings = try await bookingService.fetchPastBookings(
                page: currentPage,
                limit: pageSize
            )

            hasMore = pastBookings.count == pageSize
            isLoading = false
        } catch {
            print("Error loading past bookings: \(error)")
            isLoading = false
        }
    }

    func loadMore() async {
        guard hasMore, !isLoading else { return }

        isLoading = true
        currentPage += 1

        do {
            let moreBookings = try await bookingService.fetchPastBookings(
                page: currentPage,
                limit: pageSize
            )

            pastBookings.append(contentsOf: moreBookings)
            hasMore = moreBookings.count == pageSize
            isLoading = false
        } catch {
            print("Error loading more bookings: \(error)")
            currentPage -= 1 // Revert page
            isLoading = false
        }
    }

    func refresh() async {
        await loadPastBookings()
    }

    func applyFilters() {
        // Apply filters to past bookings
        // Re-fetch from API with filter parameters
    }

    func submitReview(
        for booking: Booking,
        rating: Int,
        review: String?,
        tags: [String]
    ) async {
        do {
            let submittedReview = try await bookingService.submitReview(
                bookingId: booking.id,
                rating: rating,
                review: review,
                tags: tags
            )

            // Update local booking with review
            if let index = pastBookings.firstIndex(where: { $0.id == booking.id }) {
                pastBookings[index].review = submittedReview
            }

            ToastManager.show("Review submitted successfully")
            HapticFeedback.success()

            Analytics.logEvent("review_submitted", parameters: [
                "booking_id": booking.id,
                "rating": rating,
                "has_text_review": review != nil
            ])
        } catch {
            ToastManager.show("Failed to submit review", type: .error)
        }
    }

    func generateInvoice(for booking: Booking) async throws -> URL {
        return try await bookingService.generateInvoicePDF(booking.id)
    }

    private func groupBookingsByMonth(_ bookings: [Booking]) -> [BookingGroup] {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"

        var groups: [String: [Booking]] = [:]

        for booking in bookings {
            let monthKey = formatter.string(from: booking.dateTime)
            groups[monthKey, default: []].append(booking)
        }

        return groups.map { month, bookings in
            BookingGroup(
                month: month,
                bookings: bookings.sorted { $0.dateTime > $1.dateTime }
            )
        }.sorted { group1, group2 in
            // Sort groups by date (most recent first)
            guard let date1 = formatter.date(from: group1.month),
                  let date2 = formatter.date(from: group2.month) else {
                return false
            }
            return date1 > date2
        }
    }
}

struct BookingGroup: Identifiable {
    let id = UUID()
    let month: String
    let bookings: [Booking]
}
```

### Component: PastBookingCard
```swift
struct PastBookingCard: View {
    let booking: Booking
    let onTap: () -> Void
    let onInvoiceTap: () -> Void
    let onBookAgain: () -> Void
    let onReviewTap: (() -> Void)?

    @State private var isReviewExpanded = false

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                // Status Badge
                StatusBadge(status: .completed)

                // Service Info
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

                    Text(booking.dateTime.formatted(date: .abbreviated, time: .shortened))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.textSecondary)
                }

                // Provider
                HStack(spacing: 10) {
                    AsyncImage(url: URL(string: booking.provider?.photoURL ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray300
                    }
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())

                    Text(booking.provider?.name ?? "N/A")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(.textPrimary)

                    if let rating = booking.provider?.rating {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.yellow)

                            Text(String(format: "%.1f", rating))
                                .font(.system(size: 13))
                                .foregroundColor(.textSecondary)
                        }
                    }
                }

                // Price
                Text("₹\(Int(booking.amount))")
                    .font(.custom("Inter-SemiBold", size: 18))
                    .foregroundColor(.primary)

                // Review Section
                Divider()

                if let review = booking.review {
                    // Existing Review
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 4) {
                            ForEach(0..<5) { index in
                                Image(systemName: index < review.rating ? "star.fill" : "star")
                                    .font(.system(size: 14))
                                    .foregroundColor(index < review.rating ? .yellow : .gray400)
                            }

                            Text("You rated \(review.rating) star\(review.rating > 1 ? "s" : "")")
                                .font(.system(size: 13))
                                .foregroundColor(.textSecondary)
                        }

                        if let reviewText = review.text, !reviewText.isEmpty {
                            Text(reviewText)
                                .font(.system(size: 13))
                                .italic()
                                .foregroundColor(.textSecondary)
                                .lineLimit(isReviewExpanded ? nil : 2)
                                .onTapGesture {
                                    withAnimation {
                                        isReviewExpanded.toggle()
                                    }
                                }
                        }
                    }
                } else if let onReview = onReviewTap {
                    // Review CTA
                    Button(action: onReview) {
                        HStack {
                            Image(systemName: "star")
                                .font(.system(size: 16))
                                .foregroundColor(.warning)

                            Text("Rate your experience")
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

                // Action Buttons
                if booking.review != nil {
                    HStack(spacing: 12) {
                        Button(action: onInvoiceTap) {
                            HStack(spacing: 6) {
                                Image(systemName: "doc.text")
                                    .font(.system(size: 14))
                                Text("Invoice")
                                    .font(.custom("Inter-Medium", size: 14))
                            }
                            .foregroundColor(.textSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray300, lineWidth: 1)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())

                        Button(action: onBookAgain) {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 14))
                                Text("Book Again")
                                    .font(.custom("Inter-Medium", size: 14))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.primary)
                            .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
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
                Rectangle()
                    .fill(Color.success)
                    .frame(width: 4)
                    .cornerRadius(2, corners: [.topLeft, .bottomLeft]),
                alignment: .leading
            )
            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
        .padding(.bottom, 16)
    }
}
```

## Performance Optimization

### Data Loading
- **Pagination**: Load 10 bookings per page
- **Caching**: Cache past bookings locally (CoreData)
- **Lazy Loading**: Use LazyVStack for list
- **Image Caching**: Cache provider photos

### UI Optimization
- **Reuse**: Reuse booking cards
- **Minimize Re-renders**: Equatable conformance
- **Debounce Search**: 300ms delay
- **Skeleton Screens**: Show while loading

## Testing Checklist

### Functional
- ✅ Load past bookings on tab open
- ✅ Group bookings by month correctly
- ✅ Tap booking navigates to detail
- ✅ Download invoice works
- ✅ Book again creates new booking
- ✅ Leave review opens modal
- ✅ Submit review updates card
- ✅ Pagination loads more bookings
- ✅ Pull to refresh updates list
- ✅ Filter bookings works
- ✅ Search bookings works
- ✅ Empty state shows correctly

### Visual
- ✅ Light mode
- ✅ Dark mode
- ✅ iPhone SE (small screen)
- ✅ iPhone 14 Pro Max (large screen)
- ✅ Dynamic Type scaling
- ✅ VoiceOver navigation
- ✅ Review text truncation

### Edge Cases
- ✅ No past bookings (empty state)
- ✅ Very long service names
- ✅ Very long reviews
- ✅ Network error during load
- ✅ Failed invoice generation
- ✅ Review submission failure
- ✅ Missing provider info
