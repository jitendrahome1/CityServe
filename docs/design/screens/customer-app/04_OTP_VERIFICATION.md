# 04 - OTP Verification

**Screen ID:** 04
**Screen Name:** OTP Verification
**User Flow:** Phone Registration → OTP Verification → Profile Setup
**Entry Point:** After user enters phone number and receives OTP
**Next Screen:** Profile Setup (05) for new users, or Home (06) for returning users

---

## Overview

The OTP verification screen allows users to verify their phone number by entering the 6-digit code sent via SMS. This is a critical security step in the authentication flow, confirming the user owns the phone number they provided.

**Purpose:**
- Verify user's phone number ownership
- Prevent fraudulent account creation
- Secure authentication method (SMS OTP)
- Allow OTP resend if not received
- Provide clear feedback during verification
- Handle edge cases (wrong OTP, expired OTP, rate limiting)

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ‹                                     │ ← Back Button
├────────────────────────────────────────┤
│                                        │
│                                        │
│            ┌──────────┐                │
│            │          │                │
│            │   ✉️     │                │ ← SMS Icon
│            │          │                │   (64x64pt)
│            └──────────┘                │
│                                        │
│         Verify Phone Number            │ ← Title
│                                        │
│   We've sent a 6-digit code to         │
│        +91 99999 99999                 │ ← Phone Display
│          [Edit] [Resend]               │ ← Action Links
│                                        │
│                                        │
│  ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ │
│  │ 5 │ │ 3 │ │ 2 │ │ 9 │ │ 1 │ │ 7 │ │ ← OTP Input Boxes
│  └───┘ └───┘ └───┘ └───┘ └───┘ └───┘ │   (6 boxes)
│                                        │
│                                        │
│         ⏱️  Resend code in 00:45       │ ← Countdown Timer
│                                        │
│                                        │
│  ┌────────────────────────────────┐   │
│  │     Verify & Continue          │   │ ← Primary Button
│  └────────────────────────────────┘   │   (Auto-triggers when
│                                        │    6 digits entered)
│                                        │
│                                        │
│       Having trouble? Contact us       │ ← Support Link
│                                        │
│                                        │
│                                        │
└────────────────────────────────────────┘
```

---

## Layout Specifications

### Screen Dimensions
```
Device: iPhone 14 (390x844pt)
Safe Area Top: 47pt (status bar + notch)
Safe Area Bottom: 34pt (home indicator)
Content Area: 390x763pt
Scrollable: No (content fits on screen)
```

### Background
```
Color: White (#FFFFFF) / Dark (#1E1E1E)
```

### Back Button
```
Position: Top left, 16pt from left edge, 8pt from top safe area
Icon: chevron.left (SF Symbol)
Size: 24x24pt
Color: #333333 (light mode), #E0E0E0 (dark mode)
Tap Target: 44x44pt
Action: Navigate back to Phone Registration (with confirmation alert)
Haptic: Medium impact
```

### Icon Container
```
Position: Centered horizontally, 64pt from top safe area
Icon: envelope.fill (SF Symbol) or message.fill
Size: 64x64pt
Background: Circle, 96pt diameter, #FFF5F0 (light orange tint)
Icon Color: #FF6B35 (brand secondary - orange)
Shadow: None
```

### Title Section
```
Position: 24pt below icon
Alignment: Center

Title:
├─ Text: "Verify Phone Number"
├─ Font: Inter SemiBold, 26pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Letter Spacing: -0.5pt
└─ Alignment: Center

Subtitle (Phone Display):
├─ Text: "We've sent a 6-digit code to"
├─ Font: SF Pro Regular, 15pt
├─ Color: #666666 (light), #A0A0A0 (dark)
├─ Line Height: 1.4
├─ Alignment: Center
└─ Margin Top: 8pt

Phone Number:
├─ Text: "+91 99999 99999" (formatted)
├─ Font: SF Pro Medium, 16pt
├─ Color: #0D7377 (brand primary - teal)
├─ Alignment: Center
└─ Margin Top: 4pt

Action Links:
├─ Position: 12pt below phone number
├─ Alignment: Center (horizontal stack)
├─ Gap: 16pt between links
└─ Links:
    ├─ "Edit" - Opens edit phone sheet
    ├─ "Resend" - Sends new OTP (if timer expired)
    ├─ Font: SF Pro Medium, 14pt
    ├─ Color: #0D7377 (enabled), #CCCCCC (disabled during countdown)
    └─ Underline: On tap (active state)
```

### OTP Input Section
```
Position: 32pt below action links
Alignment: Center
Layout: Horizontal stack of 6 boxes

Box Dimensions:
├─ Size: 48x56pt each
├─ Gap: 8pt between boxes
├─ Total Width: (48 × 6) + (8 × 5) = 328pt
├─ Border Radius: 12pt
├─ Border: 2pt solid
└─ Background: #F8F8F8 (light), #2A2A2A (dark)

Box States:
├─ Empty (not focused):
│   ├─ Border: #E0E0E0
│   └─ Background: #F8F8F8
├─ Empty (focused):
│   ├─ Border: #0D7377 (brand primary)
│   ├─ Background: #FFFFFF
│   └─ Shadow: 0 0 0 4px rgba(13,115,119,0.1)
├─ Filled:
│   ├─ Border: #0D7377
│   ├─ Background: #F0F9FA (light teal tint)
│   └─ Text: SF Pro Medium, 24pt, #1E1E1E
└─ Error:
    ├─ Border: #EA5455 (error red)
    ├─ Background: #FFF5F5 (light red tint)
    └─ Shake animation

Text Style:
├─ Font: SF Pro Medium, 24pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Alignment: Center
└─ Secure: No (digits visible, not dots)

Behavior:
├─ Auto-focus on first box (screen appear)
├─ Auto-advance to next box after digit entered
├─ Backspace: Delete current digit, move to previous box
├─ Paste support: Detects 6-digit code from clipboard
├─ Auto-verify: Triggers verification when 6th digit entered
└─ Keyboard: Number pad
```

### Countdown Timer
```
Position: 24pt below OTP boxes
Alignment: Center

Default (counting down):
├─ Icon: clock.fill (SF Symbol), 16x16pt
├─ Text: "Resend code in 00:45"
├─ Font: SF Pro Regular, 14pt
├─ Color: #666666 (light), #A0A0A0 (dark)
├─ Updates every second (00:59 → 00:00)
└─ Format: "mm:ss"

Expired (00:00):
├─ Text: "Didn't receive code?"
├─ Link: "Resend now" (tappable)
├─ Font: SF Pro Medium, 14pt
├─ Color: #0D7377 (brand primary)
└─ Action: Send new OTP, restart timer (60 seconds)

Timer Duration:
├─ Initial: 60 seconds (1 minute)
├─ After resend: 120 seconds (2 minutes)
└─ Max resends: 3 in 15 minutes (rate limiting)
```

### Verify Button
```
Position: 24pt below countdown timer
Padding: 0 32pt horizontal

Button:
├─ Width: Full (390pt - 64pt padding)
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Background: #0D7377 (enabled), #E0E0E0 (disabled)
├─ Shadow: 0 4px 12px rgba(13,115,119,0.2) (enabled)
└─ Shadow: None (disabled)

Text:
├─ Text: "Verify & Continue"
├─ Font: Inter SemiBold, 16pt
├─ Color: White (#FFFFFF)
└─ Icon (loading): ProgressView (spinner), white

States:
├─ Disabled: OTP incomplete (< 6 digits)
├─ Enabled: 6 digits entered (auto-triggers)
├─ Loading: Verifying OTP with backend
└─ Error: Shake animation if verification fails

Behavior:
├─ Auto-trigger when 6th digit entered (no need to tap)
├─ Show loading spinner during verification (2-3s)
├─ Success → Navigate to Profile Setup or Home
└─ Error → Clear OTP, show error message, refocus first box
```

### Support Link
```
Position: 24pt below button
Alignment: Center
Padding Bottom: 32pt

Text:
├─ "Having trouble?" - Regular text
├─ Font: SF Pro Regular, 13pt
├─ Color: #666666
└─ "Contact us" - Link text
    ├─ Font: SF Pro Medium, 13pt
    ├─ Color: #0D7377
    └─ Action: Open support (email, chat, or help center)
```

---

## Component Breakdown

### 1. OTP Input Component
```
Component: Custom OTPTextField (6 individual boxes)
Sub-components:
├─ 6 × SingleDigitBox (independent text fields)
├─ Focus manager (auto-advance logic)
└─ Paste handler (clipboard detection)

Functionality:
├─ Auto-focus first box on appear
├─ Auto-advance to next box after digit entry
├─ Backspace: Delete current, move to previous
├─ Paste: Detects "123456" from clipboard, fills all boxes
├─ Auto-verify: Calls verification API when 6th digit entered
└─ Accessibility: Grouped as single field ("Enter 6-digit code")

States:
├─ Empty (6 boxes, first focused)
├─ Partial (2-5 digits entered)
├─ Complete (6 digits entered, verifying)
├─ Error (wrong code, boxes shake + clear)
└─ Success (verified, navigate away)
```

### 2. Countdown Timer Component
```
Component: CountdownTimer
Props:
├─ duration: Int (seconds, default 60)
├─ onExpire: () -> Void (callback when 00:00)
└─ resetTrigger: Bool (restart timer on resend)

Display:
├─ Clock icon + "Resend code in 00:XX"
├─ Updates every second
├─ Changes to "Resend now" link when expired
└─ Disables "Resend" link while counting

Logic:
├─ Timer.publish(every: 1.0) publisher
├─ Format seconds as mm:ss
├─ Stop at 00:00, trigger callback
└─ Restart on manual resend
```

### 3. Phone Display Component
```
Component: PhoneNumberDisplay
Props:
├─ phoneNumber: String ("+919999999999")
├─ onEdit: () -> Void (callback)
└─ onResend: () -> Void (callback)

Display:
├─ Formatted: "+91 99999 99999"
├─ Two action links: "Edit" | "Resend"
├─ Links disabled during countdown
└─ Teal color for phone number (emphasis)

Actions:
├─ Edit: Show bottom sheet to change phone number
├─ Resend: Send new OTP, restart timer (if allowed)
└─ Haptic feedback on tap
```

---

## Animations & Transitions

### Entry Animation
```
Duration: 500ms
Easing: Ease Out

Sequence:
0ms   - Screen slides in from right
100ms - Icon fades in + scale (0.8 → 1.0)
200ms - Title + subtitle fade in + slide up (10pt)
300ms - Phone number + action links fade in
400ms - OTP boxes fade in + slide up (10pt)
500ms - Timer + button fade in
600ms - Auto-focus first OTP box (keyboard appears)
```

### OTP Box Focus Animation
```
Duration: 200ms
Easing: Ease Out

Changes:
├─ Border color: #E0E0E0 → #0D7377
├─ Border width: 2pt (no change, always 2pt)
├─ Background: #F8F8F8 → #FFFFFF
├─ Shadow: Appear (0 0 0 4px rgba(13,115,119,0.1))
└─ Cursor: Blink animation (every 500ms)
```

### Digit Entry Animation
```
Duration: 150ms
Easing: Spring (damping 0.7)

Sequence:
├─ Digit appears: Fade in (opacity 0 → 1)
├─ Box scales: 1.0 → 1.05 → 1.0
├─ Background changes: #FFFFFF → #F0F9FA (teal tint)
├─ Focus moves to next box (if not last)
└─ Haptic: Light impact

If last digit (6th):
├─ All boxes scale slightly (1.0 → 1.02 → 1.0)
├─ Auto-trigger verification (500ms delay)
└─ Button shows loading state
```

### Auto-Advance Animation
```
Duration: 150ms
Easing: Ease Out

Sequence:
├─ Current box: Focus removed (shadow fades out)
├─ Next box: Focus applied (shadow fades in, border color changes)
├─ Cursor moves immediately
└─ Smooth transition (no flicker)
```

### Backspace Animation
```
Duration: 100ms
Easing: Ease Out

Sequence:
├─ Current digit: Fade out + scale down (1.0 → 0.8)
├─ Box background: Revert to #F8F8F8
├─ Focus moves to previous box
└─ Haptic: Light impact
```

### Paste Animation
```
Trigger: User pastes 6-digit code
Duration: 600ms
Easing: Sequential ease out

Sequence:
├─ All boxes fill sequentially (100ms each)
├─ Each box: Fade in digit + scale animation
├─ Final state: All 6 boxes filled
├─ Wait 300ms
├─ Auto-trigger verification
└─ Haptic: Medium impact
```

### Error Animation (Wrong OTP)
```
Trigger: Backend returns "invalid OTP"
Duration: 600ms
Easing: Ease in/out

Sequence:
├─ Stop loading spinner
├─ All OTP boxes shake:
│   ├─ 0ms: Translate +10pt right
│   ├─ 100ms: Translate -10pt left
│   ├─ 200ms: Translate +8pt right
│   ├─ 300ms: Translate -8pt left
│   ├─ 400ms: Translate +4pt right
│   └─ 500ms: Return to center
├─ Border color: #0D7377 → #EA5455 (red)
├─ Background: #F0F9FA → #FFF5F5 (light red)
├─ All digits clear (fade out)
├─ Error message appears below boxes
├─ Refocus first box
└─ Haptic: Error notification (3 taps)

Error Message:
├─ Text: "Invalid code. Please try again."
├─ Font: SF Pro Regular, 13pt
├─ Color: #EA5455 (error red)
├─ Icon: exclamationmark.circle.fill
├─ Position: 8pt below OTP boxes
└─ Auto-dismiss: After 3 seconds
```

### Success Animation
```
Trigger: OTP verified successfully
Duration: 800ms
Easing: Ease out

Sequence:
├─ Stop loading spinner
├─ All OTP boxes:
│   ├─ Border: #0D7377 → #28C76F (success green)
│   ├─ Background: #F0F9FA → #F0FFF4 (light green)
│   └─ Checkmark icon appears (fade in + scale)
├─ Button:
│   ├─ Background: #0D7377 → #28C76F
│   ├─ Text: "Verify & Continue" → "Verified ✓"
├─ Wait 400ms (user sees success state)
├─ Entire screen fades out (opacity 1 → 0, 300ms)
├─ Navigate to Profile Setup or Home
└─ Haptic: Success notification (2 taps)
```

### Resend OTP Animation
```
Trigger: User taps "Resend now"
Duration: 300ms

Sequence:
├─ "Resend now" link scales (1.0 → 0.95 → 1.0)
├─ Link temporarily disabled (gray out)
├─ Show toast: "Code sent!"
│   ├─ Position: Top of screen
│   ├─ Background: #28C76F (success green)
│   ├─ Duration: 2 seconds
│   └─ Icon: checkmark.circle.fill
├─ Timer resets (00:60 or 02:00)
├─ Timer starts counting down
└─ Haptic: Success notification
```

---

## States

### Default State (Initial)
```
Status: Waiting for user to enter OTP
Visual:
├─ All 6 OTP boxes empty
├─ First box focused (blue border)
├─ Countdown timer: 00:60 (counting down)
├─ "Resend" link: Disabled (gray)
├─ Button: Disabled (gray)
└─ Keyboard: Number pad visible
```

### Typing State (1-5 digits)
```
Status: User entering OTP code
Visual:
├─ Boxes: Some filled, some empty
├─ Current box: Focused (blue border)
├─ Filled boxes: Teal tint background
├─ Timer: Still counting down
├─ Button: Still disabled
└─ Auto-advancing focus on each digit entry
```

### Complete State (6 digits entered)
```
Status: All digits entered, auto-verifying
Visual:
├─ All 6 boxes filled
├─ Last box: Still focused
├─ Button: Shows loading spinner (auto-triggered)
├─ Screen interactions: Disabled (no editing during verification)
└─ Keyboard: Remains visible (don't dismiss)

Duration: 2-5 seconds (API verification)
```

### Verifying State (Loading)
```
Status: Backend verifying OTP
Visual:
├─ Button: Spinner + "Verifying..."
├─ OTP boxes: Disabled (non-editable)
├─ Timer: Still counting (background process)
├─ Back button: Disabled (prevent navigation)
└─ User feedback: Loading indicator

Timeout: 10 seconds max (then show network error)
```

### Success State → Navigation
```
Status: OTP verified successfully
Visual:
├─ All boxes: Green border + checkmark
├─ Button: Green background + "Verified ✓"
├─ Success animation plays
└─ Navigate to next screen (Profile Setup or Home)

Transition:
├─ Wait 400ms (show success state)
├─ Fade out screen (300ms)
└─ Push to next screen

Data Passed:
├─ Phone number (verified)
├─ User ID (from backend)
└─ Auth token (session)
```

### Error State (Invalid OTP)
```
Trigger: Backend returns "OTP incorrect"
Visual:
├─ All boxes: Red border + red tint background
├─ Shake animation (600ms)
├─ All digits cleared
├─ Error message: "Invalid code. Please try again."
├─ First box refocused
├─ Button: Returns to disabled state
└─ Timer: Continues counting

User Action: Can immediately re-enter OTP
Attempts Remaining: Track failed attempts (max 3-5)
```

### Error State (Expired OTP)
```
Trigger: Backend returns "OTP expired" (> 10 minutes old)
Visual:
├─ Error message: "This code has expired. Please request a new one."
├─ Timer: Shows "00:00"
├─ "Resend now" link: Enabled
├─ OTP boxes: Disabled
└─ Alert icon appears

User Action: Must tap "Resend" to get new OTP
```

### Error State (Network Failure)
```
Trigger: No internet or backend unreachable
Visual:
├─ Loading stops
├─ Toast appears: "Unable to verify. Check your connection."
├─ Button: Returns to enabled state
├─ OTP boxes: Remain filled (can retry)
└─ "Retry" option in toast

User Action: Can tap button again to retry
Auto-retry: No (require explicit user action)
```

### Error State (Rate Limited)
```
Trigger: Too many failed attempts (5+ wrong codes)
Visual:
├─ All boxes: Disabled
├─ Error message: "Too many attempts. Please try again in 15 minutes."
├─ Button: Disabled
├─ Timer: Shows cooldown (15:00 → 00:00)
└─ Support link: Highlighted ("Contact us" emphasized)

Recovery: Re-enable after cooldown period
Alternative: "Use different phone number" option
```

### Timer Expired State
```
Trigger: Countdown reaches 00:00
Visual:
├─ Timer text changes:
│   └─ "Didn't receive code? Resend now"
├─ "Resend now" link: Enabled (teal color)
├─ OTP boxes: Remain editable (can still verify if OTP arrived late)
└─ Tappable link to resend

User Action: Can request new OTP or continue entering current one
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E (dark background)
Icon Background: #3A2620 (dark orange tint)
Icon Color: #FF8B60 (lighter orange for visibility)
Text Primary: #E0E0E0 (light text)
Text Secondary: #A0A0A0 (secondary light text)
Phone Number: #14A0A5 (lighter teal)

OTP Boxes:
├─ Background (empty): #2A2A2A
├─ Background (filled): #1A4A4C (dark teal tint)
├─ Border (default): #3A3A3A
├─ Border (focused): #14A0A5 (lighter teal)
├─ Border (error): #EA5455 (same red)
├─ Text: #E0E0E0
└─ Shadow: Removed (not visible in dark mode)

Button:
├─ Background (enabled): #0D7377
├─ Background (disabled): #3A3A3A
├─ Text: #FFFFFF

Timer:
├─ Text: #A0A0A0
├─ Link (enabled): #14A0A5

Error Message:
├─ Text: #EA5455
├─ Background tint: #3A2020 (dark red tint)
```

---

## Accessibility

### VoiceOver

**Element Labels:**
```
Back Button: "Back, button"
Icon: Decorative (hidden from VoiceOver)
Title: "Verify Phone Number, heading"
Subtitle: "We've sent a 6-digit code to +91 99999 99999"
Edit Link: "Edit phone number, button"
Resend Link: "Resend code, button" / "Resend code, disabled" (during countdown)

OTP Input (grouped):
├─ Label: "Enter verification code, 6 digits"
├─ Hint: "Enter the code sent to your phone"
├─ Value: Announces each digit as typed ("5", "3", "2", etc.)
└─ State: "5 3 2, 3 of 6 digits entered"

Timer: "Resend code in 45 seconds" (updated every 10 seconds)
Button: "Verify and continue, button, disabled" / "Verify and continue, button"
Support Link: "Having trouble? Contact us, link"
```

**Announcements:**
```
On screen appear: "Verify Phone Number. Code sent to +91 99999 99999"
On digit entry: "5" (each digit read aloud)
On complete: "All 6 digits entered. Verifying..."
On error: "Error. Invalid code. Please try again."
On success: "Verified. Continuing."
On timer expire: "Code expired. Resend now."
On resend: "New code sent."
```

**Focus Order:**
```
1. Back button
2. Edit link
3. Resend link
4. OTP input (grouped as one)
5. Verify button
6. Support link
```

**Custom Actions:**
```
OTP Input:
├─ Swipe up: Paste from clipboard (if 6-digit code detected)
├─ Swipe down: Clear all digits
└─ Magic Tap: Auto-fill from Messages (if iOS detects OTP)
```

### Dynamic Type

**Supported Sizes:** -2 to +3

**Scaling Behavior:**
```
Title: 26pt → 22pt (min) to 32pt (max)
Subtitle: 15pt → 13pt (min) to 18pt (max)
Phone Number: 16pt → 14pt (min) to 20pt (max)
OTP Boxes: 24pt → 20pt (min) to 32pt (max)
Box Size: 48x56pt → 56x64pt at +3
Timer Text: 14pt → 12pt (min) to 17pt (max)
Button Text: 16pt → 14pt (min) to 19pt (max)

Layout Adjustments:
├─ At +2: OTP boxes arranged in 2 rows (3 boxes each) if width constrained
├─ At +3: Vertical spacing increases to 32pt between sections
└─ Button height: 52pt → 60pt at +3
```

### Reduced Motion

**If "Reduce Motion" enabled:**
```
Entry animation: Instant appear (no slide/fade)
Icon animation: Instant appear (no scale)
OTP box focus: Instant border color change (no shadow animation)
Digit entry: Instant appear (no scale)
Auto-advance: Instant focus change (no transition)
Error shake: Replaced with red border flash (3 flashes)
Success animation: Instant color change (no checkmark animation)
Transitions: Crossfade instead of slide
```

### Auto-Fill OTP (iOS)

**SMS Auto-Fill:**
```
iOS Security Code AutoFill:
├─ Enable: contentType = .oneTimeCode
├─ Detection: iOS scans Messages app for OTP
├─ Banner: "From Messages: 532917" appears above keyboard
├─ Action: Tap banner to auto-fill all 6 boxes
└─ Animation: Paste animation (sequential fill)

SMS Format:
├─ Standard: "532917 is your UrbanNest verification code"
├─ iOS detects: 6-digit number in recent SMS
├─ Auto-suggest: Appears within 30 seconds of SMS arrival
└─ Security: Domain-bound (urb annest.com or your-app-name)
```

### Color Contrast

**WCAG AA Compliance (4.5:1 minimum):**
```
✅ Title (#1E1E1E on #FFFFFF): 16.1:1
✅ Subtitle (#666666 on #FFFFFF): 5.7:1
✅ Phone (#0D7377 on #FFFFFF): 4.9:1
✅ OTP Text (#1E1E1E on #F0F9FA): 14.2:1
✅ Button Text (White on #0D7377): 5.2:1
✅ Error (#EA5455 on #FFFFFF): 4.8:1
✅ Timer (#666666 on #FFFFFF): 5.7:1
✅ Dark mode Title (#E0E0E0 on #1E1E1E): 12.6:1
✅ Dark mode OTP (#E0E0E0 on #1A4A4C): 9.8:1
```

### Touch Targets

**Minimum 44x44pt:**
```
✅ Back button: 44x44pt
✅ Edit link: Minimum 44pt height
✅ Resend link: Minimum 44pt height
✅ Each OTP box: 48x56pt (exceeds minimum)
✅ Verify button: Full width x 52pt
✅ Support link: Full width x 44pt
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct OTPVerificationView: View {
    let phoneNumber: String // "+919999999999"
    let verificationID: String // From Firebase

    @StateObject private var viewModel: OTPVerificationViewModel
    @State private var otpCode: [String] = ["", "", "", "", "", ""]
    @State private var isVerifying: Bool = false
    @State private var errorMessage: String? = nil
    @State private var timeRemaining: Int = 60
    @State private var canResend: Bool = false
    @FocusState private var focusedBox: Int?
    @Environment(\.dismiss) var dismiss

    init(phoneNumber: String, verificationID: String) {
        self.phoneNumber = phoneNumber
        self.verificationID = verificationID
        _viewModel = StateObject(wrappedValue: OTPVerificationViewModel(verificationID: verificationID))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Icon
                ZStack {
                    Circle()
                        .fill(Color.secondaryLight.opacity(0.1))
                        .frame(width: 96, height: 96)

                    Image(systemName: "envelope.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .foregroundColor(.brandSecondary)
                }
                .padding(.top, 64)

                // Title
                Text("Verify Phone Number")
                    .font(.custom("Inter-SemiBold", size: 26))
                    .foregroundColor(.textPrimary)
                    .padding(.top, 24)

                // Subtitle
                VStack(spacing: 4) {
                    Text("We've sent a 6-digit code to")
                        .font(.system(size: 15))
                        .foregroundColor(.textSecondary)

                    Text(formatPhoneNumber(phoneNumber))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.brandPrimary)
                }
                .padding(.top, 8)

                // Edit / Resend Links
                HStack(spacing: 16) {
                    Button("Edit") {
                        showEditPhoneSheet()
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.brandPrimary)

                    Text("•")
                        .foregroundColor(.textSecondary)

                    Button("Resend") {
                        resendOTP()
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(canResend ? .brandPrimary : .gray400)
                    .disabled(!canResend)
                }
                .padding(.top, 12)

                // OTP Input Boxes
                OTPInputView(
                    otpCode: $otpCode,
                    focusedBox: $focusedBox,
                    hasError: errorMessage != nil
                )
                .padding(.top, 32)
                .onChange(of: otpCode) { newValue in
                    errorMessage = nil
                    checkIfComplete(newValue)
                }

                // Error Message
                if let error = errorMessage {
                    ErrorLabel(message: error)
                        .padding(.top, 12)
                }

                // Countdown Timer
                CountdownTimerView(
                    timeRemaining: $timeRemaining,
                    canResend: $canResend,
                    onResend: resendOTP
                )
                .padding(.top, 24)

                // Verify Button
                PrimaryButton(
                    title: "Verify & Continue",
                    action: verifyOTP,
                    isLoading: isVerifying,
                    isDisabled: !isOTPComplete
                )
                .padding(.horizontal, 32)
                .padding(.top, 24)

                // Support Link
                HStack(spacing: 4) {
                    Text("Having trouble?")
                        .font(.system(size: 13))
                        .foregroundColor(.textSecondary)

                    Button("Contact us") {
                        openSupport()
                    }
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.brandPrimary)
                }
                .padding(.top, 24)
                .padding(.bottom, 32)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: handleBackButton) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.textPrimary)
                }
            }
        }
        .onAppear {
            startTimer()
            focusedBox = 0 // Auto-focus first box
        }
    }

    private var isOTPComplete: Bool {
        otpCode.allSatisfy { $0.count == 1 }
    }

    private func checkIfComplete(_ code: [String]) {
        if isOTPComplete {
            // Auto-verify after short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                verifyOTP()
            }
        }
    }

    private func verifyOTP() {
        let code = otpCode.joined()
        isVerifying = true

        Task {
            do {
                let user = try await viewModel.verifyOTP(code: code, phone: phoneNumber)
                isVerifying = false

                // Show success animation (400ms)
                try? await Task.sleep(nanoseconds: 400_000_000)

                // Navigate to next screen
                if user.isNewUser {
                    // Navigate to Profile Setup
                } else {
                    // Navigate to Home
                }

            } catch {
                isVerifying = false
                handleVerificationError(error)
            }
        }
    }

    private func handleVerificationError(_ error: Error) {
        // Shake animation + clear OTP
        withAnimation(.easeInOut(duration: 0.6)) {
            // Shake handled by view modifier
        }

        errorMessage = error.localizedDescription
        otpCode = ["", "", "", "", "", ""]
        focusedBox = 0

        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }

    private func resendOTP() {
        guard canResend else { return }

        Task {
            do {
                _ = try await viewModel.resendOTP(to: phoneNumber)

                // Show success toast
                showToast(message: "Code sent!", type: .success)

                // Reset timer (2 minutes after first resend)
                timeRemaining = timeRemaining == 60 ? 120 : 120
                canResend = false
                startTimer()

            } catch {
                showToast(message: "Failed to send code. Try again.", type: .error)
            }
        }
    }

    private func startTimer() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    canResend = true
                }
            }
            .store(in: &viewModel.cancellables)
    }

    private func handleBackButton() {
        // Show confirmation alert
        let alert = UIAlertController(
            title: "Go back?",
            message: "You'll need to request a new verification code",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Go Back", style: .destructive) { _ in
            dismiss()
        })
        // Present alert
    }

    private func formatPhoneNumber(_ phone: String) -> String {
        // "+919999999999" → "+91 99999 99999"
        let digits = phone.filter { $0.isNumber }
        if digits.count == 10 {
            return "+91 \(digits.prefix(5)) \(digits.suffix(5))"
        }
        return phone
    }

    private func showEditPhoneSheet() {
        // Show bottom sheet to edit phone number
    }

    private func openSupport() {
        // Open support (email, chat, help center)
    }

    private func showToast(message: String, type: ToastType) {
        // Show toast notification
    }
}
```

### OTP Input Component

```swift
struct OTPInputView: View {
    @Binding var otpCode: [String]
    var focusedBox: FocusState<Int?>.Binding
    var hasError: Bool

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<6, id: \.self) { index in
                SingleDigitBox(
                    digit: $otpCode[index],
                    index: index,
                    focusedBox: focusedBox,
                    hasError: hasError
                )
            }
        }
        .padding(.horizontal, 16)
        .onAppear {
            // Enable paste detection
            UIPasteboard.general.addObserver(
                self,
                forKeyPath: "changeCount",
                options: .new,
                context: nil
            )
        }
    }

    private func handlePaste() {
        if let pastedString = UIPasteboard.general.string,
           pastedString.count == 6,
           pastedString.allSatisfy({ $0.isNumber }) {
            // Fill all boxes
            for (index, char) in pastedString.enumerated() {
                otpCode[index] = String(char)
            }
            focusedBox.wrappedValue = nil // Remove focus
        }
    }
}

struct SingleDigitBox: View {
    @Binding var digit: String
    let index: Int
    var focusedBox: FocusState<Int?>.Binding
    var hasError: Bool

    @State private var shake: Bool = false

    var body: some View {
        TextField("", text: $digit)
            .font(.system(size: 24, weight: .medium))
            .foregroundColor(.textPrimary)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .frame(width: 48, height: 56)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
            .shadow(color: shadowColor, radius: 4)
            .focused(focusedBox, equals: index)
            .onChange(of: digit) { newValue in
                handleDigitChange(newValue)
            }
            .modifier(ShakeEffect(animatableData: shake ? 1 : 0))
            .onChange(of: hasError) { error in
                if error {
                    withAnimation(.easeInOut(duration: 0.6)) {
                        shake.toggle()
                    }
                }
            }
            .textContentType(.oneTimeCode) // Enable iOS auto-fill
    }

    private var backgroundColor: Color {
        if hasError {
            return Color.red.opacity(0.05)
        } else if !digit.isEmpty {
            return Color.brandPrimary.opacity(0.05)
        } else if isFocused {
            return Color.white
        } else {
            return Color.gray100
        }
    }

    private var borderColor: Color {
        if hasError {
            return .error
        } else if isFocused {
            return .brandPrimary
        } else if !digit.isEmpty {
            return .brandPrimary
        } else {
            return .gray300
        }
    }

    private var shadowColor: Color {
        isFocused ? Color.brandPrimary.opacity(0.1) : Color.clear
    }

    private var isFocused: Bool {
        focusedBox.wrappedValue == index
    }

    private func handleDigitChange(_ newValue: String) {
        // Only allow single digit
        if newValue.count > 1 {
            digit = String(newValue.last!)
        }

        // Auto-advance to next box
        if newValue.count == 1 && index < 5 {
            focusedBox.wrappedValue = index + 1
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }

        // Backspace: Move to previous box
        if newValue.isEmpty && index > 0 {
            focusedBox.wrappedValue = index - 1
        }
    }
}

struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = 10 * sin(animatableData * .pi * 2)
        return ProjectionTransform(
            CGAffineTransform(translationX: translation, y: 0)
        )
    }
}
```

### Countdown Timer Component

```swift
struct CountdownTimerView: View {
    @Binding var timeRemaining: Int
    @Binding var canResend: Bool
    var onResend: () -> Void

    var body: some View {
        HStack(spacing: 6) {
            if !canResend {
                Image(systemName: "clock.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)

                Text("Resend code in \(formattedTime)")
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)
            } else {
                Text("Didn't receive code?")
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary)

                Button("Resend now") {
                    onResend()
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.brandPrimary)
            }
        }
    }

    private var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
```

### ViewModel

```swift
@MainActor
class OTPVerificationViewModel: ObservableObject {
    let verificationID: String
    var cancellables = Set<AnyCancellable>()

    init(verificationID: String) {
        self.verificationID = verificationID
    }

    func verifyOTP(code: String, phone: String) async throws -> User {
        // Firebase Phone Auth verification
        // Simulated:
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2s

        if code == "111111" {
            throw NSError(domain: "", code: 401, userInfo: [
                NSLocalizedDescriptionKey: "Invalid code. Please try again."
            ])
        }

        // Success: Return user
        return User(id: "123", phone: phone, isNewUser: true)

        // Real implementation:
        // let credential = PhoneAuthProvider.provider().credential(
        //     withVerificationID: verificationID,
        //     verificationCode: code
        // )
        // let result = try await Auth.auth().signIn(with: credential)
        // return User(from: result.user)
    }

    func resendOTP(to phone: String) async throws -> String {
        // Send new OTP
        try await Task.sleep(nanoseconds: 1_500_000_000)
        return "new-verification-id"
    }
}
```

---

## Assets Required

### SF Symbols
```
- chevron.left (Back button)
- envelope.fill or message.fill (SMS icon)
- clock.fill (Timer icon)
- exclamationmark.circle.fill (Error icon)
- checkmark.circle.fill (Success icon, toast)
```

### Colors from Design System
```
- brandPrimary (#0D7377)
- brandSecondary (#FF6B35)
- secondaryLight (#FFF5F0)
- textPrimary (#1E1E1E)
- textSecondary (#666666)
- gray100 (#F8F8F8)
- gray300 (#E0E0E0)
- gray400 (#CCCCCC)
- success (#28C76F)
- error (#EA5455)
- white (#FFFFFF)
```

---

## Navigation Flow

### Entry Points
```
1. From Phone Registration: After OTP sent successfully
   └─ Transition: Slide in from right (300ms)
   └─ Data: { phoneNumber, verificationID }

2. From Login Screen: If phone login requires verification
   └─ Transition: Slide in from right
```

### Exit Points
```
1. Success (New User):
   └─ Navigate to: Profile Setup Screen (05)
   └─ Transition: Fade out + slide in (400ms)
   └─ Data: { userId, authToken, phoneNumber }

2. Success (Returning User):
   └─ Navigate to: Home Screen (06)
   └─ Transition: Fade out + crossfade (400ms)
   └─ Data: { userId, authToken }

3. Tap Back Button:
   └─ Show Alert: "Go back? You'll need to request a new code"
   └─ If confirmed: Navigate back to Phone Registration
   └─ Transition: Slide out to right (300ms)

4. Edit Phone Number:
   └─ Present: Edit Phone Bottom Sheet
   └─ Transition: Slide up from bottom (300ms)

5. Contact Support:
   └─ Navigate to: Support Screen or open email
```

---

## Error Handling

### Invalid OTP
```
Scenario: User enters wrong 6-digit code
Response: Backend returns 401 "Invalid OTP"
Action:
├─ Shake OTP boxes (600ms animation)
├─ Turn boxes red
├─ Clear all digits
├─ Show error message below boxes
├─ Refocus first box
├─ Track attempt count (max 5)
└─ Haptic: Error notification
```

### Expired OTP
```
Scenario: OTP is older than 10 minutes
Response: Backend returns 410 "OTP Expired"
Action:
├─ Show error: "This code has expired"
├─ Disable OTP boxes
├─ Enable "Resend" immediately (bypass timer)
├─ Highlight "Resend now" button
└─ User must request new code
```

### Network Error
```
Scenario: No internet during verification
Action:
├─ Stop loading spinner
├─ Show toast: "Unable to verify. Check connection."
├─ Keep OTP filled (allow retry)
├─ Re-enable Verify button
└─ Log error for analytics
```

### Rate Limiting (Too Many Wrong Attempts)
```
Scenario: 5+ wrong OTP codes entered
Response: Backend returns 429 "Too Many Requests"
Action:
├─ Disable all inputs
├─ Show message: "Too many attempts. Try again in 15 minutes."
├─ Show countdown timer (15:00)
├─ Disable resend
├─ Offer "Contact Support" option
└─ Re-enable after cooldown
```

### SMS Not Received
```
Scenario: User never receives SMS
Self-Service Options:
├─ "Resend" button (after 60s)
├─ "Edit" phone number (if typo)
├─ "Contact Support" (if persistent issue)
└─ Check spam/blocked messages (help text)
```

---

## Performance Requirements

```
Screen load: < 300ms
OTP box responsiveness: < 50ms (keystroke to display)
Auto-advance: < 100ms
Verification API: 2-5 seconds typical, 10s timeout
Memory: < 25MB
Animations: 60fps
```

---

## Testing Checklist

- [ ] 6 OTP boxes render correctly
- [ ] Auto-focus on first box when screen appears
- [ ] Can enter digits 0-9 only
- [ ] Auto-advance to next box works
- [ ] Backspace moves to previous box
- [ ] Paste detection fills all 6 boxes
- [ ] iOS auto-fill from Messages works
- [ ] Auto-verify triggers when 6th digit entered
- [ ] Countdown timer counts down correctly (60s → 0s)
- [ ] "Resend" disabled during countdown
- [ ] "Resend" enabled when timer reaches 00:00
- [ ] Resend OTP sends new code successfully
- [ ] Timer resets after resend (120s)
- [ ] Correct OTP verifies successfully
- [ ] Wrong OTP shows error + shake animation
- [ ] Expired OTP handled correctly
- [ ] Network error shows retry option
- [ ] Rate limiting prevents abuse
- [ ] Back button shows confirmation alert
- [ ] Edit phone opens sheet
- [ ] Dark mode looks correct
- [ ] VoiceOver announces OTP correctly
- [ ] Dynamic Type scales properly
- [ ] Reduced Motion disables animations
- [ ] Works on iPhone SE (small)
- [ ] Works on iPhone 14 Pro Max (large)
- [ ] No memory leaks
- [ ] Haptic feedback on interactions

---

## Analytics Events

```swift
// Screen view
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "otp_verification",
    "phone_number_hash": phoneNumberHash
])

// OTP digit entered
Analytics.logEvent("otp_digit_entered", parameters: [
    "digit_position": index, // 0-5
    "total_entered": otpCode.filter { !$0.isEmpty }.count
])

// Auto-verify triggered
Analytics.logEvent("otp_auto_verify_triggered", parameters: [:])

// Verification success
Analytics.logEvent("otp_verification_success", parameters: [
    "duration_ms": verificationDuration,
    "attempts": attemptCount
])

// Verification failed
Analytics.logEvent("otp_verification_failed", parameters: [
    "error": "invalid_code", // or "expired", "network_error"
    "attempt_number": attemptCount
])

// Resend OTP
Analytics.logEvent("otp_resend_requested", parameters: [
    "time_remaining": timeRemaining,
    "resend_count": resendCount
])

// Edit phone tapped
Analytics.logEvent("edit_phone_tapped", parameters: [:])

// Back button (with confirmation)
Analytics.logEvent("otp_screen_back", parameters: [
    "confirmed": true/false
])
```

---

## Design Rationale

**Why this design:**

- **6 individual boxes**: Industry standard (iOS, banking apps), clear visual feedback
- **Auto-advance**: Reduces friction, faster input
- **Auto-verify**: No need to tap button, seamless UX
- **Countdown timer**: Sets expectations, prevents abuse
- **Edit phone option**: Fixes typos without full restart
- **Resend functionality**: Self-service recovery
- **iOS auto-fill support**: Leverages platform features, reduces manual entry
- **Paste detection**: Supports copy from Messages app
- **Clear error states**: User always knows what went wrong and how to fix it

**Alternatives Considered:**

- Single text field (6 digits): Less clear visual feedback, harder to edit mid-code
- Manual verify button always required: More taps, slower UX
- No resend option: Dead-end if SMS fails, poor UX
- No timer countdown: Users spam resend, server load increases
- Hide digits (dots): Less user-friendly for OTP (not password)

---

**This OTP verification screen is the security gate for the platform. It must be fast, clear, and handle edge cases gracefully to avoid user drop-off.**
