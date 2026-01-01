# UrbanNest Component Library

**Version:** 1.0
**Last Updated:** December 31, 2024
**Design System:** See [DESIGN_SYSTEM.md](./DESIGN_SYSTEM.md)

This document provides detailed specifications for all reusable UI components in the UrbanNest platform.

---

## Table of Contents

1. [Buttons](#buttons)
2. [Input Fields](#input-fields)
3. [Cards](#cards)
4. [Navigation](#navigation)
5. [Lists](#lists)
6. [Badges & Tags](#badges--tags)
7. [Dialogs & Modals](#dialogs--modals)
8. [Feedback Components](#feedback-components)
9. [Data Display](#data-display)
10. [Media Components](#media-components)

---

## Buttons

### Primary Button

**Purpose:** Main call-to-action buttons

**Variants:**
- Large (48pt height)
- Medium (40pt height)
- Small (32pt height)

**Specification:**

```
Large Button:
├─ Height: 48pt
├─ Padding: 16pt vertical, 24pt horizontal
├─ Min Width: 120pt
├─ Border Radius: 8pt
├─ Background: #0D7377 (brandPrimary)
├─ Text: Inter SemiBold 16pt, White
├─ Shadow: Level 1 (0 2px 4px rgba(0,0,0,0.08))
└─ Icon: Optional, 20x20pt, 8pt spacing

States:
├─ Default: Background #0D7377
├─ Hover: Background #14A0A5, Shadow Level 2
├─ Pressed: Background #095256, Scale 0.98
├─ Disabled: Background #E0E0E0, Text #999999, no shadow
└─ Loading: Spinner + disabled state
```

**Usage Examples:**
- "Book Now" - Service detail screen
- "Confirm Booking" - Booking summary
- "Pay Now" - Payment screen
- "Submit" - Form submissions

**Do's:**
- Use for primary action on each screen (only one per screen)
- Ensure sufficient padding for touch target (min 44pt height)
- Use loading state for async actions

**Don'ts:**
- Don't use multiple primary buttons on the same screen
- Don't use for destructive actions (use Destructive Button)
- Don't make text ALL CAPS

**SwiftUI Example:**
```swift
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isLoading: Bool = false
    var isDisabled: Bool = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(title)
                        .font(.custom("Inter-SemiBold", size: 16))
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(isDisabled ? Color.gray200 : Color.brandPrimary)
            .cornerRadius(8)
            .shadow(radius: isDisabled ? 0 : 2, y: isDisabled ? 0 : 2)
        }
        .disabled(isDisabled || isLoading)
        .scaleEffect(isLoading ? 0.98 : 1.0)
    }
}
```

---

### Secondary Button

**Purpose:** Alternative actions, less emphasis

**Specification:**

```
Height: 48pt (Large), 40pt (Medium), 32pt (Small)
├─ Padding: 16pt vertical, 24pt horizontal
├─ Border Radius: 8pt
├─ Background: Transparent
├─ Border: 2pt solid #0D7377
├─ Text: Inter SemiBold 16pt, #0D7377
└─ Shadow: None

States:
├─ Default: Border #0D7377, Text #0D7377
├─ Hover: Background #0D73770A (5% opacity), Border #14A0A5
├─ Pressed: Background #0D737714 (10% opacity), Scale 0.98
└─ Disabled: Border #E0E0E0, Text #999999
```

**Usage Examples:**
- "Cancel" - Dialogs, forms
- "Skip" - Onboarding, optional steps
- "View Details" - Secondary actions

---

### Destructive Button

**Purpose:** Dangerous or irreversible actions

**Specification:**

```
Same as Primary Button but:
├─ Background: #EA5455 (error color)
├─ Hover: Background #F87171
└─ Pressed: Background #DC2626
```

**Usage Examples:**
- "Delete Account"
- "Cancel Booking" (with penalty)
- "Remove" items

---

### Text Button

**Purpose:** Tertiary actions, minimal visual weight

**Specification:**

```
Height: Auto (text height + 16pt padding)
├─ Padding: 8pt vertical, 0pt horizontal
├─ Background: Transparent
├─ Text: Inter Medium 14pt, #0D7377
├─ Border: None
└─ Underline: On hover only

States:
├─ Default: Text #0D7377
├─ Hover: Text #14A0A5, Underline
├─ Pressed: Text #095256, Opacity 0.8
└─ Disabled: Text #999999
```

**Usage Examples:**
- "Learn More"
- "Forgot Password?"
- "View All"

---

### Icon Button

**Purpose:** Actions represented by icons only

**Specification:**

```
Size: 40x40pt (touch target)
├─ Icon: 24x24pt, centered
├─ Background: Transparent (or #F5F5F5 for filled variant)
├─ Border Radius: 8pt (square) or 50% (circle)
└─ Icon Color: #333333 (default), #0D7377 (active)

States:
├─ Default: Icon color #333333
├─ Hover: Background #F5F5F5, Icon color #0D7377
├─ Pressed: Background #E0E0E0, Scale 0.95
└─ Active: Icon color #0D7377, Background #0D73771A
```

**Usage Examples:**
- Close button (xmark icon)
- Back button (chevron.left)
- More options (ellipsis)
- Favorite (heart icon)

---

### Floating Action Button (FAB)

**Purpose:** Primary action, always visible

**Specification:**

```
Size: 56x56pt
├─ Icon: 24x24pt, centered, White
├─ Background: #0D7377
├─ Border Radius: 50% (circle)
├─ Shadow: Level 3 (0 8px 16px rgba(0,0,0,0.15))
└─ Position: Fixed, bottom right, 16pt margin

States:
├─ Default: Background #0D7377, Shadow Level 3
├─ Hover: Background #14A0A5, Scale 1.1
├─ Pressed: Background #095256, Scale 0.95
└─ Hidden: Scale 0, opacity 0 (when scrolling up)
```

**Usage:**
- Admin dashboard: "Add Service"
- Provider app: "Add Availability"

---

## Input Fields

### Text Input

**Purpose:** Single-line text entry

**Specification:**

```
Height: 48pt
├─ Padding: 12pt vertical, 16pt horizontal
├─ Border Radius: 8pt
├─ Border: 1pt solid #E0E0E0
├─ Background: #F5F5F5
├─ Text: SF Pro Regular 14pt, #333333
├─ Placeholder: SF Pro Regular 14pt, #999999
└─ Label: Inter Medium 14pt, #333333, 8pt above field

States:
├─ Default: Border #E0E0E0, Background #F5F5F5
├─ Focus: Border #0D7377 (2pt), Background White
├─ Error: Border #EA5455 (2pt), Helper text #EA5455 below
├─ Disabled: Background #F5F5F5, Text #999999, no interaction
└─ Success: Border #28C76F (2pt), Checkmark icon right
```

**Elements:**
```
Label (Optional):
├─ Text: Inter Medium 14pt, #333333
├─ Required indicator: Red asterisk (*)
└─ Position: 8pt above input field

Helper Text:
├─ Text: SF Pro Regular 12pt, #666666 (default), #EA5455 (error)
├─ Position: 4pt below input field
└─ Usage: Hints, error messages, character count

Icon (Optional):
├─ Size: 20x20pt
├─ Position: Left (16pt from edge) or Right (12pt from edge)
└─ Color: #999999 (default), #0D7377 (active)
```

**Variants:**
- With left icon (search, user, lock icons)
- With right icon (clear button, show/hide password)
- With prefix (currency symbol, country code)
- Multiline (Text Area)

**Validation:**
```
Real-time: On blur (field loses focus)
Display:
├─ Error: Red border + error message below
├─ Success: Green border + checkmark icon
└─ Warning: Yellow border + warning message

Error Messages:
├─ "This field is required"
├─ "Please enter a valid email address"
├─ "Password must be at least 8 characters"
└─ "Username already exists"
```

**SwiftUI Example:**
```swift
struct StandardTextField: View {
    @Binding var text: String
    let label: String
    let placeholder: String
    var isError: Bool = false
    var errorMessage: String = ""
    var leftIcon: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !label.isEmpty {
                Text(label)
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(.gray800)
            }

            HStack(spacing: 12) {
                if let icon = leftIcon {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(.gray400)
                }

                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .foregroundColor(.gray800)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.gray100)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isError ? Color.error : Color.gray200, lineWidth: isError ? 2 : 1)
            )

            if isError && !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.system(size: 12))
                    .foregroundColor(.error)
            }
        }
    }
}
```

---

### Phone Input

**Purpose:** Phone number entry with country code

**Specification:**

```
Height: 48pt
├─ Country Code Picker: Left side, 80pt width
│   ├─ Flag: 20x20pt emoji
│   ├─ Code: SF Pro Regular 14pt, #333333 (e.g., +91)
│   └─ Dropdown icon: chevron.down, 16x16pt
├─ Separator: 1pt vertical line, #E0E0E0, 40pt height
└─ Phone Input: Right side, flex width
    ├─ Placeholder: "9876543210"
    ├─ Keyboard: Number pad
    └─ Max Length: 10 digits (India)

Interaction:
├─ Tap country code → Opens country picker bottom sheet
├─ Tap phone input → Shows number keyboard
└─ Auto-format: Adds spaces for readability (e.g., 98765 43210)
```

---

### OTP Input

**Purpose:** One-time password entry

**Specification:**

```
6 Individual Boxes:
Each Box:
├─ Size: 48x56pt
├─ Gap: 8pt between boxes
├─ Border Radius: 8pt
├─ Border: 2pt solid #E0E0E0
├─ Background: #F5F5F5
├─ Text: Inter SemiBold 24pt, #333333, centered
└─ Cursor: Blinking, #0D7377

States per Box:
├─ Empty: Border #E0E0E0, Background #F5F5F5
├─ Focus: Border #0D7377, Background White
├─ Filled: Border #0D7377, Background White, Bold text
└─ Error: Border #EA5455, Shake animation

Interaction:
├─ Auto-advance: Move to next box on digit entry
├─ Backspace: Clear current, move to previous
├─ Paste: Auto-fill all 6 boxes from clipboard
└─ Auto-submit: Trigger verification when all 6 filled
```

**Additional Elements:**
```
Timer:
├─ Text: "Resend OTP in 0:45"
├─ Position: Below OTP boxes, centered
├─ Style: SF Pro Regular 12pt, #666666
└─ After expiry: "Didn't receive? Resend OTP" (link)
```

---

### Search Bar

**Purpose:** Search input with icon and clear button

**Specification:**

```
Height: 48pt (default), 40pt (compact)
├─ Padding: 12pt vertical, 16pt horizontal, 40pt left (icon)
├─ Border Radius: 12pt (pill-shaped)
├─ Background: #F5F5F5
├─ Border: None (focus: 2pt solid #0D7377)
├─ Search Icon: magnifyingglass, 20x20pt, left 12pt, #999999
├─ Clear Button: xmark.circle.fill, 20x20pt, right 12pt, #999999
├─ Placeholder: "Search for services..."
└─ Text: SF Pro Regular 14pt, #333333

States:
├─ Default: Background #F5F5F5, no border
├─ Focus: Background White, Border #0D7377 (2pt)
├─ Active (with text): Show clear button (x icon)
└─ Disabled: Background #F5F5F5, opacity 0.5

Interaction:
├─ Tap field → Focus, show keyboard
├─ Type → Show live search results below
├─ Tap clear → Clear text, maintain focus
├─ Tap cancel → Clear text, dismiss keyboard, blur
└─ Debounce: 300ms delay before search API call
```

---

### Text Area

**Purpose:** Multi-line text entry

**Specification:**

```
Min Height: 96pt (3 lines)
Max Height: 200pt (scrollable beyond)
├─ Padding: 12pt all sides
├─ Border Radius: 8pt
├─ Border: 1pt solid #E0E0E0
├─ Background: #F5F5F5
├─ Text: SF Pro Regular 14pt, #333333, 1.5 line height
└─ Scrollbar: Auto-show when content exceeds max height

Additional:
├─ Character Counter: Bottom right, "150/500", #666666
├─ Resize Handle: Bottom right corner (web only)
└─ Label & Helper Text: Same as Text Input
```

**Usage:**
- Review text
- Special instructions for booking
- Support messages
- Provider bio

---

### Select / Dropdown

**Purpose:** Single selection from a list

**Specification:**

```
Height: 48pt
├─ Padding: 12pt vertical, 16pt horizontal, 36pt right (icon)
├─ Border Radius: 8pt
├─ Border: 1pt solid #E0E0E0
├─ Background: #F5F5F5
├─ Selected Text: SF Pro Regular 14pt, #333333
├─ Placeholder: SF Pro Regular 14pt, #999999
└─ Icon: chevron.down, 20x20pt, right 12pt, #999999

Dropdown Menu:
├─ Background: White
├─ Border Radius: 8pt
├─ Shadow: Level 2
├─ Max Height: 240pt (scrollable)
├─ Item Height: 48pt
├─ Item Padding: 12pt vertical, 16pt horizontal
├─ Hover: Background #F5F5F5
└─ Selected: Background #0D73771A, Checkmark icon right
```

**iOS Alternative:** Use native picker or bottom sheet with list

---

### Checkbox

**Purpose:** Multiple selections or toggle options

**Specification:**

```
Size: 20x20pt
├─ Border Radius: 4pt
├─ Border: 2pt solid #E0E0E0
├─ Background: Transparent (unchecked), #0D7377 (checked)
├─ Checkmark: White, 14x14pt, centered
└─ Label: SF Pro Regular 14pt, #333333, 12pt left spacing

States:
├─ Unchecked: Border #E0E0E0, Background transparent
├─ Checked: Border #0D7377, Background #0D7377, Checkmark visible
├─ Indeterminate: Border #0D7377, Background #0D7377, Dash icon
├─ Disabled: Border #E0E0E0, Background #F5F5F5, opacity 0.5
└─ Hover: Border #0D7377

Touch Target: 44x44pt minimum (invisible padding)
```

---

### Radio Button

**Purpose:** Single selection from multiple options

**Specification:**

```
Size: 20x20pt circle
├─ Border: 2pt solid #E0E0E0
├─ Background: Transparent (unselected), #0D7377 dot (selected)
├─ Dot: 10x10pt circle, centered, White
└─ Label: SF Pro Regular 14pt, #333333, 12pt left spacing

States:
├─ Unselected: Border #E0E0E0, no dot
├─ Selected: Border #0D7377, dot visible
├─ Disabled: Border #E0E0E0, opacity 0.5
└─ Hover: Border #0D7377

Group:
├─ Vertical Stack: 12pt spacing between items
└─ Only one can be selected at a time
```

---

### Toggle Switch

**Purpose:** On/off binary state

**Specification:**

```
Size: 51x31pt
├─ Track:
│   ├─ Width: 51pt, Height: 31pt
│   ├─ Border Radius: 999pt (pill)
│   ├─ Background: #E0E0E0 (off), #0D7377 (on)
│   └─ Transition: 200ms ease
├─ Thumb:
│   ├─ Size: 27x27pt circle
│   ├─ Background: White
│   ├─ Shadow: 0 2px 4px rgba(0,0,0,0.2)
│   ├─ Position: Left 2pt (off), Right 2pt (on)
│   └─ Transition: 200ms ease with spring
└─ Label: SF Pro Regular 14pt, left of switch, 12pt spacing

States:
├─ Off: Track #E0E0E0, Thumb left
├─ On: Track #0D7377, Thumb right
├─ Disabled: Track #F5F5F5, opacity 0.5
└─ Transition: Spring animation on toggle
```

**Usage:**
- Enable/disable notifications
- Provider availability toggle
- Feature flags in settings

---

## Cards

### Service Card

**Purpose:** Display service offerings in a grid

**Specification:**

```
Size: 181pt width x 140pt height (2-column grid, 12pt gap)
├─ Padding: 12pt all sides
├─ Border Radius: 12pt
├─ Background: White
├─ Border: None
├─ Shadow: Level 1 (0 2px 4px rgba(0,0,0,0.08))
└─ Layout: Vertical stack, centered

Content:
├─ Icon: 32x32pt, centered, #0D7377 or color variant
├─ Spacer: 8pt
├─ Title: Inter Medium 14pt, #1E1E1E, centered, max 2 lines
├─ Spacer: 4pt
├─ Price: Inter SemiBold 16pt, #0D7377, centered
└─ Rating (Optional): ⭐ 4.8, SF Pro Regular 12pt, #666666

States:
├─ Default: Shadow Level 1
├─ Hover: Shadow Level 2, Scale 1.02, Transition 200ms
├─ Pressed: Shadow Level 1, Scale 0.98, Transition 100ms
└─ Disabled: Opacity 0.5, no interaction
```

**Dark Mode:**
- Background: #2A2A2A
- Border: 1pt solid #3A3A3A
- Text: #E0E0E0
- Shadow: Reduced opacity + subtle border

**SwiftUI Example:**
```swift
struct ServiceCard: View {
    let service: Service
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                Image(systemName: service.iconName)
                    .font(.system(size: 32))
                    .foregroundColor(.brandPrimary)

                Text(service.name)
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(.gray900)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)

                Text("₹\(service.basePrice)")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(.brandPrimary)
            }
            .frame(width: 181, height: 140)
            .padding(12)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 2, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
```

---

### Booking Card

**Purpose:** Display booking information in lists

**Specification:**

```
Width: Full width - 32pt margins
Height: Auto (min 100pt)
├─ Padding: 16pt all sides
├─ Border Radius: 12pt
├─ Background: White
├─ Border Left: 4pt solid (status color)
├─ Shadow: Level 1
└─ Layout: Horizontal with vertical content stack

Status Bar Colors:
├─ Pending: #FFC107 (Yellow)
├─ Active: #FF6B35 (Orange)
├─ Completed: #28C76F (Green)
└─ Cancelled: #EA5455 (Red)

Content Layout:
├─ Status Badge: Top right, pill shape
│   ├─ Background: Status color with 0.1 opacity
│   ├─ Text: Inter SemiBold 11pt, Status color
│   ├─ Padding: 4pt vertical, 8pt horizontal
│   └─ Border Radius: 999pt
├─ Service Name: Inter SemiBold 16pt, #1E1E1E
├─ Date & Time: SF Pro Regular 14pt, #666666, 4pt top margin
├─ Provider Info:
│   ├─ Profile Image: 32x32pt circle, 12pt top margin
│   ├─ Name: SF Pro Medium 14pt, #333333, 8pt left margin
│   └─ Rating: ⭐ 4.8, SF Pro Regular 12pt, #666666
└─ Price: Inter SemiBold 18pt, #0D7377, absolute top right

Interaction:
├─ Tap anywhere → Navigate to booking detail
├─ Tap provider → Navigate to provider profile
└─ Haptic: Medium impact feedback
```

---

### Provider Card

**Purpose:** Display provider information

**Specification:**

```
Width: Full width - 32pt margins
Height: Auto (min 80pt)
├─ Padding: 12pt all sides
├─ Border Radius: 12pt
├─ Background: White
├─ Shadow: Level 1
└─ Layout: Horizontal

Content:
├─ Profile Image: 60x60pt circle, left aligned
├─ Info Stack: 12pt left spacing
│   ├─ Name: Inter SemiBold 16pt, #1E1E1E
│   ├─ Rating: ⭐ 4.9 (512 reviews), SF Pro Regular 12pt, #666666, 2pt top
│   ├─ Services: "AC Repair • Plumbing", SF Pro Regular 12pt, #999999, 4pt top
│   └─ Distance: "2.3 km away", SF Pro Regular 12pt, #666666, 4pt top
└─ Chevron: chevron.right, 20x20pt, absolute right
```

---

### Stat Card

**Purpose:** Display key metrics on dashboards

**Specification:**

```
Size: Square (160x160pt) or Rect (full width x 100pt)
├─ Padding: 16pt all sides
├─ Border Radius: 12pt
├─ Background: Gradient (Primary to Primary Light) or White
├─ Shadow: Level 1
└─ Layout: Vertical centered

Content:
├─ Icon: 32x32pt, top left or centered, White (gradient) or Primary (white bg)
├─ Value: Inter Bold 28pt, White (gradient) or #1E1E1E (white)
├─ Label: SF Pro Regular 12pt, White 80% (gradient) or #666666 (white)
└─ Change: "+12% vs last week", SF Pro Regular 11pt, #28C76F or #EA5455
```

**Usage:**
- Revenue dashboard
- Booking statistics
- Provider performance metrics

---

## Navigation

### Bottom Tab Bar

**Purpose:** Primary navigation on mobile

**Specification:**

```
Height: 49pt + safe area (typically 83pt total on iPhone 14)
├─ Background: White (#FFFFFF)
├─ Border Top: 1pt solid #E0E0E0
├─ Shadow: 0 -2px 8px rgba(0,0,0,0.05)
└─ Safe Area: Extends to bottom including home indicator

Tab Items:
├─ Count: 4-5 tabs maximum
├─ Width: Equal distribution (screen width / tab count)
├─ Padding: 8pt top, safe area bottom
└─ Layout: Icon + Label stacked, centered

Each Tab:
├─ Icon: 24x24pt, centered
├─ Label: SF Pro Regular 10pt, centered, 4pt top margin
├─ Selected Color: #0D7377
├─ Unselected Color: #999999
└─ Badge: Optional, red dot (8pt), top right of icon

Tabs:
1. Home (house.fill)
2. Services (list.bullet.rectangle)
3. Bookings (calendar)
4. Profile (person.fill)

Interaction:
├─ Tap: Switch tab with cross-fade animation (300ms)
├─ Icon Animation: Spring bounce (scale 1.1 → 1.0)
├─ Haptic: Light impact on tap
└─ Selected: Icon tint changes, label bolded
```

---

### Top Navigation Bar

**Purpose:** Screen title and actions

**Specification:**

```
Height: 56pt (content) + status bar (~47pt on iPhone 14)
├─ Background: White
├─ Border Bottom: 1pt solid #E0E0E0
├─ Padding: 16pt horizontal
└─ Layout: Left - Center - Right

Left:
├─ Back Button: chevron.left, 24x24pt, #333333
├─ Menu Button: line.horizontal.3, 24x24pt
└─ Logo: 32pt height (on home screen)

Center:
├─ Title: Inter SemiBold 16pt, #1E1E1E, truncate if needed
└─ Subtitle: SF Pro Regular 12pt, #666666 (optional)

Right:
├─ Action Icons: 24x24pt, max 2 icons
│   ├─ Search (magnifyingglass)
│   ├─ Notifications (bell.fill) with badge
│   ├─ More (ellipsis)
│   └─ Share (square.and.arrow.up)
└─ Spacing: 16pt between icons
```

---

### Breadcrumbs (Web)

**Purpose:** Show navigation hierarchy

**Specification:**

```
Height: Auto
├─ Padding: 12pt vertical, 0pt horizontal
├─ Font: SF Pro Regular 14pt
├─ Color: #666666 (path), #0D7377 (current)
└─ Separator: chevron.right, 16x16pt, #999999, 8pt spacing

Example: Home > Services > AC Repair
├─ Links: Underline on hover
├─ Current: Bold, no link
└─ Max Items: Show last 3 levels with "..." for more
```

---

## Lists

### List Item

**Purpose:** Display items in scrollable lists

**Specification:**

```
Height: Auto (min 64pt)
├─ Padding: 12pt vertical, 16pt horizontal
├─ Border Bottom: 1pt solid #F5F5F5
├─ Background: White
└─ Layout: Horizontal

Content:
├─ Left: Icon/Image (40x40pt, 12pt right margin)
├─ Center: Title + Subtitle stacked
│   ├─ Title: Inter Medium 14pt, #1E1E1E
│   └─ Subtitle: SF Pro Regular 12pt, #666666, 4pt top margin
├─ Right: Accessory
│   ├─ Chevron (chevron.right, 20x20pt)
│   ├─ Switch toggle
│   ├─ Value (Inter Medium 14pt, #333333)
│   └─ Badge or tag

States:
├─ Default: Background White
├─ Hover: Background #F5F5F5
├─ Pressed: Background #E0E0E0, opacity 0.5
└─ Selected: Background #0D73770A, left border 4pt #0D7377
```

**Variants:**
- Simple (text only)
- With icon/image
- With switch
- With chevron (navigable)
- Multiline (subtitle, metadata)

---

### Section Header

**Purpose:** Group list items by category

**Specification:**

```
Height: 32pt
├─ Padding: 8pt vertical, 16pt horizontal
├─ Background: #F5F5F5
├─ Text: Inter SemiBold 12pt, #666666, uppercase
└─ Border Top: 1pt solid #E0E0E0 (optional)

Usage:
├─ Group related items (e.g., "Recent Bookings", "Past Orders")
├─ Sticky header on scroll (optional)
└─ Can include count: "BOOKINGS (12)"
```

---

## Badges & Tags

### Badge (Notification)

**Purpose:** Show unread count or status

**Specification:**

```
Size: 8pt diameter (dot) or auto width (with number)
├─ Background: #EA5455 (error red)
├─ Text: Inter SemiBold 11pt, White
├─ Padding: 4pt vertical, 6pt horizontal (if with number)
├─ Border Radius: 999pt (pill)
├─ Border: 2pt solid White (if overlapping icon)
└─ Position: Top right of parent element

Variants:
├─ Dot: 8pt circle, no text (presence indicator)
├─ Number: "3", "12", "99+" (max 99+)
└─ Empty: Hidden when count is 0
```

**Usage:**
- Notification bell (unread count)
- Tab bar items (new content)
- Messages (unread count)

---

### Status Badge

**Purpose:** Show status or category

**Specification:**

```
Height: Auto (min 24pt)
├─ Padding: 4pt vertical, 8pt horizontal
├─ Border Radius: 4pt (rounded) or 999pt (pill)
├─ Background: Status color 0.1 opacity
├─ Text: Inter SemiBold 11pt, Status color
└─ Border: None

Status Colors:
├─ Active: #FF6B35 (Orange)
├─ Completed: #28C76F (Green)
├─ Pending: #FFC107 (Yellow)
├─ Cancelled: #EA5455 (Red)
├─ Draft: #999999 (Gray)
└─ Info: #00CFE8 (Cyan)
```

---

### Tag/Chip

**Purpose:** Represent attributes or filters

**Specification:**

```
Height: 32pt
├─ Padding: 6pt vertical, 12pt horizontal
├─ Border Radius: 999pt (pill)
├─ Background: #F5F5F5 (default), #0D73771A (selected)
├─ Text: Inter Medium 12pt, #333333 (default), #0D7377 (selected)
├─ Border: 1pt solid #E0E0E0 (default), 2pt solid #0D7377 (selected)
└─ Close Icon: xmark.circle.fill, 16x16pt, right 8pt (removable)

States:
├─ Default: Gray background, gray border
├─ Selected: Primary background (light), primary border
├─ Hover: Darken background slightly
└─ Pressed: Scale 0.95

Variants:
├─ Default (static)
├─ Selectable (toggle selected state)
├─ Removable (with x icon)
└─ With icon (left side, 16x16pt)
```

**Usage:**
- Filter chips (selected services)
- Skill tags (provider profile)
- Categories

---

## Dialogs & Modals

### Alert Dialog

**Purpose:** Important messages requiring user action

**Specification:**

```
Width: 270pt (iOS standard)
├─ Padding: 20pt all sides
├─ Border Radius: 14pt
├─ Background: White
├─ Shadow: Level 4
└─ Backdrop: 0.4 opacity black, tap to dismiss (if not critical)

Content:
├─ Title: Inter SemiBold 17pt, #1E1E1E, centered, max 2 lines
├─ Spacer: 8pt
├─ Message: SF Pro Regular 13pt, #666666, centered, max 4 lines
├─ Spacer: 20pt
├─ Actions: Buttons horizontal or vertical
│   ├─ Primary: Text button, #0D7377
│   ├─ Secondary: Text button, #666666
│   └─ Destructive: Text button, #EA5455

Button Layout:
├─ 2 buttons: Horizontal, equal width
├─ 3+ buttons: Vertical stack
└─ Spacing: 12pt between buttons
```

**Interaction:**
- Tap backdrop → Dismiss (if allowed)
- Tap button → Action + dismiss
- Haptic: Medium impact on appear

**Usage:**
- Confirm delete
- Permission requests
- Error alerts
- Success confirmations

---

### Bottom Sheet

**Purpose:** Content panel sliding from bottom

**Specification:**

```
Width: Full screen width
Max Height: 90% of screen height
├─ Border Radius: 16pt (top corners only)
├─ Background: White
├─ Shadow: Level 3 (0 8px 16px rgba(0,0,0,0.15))
└─ Safe Area: Extends to bottom

Handle:
├─ Size: 32x4pt
├─ Background: #E0E0E0
├─ Border Radius: 999pt
├─ Position: Centered, 8pt from top
└─ Drag: Dismiss on down swipe

Content:
├─ Padding: 24pt horizontal, 16pt top (below handle), 16pt bottom
├─ Title: Inter SemiBold 20pt, left aligned or centered
├─ Close Button: xmark, 24x24pt, top right (optional)
└─ Scrollable: If content exceeds max height

Animation:
├─ Appear: Slide up 300ms, Ease Out
├─ Dismiss: Slide down 250ms, Ease In
├─ Backdrop: Fade in/out with sheet
└─ Interactive Dismiss: Drag down, rubber-band if can't dismiss
```

**Usage:**
- Filter options
- Action menus
- Content pickers
- Sharing options

---

### Modal / Dialog

**Purpose:** Full-page overlay for focused tasks

**Specification:**

```
Width: 90% of screen width (max 400pt on tablet/desktop)
Height: Auto (max 80% of screen height)
├─ Padding: 24pt all sides
├─ Border Radius: 16pt
├─ Background: White
├─ Shadow: Level 4
└─ Backdrop: 0.4 opacity black, tap to dismiss (optional)

Header:
├─ Title: Inter SemiBold 20pt, left aligned
├─ Close Button: xmark, 24x24pt, top right
└─ Divider: 1pt solid #E0E0E0, 16pt below title

Body:
├─ Scrollable content
├─ Form fields, lists, or other content
└─ Max Height: 60vh with scroll

Footer:
├─ Divider: 1pt solid #E0E0E0
├─ Actions: Primary + Secondary buttons
└─ Layout: Horizontal (right-aligned) or full-width stacked
```

---

## Feedback Components

### Toast / Snackbar

**Purpose:** Brief confirmation messages

**Specification:**

```
Width: Auto (min 280pt, max 90% screen width)
Height: Auto (min 48pt)
├─ Padding: 12pt vertical, 16pt horizontal
├─ Border Radius: 8pt
├─ Background: #333333 (dark), #FFFFFF (light with shadow)
├─ Text: SF Pro Regular 14pt, White (dark), #333333 (light)
├─ Position: Bottom center, 80pt from bottom (above tab bar)
├─ Shadow: Level 2 (light variant only)
└─ Duration: 3 seconds (auto-dismiss)

Variants:
├─ Success: Green background (#28C76F), checkmark icon left
├─ Error: Red background (#EA5455), xmark icon left
├─ Info: Dark background, info icon left
└─ With Action: "UNDO" button right side, text button style

Animation:
├─ Appear: Slide up + fade in, 200ms
├─ Dismiss: Fade out + slide down, 200ms
└─ Queue: Multiple toasts stack, max 2 visible
```

---

### Progress Indicator

**Specification:**

#### Circular Spinner
```
Size: 20x20pt (Small), 32x32pt (Medium), 48x48pt (Large)
├─ Color: #0D7377 (primary), #666666 (secondary)
├─ Stroke Width: 2pt (small), 3pt (medium), 4pt (large)
└─ Animation: Rotate 360°, 1000ms linear, continuous

Usage:
├─ Button loading (small, white on primary button)
├─ Inline loading (medium, next to text)
└─ Full-screen loading (large, centered)
```

#### Linear Progress Bar
```
Width: Full width - 32pt margins
Height: 4pt
├─ Background: #E0E0E0 (track)
├─ Fill: #0D7377 (progress)
├─ Border Radius: 999pt
└─ Animation: Smooth transition on progress change

Variants:
├─ Determinate: Shows exact % (0-100)
└─ Indeterminate: Animated stripe pattern, continuous
```

---

### Empty State

**Purpose:** Show when list/content is empty

**Specification:**

```
Centered vertically and horizontally
├─ Icon/Illustration: 120x120pt, centered, #E0E0E0 or colored
├─ Spacer: 16pt
├─ Title: Inter SemiBold 18pt, #1E1E1E, centered
├─ Spacer: 8pt
├─ Description: SF Pro Regular 14pt, #666666, centered, max width 300pt
├─ Spacer: 24pt
└─ Action Button: Primary button (optional)

Examples:
├─ No bookings: "You haven't booked any services yet"
├─ No search results: "No services found for 'plumbing'"
├─ No notifications: "You're all caught up!"
└─ Empty cart: "Your cart is empty. Start browsing!"
```

---

### Error State

**Purpose:** Show when content failed to load

**Specification:**

```
Similar to Empty State but:
├─ Icon: xmark.circle.fill, 80x80pt, #EA5455
├─ Title: "Something went wrong"
├─ Description: Error message or "Please try again"
└─ Action: "Retry" button (primary)
```

---

### Skeleton Screen

**Purpose:** Loading placeholder

**Specification:**

```
Skeleton elements match the final content layout:

Shape:
├─ Border Radius: Same as final element
├─ Background: Linear gradient shimmer
│   ├─ Color 1: #F5F5F5
│   ├─ Color 2: #E0E0E0 (midpoint)
│   ├─ Color 3: #F5F5F5
│   └─ Animation: Slide left to right, 1500ms linear, continuous

Common Skeletons:
├─ Text Line: 100% width x 14pt height, 4pt gap
├─ Heading: 70% width x 24pt height
├─ Card: Full card size with inner rectangles
├─ Circle: Profile image placeholder
└─ Service Card: Icon circle + 2 text lines
```

---

## Data Display

### Rating Stars

**Purpose:** Display or collect ratings

**Specification:**

```
Star Size: 16x16pt (small), 20x20pt (medium), 24x24pt (large)
├─ Filled: star.fill, #FFC107 (yellow)
├─ Half: star.leadinghalf.filled, #FFC107
├─ Empty: star, #E0E0E0
├─ Spacing: 4pt between stars
└─ Count: Always 5 stars total

Display Mode:
├─ Value: 4.8
├─ Stars: 4.5 filled (4 full + 1 half)
├─ Text: "(512 reviews)", SF Pro Regular 12pt, #666666, 8pt left spacing
└─ Layout: Horizontal inline

Interactive Mode (rating input):
├─ Tap star: Set rating (1-5)
├─ Hover: Preview rating before tap
├─ Haptic: Light impact on each star
└─ Clearable: Tap same star to clear
```

---

### Price Tag

**Purpose:** Display pricing information

**Specification:**

```
Layout: Horizontal or stacked

Original Price (if discounted):
├─ Text: Inter Regular 14pt, #999999
├─ Strikethrough: 1pt solid #999999
└─ Position: Above or left of discounted price

Discounted/Final Price:
├─ Text: Inter SemiBold 18pt, #0D7377
├─ Currency: "₹" prefix
└─ Format: 1,999 (with thousand separator)

Discount Badge:
├─ Text: "20% OFF", Inter SemiBold 10pt, White
├─ Background: #EA5455 (red)
├─ Padding: 2pt vertical, 6pt horizontal
├─ Border Radius: 4pt
└─ Position: Top right of card
```

---

### Timeline

**Purpose:** Show chronological events

**Specification:**

```
Vertical Layout:
├─ Line: 2pt solid #E0E0E0, left aligned, connects dots
├─ Dots: 12pt diameter circles
│   ├─ Completed: Filled #28C76F
│   ├─ Current: Border 3pt #0D7377, white fill
│   └─ Upcoming: Border 2pt #E0E0E0, white fill
├─ Content: Right of dot, 16pt spacing
│   ├─ Title: Inter SemiBold 14pt, #1E1E1E
│   ├─ Time: SF Pro Regular 12pt, #666666, 4pt top margin
│   └─ Description: SF Pro Regular 12pt, #666666 (optional)
└─ Spacing: 24pt between events
```

**Usage:**
- Booking status timeline
- Order tracking
- Provider service history

---

## Media Components

### Avatar / Profile Image

**Purpose:** Display user profile pictures

**Specification:**

```
Sizes:
├─ Extra Small: 24x24pt
├─ Small: 32x32pt
├─ Medium: 48x48pt
├─ Large: 64x64pt
├─ Extra Large: 96x96pt
└─ Hero: 120x120pt

Style:
├─ Border Radius: 50% (circle)
├─ Border: 2pt solid White (if overlapping)
├─ Placeholder: Initials on colored background
│   ├─ Text: Inter SemiBold, White, 40% of avatar size
│   └─ Background: Deterministic color from user ID
└─ Status Badge: 8pt dot, bottom right
    ├─ Online: #28C76F (green)
    ├─ Offline: #999999 (gray)
    └─ Border: 2pt solid White
```

---

### Image Gallery

**Purpose:** Display multiple images with lightbox

**Specification:**

```
Grid Layout:
├─ Columns: 3 (mobile), 4 (tablet), 5 (desktop)
├─ Gap: 8pt
├─ Aspect Ratio: 1:1 (square)
├─ Border Radius: 8pt
└─ Thumbnail: Fit cover, centered crop

Interaction:
├─ Tap image → Open lightbox fullscreen
├─ Swipe → Navigate between images
├─ Pinch → Zoom in/out
└─ Tap outside → Close lightbox

Lightbox:
├─ Background: Black 0.9 opacity
├─ Image: Centered, fit screen with padding
├─ Counter: "3 / 12", top center
├─ Close: xmark, top right, 44x44pt
└─ Navigation: chevron.left/right, side edges
```

---

## Implementation Checklist

For each component, ensure:

- ✅ All states implemented (default, hover, pressed, disabled)
- ✅ Dark mode variant designed
- ✅ Accessibility labels provided
- ✅ Touch targets minimum 44x44pt
- ✅ Haptic feedback where appropriate
- ✅ Animations smooth (60fps)
- ✅ Responsive to different screen sizes
- ✅ Color contrast WCAG AA compliant
- ✅ Loading and error states included
- ✅ Keyboard navigation support (web)

---

**This component library ensures consistency across the UrbanNest platform. All components should be implemented as reusable SwiftUI/React views following these specifications exactly.**
