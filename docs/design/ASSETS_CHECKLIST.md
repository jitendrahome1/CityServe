# UrbanNest Assets Checklist

**Version:** 1.0
**Last Updated:** December 31, 2024
**For:** iOS, Android, Web platforms

This document lists all required assets for the UrbanNest platform including app icons, service icons, illustrations, images, and other design assets.

---

## Table of Contents

1. [App Icons & Brand Assets](#app-icons--brand-assets)
2. [Service Category Icons](#service-category-icons)
3. [UI Icons (SF Symbols)](#ui-icons-sf-symbols)
4. [Illustrations](#illustrations)
5. [Images & Photos](#images--photos)
6. [Marketing Assets](#marketing-assets)
7. [Platform-Specific Requirements](#platform-specific-requirements)

---

## App Icons & Brand Assets

### iOS App Icon

Required sizes for iOS App Icon (all PNG format, no transparency):

```
iPhone:
- 180x180px @ 3x  (iPhone 14 Pro, 14, 13 Pro, etc.)
- 120x120px @ 2x  (iPhone SE, older models)

iPad:
- 152x152px @ 2x  (iPad Pro)
- 76x76px @ 1x    (iPad)

App Store:
- 1024x1024px     (App Store listing)

Spotlight/Settings:
- 120x120px @ 3x  (Spotlight iPhone)
- 80x80px @ 2x    (Spotlight iPhone)
- 80x80px @ 2x    (Settings iPhone)
- 58x58px @ 2x    (Settings iPhone)
- 40x40px @ 2x    (Spotlight iPad)
- 40x40px @ 2x    (Settings iPad)
```

**Design Specifications:**
- Background: Deep Teal (#0D7377) with subtle gradient
- Icon: White "UN" monogram or nest symbol
- Style: Rounded square (iOS applies corner radius automatically)
- No text: Icon should be recognizable without text
- Padding: 10% safe area from edges

**File Naming Convention:**
```
AppIcon-1024.png         (1024x1024 - App Store)
AppIcon-180.png          (180x180 - iPhone @3x)
AppIcon-120.png          (120x120 - iPhone @2x)
... etc.
```

---

### Android App Icon

Required sizes for Android (Adaptive Icon):

```
Foreground Layer:
- 432x432px (xxxhdpi) - Main drawable
- 324x324px (xxhdpi)
- 216x216px (xhdpi)
- 162x162px (hdpi)
- 108x108px (mdpi)

Background Layer:
- Same sizes as foreground

Play Store:
- 512x512px (Play Store listing)
```

**Adaptive Icon Specifications:**
- Safe Zone: 66dp diameter circle (center-cropped on some devices)
- Foreground: "UN" monogram or nest symbol (white)
- Background: Deep Teal (#0D7377) solid color or gradient
- Export both foreground and background as separate files

---

### Logo Files

```
Primary Logo (Horizontal):
- Logo-Primary-Light.svg     (Deep Teal on white/transparent)
- Logo-Primary-Dark.svg      (White on dark background)
- Logo-Primary-Light.png     (2x, 3x for mobile)
- Logo-Primary-Dark.png      (2x, 3x for mobile)
- Dimensions: 200x60px @ 1x

Icon-Only Logo:
- Logo-Icon-Light.svg        (Just nest/UN symbol)
- Logo-Icon-Dark.svg
- Dimensions: 80x80px @ 1x

Wordmark (Text only):
- Logo-Wordmark-Light.svg
- Logo-Wordmark-Dark.svg
- Font: Inter Bold, "UrbanNest"
```

---

### Splash Screen

```
iOS:
- Launch Screen (Xcode Storyboard)
- Center: Logo icon (120x120pt)
- Background: Deep Teal (#0D7377) or White

Android:
- Splash Screen XML (Material 3 guidelines)
- Icon: 288x288dp
- Background: Deep Teal (#0D7377)

Web:
- Loading screen: Full viewport
- Logo: SVG, responsive
```

---

## Service Category Icons

### Primary Service Categories (50 icons)

**Format:** SVG (scalable) + PNG @2x, @3x
**Size:** 32x32pt @ 1x (64x64px @ 2x, 96x96px @ 3x)
**Style:** Flat, 2-color (Primary + White or single color)
**Color:** Deep Teal (#0D7377) for customer app, White for badges

#### Home Services (10 icons)

```
1.  ac-repair.svg              - Air conditioning unit with wrench
2.  refrigerator-repair.svg    - Refrigerator with tools
3.  washing-machine.svg        - Washing machine icon
4.  microwave-repair.svg       - Microwave oven
5.  geyser-repair.svg          - Water heater/geyser
6.  tv-repair.svg              - Television set
7.  chimney-repair.svg         - Kitchen chimney/exhaust
8.  dishwasher.svg             - Dishwasher machine
9.  water-purifier.svg         - RO water purifier
10. air-cooler.svg             - Air cooler icon
```

#### Utilities (10 icons)

```
11. plumbing.svg               - Pipe wrench or faucet
12. electrical.svg             - Lightning bolt or plug
13. carpentry.svg              - Hammer and nails
14. painting.svg               - Paint roller or brush
15. pest-control.svg           - Bug/insect with X
16. cleaning.svg               - Broom or sparkles
17. gardening.svg              - Plant or leaf
18. bathroom-cleaning.svg      - Toilet or shower icon
19. kitchen-cleaning.svg       - Plates or utensils
20. car-wash.svg               - Car with water drops
```

#### Personal Care (10 icons)

```
21. salon-at-home.svg          - Scissors and comb
22. massage.svg                - Hands massaging
23. spa.svg                    - Lotus flower or spa stones
24. facial.svg                 - Face outline with sparkles
25. hair-color.svg             - Hair dye bottle
26. bridal-makeup.svg          - Makeup brushes
27. mehandi.svg                - Henna hand design
28. waxing.svg                 - Smooth skin icon
29. pedicure.svg               - Feet icon
30. manicure.svg               - Hands/nails icon
```

#### Professional Services (10 icons)

```
31. yoga-trainer.svg           - Person in yoga pose
32. fitness-trainer.svg        - Dumbbell or person exercising
33. dietitian.svg              - Apple or nutrition symbol
34. tutor.svg                  - Book and pen
35. music-teacher.svg          - Musical note
36. dance-teacher.svg          - Person dancing
37. photographer.svg           - Camera icon
38. videographer.svg           - Video camera
39. event-planner.svg          - Calendar with checkmarks
40. catering.svg               - Chef hat or food platter
```

#### Repair & Maintenance (10 icons)

```
41. mobile-repair.svg          - Smartphone with wrench
42. laptop-repair.svg          - Laptop with tools
43. computer-repair.svg        - Desktop monitor with tools
44. printer-repair.svg         - Printer icon
45. inverter-repair.svg        - Inverter/UPS icon
46. cctv-installation.svg      - Security camera
47. lock-repair.svg            - Lock and key
48. furniture-assembly.svg     - Furniture pieces
49. modular-kitchen.svg        - Kitchen cabinets
50. interior-design.svg        - Floor plan or color palette
```

---

## UI Icons (SF Symbols)

### Navigation Icons

```
Primary Navigation:
- house.fill                   - Home tab
- list.bullet.rectangle       - Services tab
- calendar                    - Bookings tab
- person.fill                 - Profile tab

Secondary Navigation:
- chevron.left                - Back button
- chevron.right               - Forward, next
- chevron.down                - Dropdown, expand
- chevron.up                  - Collapse
- xmark                       - Close, cancel
- line.horizontal.3           - Menu, hamburger
- ellipsis                    - More options (3 dots)
```

### Action Icons

```
Common Actions:
- magnifyingglass             - Search
- magnifyingglass.circle      - Search button
- plus                        - Add, create new
- plus.circle.fill            - Add button (filled)
- minus                       - Remove, decrease
- pencil                      - Edit
- trash                       - Delete
- paperplane.fill             - Send, submit
- square.and.arrow.up         - Share, export
- arrow.clockwise             - Refresh, reload
- gear                        - Settings
- slider.horizontal.3         - Filter, adjust
- arrow.down.circle           - Download
- arrow.up.circle             - Upload
```

### Status & Feedback Icons

```
Status:
- checkmark.circle.fill       - Success, completed
- xmark.circle.fill           - Error, failed
- exclamationmark.triangle    - Warning, caution
- info.circle                 - Information, help
- bell.fill                   - Notifications
- bell.badge.fill             - Unread notifications

Ratings & Favorites:
- star                        - Star rating (outline)
- star.fill                   - Star rating (filled)
- star.leadinghalf.filled     - Half star
- heart                       - Favorite (outline)
- heart.fill                  - Favorited
```

### Communication Icons

```
- phone.fill                  - Call, phone number
- message.fill                - Chat, messaging
- envelope.fill               - Email
- bubble.left.and.bubble.right - Support chat
- video.fill                  - Video call
- mic.fill                    - Voice, microphone
```

### Location & Maps

```
- mappin.circle.fill          - Location pin
- mappin.and.ellipse         - Current location
- location.fill              - GPS location
- map.fill                   - Map view
- arrow.triangle.turn.up.right.circle - Navigation, directions
```

### Booking & Payment

```
- calendar.badge.plus         - Add booking
- clock.fill                  - Time, schedule
- creditcard.fill             - Payment, credit card
- indianrupeesign.circle     - Indian Rupee currency
- wallet.pass.fill           - Wallet, passes
- doc.text.fill              - Invoice, receipt
- barcode                    - QR code, barcode
```

### Profile & Account

```
- person.circle.fill          - User profile
- person.2.fill              - Multiple users
- person.badge.plus          - Add user
- lock.fill                  - Password, security
- key.fill                   - Authentication
- eye.fill                   - Show password
- eye.slash.fill             - Hide password
```

---

## Illustrations

### Onboarding Illustrations (3 images)

```
1. Onboarding-1-Discover.svg
   - Illustration: Person searching for services on phone
   - Colors: Primary brand colors
   - Size: 280x240pt @ 1x
   - Style: Modern, friendly, minimal

2. Onboarding-2-Book.svg
   - Illustration: Calendar and clock with checkmark
   - Message: "Easy booking"

3. Onboarding-3-Relax.svg
   - Illustration: Person relaxing while service is done
   - Message: "Sit back and relax"
```

**Export Formats:**
- SVG (web)
- PDF (iOS vector)
- PNG @ 2x, 3x (fallback)

---

### Empty State Illustrations (5 images)

```
1. Empty-Bookings.svg
   - Illustration: Calendar with sad face or empty box
   - Message: "No bookings yet"
   - Size: 120x120pt @ 1x

2. Empty-Search.svg
   - Illustration: Magnifying glass with question mark
   - Message: "No results found"

3. Empty-Notifications.svg
   - Illustration: Bell with checkmark
   - Message: "All caught up!"

4. Empty-Favorites.svg
   - Illustration: Empty heart or star
   - Message: "No favorites yet"

5. Empty-Messages.svg
   - Illustration: Empty chat bubble
   - Message: "No messages"
```

---

### Error State Illustrations (3 images)

```
1. Error-Network.svg
   - Illustration: Broken wifi symbol or disconnected plug
   - Message: "Connection error"
   - Size: 100x100pt @ 1x

2. Error-404.svg
   - Illustration: Confused person or lost icon
   - Message: "Page not found"

3. Error-General.svg
   - Illustration: Warning triangle or sad cloud
   - Message: "Something went wrong"
```

---

### Success Illustrations (2 images)

```
1. Success-Booking.svg
   - Illustration: Checkmark with confetti
   - Message: "Booking confirmed!"
   - Size: 160x160pt @ 1x

2. Success-Payment.svg
   - Illustration: Money with checkmark
   - Message: "Payment successful"
```

---

## Images & Photos

### Promotional Banners

```
Hero Banner:
- Size: 1200x400px (web), 390x200pt @ 3x (mobile)
- Content: Service professional at work, happy customer
- Overlay: Text "Get 20% off on first booking"
- Format: JPG (compressed), WebP (web)

Service Banners (50 banners, one per service):
- Size: 800x400px
- Content: Service being performed
- Quality: High resolution, professional photos
- Format: JPG optimized for web/mobile

Promo Cards:
- Size: 358x140pt @ 1x (fits 2-column grid)
- Content: Seasonal offers, discounts
- Format: PNG with transparency or JPG
```

---

### Provider Profile Photos

```
Guidelines (not actual assets, providers upload):
- Minimum Size: 400x400px
- Aspect Ratio: 1:1 (square)
- Format: JPG, PNG
- Max File Size: 2MB
- Content: Professional headshot, clear face visible
- Background: Neutral or blurred
```

---

### Service Before/After Photos

```
Template for providers to upload:
- Size: 800x600px minimum
- Aspect Ratio: 4:3 or 16:9
- Format: JPG
- Max File Size: 5MB per image
- Content: Clear, well-lit photos of work
```

---

## Marketing Assets

### App Store Screenshots (iOS)

```
6.7" iPhone (Pro Max):
- 1290x2796px (6 screenshots required)
- Screenshot 1: Home screen with services
- Screenshot 2: Service detail page
- Screenshot 3: Booking flow
- Screenshot 4: Active booking tracking
- Screenshot 5: Profile with completed bookings
- Screenshot 6: Promotions/offers

6.5" iPhone:
- 1242x2688px (same 6 screenshots)

5.5" iPhone:
- 1242x2208px (same 6 screenshots)

12.9" iPad Pro:
- 2048x2732px (optional, 6 screenshots)
```

**Design Guidelines:**
- Add device frames (optional but recommended)
- Include captions/titles explaining features
- Show real UI, not mockups
- Highlight key features with callouts
- Use brand colors consistently

---

### Play Store Screenshots (Android)

```
Phone Screenshots:
- 1080x1920px minimum (7 screenshots max)
- Screenshot content same as iOS

Tablet Screenshots:
- 7" tablet: 1200x1920px
- 10" tablet: 1920x1200px (landscape)
```

---

### Social Media Assets

```
App Icon for Social:
- 512x512px (profile pictures)
- Format: PNG with transparency

Cover Images:
- Facebook: 820x312px
- Twitter: 1500x500px
- LinkedIn: 1128x191px
- Instagram: 1080x1080px (square posts)

Story Templates:
- Instagram/Facebook Stories: 1080x1920px
- Highlights: Circular 1080x1080px
```

---

### Marketing Collateral

```
Business Cards (Digital):
- 3.5x2" (1050x600px @ 300dpi)
- Format: PDF, PNG

Letterhead:
- A4 size (2480x3508px @ 300dpi)
- Format: PDF

Presentation Template:
- 16:9 ratio (1920x1080px)
- Format: PowerPoint, Keynote, PDF
```

---

## Platform-Specific Requirements

### iOS Specific Assets

```
Launch Screen:
- Storyboard-based (Xcode)
- Center logo on brand color background
- Supports all device sizes dynamically

Tab Bar Icons:
- Active: 25x25pt @ 1x (filled variant)
- Inactive: 25x25pt @ 1x (outline variant)
- Format: PDF (vector) or PNG @2x, @3x

Navigation Bar Icons:
- 22x22pt @ 1x
- Format: PDF (vector) or PNG @2x, @3x
```

---

### Android Specific Assets

```
Launcher Icons (Adaptive):
- Foreground: 432x432px (xxxhdpi)
- Background: 432x432px (xxxhdpi)
- Provide xxxhdpi, xxhdpi, xhdpi, hdpi, mdpi

Notification Icons:
- 24x24dp (xxxhdpi: 96x96px)
- Monochrome white on transparent
- Simple silhouette style

Status Bar Icons:
- 24x24dp (xxxhdpi: 96x96px)
- Monochrome
```

---

### Web Specific Assets

```
Favicon:
- favicon.ico (16x16, 32x32, 48x48 in one file)
- favicon.png (192x192px for Android/Chrome)
- apple-touch-icon.png (180x180px for iOS/Safari)

Open Graph Images:
- og-image.jpg (1200x630px)
- Used when sharing links on social media
- Include logo and tagline

PWA Icons:
- 192x192px (mobile)
- 512x512px (desktop)
- Format: PNG with transparency
```

---

## Asset Organization

### File Structure

```
/assets
├── /app-icons
│   ├── /ios
│   │   ├── AppIcon-1024.png
│   │   ├── AppIcon-180.png
│   │   └── ...
│   ├── /android
│   │   ├── ic_launcher-xxxhdpi.png
│   │   └── ...
│   └── /web
│       ├── favicon.ico
│       └── ...
├── /logos
│   ├── Logo-Primary-Light.svg
│   ├── Logo-Primary-Dark.svg
│   └── ...
├── /service-icons
│   ├── ac-repair.svg
│   ├── plumbing.svg
│   └── ... (50 icons)
├── /illustrations
│   ├── /onboarding
│   ├── /empty-states
│   ├── /error-states
│   └── /success-states
├── /images
│   ├── /banners
│   ├── /promotions
│   └── /placeholders
└── /marketing
    ├── /screenshots
    ├── /social
    └── /collateral
```

---

## Asset Specifications Summary

### File Formats

```
Icons & Logos:
- Primary: SVG (scalable, web)
- iOS: PDF (vector) or PNG @2x, @3x
- Android: PNG (multiple densities)

Illustrations:
- Primary: SVG
- Fallback: PNG @2x, @3x

Photos & Banners:
- Web: WebP (modern), JPG (fallback)
- Mobile: JPG optimized, PNG if transparency needed

App Icons:
- iOS: PNG (no transparency)
- Android: PNG (with transparency for adaptive icons)
```

### Color Profiles

```
Digital Screens:
- Color Space: sRGB
- Format: RGB (not CMYK)

Print (if needed):
- Color Space: CMYK
- Format: PDF or TIFF
- Resolution: 300dpi minimum
```

### Naming Conventions

```
Pattern: {type}-{variant}-{size}.{format}

Examples:
- Logo-Primary-Light.svg
- Icon-Home-Filled-24.png
- Illustration-Onboarding-1.svg
- Banner-Promo-FirstBooking-800x400.jpg
- Screenshot-iPhone-1-Home-1290x2796.png
```

---

## Design Tools Export Settings

### Figma Export

```
Icons (SVG):
- SVG: Outline text, include only "id" attribute
- Simplify stroke, flatten transforms

Images (PNG):
- @2x: 2x scale
- @3x: 3x scale
- Compression: Smallest file size

PDF (iOS):
- Export as PDF
- Preserve vector data
```

### Sketch Export

```
Icons:
- Format: SVG (presentation mode)
- Export density: @1x

Images:
- Formats: PNG @2x, @3x
- Compression: Lossy (80-90% quality)
```

### Adobe Illustrator

```
Icons (SVG):
- SVG: Inline Style, Decimal: 2
- Responsive: checked

PDF (iOS):
- PDF Preset: Smallest File Size
- Compress: checked
```

---

## Quality Checklist

Before finalizing assets, ensure:

- ✅ All required sizes exported
- ✅ File naming convention followed
- ✅ Colors match brand guidelines (#0D7377, #FF6B35)
- ✅ Icons optimized (< 50KB for SVG)
- ✅ Images compressed (< 200KB for mobile banners)
- ✅ Transparency removed from app icons (iOS)
- ✅ Safe zones respected (especially for adaptive icons)
- ✅ Dark mode variants created where needed
- ✅ Accessibility: Icons recognizable at small sizes
- ✅ Legal: Licensed images, no copyright issues

---

## Asset Delivery Timeline

**Phase 1 (MVP - Week 1):**
- App icons (iOS, Android, Web)
- Primary logo (light/dark variants)
- Service icons (50 icons)
- SF Symbols documentation
- Onboarding illustrations (3)
- Empty state illustrations (5)

**Phase 2 (Week 2):**
- Marketing screenshots (iOS, Android)
- Promotional banners
- Error/success illustrations
- Social media assets

**Phase 3 (Week 3):**
- Additional service photos
- Marketing collateral
- Print-ready files (if needed)

---

**All assets must adhere to the [Design System](./DESIGN_SYSTEM.md) color palette, typography, and spacing guidelines. Consistent visual language across all assets ensures brand cohesion.**
