# UrbanNest Design System

**Version:** 1.0
**Last Updated:** December 31, 2024
**Platform:** iOS, Android, Web

---

## Table of Contents

1. [Brand Identity](#brand-identity)
2. [Color Palette](#color-palette)
3. [Typography](#typography)
4. [Spacing System](#spacing-system)
5. [Border Radius](#border-radius)
6. [Shadows & Elevation](#shadows--elevation)
7. [Iconography](#iconography)
8. [Grid System](#grid-system)
9. [Breakpoints](#breakpoints)
10. [Animation & Motion](#animation--motion)
11. [Component Specifications](#component-specifications)
12. [Dark Mode](#dark-mode)
13. [Accessibility](#accessibility)

---

## Brand Identity

### Brand Name
**UrbanNest**

### Tagline
"Trusted services, delivered smartly"

### Brand Voice
- **Friendly**: Conversational, warm, approachable language
- **Clear**: Simple communication, avoiding jargon
- **Confident**: Assured and professional tone
- **Helpful**: Solution-oriented, proactive support

### Target Audience
- Urban professionals (25-45 years)
- Homemakers managing household needs
- New homeowners seeking reliable services
- Tech-savvy users comfortable with mobile bookings

### Brand Personality
- Trustworthy and reliable
- Modern and efficient
- Customer-centric
- Transparent in pricing and process

---

## Color Palette

### Primary Colors

#### Deep Teal (Primary)
```
HEX: #0D7377
RGB: 13, 115, 119
HSL: 182°, 80%, 26%

Variants:
- Light:  #14A0A5  (Hover states, light backgrounds)
- Base:   #0D7377  (Primary CTA, brand elements)
- Dark:   #095256  (Active/pressed states)
```

**Usage:**
- Primary action buttons
- Active tab indicators
- Brand elements
- Links and interactive text
- Success indicators
- Selected state backgrounds

#### Warm Orange (Secondary)
```
HEX: #FF6B35
RGB: 255, 107, 53
HSL: 16°, 100%, 60%

Variants:
- Light:  #FF8B60  (Hover states, light accents)
- Base:   #FF6B35  (Secondary CTAs, highlights)
- Dark:   #E5501F  (Pressed states, emphasis)
```

**Usage:**
- Secondary action buttons
- Accent elements
- Promotional banners
- Notification badges
- Highlight states
- Special offers

### Neutral Colors

#### Grayscale
```
White:       #FFFFFF  (Backgrounds, cards - light mode)
Gray 50:     #FAFAFA  (Subtle backgrounds)
Gray 100:    #F5F5F5  (Input backgrounds, dividers)
Gray 200:    #E0E0E0  (Borders, disabled states)
Gray 300:    #CCCCCC  (Placeholder text)
Gray 400:    #999999  (Unselected icons, secondary text)
Gray 600:    #666666  (Body text, labels)
Gray 800:    #333333  (Headings, primary text)
Gray 900:    #1E1E1E  (Headings, emphasis)
Black:       #000000  (Maximum contrast text)
```

### Functional Colors

#### Success
```
HEX: #28C76F
RGB: 40, 199, 111
HSL: 146°, 66%, 47%

Usage:
- Successful actions
- Completed bookings
- Confirmed payments
- Positive feedback
```

#### Warning
```
HEX: #FFC107
RGB: 255, 193, 7
HSL: 45°, 100%, 51%

Usage:
- Pending states
- Caution messages
- Upcoming deadlines
- Important notices
```

#### Error
```
HEX: #EA5455
RGB: 234, 84, 85
HSL: 359°, 77%, 62%

Usage:
- Error messages
- Failed actions
- Required field indicators
- Destructive actions
```

#### Info
```
HEX: #00CFE8
RGB: 0, 207, 232
HSL: 187°, 100%, 45%

Usage:
- Informational messages
- Tooltips
- Helper text
- Tips and suggestions
```

### Dark Mode Colors

```
Background:      #1E1E1E  (Primary dark background)
Surface:         #2A2A2A  (Cards, elevated surfaces)
Surface Variant: #3A3A3A  (Input fields, secondary surfaces)
Border:          #3A3A3A  (Dividers, borders)
Text Primary:    #E0E0E0  (Primary text)
Text Secondary:  #A0A0A0  (Secondary text, labels)
Text Disabled:   #666666  (Disabled text)
```

### Color Usage Guidelines

**Do's:**
- Use primary color for main CTAs and brand elements
- Use secondary color sparingly for accents and highlights
- Maintain sufficient color contrast (WCAG AA minimum)
- Use functional colors consistently for their designated purposes
- Test colors in both light and dark modes

**Don'ts:**
- Don't use more than 3 colors in a single component
- Don't use red/green alone to convey information (accessibility)
- Don't use low-contrast color combinations
- Don't override functional color meanings

---

## Typography

### Font Families

#### Headings & Branding
```
Font Family: Inter
Weights Available: Medium (500), SemiBold (600), Bold (700)
Fallback: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif

Alternative: Poppins
Weights Available: Medium (500), SemiBold (600), Bold (700)
```

**Characteristics:**
- Geometric, modern aesthetic
- High readability at all sizes
- Excellent multi-language support (Latin + Devanagari)
- Optimized for digital screens

#### Body Text (iOS)
```
Font Family: SF Pro
Weights Available: Regular (400), Medium (500), SemiBold (600)
Platform: iOS native font
```

#### Body Text (Android)
```
Font Family: Roboto
Weights Available: Regular (400), Medium (500), Bold (700)
Platform: Android native font
```

#### Body Text (Web)
```
Font Family: SF Pro / Roboto
Fallback: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif
```

#### Hindi Support
```
Font Family: Noto Sans Devanagari
Weights Available: Regular (400), Medium (500), Bold (700)
Usage: Hindi language content
```

### Type Scale

#### Display & Headings

**Display (Hero Text)**
```
Font: Inter Bold
Size: 40pt / 40px
Line Height: 1.1 (44pt)
Letter Spacing: -0.5pt
Weight: 700
Usage: Hero sections, large promotional text
```

**H1 (Page Title)**
```
Font: Inter Bold
Size: 32pt / 32px
Line Height: 1.2 (38pt)
Letter Spacing: -0.3pt
Weight: 700
Usage: Main page headings, screen titles
```

**H2 (Section Heading)**
```
Font: Inter SemiBold
Size: 24pt / 24px
Line Height: 1.3 (31pt)
Letter Spacing: -0.2pt
Weight: 600
Usage: Section titles, card headings
```

**H3 (Subsection Heading)**
```
Font: Inter SemiBold
Size: 20pt / 20px
Line Height: 1.3 (26pt)
Letter Spacing: 0pt
Weight: 600
Usage: Subsection titles, dialog headings
```

**H4 (Component Heading)**
```
Font: Inter Medium
Size: 18pt / 18px
Line Height: 1.4 (25pt)
Letter Spacing: 0pt
Weight: 500
Usage: Component titles, list section headers
```

**H5 (Small Heading)**
```
Font: Inter Medium
Size: 16pt / 16px
Line Height: 1.4 (22pt)
Letter Spacing: 0pt
Weight: 500
Usage: Small headings, card titles
```

#### Body Text

**Body Large**
```
Font: SF Pro Regular / Roboto Regular
Size: 16pt / 16px
Line Height: 1.5 (24pt)
Letter Spacing: 0pt
Weight: 400
Usage: Important body text, feature descriptions
```

**Body (Default)**
```
Font: SF Pro Regular / Roboto Regular
Size: 14pt / 14px
Line Height: 1.5 (21pt)
Letter Spacing: 0pt
Weight: 400
Usage: Standard body text, paragraph text
```

**Body Small**
```
Font: SF Pro Regular / Roboto Regular
Size: 12pt / 12px
Line Height: 1.4 (17pt)
Letter Spacing: 0pt
Weight: 400
Usage: Secondary information, helper text
```

**Caption**
```
Font: SF Pro Regular / Roboto Regular
Size: 11pt / 11px
Line Height: 1.3 (14pt)
Letter Spacing: 0.2pt
Weight: 400
Usage: Timestamps, metadata, footnotes
```

#### UI Text

**Button Text (Large)**
```
Font: Inter SemiBold
Size: 16pt / 16px
Letter Spacing: 0.3pt
Weight: 600
Usage: Primary buttons
```

**Button Text (Medium)**
```
Font: Inter Medium
Size: 14pt / 14px
Letter Spacing: 0.2pt
Weight: 500
Usage: Secondary buttons, text buttons
```

**Tab Bar Label**
```
Font: SF Pro Regular / Roboto Regular
Size: 10pt / 10px
Letter Spacing: 0pt
Weight: 400
Usage: Bottom tab bar labels
```

**Badge Text**
```
Font: Inter SemiBold
Size: 11pt / 11px
Letter Spacing: 0.3pt
Weight: 600
Usage: Badges, notification counts
```

### Typography Usage Guidelines

**Hierarchy:**
1. Use H1 once per screen for main title
2. Use H2-H5 for nested content hierarchy
3. Maintain consistent hierarchy levels (don't skip from H2 to H4)
4. Body text should be at least 14pt for readability

**Readability:**
- Line length: 50-75 characters optimal
- Paragraph spacing: 16pt between paragraphs
- Minimum touch target for links: 44x44pt
- Avoid all-caps for body text (use for labels only)

**Dynamic Type (iOS):**
- Support Dynamic Type scaling from -2 to +3
- Maintain hierarchy at all scale levels
- Ensure touch targets don't shrink below 44pt

---

## Spacing System

### 8pt Grid System

All spacing follows an 8-point grid system for consistency and scalability.

```
4pt   - Tight spacing (icon + text, inline elements)
8pt   - Base unit (small gaps, compact layouts)
12pt  - Small spacing (list item padding, tight sections)
16pt  - Medium spacing (card padding, section margins)
24pt  - Large spacing (section gaps, screen margins)
32pt  - XLarge spacing (major sections, screen padding)
48pt  - XXLarge spacing (hero sections, large gaps)
64pt  - XXXLarge spacing (massive sections)
```

### Common Spacing Patterns

#### Vertical Spacing (Stack)
```
Tight:   4pt between related items (icon + label)
Small:   8pt between list items
Medium:  16pt between components
Large:   24pt between sections
XLarge:  32pt between major sections
```

#### Horizontal Spacing (Inline)
```
Tight:   4pt between closely related items
Small:   8pt between related items (icon + text)
Medium:  12pt between unrelated items
Large:   16pt between distinct elements
```

#### Padding & Margins

**Screen Level:**
```
Mobile:     16pt horizontal, 16pt top, 8pt bottom
Tablet:     24pt horizontal, 24pt top, 16pt bottom
Desktop:    32pt horizontal, 32pt top, 24pt bottom
```

**Card Padding:**
```
Small Card:  12pt all sides
Medium Card: 16pt all sides
Large Card:  20pt all sides
```

**List Item Padding:**
```
Compact:  8pt vertical, 12pt horizontal
Default:  12pt vertical, 16pt horizontal
Spacious: 16pt vertical, 20pt horizontal
```

**Button Padding:**
```
Small:   8pt vertical, 12pt horizontal
Medium:  12pt vertical, 20pt horizontal
Large:   16pt vertical, 24pt horizontal
```

### Usage Guidelines

- Always use multiples of 4pt (preferably 8pt)
- Maintain consistent spacing for similar elements
- Use larger spacing to create visual hierarchy
- Reduce spacing for related items, increase for unrelated
- Account for safe areas on mobile devices

---

## Border Radius

### Radius Scale

```
None:    0pt   - Straight edges, data tables
Small:   4pt   - Badges, tags, small chips
Medium:  8pt   - Buttons, inputs, small cards
Large:   12pt  - Cards, modals, containers
XLarge:  16pt  - Large cards, feature cards
XXLarge: 24pt  - Hero cards, special containers
Pill:    999pt - Pill buttons, status badges
Circle:  50%   - Profile images, icon containers
```

### Component Usage

```
Buttons:         8pt (Medium)
Input Fields:    8pt (Medium)
Cards:          12pt (Large)
Modals:         16pt (XLarge)
Chips/Tags:      4pt (Small)
Profile Images: 50% (Circle)
Status Badges:  999pt (Pill)
Bottom Sheets:  16pt (XLarge, top corners only)
```

### Platform Considerations

**iOS:**
- Prefer larger radii (12pt+) for modern iOS aesthetic
- Use pill shapes for toggles and badges
- Bottom sheets: 16pt radius on top corners only

**Android:**
- Follow Material Design 3 guidelines
- Small: 4pt, Medium: 8pt, Large: 12pt, Extra Large: 28pt
- Cards: 12pt, Dialogs: 28pt

**Web:**
- Consistent with mobile (8-16pt range)
- Hover states: maintain same radius
- Ensure radius scales with component size

---

## Shadows & Elevation

### Shadow Levels

```
Level 1 (Small) - Subtle elevation
Shadow: 0 2px 4px rgba(0, 0, 0, 0.08)
Usage: Hovering cards, subtle highlights
Elevation: 2dp (Android)

Level 2 (Medium) - Standard elevation
Shadow: 0 4px 8px rgba(0, 0, 0, 0.12)
Usage: Cards, buttons, dropdowns
Elevation: 4dp (Android)

Level 3 (Large) - Prominent elevation
Shadow: 0 8px 16px rgba(0, 0, 0, 0.15)
Usage: Modals, floating buttons, popovers
Elevation: 8dp (Android)

Level 4 (XLarge) - Maximum elevation
Shadow: 0 16px 32px rgba(0, 0, 0, 0.20)
Usage: Dialogs, full-screen overlays
Elevation: 16dp (Android)
```

### Usage Guidelines

**Cards:**
- Resting state: Level 1 (Small)
- Hover state: Level 2 (Medium)
- Active/pressed: No shadow or Level 1

**Buttons:**
- Flat buttons: No shadow
- Raised buttons: Level 2 (Medium)
- Floating action button: Level 3 (Large)

**Modals & Dialogs:**
- Modal overlays: Level 3 or 4
- Dropdown menus: Level 2
- Tooltips: Level 1

**Dark Mode Adjustments:**
- Reduce shadow opacity by 50% in dark mode
- Use lighter shadows: rgba(255, 255, 255, 0.05)
- Rely more on borders than shadows for elevation

---

## Iconography

### Icon System

**Primary Icon Set:** SF Symbols (iOS) / Material Icons (Android)

### Icon Sizes

```
Extra Small: 16x16pt - Inline icons, badges
Small:       20x20pt - Input field icons, small buttons
Medium:      24x24pt - Tab bar, toolbar icons (most common)
Large:       32x32pt - Feature icons, service categories
Extra Large: 48x48pt - Empty states, illustrations
Hero:        64x64pt - Onboarding, splash screens
```

### Icon Categories

#### Tab Bar Icons
```
Home:      house.fill
Services:  list.bullet.rectangle
Bookings:  calendar
Profile:   person.fill
```

#### Navigation Icons
```
Back:            chevron.left
Forward:         chevron.right
Close:           xmark
Menu:            line.horizontal.3
Search:          magnifyingglass
Filter:          slider.horizontal.3
More:            ellipsis
```

#### Service Category Icons
```
AC Repair:       wind
Plumbing:        drop.fill
Electrical:      bolt.fill
Cleaning:        sparkles
Salon:           scissors
Painting:        paintbrush.fill
Appliance:       wrench.and.screwdriver.fill
Pest Control:    ant.fill
Carpentry:       hammer.fill
```

#### Action Icons
```
Add:             plus
Edit:            pencil
Delete:          trash
Share:           square.and.arrow.up
Save:            bookmark
Download:        arrow.down.circle
Upload:          arrow.up.circle
Refresh:         arrow.clockwise
```

#### Status Icons
```
Success:         checkmark.circle.fill
Error:           xmark.circle.fill
Warning:         exclamationmark.triangle.fill
Info:            info.circle.fill
```

#### UI Icons
```
Heart:           heart / heart.fill
Star:            star / star.fill
Location:        mappin.circle.fill
Phone:           phone.fill
Message:         message.fill
Notification:    bell.fill
Settings:        gearshape.fill
Help:            questionmark.circle
```

### Icon Usage Guidelines

**Consistency:**
- Use the same icon for the same action across the app
- Match icon style (filled vs outline) within a context
- Tab bar: Use filled icons for selected, outline for unselected

**Sizing:**
- Maintain minimum 44x44pt touch target for interactive icons
- Use appropriate size for context (don't use huge icons for minor actions)
- Scale icons proportionally, don't distort

**Color:**
- Interactive icons: Use brand colors (#0D7377)
- Inactive icons: Use Gray 400 (#999999)
- Destructive actions: Use Error color (#EA5455)
- Success states: Use Success color (#28C76F)

**Accessibility:**
- Always provide text labels or accessibility labels
- Don't rely on color alone to convey meaning
- Ensure icons have sufficient contrast (4.5:1 ratio)

---

## Grid System

### Mobile Grid (iOS/Android)

```
Columns: 4 columns
Gutter: 16pt
Margin: 16pt (left/right)
Max Width: Device width - 32pt

Breakpoints:
- iPhone SE: 320pt width → 4 columns
- iPhone 14: 390pt width → 4 columns
- iPhone 14 Pro Max: 430pt width → 4 columns
- iPad: 768pt width → 8 columns
```

### Web Grid

```
Mobile (< 640px):
- Columns: 4
- Gutter: 16px
- Margin: 16px

Tablet (640px - 1024px):
- Columns: 8
- Gutter: 24px
- Margin: 24px

Desktop (> 1024px):
- Columns: 12
- Gutter: 32px
- Margin: 32px (auto-center)
- Max Width: 1200px
```

### Common Layouts

**Service Cards Grid:**
```
Mobile: 2 columns (gap: 12pt)
Tablet: 3 columns (gap: 16pt)
Desktop: 4 columns (gap: 24pt)
```

**List View:**
```
Single column, full width
Item padding: 16pt
Dividers: 1pt solid #E0E0E0
```

---

## Breakpoints

### Mobile Breakpoints

```
Small:   320pt - 375pt  (iPhone SE, iPhone 12/13 mini)
Medium:  375pt - 414pt  (iPhone 14, iPhone 14 Pro)
Large:   414pt+         (iPhone 14 Plus, Pro Max)
Tablet:  768pt+         (iPad, landscape phones)
```

### Web Breakpoints

```
Mobile:   < 640px   (xs)
Tablet:   640px     (sm)
Desktop:  1024px    (md)
Wide:     1280px    (lg)
Ultra:    1536px    (xl)
```

### Responsive Behavior

**Typography:**
- Mobile: Base sizes
- Tablet: +2pt larger
- Desktop: +4pt larger

**Spacing:**
- Mobile: Base spacing (8pt grid)
- Tablet: +50% spacing
- Desktop: +100% spacing

**Layout:**
- Mobile: Stack vertically, single column
- Tablet: 2-column layouts where appropriate
- Desktop: Multi-column, sidebar layouts

---

## Animation & Motion

### Animation Duration

```
Instant:  0ms       - Immediate feedback
Fast:     100ms     - Quick transitions
Normal:   200ms     - Default animations
Slow:     300ms     - Deliberate motions
Slower:   500ms     - Large transitions
Slowest:  800ms     - Full-screen changes
```

### Easing Functions

```
Linear:     linear               - Constant speed (progress indicators)
Ease Out:   cubic-bezier(0.0, 0.0, 0.2, 1)   - Deceleration (entering)
Ease In:    cubic-bezier(0.4, 0.0, 1, 1)     - Acceleration (exiting)
Ease In Out: cubic-bezier(0.4, 0.0, 0.2, 1)  - Smooth (modal transitions)
Spring:     iOS spring animation             - Bouncy (interactive elements)
```

### Common Animations

**Button Press:**
```
Duration: 100ms
Effect: Scale to 0.95, opacity to 0.8
Easing: Ease Out
```

**Card Tap:**
```
Duration: 100ms
Effect: Scale to 0.98
Easing: Spring (iOS) / Ease Out (Android)
```

**Screen Transition:**
```
Duration: 300ms
Effect: Slide from right (push) or left (pop)
Easing: Ease In Out
```

**Modal Appearance:**
```
Duration: 300ms
Effect: Slide up from bottom with fade
Easing: Ease Out
Backdrop: Fade in to 0.4 opacity
```

**Loading Spinner:**
```
Duration: 1000ms (continuous)
Effect: Rotate 360 degrees
Easing: Linear
```

**Skeleton Shimmer:**
```
Duration: 1500ms (continuous)
Effect: Gradient shift left to right
Easing: Linear
```

**Haptic Feedback:**
```
Light Impact:  Selection changes, toggle switches
Medium Impact: Button taps, confirmations
Heavy Impact:  Success actions, major confirmations
```

---

## Component Specifications

### Buttons

#### Primary Button
```
Height: 48pt (Large), 40pt (Medium), 32pt (Small)
Padding: 16pt vertical, 24pt horizontal (Large)
Border Radius: 8pt
Background: #0D7377 (Primary)
Text: Inter SemiBold 16pt, White
Shadow: Level 1 (resting), Level 2 (hover)
Minimum Width: 120pt

States:
- Default: Background #0D7377, no scale
- Hover: Background #14A0A5, Shadow Level 2
- Pressed: Background #095256, Scale 0.98
- Disabled: Background #E0E0E0, Text #999999, No shadow
```

#### Secondary Button
```
Height: 48pt (Large), 40pt (Medium), 32pt (Small)
Padding: 16pt vertical, 24pt horizontal (Large)
Border Radius: 8pt
Background: Transparent
Border: 2pt solid #0D7377
Text: Inter SemiBold 16pt, #0D7377
Shadow: None

States:
- Default: Border #0D7377, Text #0D7377
- Hover: Background #0D73770A (5% opacity), Border #14A0A5
- Pressed: Background #0D737714 (10% opacity), Scale 0.98
- Disabled: Border #E0E0E0, Text #999999
```

#### Destructive Button
```
Background: #EA5455 (Error)
Text: White
Usage: Delete, cancel critical actions
All other specs same as Primary Button
```

#### Text Button
```
Height: Auto (text height + padding)
Padding: 8pt vertical, 0pt horizontal
Background: Transparent
Text: Inter Medium 14pt, #0D7377
Border: None
Shadow: None

States:
- Default: Text #0D7377
- Hover: Text #14A0A5, Underline
- Pressed: Text #095256, Opacity 0.8
```

### Input Fields

#### Text Input
```
Height: 48pt
Padding: 12pt vertical, 16pt horizontal
Border Radius: 8pt
Border: 1pt solid #E0E0E0
Background: #F5F5F5
Text: SF Pro Regular 14pt, #333333
Placeholder: SF Pro Regular 14pt, #999999

States:
- Default: Border #E0E0E0, Background #F5F5F5
- Focus: Border #0D7377 (2pt), Background White
- Error: Border #EA5455 (2pt), Error text below
- Disabled: Background #F5F5F5, Text #999999
```

#### Search Bar
```
Height: 48pt
Padding: 12pt vertical, 16pt horizontal, 40pt left (icon)
Border Radius: 12pt
Background: #F5F5F5
Icon: magnifyingglass, 20x20pt, #999999, left 12pt
Clear Button: xmark.circle.fill, 20x20pt, right 12pt
Border: None (focus: 2pt solid #0D7377)
```

#### Phone Input
```
Height: 48pt
Country Code Picker: Left side, +91 default
Separator: 1pt vertical line, #E0E0E0
Input: Right side, 10 digits
Placeholder: "9876543210"
```

#### OTP Input
```
6 individual boxes
Box Size: 48x56pt each
Gap: 8pt between boxes
Border Radius: 8pt
Border: 2pt solid #E0E0E0
Text: Inter SemiBold 24pt, centered
Focus: Border #0D7377
```

### Cards

#### Service Card
```
Size: 181pt width x 140pt height (2-column grid)
Padding: 12pt
Border Radius: 12pt
Background: White (#FFFFFF)
Shadow: Level 1

Content:
- Icon: 32x32pt, centered, top 12pt
- Title: Inter Medium 14pt, centered, 8pt margin top
- Price: Inter SemiBold 16pt, #0D7377, centered, 4pt margin top

States:
- Default: Shadow Level 1
- Hover: Shadow Level 2, Scale 1.02
- Pressed: Scale 0.98, Shadow Level 1
```

#### Booking Card
```
Width: Full width - 32pt margins
Height: Auto (min 100pt)
Padding: 16pt
Border Radius: 12pt
Background: White
Shadow: Level 1
Border Left: 4pt solid (status color)

Content:
- Status Badge: Top right, pill shape
- Service Name: Inter SemiBold 16pt
- Date & Time: SF Pro Regular 14pt, #666666
- Provider Info: Profile image + name
- Price: Inter SemiBold 18pt, #0D7377

Status Colors:
- Active: #FF6B35 (Orange)
- Completed: #28C76F (Green)
- Cancelled: #EA5455 (Red)
- Pending: #FFC107 (Yellow)
```

### Navigation

#### Bottom Tab Bar
```
Height: 49pt + safe area (typically 83pt total on iPhone 14)
Background: White (#FFFFFF)
Border Top: 1pt solid #E0E0E0
Shadow: 0 -2px 8px rgba(0,0,0,0.05)

Tab Item:
- Icon: 24x24pt
- Label: SF Pro Regular 10pt
- Spacing: 4pt between icon and label
- Selected Color: #0D7377
- Unselected Color: #999999

Interaction:
- Tap: Spring animation on icon (scale 1.1 → 1.0)
- Switch: Cross-fade content (300ms)
```

#### Top Navigation Bar
```
Height: 56pt (+ status bar on iOS)
Background: White
Border Bottom: 1pt solid #E0E0E0
Padding: 16pt horizontal

Left: Back button or menu icon (24x24pt)
Center: Title (Inter SemiBold 16pt)
Right: Action icons (24x24pt, up to 2)
```

### Lists

#### List Item
```
Height: Auto (min 64pt)
Padding: 12pt vertical, 16pt horizontal
Border Bottom: 1pt solid #F5F5F5
Background: White

Content:
- Left: Icon or image (40x40pt, 12pt right margin)
- Center: Title + subtitle stacked
- Right: Chevron or action (24x24pt)

States:
- Default: Background White
- Hover: Background #F5F5F5
- Pressed: Background #E0E0E0, opacity 0.5
```

### Modals & Bottom Sheets

#### Modal Dialog
```
Width: 90% of screen (max 400pt)
Padding: 24pt
Border Radius: 16pt
Background: White
Shadow: Level 4

Backdrop: 0.4 opacity black, tap to dismiss

Content:
- Title: Inter SemiBold 20pt, centered
- Body: SF Pro Regular 14pt, 16pt top margin
- Buttons: 24pt top margin, stacked or horizontal
```

#### Bottom Sheet
```
Width: Full width
Max Height: 90% of screen
Border Radius: 16pt (top corners only)
Background: White
Shadow: Level 3

Handle: 32x4pt, #E0E0E0, centered, 8pt top margin

Animation:
- Appear: Slide up 300ms, Ease Out
- Dismiss: Slide down 250ms, Ease In
```

---

## Dark Mode

### Color Adaptations

```
Background:      #1E1E1E  (was #FFFFFF)
Surface:         #2A2A2A  (was #FFFFFF for cards)
Surface Variant: #3A3A3A  (was #F5F5F5 for inputs)
Border:          #3A3A3A  (was #E0E0E0)
Text Primary:    #E0E0E0  (was #1E1E1E)
Text Secondary:  #A0A0A0  (was #666666)
Text Disabled:   #666666  (was #999999)

Primary:         #14A0A5  (lighter than #0D7377 for better contrast)
Secondary:       #FF8B60  (lighter than #FF6B35)
Success:         #4ADE80  (lighter than #28C76F)
Error:           #F87171  (lighter than #EA5455)
Warning:         #FCD34D  (lighter than #FFC107)
```

### Component Adjustments

**Shadows:**
- Reduce opacity by 50%
- Use elevation with borders instead of heavy shadows
- Add subtle 1pt border: rgba(255, 255, 255, 0.1)

**Buttons:**
- Primary: Lighter teal (#14A0A5) on dark background
- Secondary: Border 2pt solid #14A0A5, Text #14A0A5
- Maintain same hover/pressed states with adjusted colors

**Cards:**
- Background: #2A2A2A
- Border: Optional 1pt solid #3A3A3A
- Shadow: Level 1 with reduced opacity

**Inputs:**
- Background: #3A3A3A
- Border: #3A3A3A
- Focus: Border #14A0A5
- Text: #E0E0E0

---

## Accessibility

### Color Contrast

**WCAG AA Compliance (Minimum 4.5:1 ratio):**

```
Light Mode:
- Primary text (#1E1E1E) on White (#FFFFFF): 16.1:1 ✓
- Secondary text (#666666) on White (#FFFFFF): 5.7:1 ✓
- Primary button text (White) on Primary (#0D7377): 4.8:1 ✓
- Link text (#0D7377) on White (#FFFFFF): 5.1:1 ✓

Dark Mode:
- Primary text (#E0E0E0) on Background (#1E1E1E): 11.3:1 ✓
- Secondary text (#A0A0A0) on Background (#1E1E1E): 6.2:1 ✓
- Primary button text (White) on Primary (#14A0A5): 5.2:1 ✓
```

### Touch Targets

**Minimum Size:** 44x44pt (iOS), 48x48dp (Android)

**Examples:**
- Buttons: Minimum 44pt height
- Icons: 24x24pt icon with 44x44pt tap area
- List items: Minimum 56pt height
- Tab bar items: Entire tab (44pt+) is tappable

### Dynamic Type Support

**iOS:**
- Support all Dynamic Type sizes (from -2 to +3)
- Text should scale proportionally
- Maintain hierarchy at all sizes
- Layouts should adapt (stack if necessary)
- Touch targets must not shrink below 44pt

### Screen Reader Support

**VoiceOver Labels:**
```
Buttons: "Book now, button"
Icons: "Search, button" or "Notifications, 3 unread"
Images: Descriptive alt text
Forms: Label + field type + instructions
Lists: "Service list, 12 items, item 1 of 12"
```

**Navigation:**
- Logical reading order (top to bottom, left to right)
- Grouping related elements
- Skip links for long lists
- Clear focus indicators

### Reduced Motion

- Respect system preference for reduced motion
- Replace animations with instant transitions
- Disable auto-playing videos/carousels
- Remove parallax effects

---

## Implementation Notes

### SwiftUI Color Extension
```swift
extension Color {
    static let brandPrimary = Color("Primary") // #0D7377
    static let brandSecondary = Color("Secondary") // #FF6B35
    static let success = Color("Success") // #28C76F
    static let error = Color("Error") // #EA5455
    // ... add all colors to Assets.xcassets
}
```

### SwiftUI Font Extension
```swift
extension Font {
    static func h1() -> Font { .custom("Inter-Bold", size: 32) }
    static func h2() -> Font { .custom("Inter-SemiBold", size: 24) }
    static func body() -> Font { .system(size: 14, weight: .regular) }
    // ... add all typography styles
}
```

### SwiftUI Spacing Extension
```swift
extension CGFloat {
    static let spacingTight: CGFloat = 4
    static let spacingSmall: CGFloat = 8
    static let spacingMedium: CGFloat = 16
    static let spacingLarge: CGFloat = 24
    // ... add all spacing values
}
```

---

## Version History

**v1.0 - December 31, 2024**
- Initial design system release
- Brand colors, typography, spacing defined
- Component specifications documented
- Dark mode guidelines established
- Accessibility standards set

---

**This design system serves as the single source of truth for all UrbanNest product design and development. All designs and implementations must adhere to these guidelines to ensure consistency, quality, and brand cohesion across iOS, Android, and web platforms.**
