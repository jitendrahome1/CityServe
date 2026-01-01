# 09 - Category Detail

**Screen ID:** 09
**Screen Name:** Category Detail
**User Flow:** Service Categories → Category Card Tap → Category Detail
**Entry Point:** Tap any category card from Categories screen or Home
**Purpose:** Display all services within a specific category

---

## Overview

The category detail screen shows all available services within a selected category (e.g., "AC Repair"). Users can browse services, see pricing, ratings, and navigate to individual service details to book.

**Purpose:**
- Display all services in the selected category
- Show service pricing, ratings, and availability
- Enable service comparison within category
- Provide filtering and sorting options
- Quick access to popular/recommended services
- Navigate to service detail for booking

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ‹  AC Repair & Services        🔍 ⋮  │ ← Top Bar
├────────────────────────────────────────┤
│  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  │
│  ┃ [Category Hero Image]          ┃  │ ← Hero Banner
│  ┃ AC Repair & Services           ┃  │   (150pt height)
│  ┃ 23 Services Available          ┃  │
│  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  │
│                                        │
│  ┌─────────┬─────────┬─────────┐     │
│  │ All     │ Repair  │ Install │ ... │ ← Service Type Tabs
│  └─────────┴─────────┴─────────┘     │   (Horizontal Scroll)
│                                        │
│  Sort: Popular ▼    Filter  🎛️       │ ← Sort & Filter Bar
│                                        │
│  ┌────────────────────────────────┐   │
│  │ [Image] 🔧                     │   │ ← Service Card
│  │                                │   │   (List view)
│  │ AC Service & Gas Refill        │   │
│  │ ⭐4.9 (234) • 30-45 min        │   │
│  │                                │   │
│  │ Starting from ₹499      →      │   │
│  └────────────────────────────────┘   │
│                                        │
│  ┌────────────────────────────────┐   │
│  │ [Image] 🔧                     │   │
│  │                                │   │
│  │ AC Installation (Window/Split) │   │
│  │ ⭐4.8 (156) • 2-3 hours        │   │
│  │                                │   │
│  │ Starting from ₹999      →      │   │
│  └────────────────────────────────┘   │
│                                        │
│  ┌────────────────────────────────┐   │
│  │ [Image] 🔧 20% OFF             │   │
│  │                                │   │
│  │ AC Repair (All Brands)         │   │
│  │ ⭐4.7 (89) • 45-60 min         │   │
│  │                                │   │
│  │ ₹799  ₹999          →          │   │ ← Discounted price
│  └────────────────────────────────┘   │
│                                        │
│  ...                                   │
│                                        │
├────────────────────────────────────────┤
│  🏠     📋     📅     💬     👤        │ ← Bottom Tab Bar
└────────────────────────────────────────┘
```

---

## Layout Specifications

### Screen Dimensions
```
Device: iPhone 14 (390x844pt)
Safe Area Top: 47pt
Safe Area Bottom: 34pt
Tab Bar Height: 49pt
Content Area: 390x714pt
Scrollable: Yes (vertical, full screen)
```

### Background
```
Color: #F5F5F5 (light gray) / #1E1E1E (dark)
```

### Top Navigation Bar
```
Position: Fixed at top, 0pt from safe area
Height: 56pt
Background: White (#FFFFFF) / #2A2A2A
Border Bottom: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 2px 4px rgba(0,0,0,0.04)

Left Section:
├─ Back Button:
│   ├─ Icon: chevron.left
│   ├─ Size: 24x24pt
│   ├─ Tap Target: 44x44pt
│   └─ Action: Navigate back
│
└─ Title:
    ├─ Text: "AC Repair & Services" (category name)
    ├─ Font: Inter SemiBold, 17pt
    ├─ Color: #1E1E1E / #E0E0E0
    ├─ Max Lines: 1
    ├─ Truncation: Tail
    └─ Position: 8pt from back button

Right Section:
├─ Search Button:
│   ├─ Icon: magnifyingglass
│   ├─ Size: 22x22pt
│   ├─ Color: #666666
│   ├─ Tap Target: 44x44pt
│   └─ Action: Navigate to Search (pre-filled with category)
│
└─ More Button (Optional):
    ├─ Icon: ellipsis (3 dots vertical)
    ├─ Size: 22x22pt
    ├─ Color: #666666
    ├─ Tap Target: 44x44pt
    ├─ Action: Show action sheet (Share, Favorite)
    └─ Position: 16pt from right edge
```

### Hero Banner
```
Position: Top of scroll view (0pt from safe area)
Height: 150pt
Background: Linear gradient or image
Shadow: None

Background:
├─ Option 1: Category image (hero photo)
├─ Option 2: Solid color gradient (brand colors)
├─ Overlay: Semi-transparent gradient (dark bottom)
└─ Blur: Optional subtle blur on image

Content:
├─ Category Icon:
│   ├─ Size: 56x56pt
│   ├─ Position: 20pt from left, 24pt from top
│   ├─ Background: White circle with shadow
│   ├─ Icon: Category icon, 28x28pt
│   └─ Border: 2pt solid white
│
├─ Category Name:
│   ├─ Text: "AC Repair & Services"
│   ├─ Font: Inter Bold, 24pt
│   ├─ Color: White
│   ├─ Shadow: 0 1px 3px rgba(0,0,0,0.3) (text shadow for readability)
│   ├─ Position: 20pt from left, 90pt from top
│   └─ Max Width: 280pt
│
└─ Service Count:
    ├─ Text: "23 Services Available"
    ├─ Font: SF Pro Medium, 14pt
    ├─ Color: White 80% opacity
    ├─ Position: 20pt from left, 8pt below name
    └─ Icon (optional): checkmark.circle.fill, 14x14pt
```

### Service Type Tabs (Filter)
```
Position: 16pt below hero banner (part of scroll)
Padding: 0pt left (scrollable), 16pt right
Height: 40pt
Sticky: Optional (can make sticky on scroll)

Tab Pill:
├─ Height: 40pt
├─ Padding: 14pt horizontal
├─ Border Radius: 20pt (pill)
├─ Gap: 8pt between pills
├─ Scroll: Horizontal
│
├─ Selected:
│   ├─ Background: #0D7377 (brand primary)
│   ├─ Text Color: White
│   └─ Shadow: 0 2px 6px rgba(13,115,119,0.2)
│
└─ Unselected:
    ├─ Background: White / #2A2A2A
    ├─ Text Color: #666666 / #A0A0A0
    ├─ Border: 1pt solid #E0E0E0 / #3A3A3A
    └─ Shadow: 0 1px 3px rgba(0,0,0,0.06)

Tabs: "All", "Repair", "Installation", "Maintenance", etc.
```

### Sort & Filter Bar
```
Position: 16pt below service type tabs
Padding: 16pt horizontal
Height: 44pt
Background: Transparent

Layout: HStack with space between

Sort Dropdown:
├─ Text: "Sort: Popular"
├─ Icon: chevron.down, 14x14pt
├─ Font: SF Pro Medium, 14pt
├─ Color: #1E1E1E / #E0E0E0
├─ Tap Target: 44pt height
├─ Action: Show sort options (bottom sheet)
│   ├─ Popular (default)
│   ├─ Price: Low to High
│   ├─ Price: High to Low
│   ├─ Rating: High to Low
│   └─ Newest First
└─ Underline: Shows current selection

Filter Button:
├─ Icon: slider.horizontal.3 (filter icon)
├─ Text: "Filter"
├─ Badge: Red dot if filters applied
├─ Font: SF Pro Medium, 14pt
├─ Color: #0D7377 (brand primary) if active
├─ Tap Target: 44pt height
├─ Action: Show filter bottom sheet
│   ├─ Price range
│   ├─ Rating (4+, 4.5+)
│   ├─ Duration
│   └─ Availability (Today, Tomorrow, This Week)
└─ Gap: 12pt from sort dropdown
```

### Service List (Cards)
```
Position: 16pt below sort/filter bar
Padding: 16pt horizontal
Layout: Vertical list (LazyVStack)
Gap: 16pt between cards
Scroll: Part of main scroll view

Service Card:
├─ Width: Full (358pt)
├─ Height: Dynamic (min 120pt)
├─ Border Radius: 16pt
├─ Background: White (#FFFFFF) / #2A2A2A
├─ Border: 1pt solid #F0F0F0 / #3A3A3A
├─ Shadow: 0 2px 8px rgba(0,0,0,0.08)
├─ Padding: 12pt
└─ Tap: Navigate to Service Detail

Card Layout (HStack):

Left Section (Image):
├─ Width: 96pt
├─ Height: 96pt
├─ Border Radius: 12pt
├─ Image: Service photo or icon
├─ Background: #F5F5F5 if no image
├─ Object Fit: Cover (aspect ratio maintained)
└─ Badge (if applicable):
    ├─ Position: Top-right corner of image
    ├─ Text: "20% OFF" or "NEW"
    ├─ Font: SF Pro Bold, 10pt
    ├─ Color: White
    ├─ Background: #FF6B35 (discount) or #00CFE8 (new)
    ├─ Padding: 4pt vertical, 8pt horizontal
    ├─ Border Radius: 8pt
    └─ Shadow: 0 1px 3px rgba(0,0,0,0.2)

Right Section (Details):
├─ Padding Left: 12pt from image
├─ Flex: 1 (fills remaining space)
└─ Content (VStack, left-aligned):
    │
    ├─ Service Name:
    │   ├─ Text: "AC Service & Gas Refill"
    │   ├─ Font: Inter SemiBold, 16pt
    │   ├─ Color: #1E1E1E / #E0E0E0
    │   ├─ Max Lines: 2
    │   └─ Truncation: Tail
    │
    ├─ Meta Info (HStack):
    │   ├─ Rating:
    │   │   ├─ Icon: star.fill, 14x14pt, #FFC107
    │   │   ├─ Text: "4.9"
    │   │   ├─ Font: SF Pro Medium, 13pt
    │   │   └─ Color: #666666 / #A0A0A0
    │   │
    │   ├─ Review Count:
    │   │   ├─ Text: "(234)"
    │   │   ├─ Font: SF Pro Regular, 12pt
    │   │   ├─ Color: #999999
    │   │   └─ Position: 2pt from rating
    │   │
    │   ├─ Separator: "•"
    │   │
    │   └─ Duration:
    │       ├─ Icon: clock (optional), 12x12pt
    │       ├─ Text: "30-45 min"
    │       ├─ Font: SF Pro Regular, 12pt
    │       └─ Color: #999999
    │
    ├─ Spacer (flex)
    │
    └─ Price Section (HStack, bottom):
        ├─ Layout: HStack with space between
        │
        ├─ Price:
        │   ├─ Original Price (if discount):
        │   │   ├─ Text: "₹999"
        │   │   ├─ Font: SF Pro Regular, 14pt
        │   │   ├─ Color: #999999
        │   │   ├─ Strikethrough: Yes
        │   │   └─ Position: Before current price
        │   │
        │   └─ Current Price:
        │       ├─ Text: "Starting from ₹499" or "₹499"
        │       ├─ Font: Inter SemiBold, 17pt
        │       ├─ Color: #0D7377 (brand primary)
        │       └─ Discount color: #FF6B35 (if discounted)
        │
        └─ Arrow Icon:
            ├─ Icon: chevron.right
            ├─ Size: 20x20pt
            ├─ Color: #CCCCCC
            └─ Position: Right edge, vertical center
```

---

## Component Breakdown

### 1. Hero Banner
```
Component: CategoryHeroBanner
Props:
├─ category: Category model
├─ serviceCount: Int
└─ backgroundImage: Optional URL
```

### 2. Service Type Tabs
```
Component: HorizontalFilterTabs (reused)
Props:
├─ tabs: [String] (service types within category)
├─ selectedTab: Binding<String>
└─ onSelect: Filter services by type
```

### 3. Sort & Filter Bar
```
Component: SortFilterBar
Props:
├─ selectedSort: Binding<SortOption>
├─ hasActiveFilters: Bool (shows badge)
├─ onSortTap: Show sort bottom sheet
└─ onFilterTap: Show filter bottom sheet
```

### 4. Service List Card
```
Component: ServiceListCard (reusable)
Props:
├─ service: Service model
├─ onTap: Navigate to Service Detail
└─ Layout: Horizontal (image left, details right)

Used in:
├─ Category Detail (this screen)
├─ Search Results
└─ Favorites
```

---

## Animations & Transitions

### Screen Load Animation
```
Duration: 600ms
Easing: Ease Out

Sequence:
0ms   - Hero banner fades in (from opacity 0)
100ms - Service type tabs slide up (10pt)
200ms - Sort/filter bar slides up (10pt)
300ms - Service cards appear sequentially (100ms delay each)
```

### Sort/Filter Applied
```
Trigger: User applies sort or filter
Duration: 400ms

Animation:
├─ Service list fades out (200ms)
├─ Re-sort/filter data
├─ Service list fades in with new order (200ms)
├─ Scroll to top (if needed)
└─ Show toast: "Sorted by Price" or "2 filters applied"
```

### Service Card Tap
```
Duration: 150ms

Press:
├─ Scale: 1.0 → 0.98
├─ Shadow: Slightly reduces
└─ Haptic: Light impact

Release:
├─ Scale: 0.98 → 1.0
└─ Navigate to Service Detail
```

---

## States

### Default State
```
Visual:
├─ Hero banner: Category image + name
├─ Service types: "All" selected
├─ Sort: "Popular"
├─ Filters: None applied
├─ Services: Full list displayed
└─ Cards: Vertical scrollable list
```

### Loading State
```
Visual:
├─ Hero banner: Solid color (no shimmer)
├─ Service type tabs: Shimmer (3-4 pills)
├─ Sort/filter bar: Visible
├─ Service cards: Shimmer (4-5 cards)
└─ Duration: 1-2 seconds
```

### Filtered State (Type Selected)
```
Trigger: User selects "Repair" tab
Visual:
├─ Selected tab: Highlighted (brand primary)
├─ Services: Filtered to "Repair" only
├─ Other services: Hidden
└─ Empty state if no services in type
```

### Sorted State
```
Trigger: User selects sort option
Visual:
├─ Sort button: Shows selected option
├─ Services: Re-ordered
├─ Toast: "Sorted by Price: Low to High" (dismisses after 2s)
└─ List scrolls to top
```

### Filtered State (Filters Applied)
```
Trigger: User applies filters (price, rating, etc.)
Visual:
├─ Filter button: Red badge dot
├─ Services: Filtered list
├─ Count badge: "Showing 8 of 23 services"
├─ "Clear Filters" button appears (optional)
└─ Empty state if no matches
```

### Empty State (No Services)
```
Trigger: Category has no services (or all filtered out)
Visual:
├─ Empty state component:
│   ├─ Icon: Illustration (magnifying glass)
│   ├─ Message: "No services found"
│   ├─ Subtitle: "Try adjusting your filters"
│   └─ CTA: "Clear Filters" button
└─ Hero banner: Still visible
```

### Error State
```
Trigger: Failed to load services
Visual:
├─ Error component:
│   ├─ Icon: wifi.slash
│   ├─ Message: "Unable to load services"
│   └─ Button: "Retry"
└─ Hero banner: Still visible
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E
Hero Overlay: Darker gradient
Card Background: #2A2A2A
Card Border: #3A3A3A
Text Primary: #E0E0E0
Text Secondary: #A0A0A0
Price: #14A0A5 (lighter teal)
Tab Selected: #0D7377
```

---

## Accessibility

### VoiceOver

**Labels:**
```
Back Button: "Back, button"
Search: "Search within AC Repair, button"
More: "More options, button"
Hero: "AC Repair & Services, 23 services available, heading"
Tab: "All services, tab, selected"
Sort: "Sort: Popular, button"
Filter: "Filter, 2 filters applied, button"
Service Card: "AC Service & Gas Refill, ₹499, 4.9 stars, 234 reviews, 30-45 minutes, button"
```

### Dynamic Type

**Scaling:** -2 to +3
```
Category name: 24pt → 20pt (min) to 30pt (max)
Service name: 16pt → 14pt (min) to 19pt (max)
Meta info: 13pt → 11pt (min) to 16pt (max)
Price: 17pt → 15pt (min) to 20pt (max)
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct CategoryDetailView: View {
    let category: Category
    @StateObject private var viewModel: CategoryDetailViewModel
    @State private var selectedType: String = "All"
    @State private var selectedSort: SortOption = .popular
    @State private var activeFilters: [Filter] = []
    @State private var showSortSheet: Bool = false
    @State private var showFilterSheet: Bool = false

    init(category: Category) {
        self.category = category
        _viewModel = StateObject(wrappedValue: CategoryDetailViewModel(categoryId: category.id))
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.gray100.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    // Hero Banner
                    CategoryHeroBanner(
                        category: category,
                        serviceCount: viewModel.services.count
                    )

                    // Service Type Tabs
                    HorizontalFilterTabs(
                        tabs: viewModel.serviceTypes,
                        selectedTab: $selectedType
                    )
                    .padding(.top, 16)

                    // Sort & Filter Bar
                    SortFilterBar(
                        selectedSort: $selectedSort,
                        hasActiveFilters: !activeFilters.isEmpty,
                        onSortTap: { showSortSheet = true },
                        onFilterTap: { showFilterSheet = true }
                    )

                    // Service Cards
                    LazyVStack(spacing: 16) {
                        ForEach(filteredServices) { service in
                            ServiceListCard(service: service)
                                .onTapGesture {
                                    navigateToServiceDetail(service)
                                }
                        }
                    }
                    .padding(.horizontal, 16)

                    if filteredServices.isEmpty {
                        EmptyServicesState()
                            .padding(.top, 40)
                    }

                    Spacer(minLength: 40)
                }
            }

            // Top Bar
            CustomNavigationBar(
                title: category.name,
                showBackButton: true,
                rightItems: [.search, .more]
            )
        }
        .sheet(isPresented: $showSortSheet) {
            SortOptionsSheet(selectedSort: $selectedSort)
        }
        .sheet(isPresented: $showFilterSheet) {
            FilterSheet(activeFilters: $activeFilters)
        }
        .onAppear {
            viewModel.loadServices()
        }
    }

    private var filteredServices: [Service] {
        viewModel.services
            .filter { service in
                // Filter by type
                if selectedType != "All" {
                    guard service.type == selectedType else { return false }
                }
                // Apply filters (price, rating, etc.)
                return passesFilters(service, filters: activeFilters)
            }
            .sorted(by: selectedSort.comparator)
    }

    private func passesFilters(_ service: Service, filters: [Filter]) -> Bool {
        // Implement filter logic
        return true
    }

    private func navigateToServiceDetail(_ service: Service) {
        // Navigate
    }
}
```

---

## Assets Required

### SF Symbols
```
- chevron.left
- magnifyingglass
- ellipsis
- chevron.down
- slider.horizontal.3
- star.fill
- clock
- chevron.right
```

### Images
```
- Category hero images (optional)
- Service photos (from backend)
```

---

## Navigation Flow

### Entry
```
From Categories → Category Card Tap
Transition: Slide in from right
Data: { categoryId, categoryName }
```

### Exit
```
1. Service Card Tap → Service Detail
2. Back Button → Categories
3. Search → Search Screen (category pre-filtered)
```

---

## Testing Checklist

- [ ] Hero banner displays correctly
- [ ] Service types filter correctly
- [ ] Sort options work (Popular, Price, Rating)
- [ ] Filters apply correctly
- [ ] Filter badge shows when active
- [ ] Service cards navigate to detail
- [ ] Empty state shows when no services
- [ ] Pull to refresh works
- [ ] Dark mode correct
- [ ] VoiceOver works
- [ ] Dynamic Type scales
- [ ] Works on all devices

---

## Analytics

```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "category_detail",
    "category_id": category.id,
    "category_name": category.name
])

Analytics.logEvent("service_type_selected", parameters: [
    "category": category.name,
    "type": selectedType
])

Analytics.logEvent("services_sorted", parameters: [
    "sort_by": selectedSort.rawValue
])

Analytics.logEvent("services_filtered", parameters: [
    "filters": activeFilters.map { $0.description }
])
```

---

**This category detail screen is the service browsing experience. It must be scannable, filterable, and make service comparison easy.**
