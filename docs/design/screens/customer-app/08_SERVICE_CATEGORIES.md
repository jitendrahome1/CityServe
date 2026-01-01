# 08 - Service Categories

**Screen ID:** 08
**Screen Name:** Service Categories (All Categories Grid)
**User Flow:** Home → "See All" (Categories) → Service Categories
**Entry Point:** Tap "See All" from Categories section on Home, or Services tab in bottom nav
**Bottom Tab:** Services tab selected (2 of 4-5 tabs)

---

## Overview

The service categories screen displays a comprehensive, searchable grid of all available service categories. Users can browse all offerings, search for specific categories, and navigate to detailed category pages to book services.

**Purpose:**
- Display all service categories in organized grid
- Enable quick category discovery via search
- Show category availability and popularity
- Provide clear navigation to specific services
- Display promotional badges (New, Popular, 20% off)
- Filter by city/location

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ‹  All Services       Delhi ▼  🔍     │ ← Top Bar
├────────────────────────────────────────┤
│                                        │
│  ┌────────────────────────────────┐   │
│  │  🔍 Search categories...       │   │ ← Search Bar
│  └────────────────────────────────┘   │
│                                        │
│  ┌─────────┬─────────┬─────────┐     │
│  │ Home    │ Repair  │ Beauty  │ ... │ ← Category Tabs
│  │ Services│         │         │     │   (Horizontal Scroll)
│  └─────────┴─────────┴─────────┘     │
│                                        │
│  ┌──────────┐ ┌──────────┐ ┌────────┐│
│  │ 🔧       │ │ 🚿       │ │ 💡 NEW │ ← Category Cards
│  │ AC       │ │ Plumbing │ │ Elect- ││   (2 columns)
│  │ Repair   │ │          │ │ rical  ││
│  │          │ │          │ │        ││
│  │ 23       │ │ 15       │ │ 12     ││ ← Service count
│  │ Services │ │ Services │ │Services││
│  │ ⭐4.8    │ │ ⭐4.7    │ │ ⭐4.9  ││ ← Avg rating
│  └──────────┘ └──────────┘ └────────┘│
│                                        │
│  ┌──────────┐ ┌──────────┐ ┌────────┐│
│  │ ✂️       │ │ 🧹 20%   │ │ 🎨     ││
│  │ Salon &  │ │ Cleaning │ │ Paint- ││
│  │ Spa      │ │ & Pest   │ │ ing &  ││
│  │          │ │ Control  │ │ Reno-  ││
│  │ 45       │ │ 18       │ │ vation ││
│  │ Services │ │ Services │ │ 8 Svc  ││
│  │ ⭐4.6    │ │ ⭐4.8    │ │ ⭐4.7  ││
│  └──────────┘ └──────────┘ └────────┘│
│                                        │
│  ┌──────────┐ ┌──────────┐            │
│  │ 🚗       │ │ 🛠️       │            │
│  │ Vehicle  │ │ Carpentry│            │
│  │ Service  │ │ & Furni- │            │
│  │          │ │ ture     │            │
│  │ 10       │ │ 14       │            │
│  │ Services │ │ Services │            │
│  │ ⭐4.5    │ │ ⭐4.6    │            │
│  └──────────┘ └──────────┘            │
│                                        │
│                                        │
├────────────────────────────────────────┤
│  🏠     📋     📅     💬     👤        │ ← Bottom Tab Bar
│  Home  Services Bookings Chat Profile │
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
Content Area: 390x (763 - 49 = 714pt)
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
│   ├─ Color: #333333 / #E0E0E0
│   ├─ Tap Target: 44x44pt
│   ├─ Position: 12pt from left
│   └─ Action: Navigate back (Home or previous)
│
└─ Title:
    ├─ Text: "All Services"
    ├─ Font: Inter SemiBold, 18pt
    ├─ Color: #1E1E1E / #E0E0E0
    └─ Position: 8pt from back button

Right Section:
├─ City Selector:
│   ├─ Text: "Delhi" (current city)
│   ├─ Icon: chevron.down, 14x14pt
│   ├─ Font: SF Pro Medium, 14pt
│   ├─ Color: #0D7377 (brand primary)
│   ├─ Tap Target: 44pt height
│   ├─ Position: 8pt from search button
│   └─ Action: Open city picker
│
└─ Search Button:
    ├─ Icon: magnifyingglass
    ├─ Size: 22x22pt
    ├─ Color: #666666 / #A0A0A0
    ├─ Tap Target: 44x44pt
    ├─ Position: 16pt from right edge
    └─ Action: Focus search bar (scroll to top)
```

### Search Bar
```
Position: 16pt below top bar (part of scroll view)
Padding: 16pt horizontal
Height: 48pt
Sticky: Optional (can make sticky on scroll)

Component:
├─ Border Radius: 12pt
├─ Background: White (#FFFFFF) / #2A2A2A
├─ Border: None
├─ Shadow: 0 2px 8px rgba(0,0,0,0.08)
└─ Layout: HStack (icon + text field + clear button)

Icon:
├─ Image: magnifyingglass
├─ Size: 20x20pt
├─ Color: #999999
├─ Position: 16pt from left edge
└─ Alignment: Vertical center

Text Field:
├─ Placeholder: "Search categories..."
├─ Font: SF Pro Regular, 15pt
├─ Color: #1E1E1E / #E0E0E0
├─ Placeholder Color: #999999
├─ Padding Left: 12pt from icon
├─ Keyboard: Default (alphabet)
├─ Autocorrect: No
└─ Live search: Updates results as user types

Clear Button (when text present):
├─ Icon: xmark.circle.fill
├─ Size: 20x20pt
├─ Color: #CCCCCC
├─ Position: 16pt from right edge
└─ Action: Clear search text
```

### Category Tabs (Filter Tabs)
```
Position: 16pt below search bar
Padding: 0pt left (scrollable), 16pt right
Height: 40pt
Scroll: Horizontal (snap to each tab)

Tab Layout:
├─ Layout: HStack in ScrollView
├─ Gap: 8pt between tabs
├─ Padding Left: 16pt
├─ Show Indicator: No (hide scrollbar)
└─ Tabs: "All", "Home Services", "Repairs", "Beauty", "Cleaning", etc.

Tab Pill:
├─ Height: 40pt
├─ Padding: 12pt horizontal
├─ Border Radius: 20pt (pill shape)
├─ Background:
│   ├─ Selected: #0D7377 (brand primary)
│   └─ Unselected: White (#FFFFFF) / #2A2A2A
├─ Border:
│   ├─ Selected: None
│   └─ Unselected: 1pt solid #E0E0E0 / #3A3A3A
├─ Shadow:
│   ├─ Selected: 0 2px 6px rgba(13,115,119,0.2)
│   └─ Unselected: 0 1px 3px rgba(0,0,0,0.06)
└─ Tap: Filter categories by tab

Tab Text:
├─ Font: SF Pro Medium, 14pt
├─ Color:
│   ├─ Selected: White (#FFFFFF)
│   └─ Unselected: #666666 / #A0A0A0
└─ Animation: Smooth transition on selection (200ms)
```

### Category Cards Grid
```
Position: 16pt below category tabs
Padding: 16pt horizontal
Layout: LazyVGrid, 2 columns
Gap: 12pt horizontal, 16pt vertical
Scroll: Part of main scroll view

Card Dimensions:
├─ Width: (390 - 32 - 12) / 2 = 173pt
├─ Height: 180pt (fixed)
├─ Border Radius: 16pt
├─ Background: White (#FFFFFF) / #2A2A2A
├─ Border: 1pt solid #F0F0F0 / #3A3A3A
├─ Shadow: 0 2px 8px rgba(0,0,0,0.08)
└─ Tap: Navigate to Category Detail

Card Content (VStack):
├─ Top Section (Icon + Badge):
│   ├─ Layout: ZStack (badge overlays icon)
│   ├─ Icon Container:
│   │   ├─ Size: 64x64pt
│   │   ├─ Background: Circle, light color tint (#F0F9FA for repairs)
│   │   ├─ Icon: Category icon (emoji or image), 32x32pt
│   │   ├─ Position: Centered horizontally, 16pt from top
│   │   └─ No border
│   │
│   └─ Badge (if applicable):
│       ├─ Text: "NEW" or "20% OFF" or "POPULAR"
│       ├─ Font: SF Pro Bold, 9pt
│       ├─ Color: White
│       ├─ Background:
│       │   ├─ NEW: #00CFE8 (info blue)
│       │   ├─ DISCOUNT: #FF6B35 (secondary orange)
│       │   └─ POPULAR: #FFC107 (warning yellow)
│       ├─ Border Radius: 8pt
│       ├─ Padding: 3pt vertical, 6pt horizontal
│       ├─ Position: Top-right corner of icon
│       └─ Shadow: 0 1px 3px rgba(0,0,0,0.15)
│
├─ Category Name:
│   ├─ Text: "AC Repair" or "Salon & Spa"
│   ├─ Font: Inter SemiBold, 16pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   ├─ Max Lines: 2
│   ├─ Alignment: Center
│   ├─ Position: 12pt below icon
│   └─ Truncation: Tail (if > 2 lines)
│
├─ Service Count:
│   ├─ Text: "23 Services" or "8 Svc" (abbreviated if long)
│   ├─ Font: SF Pro Regular, 12pt
│   ├─ Color: #999999
│   ├─ Alignment: Center
│   └─ Position: 6pt below name
│
└─ Rating:
    ├─ Layout: HStack (star icon + rating number)
    ├─ Icon: star.fill, 14x14pt, #FFC107 (yellow)
    ├─ Text: "4.8" (average rating)
    ├─ Font: SF Pro Medium, 14pt
    ├─ Color: #666666 / #A0A0A0
    ├─ Gap: 4pt
    ├─ Alignment: Center
    └─ Position: 8pt below service count
```

---

## Component Breakdown

### 1. Search Bar (Editable)
```
Component: SearchableTextField
Features:
├─ Live search (debounced 300ms)
├─ Filter categories by name
├─ Clear button
├─ Keyboard dismissal on scroll
└─ Auto-focus option
```

### 2. Category Filter Tabs
```
Component: HorizontalFilterTabs
Props:
├─ tabs: [String] (category groups)
├─ selectedTab: Binding<String>
├─ onSelect: (String) -> Void
└─ Scrollable with snap behavior
```

### 3. Category Card
```
Component: CategoryCard (reusable)
Props:
├─ category: Category model
├─ onTap: Navigate to Category Detail
└─ showBadge: Bool (NEW, DISCOUNT, POPULAR)

Used in:
├─ Service Categories (this screen)
├─ Home Screen (horizontal scroll)
└─ Search Results
```

---

## Animations & Transitions

### Screen Load Animation
```
Duration: 600ms
Easing: Ease Out

Sequence:
0ms   - Top bar slides down (from y:-56 to y:0)
100ms - Search bar fades in + slides up (10pt)
200ms - Category tabs fade in + slide up (10pt)
300ms - Category cards appear sequentially:
        ├─ Row 1 left card (0ms delay)
        ├─ Row 1 right card (50ms delay)
        ├─ Row 2 left card (100ms delay)
        ├─ Row 2 right card (150ms delay)
        └─ Continue for all visible cards
```

### Search Filter Animation
```
Trigger: User types in search bar
Duration: 300ms
Easing: Ease Out

Animation:
├─ Filtered-out cards: Fade out + scale down (1.0 → 0.95)
├─ Matching cards: Remain visible
├─ Grid reflows (smooth layout animation)
└─ Empty state appears if no matches
```

### Tab Selection Animation
```
Trigger: User taps a filter tab
Duration: 250ms
Easing: Ease Out

Animation:
├─ Selected tab: Background color animates to brand primary
├─ Selected tab: Text color animates to white
├─ Previous tab: Reverses (to white background, gray text)
├─ Categories filter to matching tab
└─ Grid reflows with filtered cards
```

### Card Tap Animation
```
Duration: 150ms
Easing: Ease Out

Press:
├─ Scale: 1.0 → 0.96
├─ Shadow: Reduces slightly
└─ Haptic: Light impact

Release:
├─ Scale: 0.96 → 1.0
├─ Shadow: Returns to normal
└─ Navigate to Category Detail
```

### Pull to Refresh
```
Trigger: User pulls down from top
Duration: 600ms

Animation:
├─ Activity indicator appears
├─ Refresh categories data
├─ Cards update with fade transition
└─ Indicator disappears
```

---

## States

### Default State (All Categories)
```
Status: All categories displayed
Visual:
├─ Search bar: Empty
├─ Filter tab: "All" selected
├─ Categories: Full grid visible (2 columns)
├─ Cards: Show all available categories
└─ Scroll: Enabled
```

### Loading State (Initial)
```
Status: Fetching categories from backend
Visual:
├─ Top bar: Visible immediately
├─ Search bar: Shimmer placeholder
├─ Filter tabs: Shimmer placeholders (5-6 pills)
├─ Category cards: Shimmer grid (6-8 placeholders)
└─ Duration: 1-2 seconds typical
```

### Searching State (Active Search)
```
Trigger: User types in search bar
Status: Filtering categories by search text
Visual:
├─ Search bar: Focused, text visible, clear button shown
├─ Filter tabs: Disabled (grayed out during search)
├─ Categories: Filtered to matching results
├─ Non-matching cards: Hidden (fade out)
└─ Results update live (debounced 300ms)
```

### Empty Search Results
```
Trigger: Search query returns no matches
Visual:
├─ Empty state component:
│   ├─ Icon: Magnifying glass (illustration)
│   ├─ Message: "No categories found"
│   ├─ Subtitle: "Try a different search term"
│   └─ CTA: "Clear Search" button
└─ Filter tabs: Hidden or disabled
```

### Tab Filtered State
```
Trigger: User selects a category tab (e.g., "Beauty")
Status: Categories filtered to tab group
Visual:
├─ Selected tab: Highlighted (brand primary background)
├─ Categories: Filtered to matching group
├─ Non-matching categories: Hidden
├─ Grid reflows to fit filtered results
└─ Search bar: Still active (can search within tab)
```

### No Categories Available (City)
```
Trigger: Selected city has no services yet
Visual:
├─ Empty state:
│   ├─ Icon: Location pin illustration
│   ├─ Message: "No services in your area yet"
│   ├─ Subtitle: "We're expanding soon!"
│   └─ CTA: "Change City" button
└─ All other elements: Hidden
```

### Error State (Network Failure)
```
Trigger: Initial data fetch fails
Visual:
├─ Error state component:
│   ├─ Icon: wifi.slash (no connection)
│   ├─ Message: "Unable to load categories"
│   ├─ Subtitle: "Check your connection"
│   └─ Button: "Retry"
└─ Top bar + bottom tab: Still visible
```

### Refreshing State (Pull to Refresh)
```
Trigger: User pulls down to refresh
Visual:
├─ Activity indicator at top
├─ Content slightly pulled down
├─ Refresh categories in background
├─ Update cards with new data
└─ Indicator disappears with bounce
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E (dark background)
Top Bar Background: #2A2A2A
Top Bar Border: #3A3A3A
Search Bar Background: #2A2A2A
Search Bar Border: #3A3A3A
Card Background: #2A2A2A
Card Border: #3A3A3A
Icon Background: Darker tints (e.g., #1A4A4C for repairs)
Text Primary: #E0E0E0
Text Secondary: #A0A0A0
Tab Selected: #0D7377 (same)
Tab Unselected Background: #2A2A2A
Tab Unselected Border: #3A3A3A
Badge: Same colors (sufficient contrast)
```

---

## Accessibility

### VoiceOver

**Element Labels:**
```
Back Button: "Back, button"
Title: "All Services, heading"
City Selector: "Delhi, City selector, button"
Search Button: "Search, button"
Search Field: "Search categories, search field"
Clear Button: "Clear search, button"
Tab: "All categories, tab, selected" or "Beauty, tab"
Category Card: "AC Repair, 23 services, 4.8 stars, NEW, button"
```

**Announcements:**
```
On screen appear: "All Services. 20 categories available."
On search: "Showing 5 results for 'clean'"
On empty search: "No categories found for 'xyz'"
On tab select: "Showing Beauty categories. 8 categories."
On network error: "Error. Unable to load categories."
```

**Focus Order:**
```
1. Back button
2. City selector
3. Search button
4. Search field
5. Clear button (if text)
6. Category tabs (left to right)
7. Category cards (row 1 left, row 1 right, row 2 left, etc.)
8. Bottom tab bar
```

### Dynamic Type

**Supported Sizes:** -2 to +3

**Scaling:**
```
Title: 18pt → 16pt (min) to 22pt (max)
Search placeholder: 15pt → 13pt (min) to 18pt (max)
Tab text: 14pt → 12pt (min) to 17pt (max)
Category name: 16pt → 14pt (min) to 19pt (max)
Service count: 12pt → 10pt (min) to 15pt (max)
Rating: 14pt → 12pt (min) to 17pt (max)

Layout Adjustments:
├─ At +2: Card height increases (180pt → 200pt)
├─ At +3: May switch to single column (1 card per row)
└─ Card spacing increases proportionally
```

### Reduced Motion

**If enabled:**
```
Screen load: Instant appear (no staggered animations)
Search filter: Instant update (no fade/scale)
Tab selection: Instant color change
Card tap: No scale animation
Pull to refresh: Standard indicator only
```

### Color Contrast

**WCAG AA (4.5:1):**
```
✅ Category name (#1E1E1E on #FFFFFF): 16.1:1
✅ Service count (#999999 on #FFFFFF): 4.5:1
✅ Rating (#666666 on #FFFFFF): 5.7:1
✅ Tab selected text (White on #0D7377): 5.2:1
✅ Tab unselected (#666666 on #FFFFFF): 5.7:1
✅ Dark mode name (#E0E0E0 on #2A2A2A): 11.4:1
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct ServiceCategoriesView: View {
    @StateObject private var viewModel = ServiceCategoriesViewModel()
    @State private var searchText: String = ""
    @State private var selectedTab: String = "All"
    @FocusState private var isSearchFocused: Bool

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack(alignment: .top) {
            Color.gray100.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    // Search Bar
                    SearchBar(text: $searchText, isFocused: $isSearchFocused)
                        .padding(.top, 72) // Top bar + padding
                        .padding(.horizontal, 16)

                    // Category Filter Tabs
                    CategoryFilterTabs(
                        tabs: viewModel.categoryTabs,
                        selectedTab: $selectedTab
                    )
                    .disabled(!searchText.isEmpty) // Disable during search

                    // Category Cards Grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredCategories) { category in
                            CategoryCard(category: category)
                                .onTapGesture {
                                    navigateToCategoryDetail(category)
                                }
                        }
                    }
                    .padding(.horizontal, 16)

                    // Empty State
                    if filteredCategories.isEmpty {
                        EmptySearchState(searchText: searchText)
                            .padding(.top, 40)
                    }

                    Spacer(minLength: 40)
                }
            }
            .refreshable {
                await viewModel.refreshCategories()
            }

            // Top Navigation Bar (Fixed)
            CustomNavigationBar(
                title: "All Services",
                showBackButton: true,
                rightItems: [
                    .citySelector(selectedCity: $viewModel.selectedCity),
                    .search(action: focusSearch)
                ]
            )
        }
        .onAppear {
            viewModel.loadCategories()
        }
    }

    private var filteredCategories: [Category] {
        viewModel.categories
            .filter { category in
                // Filter by search text
                if !searchText.isEmpty {
                    return category.name.localizedCaseInsensitiveContains(searchText)
                }
                // Filter by selected tab
                if selectedTab != "All" {
                    return category.group == selectedTab
                }
                return true
            }
    }

    private func navigateToCategoryDetail(_ category: Category) {
        // Navigate to Category Detail Screen
    }

    private func focusSearch() {
        isSearchFocused = true
    }
}
```

### ViewModel

```swift
@MainActor
class ServiceCategoriesViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var categoryTabs: [String] = ["All", "Home Services", "Repairs", "Beauty", "Cleaning"]
    @Published var selectedCity: City = .delhi
    @Published var isLoading: Bool = true

    func loadCategories() {
        isLoading = true

        Task {
            // Fetch from Firestore
            let fetchedCategories = await fetchCategories(city: selectedCity)
            self.categories = fetchedCategories
            self.isLoading = false
        }
    }

    func refreshCategories() async {
        let fetchedCategories = await fetchCategories(city: selectedCity)
        self.categories = fetchedCategories
    }

    private func fetchCategories(city: City) async -> [Category] {
        // Simulated fetch
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return Category.mockData
    }
}
```

---

## Assets Required

### SF Symbols
```
- chevron.left (Back button)
- chevron.down (City selector)
- magnifyingglass (Search icon)
- xmark.circle.fill (Clear search)
- star.fill (Rating)
```

### Category Icons
```
From ASSETS_CHECKLIST.md (50+ icons):
- ac-repair.svg
- plumbing.svg
- electrical.svg
- salon-spa.svg
- cleaning.svg
- painting.svg
- carpentry.svg
- vehicle-service.svg
- pest-control.svg
... (all category icons)
```

---

## Navigation Flow

### Entry Points
```
1. From Home: Tap "See All" in Categories section
   └─ Transition: Slide in from right (300ms)

2. From Bottom Tab: Tap "Services" tab
   └─ Transition: Tab switch animation

3. From Search: Breadcrumb navigation
   └─ Transition: Pop navigation
```

### Exit Points
```
1. Tap Category Card → Category Detail Screen
   └─ Transition: Slide in from right
   └─ Data: { categoryId, categoryName }

2. Tap Back → Return to previous screen (Home)
   └─ Transition: Slide out to right (pop)

3. Tap City Selector → City Picker Bottom Sheet
   └─ Transition: Sheet from bottom

4. Bottom Tab Taps → Other screens
   └─ Transition: Tab switch
```

---

## Error Handling

### Network Error
```
Action:
├─ Show error state with retry button
├─ Cache last loaded categories (show stale)
├─ Toast: "Using cached data"
└─ Allow retry
```

### Empty Categories (City)
```
Action:
├─ Show empty state
├─ Message: "No services in your area"
├─ CTA: "Change City"
└─ Allow city change
```

---

## Testing Checklist

- [ ] Screen loads within 2 seconds
- [ ] All categories displayed (2 column grid)
- [ ] Search filters categories correctly
- [ ] Search is debounced (300ms)
- [ ] Clear button works
- [ ] Category tabs filter correctly
- [ ] Tab selection animates smoothly
- [ ] Cards navigate to detail
- [ ] Pull to refresh works
- [ ] Empty search state shows
- [ ] City selector works
- [ ] Badges display correctly (NEW, 20% OFF)
- [ ] Dark mode renders correctly
- [ ] VoiceOver works
- [ ] Dynamic Type scales
- [ ] Reduced Motion respected
- [ ] Works on all device sizes
- [ ] No memory leaks

---

## Analytics Events

```swift
// Screen view
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "service_categories",
    "city": selectedCity.name
])

// Search performed
Analytics.logEvent("categories_searched", parameters: [
    "query": searchText,
    "results_count": filteredCategories.count
])

// Tab selected
Analytics.logEvent("category_tab_selected", parameters: [
    "tab": selectedTab
])

// Category tapped
Analytics.logEvent("category_tapped", parameters: [
    "category_id": category.id,
    "category_name": category.name,
    "source": "categories_screen"
])
```

---

## Design Rationale

**Why this design:**

- **Grid layout**: Efficient space use, scannable
- **Search prominence**: Quick filtering
- **Filter tabs**: Group related categories
- **Badges**: Highlight new/promoted categories
- **Service count**: Sets expectations
- **Rating display**: Social proof

**Alternatives Considered:**

- List view: Less efficient space use
- No search: Harder to find specific category
- No tabs: Overwhelming number of categories
- Larger cards: Fewer categories per screen, more scrolling

---

**This categories screen is the service discovery hub. It must be scannable, searchable, and make finding the right category effortless.**
