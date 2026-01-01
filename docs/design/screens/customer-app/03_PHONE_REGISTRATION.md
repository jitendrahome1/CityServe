# 03 - Phone Registration

**Screen ID:** 03
**Screen Name:** Phone Registration
**User Flow:** Onboarding → Phone Registration → OTP Verification
**Entry Point:** First-time user completes onboarding or returns to login
**Next Screen:** OTP Verification (04)

---

## Overview

The phone registration screen is the primary entry point for new users to create an account. It collects the user's phone number, which will be verified via OTP and used as the primary authentication method.

**Purpose:**
- Collect user's phone number for account creation
- Validate phone number format (Indian mobile: 10 digits)
- Initiate OTP verification process
- Provide clear terms & conditions agreement
- Support quick login for returning users

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
│            │   📱     │                │ ← Phone Icon
│            │          │                │   (64x64pt)
│            └──────────┘                │
│                                        │
│         Create Account                 │ ← Title
│                                        │
│   Enter your mobile number to get      │
│   started with UrbanNest               │ ← Subtitle
│                                        │
│                                        │
│  Mobile Number                         │ ← Label
│  ┌──────┬──────────────────────────┐  │
│  │ +91 ▼│  99999 99999             │  │ ← Phone Input
│  └──────┴──────────────────────────┘  │   (Country Code + Number)
│                                        │
│                                        │
│  ☐ I agree to the Terms & Conditions  │ ← Checkbox
│     and Privacy Policy                 │
│                                        │
│                                        │
│  ┌────────────────────────────────┐   │
│  │     Continue                   │   │ ← Primary Button
│  └────────────────────────────────┘   │
│                                        │
│                                        │
│         Already have an account?       │
│              Login here                │ ← Login Link
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
Scrollable: Yes (for smaller devices or landscape)
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
Action: Navigate back to Onboarding (or previous screen)
```

### Icon Container
```
Position: Centered horizontally, 80pt from top safe area
Icon: phone.fill (SF Symbol) or custom illustration
Size: 64x64pt
Background: Circle, 96pt diameter, #F0F9FA (light teal tint)
Icon Color: #0D7377 (brand primary)
```

### Title Section
```
Position: 24pt below icon
Alignment: Center

Title:
├─ Text: "Create Account"
├─ Font: Inter SemiBold, 28pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Letter Spacing: -0.5pt
└─ Alignment: Center

Subtitle:
├─ Text: "Enter your mobile number to get started with UrbanNest"
├─ Font: SF Pro Regular, 15pt
├─ Color: #666666 (light), #A0A0A0 (dark)
├─ Line Height: 1.4 (21pt)
├─ Max Width: 320pt
├─ Alignment: Center
└─ Margin Top: 8pt
```

### Phone Input Section
```
Position: 32pt below subtitle
Padding: 0 32pt horizontal

Label:
├─ Text: "Mobile Number"
├─ Font: SF Pro Medium, 14pt
├─ Color: #333333 (light), #E0E0E0 (dark)
└─ Margin Bottom: 8pt

Input Container:
├─ Height: 56pt
├─ Border Radius: 12pt
├─ Border: 1pt solid #E0E0E0 (default)
├─ Border (focused): 2pt solid #0D7377
├─ Border (error): 2pt solid #EA5455
├─ Background: #F8F8F8 (light), #2A2A2A (dark)
└─ Shadow: None (default), 0 0 0 4px rgba(13,115,119,0.1) (focused)

Country Code Picker:
├─ Width: 80pt
├─ Text: "+91" (default India)
├─ Font: SF Pro Regular, 16pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Icon: chevron.down, 16x16pt
├─ Border Right: 1pt solid #E0E0E0
├─ Tap Target: Full height (56pt)
└─ Action: Open country picker bottom sheet

Phone Number Input:
├─ Padding Left: 16pt (from divider)
├─ Font: SF Pro Regular, 16pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Placeholder: "99999 99999"
├─ Placeholder Color: #999999
├─ Keyboard: Number Pad
├─ Max Length: 10 digits (auto-formatted with space after 5 digits)
└─ Auto Focus: Yes (on screen appear)

Error Message (if validation fails):
├─ Position: 8pt below input
├─ Text: "Please enter a valid 10-digit mobile number"
├─ Font: SF Pro Regular, 13pt
├─ Color: #EA5455 (error red)
└─ Icon: exclamationmark.circle.fill, 14x14pt, aligned left
```

### Terms & Conditions Checkbox
```
Position: 24pt below phone input
Padding: 0 32pt horizontal

Checkbox:
├─ Size: 20x20pt
├─ Border Radius: 4pt
├─ Border: 2pt solid #CCCCCC (unchecked)
├─ Background: #0D7377 (checked)
├─ Icon (checked): checkmark (white)
├─ Tap Target: 44x44pt
└─ Animation: Scale 1.0 → 1.2 → 1.0 (100ms) on tap

Label:
├─ Font: SF Pro Regular, 13pt
├─ Color: #666666 (light), #A0A0A0 (dark)
├─ Padding Left: 8pt from checkbox
├─ Line Height: 1.5
└─ Max Width: 280pt

Links (inline):
├─ "Terms & Conditions" - Tappable link
├─ "Privacy Policy" - Tappable link
├─ Font: SF Pro Medium, 13pt
├─ Color: #0D7377 (brand primary)
├─ Underline: None (default), Yes (on press)
└─ Action: Open in sheet (WebView or native view)
```

### Continue Button
```
Position: 24pt below terms checkbox
Padding: 0 32pt horizontal

Button:
├─ Width: Full (390pt - 64pt padding)
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Background: #0D7377 (enabled), #E0E0E0 (disabled)
├─ Shadow: 0 4px 12px rgba(13,115,119,0.2) (enabled)
├─ Shadow: None (disabled)
└─ Animation: Scale 0.98 on press

Text:
├─ Text: "Continue"
├─ Font: Inter SemiBold, 16pt
├─ Color: White (#FFFFFF)
├─ Letter Spacing: 0.5pt
└─ Icon (loading): ProgressView (spinner), white

States:
├─ Default: Enabled if phone valid (10 digits) + terms checked
├─ Disabled: Phone invalid OR terms unchecked
├─ Loading: Spinner replaces text, button disabled
└─ Error: Shake animation (if OTP request fails)

Action:
└─ Send OTP to entered phone number → Navigate to OTP screen
```

### Login Link
```
Position: 24pt below Continue button
Alignment: Center
Padding Bottom: 32pt (+ safe area)

Text:
├─ "Already have an account?" - Regular text
├─ Font: SF Pro Regular, 14pt
├─ Color: #666666
└─ "Login here" - Link text
    ├─ Font: SF Pro Medium, 14pt
    ├─ Color: #0D7377
    └─ Action: Navigate to Login Screen (05)
```

---

## Component Breakdown

### 1. Phone Icon/Illustration
```
Component: Image or SF Symbol
Symbol: phone.fill
Size: 64x64pt
Container: Circle background
Background Color: #F0F9FA (10% teal tint)
Icon Color: #0D7377
Shadow: None
```

### 2. Phone Input Component
```
Component: Custom PhoneTextField (reusable)
Sub-components:
├─ Country Code Picker (Button)
├─ Vertical Divider (1pt line)
└─ Number TextField (UITextField wrapper)

Functionality:
├─ Auto-format: "12345" → "12345", "123456" → "12345 6"
├─ Max length: 10 digits
├─ Only numeric input allowed
├─ Clear button appears when text entered
├─ Validation: Real-time + on blur
└─ Accessibility: Label + hint + error announcement

States:
├─ Empty (placeholder visible)
├─ Typing (focused, border highlighted)
├─ Filled Valid (green checkmark icon right side)
├─ Filled Invalid (red error icon + message below)
└─ Disabled (grayed out, not editable)
```

### 3. Terms Checkbox Component
```
Component: Custom Checkbox with AttributedString
Checkbox States:
├─ Unchecked (border only)
└─ Checked (filled with checkmark)

Text Handling:
├─ Regular text: "I agree to the"
├─ Link 1: "Terms & Conditions" (tappable)
├─ Regular text: "and"
├─ Link 2: "Privacy Policy" (tappable)
└─ AttributedString with tappable ranges

Interactions:
├─ Tap checkbox: Toggle checked state
├─ Tap link: Open document in sheet
└─ VoiceOver: "Checkbox, unchecked, I agree to terms"
```

### 4. Continue Button (PrimaryButton)
```
Component: PrimaryButton (from component library)
Props:
├─ title: "Continue"
├─ action: sendOTPRequest
├─ isLoading: Bool (shows spinner)
├─ isDisabled: Bool (phone invalid OR terms unchecked)
└─ hapticFeedback: Medium impact on tap
```

---

## Animations & Transitions

### Entry Animation
```
Duration: 400ms
Easing: Ease Out

Sequence:
0ms   - Screen appears (slide in from right)
100ms - Icon fades in + scale (0.8 → 1.0)
200ms - Title + subtitle fade in + slide up (10pt)
300ms - Phone input fades in + slide up (10pt)
400ms - Checkbox fades in + slide up (10pt)
500ms - Button fades in + slide up (10pt)
600ms - Login link fades in
```

### Phone Input Focus Animation
```
Duration: 200ms
Easing: Ease Out

Changes:
├─ Border color: #E0E0E0 → #0D7377
├─ Border width: 1pt → 2pt
├─ Shadow: Appear (0 0 0 4px rgba(13,115,119,0.1))
└─ Placeholder: Fade out slightly
```

### Checkbox Toggle Animation
```
Duration: 150ms
Easing: Spring (damping 0.6)

Checked:
├─ Scale: 1.0 → 1.2 → 1.0
├─ Background: Transparent → #0D7377
├─ Checkmark: Draw from left to right (stroke animation)
└─ Haptic: Light impact

Unchecked:
├─ Scale: 1.0 → 0.9 → 1.0
├─ Background: #0D7377 → Transparent
└─ Checkmark: Fade out immediately
```

### Button Press Animation
```
Duration: 100ms
Easing: Ease Out

Press Down:
├─ Scale: 1.0 → 0.98
└─ Haptic: Medium impact

Release:
├─ Scale: 0.98 → 1.0
└─ Trigger action (if enabled)
```

### Error Shake Animation
```
Trigger: Invalid phone number on Continue tap
Duration: 500ms

Sequence:
├─ 0ms: Input translates +10pt right
├─ 100ms: Input translates -10pt left
├─ 200ms: Input translates +8pt right
├─ 300ms: Input translates -8pt left
├─ 400ms: Input translates +4pt right
├─ 500ms: Input returns to center (0pt)
└─ Haptic: Error notification
```

### Loading State Animation
```
Trigger: Continue button tapped (valid input)
Duration: Continuous until response

Changes:
├─ Button text fades out (200ms)
├─ Spinner fades in (200ms)
├─ Button disabled (no interaction)
└─ Spinner rotates continuously (1s per rotation)
```

---

## States

### Default State
```
Status: Ready for input
Visual:
├─ Phone input: Empty with placeholder
├─ Checkbox: Unchecked
├─ Button: Disabled (gray)
└─ No error messages
```

### Typing State
```
Status: User entering phone number
Visual:
├─ Phone input: Focused (blue border)
├─ Keyboard: Number pad visible
├─ Real-time formatting: "12345 67890"
├─ Clear button visible (if text present)
└─ Button: Still disabled until valid + terms checked
```

### Valid Ready State
```
Status: Phone valid (10 digits) + Terms checked
Visual:
├─ Phone input: Green checkmark icon (right side)
├─ Checkbox: Checked (green background)
├─ Button: Enabled (teal with shadow)
└─ Ready to submit
```

### Loading State (OTP Request)
```
Status: Sending OTP to phone number
Visual:
├─ Phone input: Disabled (non-editable)
├─ Checkbox: Disabled
├─ Button: Spinner replacing text
├─ Back button: Disabled
└─ Screen interaction: Disabled

Duration: 2-5 seconds typical
Timeout: 30 seconds (then show error)
```

### Success State → Navigation
```
Status: OTP sent successfully
Action: Navigate to OTP Verification screen (04)
Transition: Slide left (push)
Data Passed: Phone number, verification ID
```

### Error State (Invalid Phone)
```
Trigger: User taps Continue with invalid phone
Visual:
├─ Phone input: Red border (2pt)
├─ Error icon: Red exclamation mark (left of input)
├─ Error message: "Please enter a valid 10-digit mobile number"
├─ Input shake animation
└─ Button: Remains disabled

Haptic: Error notification feedback
```

### Error State (Network Failure)
```
Trigger: OTP request fails (no internet, server error)
Visual:
├─ Button returns to enabled state
├─ Toast/Alert appears: "Unable to send OTP. Please try again."
├─ Toast position: Top of screen, below safe area
├─ Toast type: Error (red background)
└─ Auto-dismiss: 3 seconds

Action: User can retry
```

### Error State (Rate Limited)
```
Trigger: Too many OTP requests (3+ in 15 minutes)
Visual:
├─ Button disabled
├─ Error message below input: "Too many attempts. Please try again in 15 minutes."
├─ Timer: Countdown displayed (15:00, 14:59, ...)
└─ Phone input: Disabled

Recovery: Re-enable after cooldown period
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E (dark background)
Surface (Input): #2A2A2A (dark surface)
Text Primary: #E0E0E0 (light text)
Text Secondary: #A0A0A0 (secondary light text)
Border: #3A3A3A (dark border)
Border Focused: #14A0A5 (lighter teal)
Icon Background: #1A4A4C (dark teal tint)
Checkbox Unchecked: #4A4A4A (dark gray)
Checkbox Checked: #0D7377 (same brand primary)
Button Disabled: #3A3A3A (dark gray)
Error: #EA5455 (same error red)
```

### Adjustments
```
Icon background opacity reduced (10% → 8%)
Input background slightly lighter for contrast
Shadows removed (not visible in dark mode)
Focus ring more visible (brighter teal)
```

---

## Accessibility

### VoiceOver

**Element Labels:**
```
Back Button: "Back, button"
Phone Input: "Mobile number, text field"
Country Code: "Country code, India +91, button"
Checkbox: "I agree to the Terms & Conditions and Privacy Policy, checkbox, unchecked"
Terms Link: "Terms & Conditions, link"
Privacy Link: "Privacy Policy, link"
Continue Button: "Continue, button, disabled" / "Continue, button"
Login Link: "Already have an account? Login here, link"
```

**Announcements:**
```
On error: "Error. Please enter a valid 10-digit mobile number"
On checkbox toggle: "Checked" / "Unchecked"
On loading: "Sending verification code"
On success: "Code sent"
```

**Focus Order:**
```
1. Back button
2. Phone input (auto-focused on appear)
3. Country code picker
4. Checkbox
5. Terms link
6. Privacy link
7. Continue button
8. Login link
```

### Dynamic Type

**Supported Sizes:** -2 (smaller) to +3 (larger)

**Scaling Behavior:**
```
Title: 28pt → 24pt (min) to 34pt (max)
Subtitle: 15pt → 13pt (min) to 18pt (max)
Input text: 16pt → 14pt (min) to 20pt (max)
Button text: 16pt → 14pt (min) to 19pt (max)
Input height: Scales proportionally (56pt → 64pt at +3)
Vertical spacing: Increases at +2 and above
```

**Layout Adjustments:**
```
At +2 and above:
├─ Subtitle becomes multi-line
├─ Terms text becomes 3 lines
├─ Button height increases to 60pt
└─ Bottom spacing increases to 40pt
```

### Reduced Motion

**If "Reduce Motion" enabled:**
```
Entry animation: Instant appear (no slide/fade)
Icon animation: Instant appear (no scale)
Text animation: Instant appear (no slide)
Checkbox toggle: Instant change (no scale spring)
Button press: No scale animation
Error shake: Replaced with red border flash
Focus ring: Instant appear (no animated expansion)
Transitions: Crossfade instead of slide
```

### Color Contrast

**WCAG AA Compliance (4.5:1 minimum):**
```
✅ Title (#1E1E1E on #FFFFFF): 16.1:1
✅ Subtitle (#666666 on #FFFFFF): 5.7:1
✅ Input text (#1E1E1E on #F8F8F8): 14.8:1
✅ Button text (White on #0D7377): 5.2:1
✅ Error text (#EA5455 on #FFFFFF): 4.8:1
✅ Terms text (#666666 on #FFFFFF): 5.7:1
✅ Dark mode title (#E0E0E0 on #1E1E1E): 12.6:1
```

### Touch Targets

**Minimum 44x44pt for all interactive elements:**
```
✅ Back button: 44x44pt
✅ Country code picker: 80x56pt (exceeds minimum)
✅ Phone input: Full width x 56pt
✅ Checkbox: 44x44pt (visual 20pt, padding adds to 44pt)
✅ Terms links: 44pt height touch area
✅ Continue button: Full width x 52pt
✅ Login link: Full width x 44pt
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct PhoneRegistrationView: View {
    @StateObject private var viewModel = PhoneRegistrationViewModel()
    @State private var phoneNumber: String = ""
    @State private var isTermsAccepted: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @FocusState private var isPhoneFocused: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Icon
                ZStack {
                    Circle()
                        .fill(Color.brandPrimary.opacity(0.1))
                        .frame(width: 96, height: 96)

                    Image(systemName: "phone.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .foregroundColor(.brandPrimary)
                }
                .padding(.top, 80)

                // Title
                Text("Create Account")
                    .font(.custom("Inter-SemiBold", size: 28))
                    .foregroundColor(.textPrimary)
                    .padding(.top, 24)

                // Subtitle
                Text("Enter your mobile number to get started with UrbanNest")
                    .font(.system(size: 15))
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 320)
                    .padding(.top, 8)

                // Phone Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Mobile Number")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.textPrimary)

                    PhoneTextField(
                        phoneNumber: $phoneNumber,
                        countryCode: "+91",
                        isValid: viewModel.isPhoneValid,
                        errorMessage: errorMessage
                    )
                    .focused($isPhoneFocused)
                    .onChange(of: phoneNumber) { newValue in
                        errorMessage = nil // Clear error on typing
                        viewModel.validatePhone(newValue)
                    }

                    if let error = errorMessage {
                        ErrorLabel(message: error)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 32)

                // Terms Checkbox
                TermsCheckbox(isChecked: $isTermsAccepted)
                    .padding(.horizontal, 32)
                    .padding(.top, 24)

                // Continue Button
                PrimaryButton(
                    title: "Continue",
                    action: handleContinue,
                    isLoading: isLoading,
                    isDisabled: !isFormValid
                )
                .padding(.horizontal, 32)
                .padding(.top, 24)

                // Login Link
                HStack(spacing: 4) {
                    Text("Already have an account?")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)

                    Button(action: navigateToLogin) {
                        Text("Login here")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.brandPrimary)
                    }
                }
                .padding(.top, 24)
                .padding(.bottom, 32)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.textPrimary)
                }
            }
        }
        .onAppear {
            isPhoneFocused = true // Auto-focus phone input
        }
    }

    private var isFormValid: Bool {
        viewModel.isPhoneValid && isTermsAccepted
    }

    private func handleContinue() {
        guard isFormValid else {
            if !viewModel.isPhoneValid {
                errorMessage = "Please enter a valid 10-digit mobile number"
                withAnimation(.easeInOut(duration: 0.5)) {
                    // Shake animation handled by modifier
                }
            }
            return
        }

        isLoading = true

        Task {
            do {
                let verificationID = try await viewModel.sendOTP(to: phoneNumber)
                isLoading = false

                // Navigate to OTP screen
                // navigationController.push(OTPVerificationView(phone: phoneNumber, verificationID: verificationID))

            } catch {
                isLoading = false
                errorMessage = error.localizedDescription

                // Show error toast
                showErrorToast(message: "Unable to send OTP. Please try again.")
            }
        }
    }

    private func navigateToLogin() {
        // Navigate to Login screen
    }

    private func showErrorToast(message: String) {
        // Show toast notification
    }
}
```

### Custom PhoneTextField Component

```swift
struct PhoneTextField: View {
    @Binding var phoneNumber: String
    let countryCode: String
    var isValid: Bool
    var errorMessage: String?

    @State private var isFocused: Bool = false
    @FocusState private var textFieldFocus: Bool

    var body: some View {
        HStack(spacing: 0) {
            // Country Code Picker
            Button(action: openCountryPicker) {
                HStack(spacing: 4) {
                    Text(countryCode)
                        .font(.system(size: 16))
                        .foregroundColor(.textPrimary)

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.textSecondary)
                }
                .frame(width: 80, height: 56)
            }
            .accessibilityLabel("Country code, India \(countryCode)")

            // Divider
            Rectangle()
                .fill(Color.gray300)
                .frame(width: 1, height: 32)

            // Phone Number Input
            TextField("99999 99999", text: $phoneNumber)
                .font(.system(size: 16))
                .foregroundColor(.textPrimary)
                .keyboardType(.numberPad)
                .padding(.leading, 16)
                .focused($textFieldFocus)
                .onChange(of: phoneNumber) { newValue in
                    // Format: "12345 67890"
                    phoneNumber = formatPhoneNumber(newValue)
                }

            // Validation Icon
            if phoneNumber.count == 11 { // "12345 67890" = 11 chars with space
                Image(systemName: isValid ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                    .foregroundColor(isValid ? .success : .error)
                    .padding(.trailing, 12)
            }
        }
        .background(Color.gray100)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: borderWidth)
        )
        .shadow(color: focusShadowColor, radius: 4)
    }

    private var borderColor: Color {
        if errorMessage != nil {
            return .error
        } else if textFieldFocus {
            return .brandPrimary
        } else {
            return .gray300
        }
    }

    private var borderWidth: CGFloat {
        (errorMessage != nil || textFieldFocus) ? 2 : 1
    }

    private var focusShadowColor: Color {
        textFieldFocus ? Color.brandPrimary.opacity(0.1) : Color.clear
    }

    private func formatPhoneNumber(_ input: String) -> String {
        // Remove all non-digit characters
        let digits = input.filter { $0.isNumber }

        // Limit to 10 digits
        let limited = String(digits.prefix(10))

        // Add space after 5 digits
        if limited.count > 5 {
            let index = limited.index(limited.startIndex, offsetBy: 5)
            return limited[..<index] + " " + limited[index...]
        }

        return limited
    }

    private func openCountryPicker() {
        // Open country code picker bottom sheet
    }
}
```

### TermsCheckbox Component

```swift
struct TermsCheckbox: View {
    @Binding var isChecked: Bool
    @State private var showTerms: Bool = false
    @State private var showPrivacy: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            // Checkbox
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isChecked.toggle()
                }
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(isChecked ? Color.brandPrimary : Color.gray400, lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(isChecked ? Color.brandPrimary : Color.clear)
                        )

                    if isChecked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .frame(width: 44, height: 44) // Touch target
            .accessibilityLabel(isChecked ? "Checked" : "Unchecked")

            // Terms Text with Links
            VStack(alignment: .leading, spacing: 0) {
                (Text("I agree to the ")
                    .foregroundColor(.textSecondary) +
                 Text("Terms & Conditions")
                    .foregroundColor(.brandPrimary)
                    .underline(showTerms, color: .brandPrimary)
                    .onTapGesture {
                        showTerms = true
                    } +
                 Text(" and ")
                    .foregroundColor(.textSecondary) +
                 Text("Privacy Policy")
                    .foregroundColor(.brandPrimary)
                    .underline(showPrivacy, color: .brandPrimary)
                    .onTapGesture {
                        showPrivacy = true
                    }
                )
                .font(.system(size: 13))
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .sheet(isPresented: $showTerms) {
            TermsAndConditionsView()
        }
        .sheet(isPresented: $showPrivacy) {
            PrivacyPolicyView()
        }
    }
}
```

### ViewModel

```swift
@MainActor
class PhoneRegistrationViewModel: ObservableObject {
    @Published var isPhoneValid: Bool = false

    func validatePhone(_ phone: String) {
        // Remove spaces and validate
        let digits = phone.filter { $0.isNumber }
        isPhoneValid = digits.count == 10 && digits.first != "0"
    }

    func sendOTP(to phoneNumber: String) async throws -> String {
        // Firebase Phone Auth
        let fullNumber = "+91" + phoneNumber.filter { $0.isNumber }

        // Simulated API call
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds

        // Return verification ID
        return "verification-id-12345"

        // Real implementation:
        // return try await PhoneAuthProvider.provider()
        //     .verifyPhoneNumber(fullNumber, uiDelegate: nil)
    }
}
```

---

## Assets Required

### SF Symbols
```
- chevron.left (Back button)
- phone.fill (Icon illustration)
- chevron.down (Country code picker)
- checkmark.circle.fill (Valid phone indicator)
- exclamationmark.circle.fill (Invalid phone indicator)
- checkmark (Checkbox checked state)
```

### Custom Assets
```
None required (all SF Symbols)
```

### Colors from Design System
```
- brandPrimary (#0D7377)
- brandPrimaryLight (#F0F9FA)
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
1. From Onboarding (first-time users): Tap "Get Started"
   └─ Transition: Slide in from right (300ms)

2. From Login Screen: Tap "Create Account" link
   └─ Transition: Slide in from right (300ms)

3. From App Launch: If no auth token + not first launch
   └─ Transition: Direct navigation (no animation)
```

### Exit Points
```
1. Success (OTP sent):
   └─ Navigate to: OTP Verification Screen (04)
   └─ Transition: Slide in from right (300ms)
   └─ Data passed: { phoneNumber: "+919999999999", verificationID: "xxx" }

2. Tap "Login here":
   └─ Navigate to: Login Screen (05)
   └─ Transition: Replace (crossfade 200ms)

3. Tap Back button:
   └─ Navigate to: Onboarding Screen (02) or previous screen
   └─ Transition: Slide out to right (300ms)

4. Open Terms & Conditions:
   └─ Present: Terms WebView/Native View
   └─ Transition: Sheet from bottom (300ms)

5. Open Privacy Policy:
   └─ Present: Privacy WebView/Native View
   └─ Transition: Sheet from bottom (300ms)
```

---

## Error Handling

### Invalid Phone Number
```
Trigger: User taps Continue with < 10 digits
Action:
├─ Show error message below input
├─ Shake input field animation
├─ Red border on input
├─ Keep button disabled
└─ Haptic: Error notification
```

### Network Error
```
Trigger: OTP request fails (no connection, timeout)
Action:
├─ Stop loading spinner
├─ Return button to enabled state
├─ Show error toast (top of screen)
│   ├─ Text: "Unable to send OTP. Please check your connection."
│   ├─ Background: #EA5455
│   ├─ Auto-dismiss: 4 seconds
│   └─ Icon: wifi.slash
└─ Allow user to retry
```

### Rate Limiting Error
```
Trigger: > 3 OTP requests in 15 minutes
Action:
├─ Disable phone input
├─ Disable Continue button
├─ Show error message below input
│   └─ "Too many attempts. Please try again in 14:32"
├─ Show countdown timer
├─ Re-enable after cooldown
└─ Alternative: "Contact Support" button appears
```

### Server Error (500)
```
Trigger: Backend error during OTP send
Action:
├─ Show error toast
│   ├─ Text: "Something went wrong. Please try again."
│   ├─ Duration: 4 seconds
│   └─ Action button: "Retry"
└─ Log error to analytics
```

### Invalid Phone Number (Backend Validation)
```
Trigger: Backend rejects phone number (e.g., VOIP, invalid)
Action:
├─ Show error message
│   └─ "This phone number cannot be used. Please use a valid mobile number."
├─ Red border on input
└─ Allow user to change number
```

---

## Performance Requirements

### Loading Time
```
Screen render: < 300ms
Input responsiveness: < 50ms (keystroke to display)
Validation: < 100ms (on blur)
OTP request: 2-5 seconds typical
Maximum timeout: 30 seconds
```

### Memory Usage
```
Screen memory: < 30MB
No memory leaks (check with Instruments)
```

### Animations
```
Frame rate: 60fps
No dropped frames during entry animation
Smooth keyboard appearance
```

---

## Testing Checklist

- [ ] Phone input accepts exactly 10 digits
- [ ] Phone input auto-formats with space (12345 67890)
- [ ] Country code picker opens (India +91 default)
- [ ] Checkbox toggles correctly
- [ ] Terms link opens Terms & Conditions
- [ ] Privacy link opens Privacy Policy
- [ ] Button disabled when phone invalid
- [ ] Button disabled when terms unchecked
- [ ] Button enabled when both valid + checked
- [ ] OTP sends successfully to valid number
- [ ] Navigation to OTP screen works
- [ ] Back button returns to previous screen
- [ ] Login link navigates to login screen
- [ ] Error message shows for invalid phone
- [ ] Shake animation plays on error
- [ ] Loading spinner appears during OTP request
- [ ] Network error handled gracefully
- [ ] Rate limiting prevents spam
- [ ] Dark mode looks correct
- [ ] VoiceOver navigation works
- [ ] Dynamic Type scales correctly
- [ ] Reduced Motion respected
- [ ] Works on iPhone SE (small screen)
- [ ] Works on iPhone 14 Pro Max (large screen)
- [ ] Landscape orientation (if applicable)
- [ ] No memory leaks
- [ ] Haptic feedback on interactions

---

## Analytics Events

Track user behavior for optimization:

```swift
// Screen view
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "phone_registration",
    "screen_class": "PhoneRegistrationView"
])

// Phone input started
Analytics.logEvent("phone_input_started", parameters: [:])

// Phone validation failed
Analytics.logEvent("phone_validation_failed", parameters: [
    "error": "invalid_length" // or "invalid_format"
])

// Terms checkbox toggled
Analytics.logEvent("terms_accepted", parameters: [
    "accepted": true
])

// OTP request initiated
Analytics.logEvent("otp_request_initiated", parameters: [
    "phone_country_code": "+91"
])

// OTP request success
Analytics.logEvent("otp_request_success", parameters: [
    "duration_ms": 2341
])

// OTP request failed
Analytics.logEvent("otp_request_failed", parameters: [
    "error": "network_error" // or "rate_limited", "server_error"
])

// Navigate to login
Analytics.logEvent("navigate_to_login", parameters: [
    "source": "phone_registration"
])
```

---

## Design Rationale

**Why this design:**

- **Phone-first authentication**: Industry standard for service apps in India, reduces friction vs email
- **Single input focus**: Only asks for phone number, no password on registration (reduces abandonment)
- **Clear visual hierarchy**: Icon → Title → Input → Action, guides user down the page
- **Inline validation**: Real-time feedback reduces errors and frustration
- **Terms checkbox required**: Legal compliance, explicit consent
- **Auto-format phone number**: Improves readability, confirms correct input
- **Country code picker**: Supports international users (future expansion)
- **Loading states**: Clear feedback during network operations
- **Error recovery**: Always provide retry option, never dead-end

**Alternatives Considered:**

- Email + password registration: More friction, lower conversion
- Skip terms checkbox: Legal risk, prefer explicit consent
- Phone + name on same screen: Too much cognitive load, prefer multi-step
- No country code: Limits international expansion
- Separate OTP on same screen: Better as separate screen for focus

---

**This phone registration screen is the critical first step in the user acquisition funnel. It must be frictionless, trustworthy, and fast to maximize conversion.**
