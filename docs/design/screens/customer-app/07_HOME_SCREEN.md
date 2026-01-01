# 07 - Home Screen

**Screen ID:** 07
**Screen Name:** Home Screen
**User Flow:** Login/Splash → Home (Main Dashboard)
**Entry Point:** After successful login or app launch (authenticated user)
**Bottom Tab:** Home tab selected (1 of 4-5 tabs)

---

## Overview

The home screen is the primary dashboard and landing page for authenticated users. It provides quick access to popular services, personalized recommendations, promotions, and navigation to all major app features.

**Purpose:**
- Welcome users and display personalized content
- Show popular and trending services
- Display active promotions and offers
- Provide quick search functionality
- Enable city/location selection
- Show user's recent bookings or activity
- Navigation hub to all app sections

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ≡  Delhi ▼            🔍  🔔          │ ← Top Bar
├────────────────────────────────────────┤
│                                        │
│  Good afternoon, Rahul! 👋             │ ← Greeting
│  What service do you need today?       │
│                                        │
│  ┌────────────────────────────────┐   │
│  │  🔍 Search services...         │   │ ← Search Bar
│  └────────────────────────────────┘   │
│                                        │
│  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓   │
│  ┃ [Promo Banner Image]          ┃   │ ← Featured Promo
│  ┃ 🎉 20% off first booking!     ┃   │   (Horizontal Scroll)
│  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛   │
│                                        │
│  Popular Services              →       │ ← Section Header
│                                        │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ │
│  │ 🔧      │ │ 🚿      │ │ 💡      │ │ ← Service Cards
│  │ AC      │ │ Plumb-  │ │ Elect-  │ │   (2x3 grid)
│  │ Repair  │ │ ing     │ │ rical   │ │
│  │ ⭐4.8   │ │ ⭐4.7   │ │ ⭐4.9   │ │
│  │ ₹499   │ │ ₹349    │ │ ₹299    │ │
│  └─────────┘ └─────────┘ └─────────┘ │
│                                        │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ │
│  │ ✂️      │ │ 🧹      │ │ 🎨      │ │
│  │ Salon   │ │ Clean-  │ │ Paint-  │ │
│  │ @Home   │ │ ing     │ │ ing     │ │
│  │ ⭐4.6   │ │ ⭐4.8   │ │ ⭐4.7   │ │
│  │ ₹799   │ │ ₹599    │ │ ₹1999   │ │
│  └─────────┘ └─────────┘ └─────────┘ │
│                                        │
│  Categories                     →      │ ← Section Header
│                                        │
│  [All Categories Grid/Scroll] ──────▶ │ ← Horizontal scroll
│                                        │
│  Your Recent Bookings           →      │ ← Section Header
│                                        │
│  ┌────────────────────────────────┐   │
│  │ 🔧 AC Repair             ●  │   │ ← Booking Card
│  │ Today, 3:00 PM          Active│   │
│  │ Rahul Kumar - Provider        │   │
│  └────────────────────────────────┘   │
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
Safe Area Top: 47pt (status bar + notch)
Safe Area Bottom: 34pt (home indicator)
Tab Bar Height: 49pt
Content Area: 390x (763 - 49 - 47 = 667pt)
Scrollable: Yes (vertical scroll for all content)
```

### Background
```
Color: #F5F5F5 (light gray background) / #1E1E1E (dark)
Reason: Subtle background differentiates cards from canvas
```

### Top Navigation Bar
```
Position: Fixed at top, 0pt from safe area
Height: 56pt
Background: White (#FFFFFF) / Dark (#2A2A2A)
Border Bottom: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 2px 4px rgba(0,0,0,0.04)
Layout: HStack with space between

Left Section (Menu + City):
├─ Menu Button:
│   ├─ Icon: line.3.horizontal (hamburger menu)
│   ├─ Size: 24x24pt
│   ├─ Color: #333333 / #E0E0E0
│   ├─ Tap Target: 44x44pt
│   ├─ Position: 8pt from left edge
│   └─ Action: Open side drawer/menu
│
└─ City Selector:
    ├─ Text: "Delhi" (current city)
    ├─ Icon: chevron.down, 16x16pt
    ├─ Font: SF Pro Medium, 16pt
    ├─ Color: #0D7377 (brand primary)
    ├─ Tap Target: 44pt height
    ├─ Position: 8pt from menu button
    └─ Action: Open city selection bottom sheet

Right Section (Search + Notifications):
├─ Search Button:
│   ├─ Icon: magnifyingglass
│   ├─ Size: 22x22pt
│   ├─ Color: #666666 / #A0A0A0
│   ├─ Tap Target: 44x44pt
│   ├─ Position: 8pt from notifications
│   └─ Action: Navigate to Search Screen
│
└─ Notifications Button:
    ├─ Icon: bell.fill
    ├─ Size: 22x22pt
    ├─ Color: #666666 / #A0A0A0
    ├─ Badge: Red dot (8pt diameter) if unread
    ├─ Tap Target: 44x44pt
    ├─ Position: 16pt from right edge
    └─ Action: Navigate to Notifications Screen
```

### Greeting Section
```
Position: 16pt below top bar
Padding: 16pt horizontal
Background: Transparent

Greeting Text:
├─ Text: "Good [morning/afternoon/evening], [Name]! 👋"
│   ├─ Dynamic based on time of day:
│   │   ├─ 5am-12pm: "Good morning"
│   │   ├─ 12pm-6pm: "Good afternoon"
│   │   └─ 6pm-5am: "Good evening"
│   ├─ Name: User's first name from profile
│   ├─ Emoji: Wave hand (👋)
│   ├─ Font: Inter SemiBold, 20pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   └─ Letter Spacing: -0.3pt

Subtitle:
├─ Text: "What service do you need today?"
├─ Font: SF Pro Regular, 14pt
├─ Color: #666666 / #A0A0A0
└─ Margin Top: 4pt
```

### Search Bar
```
Position: 12pt below greeting
Padding: 16pt horizontal
Tap Target: Full component (navigates to Search Screen)

Component:
├─ Height: 48pt
├─ Border Radius: 12pt
├─ Background: White (#FFFFFF) / #2A2A2A (dark)
├─ Border: None (relies on shadow)
├─ Shadow: 0 2px 8px rgba(0,0,0,0.08)
├─ Tap: Navigate to Search Screen (not editable inline)
└─ Layout: HStack (icon + text)

Icon:
├─ Image: magnifyingglass (SF Symbol)
├─ Size: 20x20pt
├─ Color: #999999
├─ Position: 16pt from left edge
└─ Alignment: Vertical center

Placeholder Text:
├─ Text: "Search services..."
├─ Font: SF Pro Regular, 15pt
├─ Color: #999999
├─ Position: 12pt from icon
└─ Alignment: Vertical center
```

### Featured Promo Banner (Horizontal Scroll)
```
Position: 16pt below search bar
Padding: 0pt left, 16pt right
Height: 140pt (banner card height)
Scroll: Horizontal, snap to cards
Paging: Yes (one card at a time)
Page Indicator: Dots below banner (if multiple promos)

Banner Card:
├─ Width: 358pt (390 - 32pt padding)
├─ Height: 140pt
├─ Border Radius: 16pt
├─ Background: Gradient or image
├─ Shadow: 0 4px 16px rgba(0,0,0,0.12)
├─ Margin Right: 16pt (between cards)
└─ Tap: Navigate to Promo Detail or Service

Card Content:
├─ Background Image: Optional (hero image)
├─ Overlay: Linear gradient (dark bottom for text readability)
├─ Icon/Emoji: 🎉 or similar (32x32pt)
├─ Title: "20% Off First Booking!"
│   ├─ Font: Inter Bold, 20pt
│   ├─ Color: White
│   └─ Position: 16pt from left, bottom section
├─ Subtitle: "Use code: FIRST20"
│   ├─ Font: SF Pro Medium, 14pt
│   ├─ Color: White 80% opacity
│   └─ Position: 6pt below title
├─ CTA Badge: "Claim Now →"
│   ├─ Font: SF Pro SemiBold, 12pt
│   ├─ Color: White
│   ├─ Background: rgba(255,255,255,0.2)
│   ├─ Border Radius: 20pt (pill)
│   ├─ Padding: 6pt vertical, 12pt horizontal
│   └─ Position: 16pt from right, 16pt from bottom
└─ Tap anywhere on card: Apply promo or navigate

Page Indicator (if > 1 promo):
├─ Position: 8pt below banner
├─ Alignment: Center
├─ Dot Size: 6pt diameter
├─ Active Dot: 20pt width (pill), #0D7377
├─ Inactive Dot: 6pt circle, #CCCCCC
└─ Gap: 6pt between dots
```

### Popular Services Section
```
Position: 24pt below promo banner
Padding: 16pt horizontal

Section Header:
├─ Layout: HStack with space between
├─ Title: "Popular Services"
│   ├─ Font: Inter SemiBold, 18pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   └─ Position: Left aligned
└─ "See All" Link:
    ├─ Icon: arrow.right (SF Symbol), 14x14pt
    ├─ Font: SF Pro Medium, 14pt
    ├─ Color: #0D7377
    ├─ Position: Right aligned
    └─ Action: Navigate to Service Categories (full list)

Service Cards Grid:
├─ Layout: 2 columns (LazyVGrid)
├─ Gap: 12pt horizontal, 16pt vertical
├─ Rows: 3 (showing 6 services)
├─ Padding Top: 16pt from header
└─ Scroll: Part of main scroll (not independent)

Service Card (Individual):
├─ Width: (390 - 32 - 12) / 2 = 173pt
├─ Height: 160pt
├─ Border Radius: 12pt
├─ Background: White (#FFFFFF) / #2A2A2A
├─ Shadow: 0 2px 8px rgba(0,0,0,0.08)
├─ Padding: 12pt
└─ Tap: Navigate to Service Detail

Card Content:
├─ Icon/Image: Service icon or photo
│   ├─ Size: 48x48pt
│   ├─ Position: Top-left, 12pt padding
│   ├─ Background: Circle, light color tint (e.g., #F0F9FA for AC)
│   └─ Icon: 24x24pt inside circle
│
├─ Service Name:
│   ├─ Text: "AC Repair" (truncate if long)
│   ├─ Font: Inter Medium, 15pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   ├─ Max Lines: 2
│   └─ Position: 8pt below icon
│
├─ Rating:
│   ├─ Icon: star.fill (SF Symbol), 12x12pt, #FFC107 (yellow)
│   ├─ Text: "4.8" (rating score)
│   ├─ Font: SF Pro Medium, 13pt
│   ├─ Color: #666666 / #A0A0A0
│   └─ Position: 8pt below service name
│
└─ Price:
    ├─ Text: "₹499" or "From ₹499"
    ├─ Font: Inter SemiBold, 16pt
    ├─ Color: #0D7377 (brand primary)
    └─ Position: Bottom-left, 12pt from edge
```

### Categories Section
```
Position: 24pt below Popular Services
Padding: 16pt horizontal (left only, right 0 for scroll)

Section Header:
├─ Layout: HStack
├─ Title: "Categories"
├─ Font: Inter SemiBold, 18pt
├─ "See All" Link: → (navigate to all categories)
└─ Margin Bottom: 12pt

Categories Horizontal Scroll:
├─ Layout: Horizontal ScrollView
├─ Snap: No (free scroll)
├─ Padding Left: 16pt
├─ Padding Right: 16pt
├─ Gap: 12pt between cards
└─ Show Indicator: No (hide scrollbar)

Category Card:
├─ Width: 100pt
├─ Height: 120pt
├─ Border Radius: 12pt
├─ Background: White (#FFFFFF) / #2A2A2A
├─ Shadow: 0 2px 6px rgba(0,0,0,0.06)
└─ Tap: Navigate to Category Detail

Card Content:
├─ Icon: Category icon (colored)
│   ├─ Size: 48x48pt
│   ├─ Position: Center horizontal, 16pt from top
│   └─ Background: Light color tint circle
│
└─ Name:
    ├─ Text: "Cleaning"
    ├─ Font: SF Pro Medium, 13pt
    ├─ Color: #1E1E1E / #E0E0E0
    ├─ Alignment: Center
    ├─ Max Lines: 2
    └─ Position: 8pt below icon
```

### Recent Bookings Section
```
Position: 24pt below Categories
Padding: 16pt horizontal
Condition: Only show if user has recent bookings

Section Header:
├─ Layout: HStack
├─ Title: "Your Recent Bookings"
├─ Font: Inter SemiBold, 18pt
├─ "See All" Link: → (navigate to all bookings)
└─ Margin Bottom: 12pt

Booking Card:
├─ Width: Full (358pt)
├─ Height: 88pt
├─ Border Radius: 12pt
├─ Background: White (#FFFFFF) / #2A2A2A
├─ Border: 1pt solid #E0E0E0 / #3A3A3A
├─ Shadow: 0 1px 4px rgba(0,0,0,0.06)
├─ Padding: 12pt
├─ Margin Bottom: 12pt (if multiple cards)
└─ Tap: Navigate to Booking Detail/Tracking

Card Layout (HStack):
├─ Service Icon:
│   ├─ Size: 48x48pt circle
│   ├─ Background: Light color tint
│   ├─ Icon: Service icon, 24x24pt
│   └─ Position: Left, 12pt padding
│
├─ Details (VStack, left-aligned):
│   ├─ Service Name: "AC Repair"
│   │   ├─ Font: SF Pro SemiBold, 15pt
│   │   ├─ Color: #1E1E1E / #E0E0E0
│   │   └─ Max Lines: 1
│   │
│   ├─ Date/Time: "Today, 3:00 PM"
│   │   ├─ Font: SF Pro Regular, 13pt
│   │   ├─ Color: #666666 / #A0A0A0
│   │   └─ Margin Top: 4pt
│   │
│   └─ Provider: "Rahul Kumar - Provider"
│       ├─ Font: SF Pro Regular, 12pt
│       ├─ Color: #999999 / #888888
│       └─ Margin Top: 4pt
│
└─ Status Badge (right):
    ├─ Text: "Active" or "Completed" or "Scheduled"
    ├─ Font: SF Pro SemiBold, 11pt
    ├─ Color: White
    ├─ Background:
    │   ├─ Active: #FFC107 (yellow/orange)
    │   ├─ Completed: #28C76F (green)
    │   └─ Scheduled: #00CFE8 (blue)
    ├─ Border Radius: 12pt (pill)
    ├─ Padding: 4pt vertical, 10pt horizontal
    ├─ Position: Top-right, 12pt from edges
    └─ Optional Dot: ● animated pulse for "Active"
```

### Bottom Tab Bar
```
Position: Fixed at bottom, above safe area
Height: 49pt + safe area bottom (34pt) = 83pt total
Background: White (#FFFFFF) / #2A2A2A (dark)
Border Top: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 -2px 8px rgba(0,0,0,0.08)

Tab Items (5 tabs):
├─ Layout: HStack, evenly distributed
├─ Tap Target: Full height, equal width
└─ Tabs:
    1. Home: house.fill (selected), house (unselected)
    2. Services: square.grid.2x2.fill / square.grid.2x2
    3. Bookings: calendar.fill / calendar
    4. Chat: message.fill / message (optional)
    5. Profile: person.fill / person

Tab Item Structure:
├─ Icon: SF Symbol, 24x24pt
├─ Label: Text below icon
│   ├─ Font: SF Pro Regular, 10pt
│   ├─ Margin Top: 2pt
│   └─ Max Lines: 1
│
├─ Colors:
│   ├─ Selected Icon: #0D7377 (brand primary)
│   ├─ Selected Label: #0D7377
│   ├─ Unselected Icon: #999999
│   └─ Unselected Label: #999999
│
└─ Animation: Icon bounces on tap (spring animation)
```

---

## Component Breakdown

### 1. Top Navigation Bar
```
Component: CustomNavigationBar (reusable)
Features:
├─ Hamburger menu (side drawer)
├─ City selector (bottom sheet)
├─ Search button (navigate)
├─ Notifications button (with badge)
└─ Fixed position (scroll under)
```

### 2. Search Bar (Non-Editable)
```
Component: SearchBarPlaceholder
Behavior: Tap to navigate to Search Screen (not inline editing)
Reason: Better UX, dedicated search screen with filters
```

### 3. Promo Banner Carousel
```
Component: PromoBannerCarousel
Features:
├─ Horizontal paging scroll
├─ Auto-advance (every 5 seconds)
├─ Page indicator dots
├─ Deep link to promo details
└─ Analytics tracking per banner
```

### 4. Service Card
```
Component: ServiceCard (reusable)
Props:
├─ service: Service model
├─ onTap: Navigate to Service Detail
└─ showRating: Bool

Used in:
├─ Popular Services (Home)
├─ Category Detail
├─ Search Results
└─ Favorites
```

### 5. Booking Card (Recent)
```
Component: RecentBookingCard
Props:
├─ booking: Booking model
├─ onTap: Navigate to Booking Detail
└─ Status badge styling based on status
```

### 6. Bottom Tab Bar
```
Component: CustomTabBar (iOS native TabView with custom styling)
Features:
├─ 5 tabs (Home, Services, Bookings, Chat, Profile)
├─ Badge support (notifications count)
├─ Selected state (icon + color change)
└─ Spring animation on tap
```

---

## Animations & Transitions

### Screen Load Animation
```
Duration: 800ms
Easing: Ease Out

Sequence:
0ms   - Top bar slides down (from y:-56 to y:0)
100ms - Greeting fades in + slides up (10pt)
200ms - Search bar fades in + slides up (10pt)
300ms - Promo banner fades in + slides up (10pt)
400ms - Popular Services section fades in + slides up (10pt)
500ms - Service cards appear sequentially (50ms delay each)
600ms - Categories scroll view fades in
700ms - Recent bookings (if any) fade in
800ms - All animations complete
```

### Service Card Tap Animation
```
Duration: 150ms
Easing: Ease Out

Press:
├─ Scale: 1.0 → 0.96
├─ Opacity: 1.0 → 0.9
└─ Haptic: Light impact

Release:
├─ Scale: 0.96 → 1.0
├─ Opacity: 0.9 → 1.0
└─ Navigate to Service Detail
```

### Promo Banner Auto-Scroll
```
Trigger: Every 5 seconds (if multiple banners)
Duration: 400ms
Easing: Ease In/Out

Animation:
├─ Current banner slides left (exits)
├─ Next banner slides in from right
├─ Page indicator updates (active dot animates)
└─ Loops back to first after last
```

### Pull to Refresh
```
Trigger: User pulls down on scroll view
Duration: 600ms

Animation:
├─ Activity indicator appears (spinning)
├─ Refresh data (fetch latest services, promos, bookings)
├─ Content updates with fade transition
└─ Activity indicator disappears
```

### Tab Switch Animation
```
Trigger: User taps different tab
Duration: 300ms

Animation:
├─ Current screen: Fade out + slight scale down (0.95)
├─ New screen: Fade in + scale up (0.95 → 1.0)
├─ Tab icon: Bounce animation (spring)
└─ Tab color: Crossfade to selected state
```

---

## States

### Default State (Loaded)
```
Status: Home screen fully loaded
Visual:
├─ All sections visible
├─ Popular Services: 6 cards displayed
├─ Promo banner: First slide visible
├─ Recent Bookings: Shown if data exists
└─ Bottom tab: Home selected (teal)
```

### Loading State (Initial)
```
Status: Fetching data from backend
Visual:
├─ Top bar: Visible immediately
├─ Skeleton screens for:
│   ├─ Greeting (shimmer text)
│   ├─ Search bar (shimmer)
│   ├─ Promo banner (shimmer card)
│   ├─ Service cards (6 shimmer cards in grid)
│   └─ Categories (shimmer horizontal scroll)
└─ Duration: 1-2 seconds typical
```

### Empty State (No Services)
```
Trigger: No services available in selected city
Visual:
├─ Greeting: Still shows
├─ Search bar: Still shows
├─ Promo banner: Hidden
├─ Popular Services: Replaced with empty state
│   ├─ Icon: Illustration (magnifying glass)
│   ├─ Message: "No services available in your area yet"
│   ├─ Subtitle: "We're expanding soon!"
│   └─ CTA: "Change City" button
└─ Recent Bookings: Hidden (or show past if any)
```

### No Recent Bookings
```
Condition: User has never booked anything
Action: Hide "Recent Bookings" section entirely
Alternative: Show CTA like "Book your first service!"
```

### Error State (Network Failure)
```
Trigger: Initial data fetch fails
Visual:
├─ Top bar: Visible
├─ Content area: Error state component
│   ├─ Icon: wifi.slash (no connection icon)
│   ├─ Message: "Unable to load services"
│   ├─ Subtitle: "Check your internet connection"
│   └─ Button: "Retry" (fetches data again)
└─ Bottom tab: Still visible
```

### Refreshing State (Pull to Refresh)
```
Trigger: User pulls down to refresh
Visual:
├─ Activity indicator at top
├─ Content slightly pulled down
├─ Refresh data in background
├─ Update UI with new data
└─ Indicator disappears with bounce
```

### Notification Badge (Unread)
```
Condition: User has unread notifications
Visual:
├─ Red dot (8pt) on bell icon (top bar)
├─ Badge remains until notifications viewed
└─ Animation: Gentle pulse (every 2s)
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E (dark background)
Top Bar Background: #2A2A2A (dark surface)
Top Bar Border: #3A3A3A
Card Background: #2A2A2A (dark surface)
Card Border: #3A3A3A
Text Primary: #E0E0E0 (light text)
Text Secondary: #A0A0A0 (secondary light text)
Search Bar Background: #2A2A2A
Promo Banner: Darker gradient overlay
Service Card: #2A2A2A with #3A3A3A border
Tab Bar Background: #2A2A2A
Tab Bar Border: #3A3A3A
Selected Tab: #14A0A5 (lighter teal)
```

---

## Accessibility

### VoiceOver

**Element Labels:**
```
Menu Button: "Menu, button"
City Selector: "Delhi, City selector, button"
Search Button: "Search, button"
Notifications: "Notifications, 3 unread, button" (if badge)
Greeting: "Good afternoon, Rahul, heading"
Search Bar: "Search services, button"
Promo Banner: "Promo: 20% off first booking, button"
Service Card: "AC Repair, ₹499, 4.8 stars, button"
Category Card: "Cleaning, category, button"
Booking Card: "AC Repair, Today 3 PM, Active booking, button"
Tab: "Home, tab, 1 of 5, selected"
```

**Focus Order:**
```
1. Menu button
2. City selector
3. Search button
4. Notifications button
5. Search bar
6. Promo banner
7-12. Service cards (grid order: row 1 left to right, row 2, row 3)
13. Categories scroll
14. Recent booking cards
15. Bottom tab bar
```

### Dynamic Type

**Supported Sizes:** -2 to +3

**Scaling:**
```
Greeting: 20pt → 17pt (min) to 24pt (max)
Subtitle: 14pt → 12pt (min) to 17pt (max)
Section headers: 18pt → 16pt (min) to 22pt (max)
Service name: 15pt → 13pt (min) to 18pt (max)
Price: 16pt → 14pt (min) to 19pt (max)
Category name: 13pt → 11pt (min) to 16pt (max)

Layout Adjustments:
├─ At +2: Service cards may become taller
├─ At +3: Grid might switch to single column
└─ Card heights adjust to fit text
```

### Reduced Motion

**If enabled:**
```
Screen load: Instant appear (no staggered animations)
Service card tap: No scale animation
Promo banner: No auto-scroll (manual only)
Tab switch: Crossfade only (no scale)
Pull to refresh: Standard indicator (no custom animation)
```

### Color Contrast

**WCAG AA (4.5:1):**
```
✅ Greeting (#1E1E1E on #F5F5F5): 15.2:1
✅ Service name (#1E1E1E on #FFFFFF): 16.1:1
✅ Price (#0D7377 on #FFFFFF): 4.9:1
✅ Category name (#1E1E1E on #FFFFFF): 16.1:1
✅ Dark mode greeting (#E0E0E0 on #1E1E1E): 12.6:1
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedCity: City = .delhi
    @State private var showCityPicker: Bool = false
    @State private var isRefreshing: Bool = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                // Background
                Color.gray100
                    .ignoresSafeArea()

                // Main Content (ScrollView)
                ScrollView {
                    VStack(spacing: 24) {
                        // Greeting
                        GreetingSection(userName: viewModel.userName)
                            .padding(.top, 72) // Top bar height + padding
                            .padding(.horizontal, 16)

                        // Search Bar
                        SearchBarPlaceholder()
                            .padding(.horizontal, 16)
                            .onTapGesture {
                                navigateToSearch()
                            }

                        // Promo Banner
                        if !viewModel.promos.isEmpty {
                            PromoBannerCarousel(promos: viewModel.promos)
                        }

                        // Popular Services
                        PopularServicesSection(services: viewModel.popularServices)

                        // Categories
                        CategoriesSection(categories: viewModel.categories)

                        // Recent Bookings
                        if !viewModel.recentBookings.isEmpty {
                            RecentBookingsSection(bookings: viewModel.recentBookings)
                        }

                        Spacer(minLength: 40)
                    }
                }
                .refreshable {
                    await refreshData()
                }

                // Top Navigation Bar (Fixed)
                CustomNavigationBar(
                    selectedCity: $selectedCity,
                    unreadCount: viewModel.unreadNotificationsCount,
                    onMenuTap: openMenu,
                    onCityTap: { showCityPicker = true },
                    onSearchTap: navigateToSearch,
                    onNotificationsTap: navigateToNotifications
                )
            }
            .sheet(isPresented: $showCityPicker) {
                CityPickerSheet(selectedCity: $selectedCity)
            }
        }
    }

    private func refreshData() async {
        await viewModel.refreshAllData()
    }

    private func openMenu() {
        // Open side drawer
    }

    private func navigateToSearch() {
        // Navigate to Search Screen
    }

    private func navigateToNotifications() {
        // Navigate to Notifications Screen
    }
}
```

### ViewModel

```swift
@MainActor
class HomeViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var popularServices: [Service] = []
    @Published var categories: [Category] = []
    @Published var promos: [Promo] = []
    @Published var recentBookings: [Booking] = []
    @Published var unreadNotificationsCount: Int = 0
    @Published var isLoading: Bool = true

    init() {
        Task {
            await loadInitialData()
        }
    }

    func loadInitialData() async {
        isLoading = true

        async let servicesTask = loadPopularServices()
        async let categoriesTask = loadCategories()
        async let promosTask = loadPromos()
        async let bookingsTask = loadRecentBookings()
        async let userTask = loadUserProfile()
        async let notificationsTask = loadUnreadCount()

        let (services, cats, proms, bookings, user, unread) = await (
            servicesTask, categoriesTask, promosTask,
            bookingsTask, userTask, notificationsTask
        )

        self.popularServices = services
        self.categories = cats
        self.promos = proms
        self.recentBookings = bookings
        self.userName = user.firstName
        self.unreadNotificationsCount = unread
        self.isLoading = false
    }

    func refreshAllData() async {
        await loadInitialData()
    }

    private func loadPopularServices() async -> [Service] {
        // Fetch from Firestore
        // Simulated:
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return Service.mockData
    }

    // Other load methods...
}
```

---

## Assets Required

### SF Symbols
```
- line.3.horizontal (Menu)
- chevron.down (City selector)
- magnifyingglass (Search)
- bell.fill (Notifications)
- star.fill (Rating)
- arrow.right (See all links)
- house.fill / house (Home tab)
- square.grid.2x2.fill / square.grid.2x2 (Services tab)
- calendar.fill / calendar (Bookings tab)
- message.fill / message (Chat tab)
- person.fill / person (Profile tab)
```

### Service Icons
```
From ASSETS_CHECKLIST.md:
- ac-repair.svg
- plumbing.svg
- electrical.svg
- salon.svg
- cleaning.svg
- painting.svg
- ... (50 service icons total)
```

### Promo Banner Images
```
- promo-banner-1.jpg (first booking 20% off)
- promo-banner-2.jpg (referral bonus)
- promo-banner-3.jpg (seasonal offers)
Sizes: 716x280px (@2x), 1074x420px (@3x)
```

---

## Navigation Flow

### Entry Points
```
1. App Launch (authenticated):
   └─ Direct to Home (no animation)

2. From Login Success:
   └─ Transition: Fade in (300ms)

3. From other tabs:
   └─ Tab switch animation
```

### Exit Points
```
1. Tap Search Bar → Search Screen
2. Tap Service Card → Service Detail Screen
3. Tap Category → Category Detail Screen
4. Tap Promo Banner → Promo Detail or Service
5. Tap Booking Card → Booking Detail/Tracking
6. Tap "See All" (Services) → All Services Screen
7. Tap "See All" (Bookings) → All Bookings Screen
8. Tap Menu → Side Drawer/Menu
9. Tap City → City Picker Bottom Sheet
10. Tap Notifications → Notifications Screen
11. Tab Bar Taps → Other screens (Services, Bookings, Profile)
```

---

## Error Handling

### Network Error (Initial Load)
```
Action:
├─ Show error state with retry button
├─ Cache last loaded data (show stale if available)
├─ Toast: "Unable to load. Using cached data."
└─ Allow retry
```

### Empty Services (City has no coverage)
```
Action:
├─ Show empty state with illustration
├─ Message: "Coming soon to your city"
├─ CTA: "Change City" or "Get Notified"
└─ Allow city change
```

---

## Testing Checklist

- [ ] Home screen loads within 2 seconds
- [ ] Greeting shows correct time of day
- [ ] User's first name displays correctly
- [ ] Search bar navigates to Search screen
- [ ] City selector opens bottom sheet
- [ ] Promo banners scroll horizontally
- [ ] Promo auto-scroll works (every 5s)
- [ ] Service cards navigate to detail
- [ ] Categories scroll horizontally
- [ ] Category cards navigate to detail
- [ ] Recent bookings show if data exists
- [ ] Booking cards navigate to tracking
- [ ] "See All" links work
- [ ] Pull to refresh updates data
- [ ] Notification badge shows count
- [ ] Bottom tabs switch correctly
- [ ] Dark mode renders correctly
- [ ] VoiceOver navigation works
- [ ] Dynamic Type scales
- [ ] Reduced Motion respected
- [ ] Works on all device sizes
- [ ] No memory leaks

---

## Analytics Events

```swift
// Screen view
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "home",
    "user_city": selectedCity.name
])

// Service card tapped
Analytics.logEvent("service_tapped", parameters: [
    "service_id": service.id,
    "service_name": service.name,
    "source": "home_popular"
])

// Promo banner tapped
Analytics.logEvent("promo_tapped", parameters: [
    "promo_id": promo.id,
    "promo_type": promo.type,
    "position": index
])

// City changed
Analytics.logEvent("city_changed", parameters: [
    "from_city": oldCity.name,
    "to_city": newCity.name
])

// Search initiated
Analytics.logEvent("search_started", parameters: [
    "source": "home_search_bar"
])
```

---

## Design Rationale

**Why this design:**

- **Greeting personalization**: Creates welcoming, personal experience
- **Search prominence**: Easy access to core functionality
- **Promo visibility**: Drives conversions, GMV
- **Service grid**: Efficient use of space, scannable
- **Recent bookings**: Quick access to ongoing services
- **Categories scroll**: Explore without clutter
- **Bottom tabs**: Standard iOS pattern, familiar navigation

**Alternatives Considered:**

- Vertical promo stack: Less engaging, lower CTR
- List instead of grid: Requires more scrolling
- No recent bookings: Missed retention opportunity
- Drawer menu only: Hidden navigation, lower discoverability

---

**The home screen is the app's hub. It must load fast, feel welcoming, and make service discovery effortless.**
