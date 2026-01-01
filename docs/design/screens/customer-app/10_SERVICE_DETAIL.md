# 10 - Service Detail

**Screen ID:** 10
**Screen Name:** Service Detail
**User Flow:** Category Detail → Service Card → Service Detail → Book Now
**Entry Point:** Tap any service card from Category, Home, or Search
**Purpose:** Display complete service information and enable booking

---

## Overview

The service detail screen is the primary conversion point where users view complete service information and initiate bookings. It showcases service features, pricing, reviews, provider details, and a prominent call-to-action to book.

**Purpose:**
- Display comprehensive service information
- Show pricing details and packages (if multiple)
- Display ratings, reviews, and testimonials
- Showcase before/after photos (if applicable)
- List what's included and excluded
- Show available time slots and providers
- Provide prominent "Book Now" CTA
- Enable adding to favorites/cart

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ‹                              ♡  ⋮   │ ← Top Bar (transparent)
├────────────────────────────────────────┤
│  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓  │
│  ┃                                ┃  │ ← Image Gallery
│  ┃  [Service Hero Image]          ┃  │   (300pt height)
│  ┃                                ┃  │   Horizontal scroll
│  ┃  ● ● ● ○ ○                     ┃  │   Page indicators
│  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛  │
│                                        │
│  ┌──────────────────────────────────┐ │
│  │ AC Service & Gas Refill          │ │ ← Service Name
│  │                                  │ │
│  │ ⭐ 4.9  234 reviews  •  30-45min│ │ ← Meta info
│  │                                  │ │
│  │ ₹499  ₹599                      │ │ ← Pricing
│  │ You save ₹100 (17%)             │ │
│  └──────────────────────────────────┘ │
│                                        │
│  What's Included ✓                    │ ← Section Header
│  • Complete AC servicing              │
│  • Gas leak check & refill            │ ← Bullet List
│  • Filter cleaning                    │
│  • 30-day service warranty            │
│                                        │
│  Service Details                      │ ← Section Header
│  📋 Category: AC Repair & Services    │
│  ⏱️  Duration: 30-45 minutes          │ ← Info rows
│  🏠 Service at your location          │
│  ✓  Same-day booking available        │
│                                        │
│  Top Providers                  →     │ ← Section Header
│  ┌────┐ ┌────┐ ┌────┐               │
│  │[P] │ │[P] │ │[P] │               │ ← Provider avatars
│  │⭐4.9│ │⭐4.8│ │⭐4.7│               │   (Horizontal scroll)
│  └────┘ └────┘ └────┘               │
│                                        │
│  Customer Reviews (234)         →     │ ← Section Header
│  ┌────────────────────────────────┐   │
│  │ ⭐⭐⭐⭐⭐                       │   │ ← Review Card
│  │ "Excellent service..."         │   │
│  │ - Rahul K. • 2 days ago        │   │
│  └────────────────────────────────┘   │
│                                        │
│  FAQs                            →     │ ← Section Header
│  ▼ What is included in service?       │ ← Expandable
│  ▶ Do you provide warranty?           │
│  ▶ What if I need to reschedule?      │
│                                        │
│  ┌────────────────────────────────┐   │
│  │  Book Now - ₹499               │   │ ← Fixed Bottom CTA
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
Safe Area Bottom: 34pt (+ 70pt for bottom CTA = 104pt)
Content Area: 390x740pt (remaining)
Scrollable: Yes (vertical, full screen)
Bottom CTA: Fixed overlay
```

### Background
```
Color: White (#FFFFFF) / #1E1E1E (dark)
Reason: Clean canvas for service details
```

### Top Navigation Bar (Transparent Overlay)
```
Position: Fixed at top, overlays images
Height: 56pt
Background: Transparent initially, then solid on scroll
Backdrop: Blur effect when scrolled (frosted glass)
Shadow: Appears on scroll

Left Section:
├─ Back Button:
│   ├─ Icon: chevron.left
│   ├─ Size: 24x24pt
│   ├─ Background: Circle, 40x40pt, rgba(255,255,255,0.9)
│   ├─ Shadow: 0 2px 8px rgba(0,0,0,0.15)
│   ├─ Tap Target: 44x44pt
│   ├─ Position: 8pt from left
│   └─ Action: Navigate back

Right Section:
├─ Favorite Button:
│   ├─ Icon: heart.fill (filled if favorited), heart (outline)
│   ├─ Size: 24x24pt
│   ├─ Background: Circle, 40x40pt, rgba(255,255,255,0.9)
│   ├─ Color: #EA5455 (red) if favorited, #666666 if not
│   ├─ Shadow: 0 2px 8px rgba(0,0,0,0.15)
│   ├─ Tap Target: 44x44pt
│   ├─ Position: 52pt from right edge
│   ├─ Action: Toggle favorite (with animation)
│   └─ Haptic: Medium impact on toggle
│
└─ Share/More Button:
    ├─ Icon: square.and.arrow.up (share) or ellipsis
    ├─ Size: 24x24pt
    ├─ Background: Circle, 40x40pt, rgba(255,255,255,0.9)
    ├─ Shadow: 0 2px 8px rgba(0,0,0,0.15)
    ├─ Tap Target: 44x44pt
    ├─ Position: 8pt from right edge
    └─ Action: Share service or show more options

Scroll Behavior:
├─ At scroll offset 0: Transparent background, visible circles
├─ At scroll offset 100pt: Background transitions to solid white/dark
├─ At scroll offset 200pt+: Fully opaque, shows title text (service name)
└─ Animation: Smooth transition (200ms ease out)
```

### Image Gallery
```
Position: Top of scroll view (0pt from top)
Height: 300pt
Layout: Horizontal scroll (paging)
Background: #F5F5F5 (placeholder if no images)

Images:
├─ Count: 3-8 images typical
├─ Aspect Ratio: 4:3 or 16:9
├─ Object Fit: Cover (maintain aspect, crop if needed)
├─ Scroll: Horizontal paging (snap to each image)
├─ Zoom: Optional (pinch to zoom)
└─ Transition: Smooth swipe with momentum

Page Indicators:
├─ Position: 16pt from bottom of gallery
├─ Alignment: Center
├─ Dot Size: 8pt diameter (active: 8x20pt pill)
├─ Active Color: White (#FFFFFF)
├─ Inactive Color: White 50% opacity
├─ Gap: 8pt between dots
└─ Background: Semi-transparent dark pill (optional)

Image Counter (Alternative):
├─ Position: Bottom-right, 16pt from edges
├─ Text: "1 / 5"
├─ Font: SF Pro Medium, 13pt
├─ Color: White
├─ Background: rgba(0,0,0,0.6)
├─ Padding: 6pt vertical, 10pt horizontal
├─ Border Radius: 16pt (pill)
└─ Shadow: 0 2px 6px rgba(0,0,0,0.3)
```

### Service Header Card
```
Position: Below image gallery (overlaps by 20pt for elevation effect)
Padding: 20pt horizontal, 20pt vertical
Background: White (#FFFFFF) / #2A2A2A
Border Radius: 24pt (top corners only)
Shadow: 0 -4px 16px rgba(0,0,0,0.08)

Content:

Service Name:
├─ Text: "AC Service & Gas Refill"
├─ Font: Inter Bold, 24pt
├─ Color: #1E1E1E / #E0E0E0
├─ Line Height: 1.2
├─ Max Lines: 2
└─ Truncation: Tail

Meta Info Bar (HStack):
├─ Position: 12pt below name
├─ Layout: Rating | Reviews | Duration
│
├─ Rating:
│   ├─ Icon: star.fill, 18x18pt, #FFC107
│   ├─ Text: "4.9"
│   ├─ Font: SF Pro SemiBold, 16pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   └─ Gap: 4pt
│
├─ Reviews (tappable):
│   ├─ Text: "234 reviews"
│   ├─ Font: SF Pro Regular, 14pt
│   ├─ Color: #0D7377 (link color)
│   ├─ Underline: On tap
│   ├─ Position: 8pt from rating
│   └─ Action: Scroll to Reviews section
│
├─ Separator: "•"
│   ├─ Color: #CCCCCC
│   └─ Font: 14pt
│
└─ Duration:
    ├─ Icon: clock, 14x14pt, #666666
    ├─ Text: "30-45 min"
    ├─ Font: SF Pro Regular, 14pt
    ├─ Color: #666666 / #A0A0A0
    └─ Position: 8pt from separator

Pricing Section:
├─ Position: 16pt below meta info
├─ Layout: HStack with baseline alignment
│
├─ Current Price:
│   ├─ Text: "₹499"
│   ├─ Font: Inter Bold, 32pt
│   ├─ Color: #0D7377 (brand primary)
│   └─ Letter Spacing: -0.5pt
│
├─ Original Price (if discounted):
│   ├─ Text: "₹599"
│   ├─ Font: SF Pro Regular, 20pt
│   ├─ Color: #999999
│   ├─ Strikethrough: Yes (line through)
│   ├─ Position: Baseline aligned, 8pt from current price
│   └─ Offset: Slightly raised (baseline offset)
│
└─ Savings Badge:
    ├─ Text: "You save ₹100 (17%)"
    ├─ Font: SF Pro Medium, 13pt
    ├─ Color: #28C76F (success green)
    ├─ Icon: arrow.down.circle.fill, 14x14pt (optional)
    ├─ Position: 8pt below prices
    └─ Background: #F0FFF4 (light green tint), optional pill
```

### What's Included Section
```
Position: 20pt below pricing
Padding: 20pt horizontal
Background: Transparent (part of scroll view)

Section Header:
├─ Text: "What's Included"
├─ Icon: checkmark.circle.fill, 20x20pt, #28C76F
├─ Font: Inter SemiBold, 18pt
├─ Color: #1E1E1E / #E0E0E0
├─ Gap: 8pt between icon and text
└─ Margin Bottom: 12pt

Included Items List:
├─ Layout: VStack, left-aligned
├─ Gap: 10pt between items
└─ Item Format:
    ├─ Icon: checkmark.circle.fill, 16x16pt, #28C76F
    ├─ Text: "Complete AC servicing"
    ├─ Font: SF Pro Regular, 15pt
    ├─ Color: #1E1E1E / #E0E0E0
    ├─ Max Lines: 2
    └─ Gap: 10pt between icon and text

Divider:
├─ Height: 1pt
├─ Color: #E0E0E0 / #3A3A3A
├─ Margin: 24pt top, 24pt bottom
└─ Horizontal span: Full width minus padding
```

### Service Details Section
```
Position: After What's Included
Padding: 20pt horizontal

Section Header:
├─ Text: "Service Details"
├─ Font: Inter SemiBold, 18pt
├─ Color: #1E1E1E / #E0E0E0
└─ Margin Bottom: 16pt

Detail Rows:
├─ Layout: VStack, left-aligned
├─ Gap: 14pt between rows
└─ Row Format (HStack):
    ├─ Icon: SF Symbol, 20x20pt, #666666
    │   ├─ Category: list.bullet.rectangle
    │   ├─ Duration: clock.fill
    │   ├─ Location: house.fill
    │   └─ Availability: checkmark.seal.fill
    │
    ├─ Label: Text
    │   ├─ Font: SF Pro Regular, 15pt
    │   ├─ Color: #666666 / #A0A0A0
    │   ├─ Text: "Category: " or "Duration: "
    │   └─ Width: 100pt (fixed, for alignment)
    │
    └─ Value: Text
        ├─ Font: SF Pro Medium, 15pt
        ├─ Color: #1E1E1E / #E0E0E0
        ├─ Text: "AC Repair & Services" or "30-45 minutes"
        └─ Flex: 1 (fills remaining space)

Divider: Same as above
```

### Top Providers Section
```
Position: After Service Details
Padding: 0pt left (scrollable), 20pt right

Section Header:
├─ Layout: HStack with space between
├─ Title: "Top Providers"
├─ Font: Inter SemiBold, 18pt
├─ "See All" Link: arrow.right icon
├─ Action: Navigate to Providers List
└─ Padding: 20pt horizontal
└─ Margin Bottom: 12pt

Providers Horizontal Scroll:
├─ Layout: Horizontal ScrollView
├─ Padding Left: 20pt
├─ Gap: 12pt between cards
└─ Show Indicator: No

Provider Card:
├─ Width: 100pt
├─ Height: 140pt
├─ Border Radius: 12pt
├─ Background: #F5F5F5 / #2A2A2A
├─ Shadow: 0 2px 6px rgba(0,0,0,0.06)
├─ Padding: 12pt
└─ Tap: Navigate to Provider Profile

Card Content (VStack):
├─ Avatar:
│   ├─ Size: 56x56pt circle
│   ├─ Image: Provider photo or initials
│   ├─ Border: 2pt solid #0D7377 (if verified)
│   └─ Badge: Verified checkmark (if applicable)
│
├─ Name:
│   ├─ Text: "Rahul K."
│   ├─ Font: SF Pro SemiBold, 14pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   ├─ Max Lines: 1
│   ├─ Truncation: Tail
│   └─ Margin Top: 8pt
│
└─ Rating:
    ├─ Icon: star.fill, 12x12pt, #FFC107
    ├─ Text: "4.9"
    ├─ Font: SF Pro Medium, 13pt
    ├─ Color: #666666
    ├─ Gap: 4pt
    └─ Margin Top: 4pt

Divider: Same as above
```

### Customer Reviews Section
```
Position: After Top Providers
Padding: 20pt horizontal

Section Header:
├─ Layout: HStack with space between
├─ Title: "Customer Reviews (234)"
├─ Font: Inter SemiBold, 18pt
├─ "See All" Link: arrow.right icon
├─ Action: Navigate to Reviews List
└─ Margin Bottom: 16pt

Rating Summary (Optional):
├─ Overall Rating: Large display
│   ├─ Number: "4.9"
│   ├─ Font: Inter Bold, 48pt
│   ├─ Color: #1E1E1E
│   ├─ Stars: 5 stars visual, #FFC107
│   └─ Subtitle: "Based on 234 reviews"
│
└─ Rating Breakdown:
    ├─ 5 stars: Progress bar (80%)
    ├─ 4 stars: Progress bar (15%)
    ├─ 3 stars: Progress bar (3%)
    ├─ 2 stars: Progress bar (1%)
    └─ 1 star: Progress bar (1%)

Review Cards:
├─ Show: 2-3 top reviews (most helpful)
├─ Layout: VStack
├─ Gap: 16pt between reviews
└─ Full reviews: Navigate to Reviews List

Review Card:
├─ Background: #F8F8F8 / #2A2A2A
├─ Border Radius: 12pt
├─ Padding: 16pt
├─ Shadow: None
│
├─ Header (HStack):
│   ├─ Avatar: 40x40pt circle
│   ├─ Name: "Rahul K."
│   ├─ Rating: 5 stars (star icons)
│   └─ Date: "2 days ago"
│
├─ Review Text:
│   ├─ Font: SF Pro Regular, 15pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   ├─ Max Lines: 3
│   ├─ Show More: "Read more" link if truncated
│   └─ Margin Top: 8pt
│
└─ Helpful Button:
    ├─ Icon: hand.thumbsup
    ├─ Text: "Helpful (12)"
    ├─ Font: SF Pro Regular, 13pt
    ├─ Color: #666666
    ├─ Tap: Mark as helpful
    └─ Margin Top: 12pt

Divider: Same as above
```

### FAQs Section
```
Position: After Reviews
Padding: 20pt horizontal

Section Header:
├─ Text: "Frequently Asked Questions"
├─ Font: Inter SemiBold, 18pt
├─ Margin Bottom: 12pt

FAQ Items:
├─ Layout: VStack
├─ Gap: 8pt between items
└─ Item Count: 4-6 top FAQs

FAQ Accordion:
├─ Button (expandable):
│   ├─ Layout: HStack with space between
│   ├─ Icon: chevron.right (collapsed), chevron.down (expanded)
│   ├─ Question: "What is included in the service?"
│   ├─ Font: SF Pro Medium, 15pt
│   ├─ Color: #1E1E1E / #E0E0E0
│   ├─ Tap Target: Full width, 52pt height min
│   └─ Background: #F8F8F8 / #2A2A2A (on tap)
│
└─ Answer (if expanded):
    ├─ Text: Detailed answer
    ├─ Font: SF Pro Regular, 14pt
    ├─ Color: #666666 / #A0A0A0
    ├─ Padding: 12pt horizontal, 12pt vertical
    ├─ Background: #F8F8F8 / #2A2A2A
    ├─ Border Radius: 8pt
    └─ Animation: Expand/collapse (200ms ease out)

"View All FAQs" Link:
├─ Position: 16pt below last FAQ
├─ Text: "View All FAQs"
├─ Icon: arrow.right
├─ Font: SF Pro Medium, 15pt
├─ Color: #0D7377
└─ Action: Navigate to FAQs Screen

Bottom Spacer:
└─ Height: 120pt (space for fixed CTA + safe area)
```

### Fixed Bottom CTA (Sticky)
```
Position: Fixed at bottom, above safe area
Height: 70pt + safe area bottom (34pt) = 104pt total
Background: White (#FFFFFF) / #2A2A2A
Border Top: 1pt solid #E0E0E0 / #3A3A3A
Shadow: 0 -4px 16px rgba(0,0,0,0.12)
Padding: 12pt horizontal, 12pt top

Button:
├─ Width: Full (390pt - 24pt padding = 366pt)
├─ Height: 56pt
├─ Border Radius: 14pt
├─ Background: #0D7377 (brand primary)
├─ Shadow: 0 4px 16px rgba(13,115,119,0.3)
├─ Tap: Navigate to Booking Flow (Date/Time Selection)
│
├─ Content (HStack):
│   ├─ Text: "Book Now"
│   │   ├─ Font: Inter SemiBold, 18pt
│   │   ├─ Color: White
│   │   └─ Letter Spacing: 0.3pt
│   │
│   ├─ Spacer
│   │
│   └─ Price:
│       ├─ Text: "₹499"
│       ├─ Font: Inter Bold, 20pt
│       ├─ Color: White
│       └─ Background: rgba(255,255,255,0.2) (pill)
│           ├─ Padding: 6pt vertical, 12pt horizontal
│           └─ Border Radius: 20pt
│
└─ Animation:
    ├─ Press: Scale 0.98, haptic feedback
    └─ Release: Scale 1.0, navigate

Alternative Layout (if packages):
├─ Show package selector above button
├─ Button text: "Select Package & Book"
└─ Price: "From ₹499"
```

---

## Component Breakdown

### 1. Image Gallery with Page Indicator
```
Component: ImageGalleryView
Features:
├─ Horizontal paging scroll
├─ Pinch to zoom (optional)
├─ Page indicator dots
├─ Swipe gestures
└─ Image counter overlay
```

### 2. Service Header Card
```
Component: ServiceHeaderCard
Props:
├─ service: Service model
├─ showDiscount: Bool
└─ onReviewsTap: Scroll to reviews
```

### 3. Bullet List (What's Included)
```
Component: BulletListView
Props:
├─ items: [String]
├─ iconColor: Color (#28C76F)
└─ icon: SF Symbol (checkmark.circle.fill)
```

### 4. Provider Card (Horizontal Scroll)
```
Component: ProviderCard (reusable)
Props:
├─ provider: Provider model
├─ onTap: Navigate to Provider Profile
└─ Layout: Vertical (avatar top, details below)
```

### 5. Review Card
```
Component: ReviewCard (reusable)
Props:
├─ review: Review model
├─ maxLines: Int (3 for preview, unlimited for full)
└─ onTap: Expand or navigate to full review
```

### 6. FAQ Accordion
```
Component: AccordionItem
Props:
├─ question: String
├─ answer: String
├─ isExpanded: Binding<Bool>
└─ Animation: Smooth expand/collapse
```

### 7. Fixed Bottom CTA
```
Component: FixedBottomCTA
Props:
├─ title: "Book Now"
├─ price: "₹499"
├─ action: Navigate to booking
└─ isLoading: Bool (if processing)
```

---

## Animations & Transitions

### Screen Load Animation
```
Duration: 600ms

Sequence:
0ms   - Image gallery fades in
100ms - Service header card slides up (20pt)
200ms - Sections fade in sequentially (100ms each)
300ms - Bottom CTA slides up from bottom
```

### Favorite Toggle Animation
```
Trigger: Tap heart icon
Duration: 300ms

Animation:
├─ Icon scales: 1.0 → 1.3 → 1.0 (bounce)
├─ Color changes: Gray → Red (or reverse)
├─ Fill animation: Outline → Filled (or reverse)
└─ Haptic: Medium impact

Backend:
└─ Save favorite status to user profile
```

### FAQ Accordion Expand/Collapse
```
Trigger: Tap FAQ question
Duration: 250ms
Easing: Ease Out

Expand:
├─ Icon rotates: 0° → 90° (chevron.right → chevron.down)
├─ Answer container: Height 0 → auto (smooth)
├─ Answer text: Opacity 0 → 1
└─ Background: Highlight (subtle)

Collapse:
└─ Reverse animation
```

### Scroll-Based Top Bar Transition
```
Trigger: User scrolls down
Duration: 200ms

States:
├─ Scroll 0-100pt: Transparent background
├─ Scroll 100-200pt: Fade in white background
├─ Scroll 200pt+: Fully opaque + show service name (title)
└─ Reverse on scroll up
```

### Book Now Button Press
```
Duration: 150ms

Press:
├─ Scale: 1.0 → 0.98
├─ Shadow: Slightly reduces
└─ Haptic: Medium impact

Release:
├─ Scale: 0.98 → 1.0
├─ Navigate to Booking Flow
└─ Show loading if processing
```

---

## States

### Default State (Loaded)
```
Visual:
├─ Image gallery: First image visible
├─ All sections: Fully rendered
├─ FAQs: All collapsed
├─ Book Now button: Enabled
└─ Favorite: Based on user's saved state
```

### Loading State (Initial)
```
Visual:
├─ Image gallery: Gray shimmer placeholder
├─ Service header: Shimmer for name, price, meta
├─ Sections: Shimmer placeholders
├─ Book Now button: Disabled (gray)
└─ Duration: 1-2 seconds
```

### Out of Stock / Unavailable
```
Trigger: Service temporarily unavailable
Visual:
├─ Banner at top: "Currently Unavailable"
├─ Book Now button:
│   ├─ Disabled (gray)
│   ├─ Text: "Notify When Available"
│   └─ Action: Subscribe to notifications
└─ All other content: Still visible
```

### Favorited State
```
Trigger: User adds to favorites
Visual:
├─ Heart icon: Filled, red (#EA5455)
├─ Toast: "Added to Favorites" (2 seconds)
└─ Sync to backend (user profile)
```

### Error State (Failed to Load)
```
Visual:
├─ Error component:
│   ├─ Icon: exclamationmark.triangle
│   ├─ Message: "Unable to load service details"
│   └─ Button: "Retry"
└─ Top bar + bottom CTA: Still visible
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E
Service Header Card: #2A2A2A
Detail Sections: #2A2A2A (cards)
Text Primary: #E0E0E0
Text Secondary: #A0A0A0
Price: #14A0A5 (lighter teal)
Savings: #28C76F (same green)
Dividers: #3A3A3A
Review Card Background: #2A2A2A
FAQ Background: #2A2A2A
Bottom CTA Background: #2A2A2A
CTA Button: #0D7377 (same brand primary)
```

---

## Accessibility

### VoiceOver

**Labels:**
```
Back: "Back, button"
Favorite: "Add to favorites, button" / "Remove from favorites, button"
Share: "Share service, button"
Image: "Service photo 1 of 5, image"
Service Name: "AC Service & Gas Refill, heading"
Rating: "4.9 stars"
Reviews: "234 reviews, button"
Price: "₹499, you save ₹100"
What's Included: "What's Included, heading"
Included Item: "Complete AC servicing, checkmark"
Provider: "Rahul K., 4.9 stars, button"
Review: "5 stars, Excellent service, Rahul K., 2 days ago"
FAQ: "What is included, button, collapsed" / "expanded"
Book Now: "Book Now, ₹499, button"
```

### Dynamic Type

**Scaling:** -2 to +3
```
Service Name: 24pt → 20pt (min) to 30pt (max)
Price: 32pt → 28pt (min) to 38pt (max)
Section Headers: 18pt → 16pt (min) to 22pt (max)
Body Text: 15pt → 13pt (min) to 18pt (max)
Button Text: 18pt → 16pt (min) to 21pt (max)

Layout Adjustments:
├─ At +2: Card heights increase
├─ At +3: Multi-column layouts may become single column
└─ Bottom CTA height increases to 70pt
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct ServiceDetailView: View {
    let serviceId: String
    @StateObject private var viewModel: ServiceDetailViewModel
    @State private var showShareSheet: Bool = false
    @State private var expandedFAQs: Set<String> = []
    @State private var scrollOffset: CGFloat = 0

    init(serviceId: String) {
        self.serviceId = serviceId
        _viewModel = StateObject(wrappedValue: ServiceDetailViewModel(serviceId: serviceId))
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            // Main Scroll View
            ScrollView {
                VStack(spacing: 0) {
                    // Image Gallery
                    ImageGalleryView(images: viewModel.service?.images ?? [])
                        .frame(height: 300)

                    // Service Header Card
                    ServiceHeaderCard(service: viewModel.service)
                        .padding(.horizontal, 20)
                        .offset(y: -20) // Overlaps gallery

                    // What's Included
                    SectionView(title: "What's Included") {
                        BulletListView(
                            items: viewModel.service?.included ?? [],
                            icon: "checkmark.circle.fill",
                            iconColor: .success
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                    Divider()
                        .padding(.vertical, 24)

                    // Service Details
                    SectionView(title: "Service Details") {
                        ServiceDetailsRows(service: viewModel.service)
                    }
                    .padding(.horizontal, 20)

                    Divider()
                        .padding(.vertical, 24)

                    // Top Providers
                    SectionView(title: "Top Providers", showSeeAll: true) {
                        ProvidersHorizontalScroll(providers: viewModel.topProviders)
                    }

                    Divider()
                        .padding(.vertical, 24)

                    // Reviews
                    SectionView(title: "Customer Reviews (\(viewModel.reviewCount))", showSeeAll: true) {
                        ReviewsPreview(reviews: viewModel.topReviews)
                    }
                    .padding(.horizontal, 20)

                    Divider()
                        .padding(.vertical, 24)

                    // FAQs
                    SectionView(title: "FAQs") {
                        FAQList(
                            faqs: viewModel.faqs,
                            expandedFAQs: $expandedFAQs
                        )
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                        .frame(height: 120) // Bottom CTA space
                }
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: ScrollOffsetKey.self, value: geo.frame(in: .named("scroll")).minY)
                    }
                )
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetKey.self) { offset in
                scrollOffset = offset
            }

            // Top Navigation Bar (Overlay)
            CustomNavigationBar(
                backgroundColor: scrollOffset < -100 ? .white : .clear,
                showTitle: scrollOffset < -200,
                title: viewModel.service?.name ?? "",
                leftItems: [.back],
                rightItems: [.favorite(isFavorited: viewModel.isFavorited), .share]
            )

            // Fixed Bottom CTA
            VStack {
                Spacer()
                FixedBottomCTA(
                    title: "Book Now",
                    price: viewModel.service?.price ?? 0,
                    action: navigateToBooking
                )
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [viewModel.shareURL])
        }
        .onAppear {
            viewModel.loadServiceDetails()
        }
    }

    private func navigateToBooking() {
        // Navigate to Booking Flow
    }
}
```

---

## Assets Required

### SF Symbols
```
- chevron.left
- heart.fill / heart
- square.and.arrow.up
- star.fill
- clock.fill / clock
- checkmark.circle.fill
- list.bullet.rectangle
- house.fill
- checkmark.seal.fill
- arrow.right
- chevron.right / chevron.down
- hand.thumbsup
```

---

## Navigation Flow

### Entry
```
From Category Detail → Service Card Tap
From Home → Service Card Tap
From Search → Service Card Tap
Transition: Slide in from right
Data: { serviceId }
```

### Exit
```
1. Book Now → Booking Flow (Date/Time Selection)
2. Reviews Link → Reviews List Screen
3. Provider Card → Provider Profile
4. Back → Previous screen
5. Share → System share sheet
```

---

## Testing Checklist

- [ ] Image gallery scrolls smoothly
- [ ] Page indicators update correctly
- [ ] Favorite toggles and persists
- [ ] All sections render correctly
- [ ] FAQs expand/collapse smoothly
- [ ] Reviews truncate with "Read more"
- [ ] Providers scroll horizontally
- [ ] Book Now navigates to booking
- [ ] Share sheet opens with correct URL
- [ ] Top bar transitions on scroll
- [ ] Out of stock state shows correctly
- [ ] Dark mode renders correctly
- [ ] VoiceOver works
- [ ] Dynamic Type scales
- [ ] Works on all devices

---

## Analytics

```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "service_detail",
    "service_id": serviceId,
    "service_name": service.name,
    "price": service.price
])

Analytics.logEvent("service_favorited", parameters: [
    "service_id": serviceId,
    "action": "added" // or "removed"
])

Analytics.logEvent("book_now_tapped", parameters: [
    "service_id": serviceId,
    "price": service.price
])

Analytics.logEvent("faq_expanded", parameters: [
    "question": faq.question
])
```

---

**This service detail screen is the conversion funnel. It must build trust, showcase value, and make booking effortless.**
