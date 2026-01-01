# 06 - Login Screen

**Screen ID:** 06
**Screen Name:** Login
**User Flow:** Returning User → Login → OTP Verification → Home
**Entry Point:** App launch (returning user without valid session), or from registration flow
**Next Screen:** OTP Verification (04), then Home

---

## Overview

The login screen is the entry point for returning users who already have an account. It uses phone-based authentication (same as registration) to maintain consistency and simplicity.

**Purpose:**
- Allow existing users to sign in
- Verify identity via phone number + OTP
- Quick access for returning users
- Redirect new users to registration
- Handle "forgot" scenarios (account recovery)
- Maintain security with OTP verification

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│                                        │
│                                        │
│            ┌──────────┐                │
│            │          │                │
│            │   [UN]   │                │ ← App Logo
│            │          │                │   (80x80pt)
│            └──────────┘                │
│                                        │
│          Welcome Back!                 │ ← Title
│                                        │
│      Sign in to continue               │ ← Subtitle
│                                        │
│                                        │
│  Mobile Number                         │ ← Label
│  ┌──────┬──────────────────────────┐  │
│  │ +91 ▼│  99999 99999             │  │ ← Phone Input
│  └──────┴──────────────────────────┘  │
│                                        │
│                                        │
│  ┌────────────────────────────────┐   │
│  │     Send OTP                   │   │ ← Primary Button
│  └────────────────────────────────┘   │
│                                        │
│                                        │
│     OR                                 │ ← Divider
│                                        │
│  ┌────────────────────────────────┐   │
│  │  [G] Continue with Google      │   │ ← Google Sign In
│  └────────────────────────────────┘   │   (Optional)
│                                        │
│                                        │
│        Don't have an account?          │
│           Create Account               │ ← Create Account Link
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
Scrollable: Yes (for keyboard + smaller devices)
```

### Background
```
Color: White (#FFFFFF) / Dark (#1E1E1E)
Gradient: Optional subtle gradient (#FFFFFF → #F8F8F8) top to bottom
```

### Logo Container
```
Position: Centered horizontally, 100pt from top safe area
Logo Image: App icon or wordmark
Size: 80x80pt
Background: White (if icon has transparent background)
Shadow: None (clean, minimal)
```

### Title Section
```
Position: 24pt below logo
Alignment: Center
Padding: 0 32pt horizontal

Title:
├─ Text: "Welcome Back!"
├─ Font: Inter Bold, 28pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Letter Spacing: -0.5pt
└─ Alignment: Center

Subtitle:
├─ Text: "Sign in to continue"
├─ Font: SF Pro Regular, 15pt
├─ Color: #666666 (light), #A0A0A0 (dark)
├─ Alignment: Center
└─ Margin Top: 8pt
```

### Phone Input Section
```
Position: 48pt below subtitle
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
├─ Max Length: 10 digits (auto-formatted with space)
├─ Auto-fill: From device contacts/autofill
└─ Auto Focus: Yes (on screen appear)

Error Message (if validation fails):
├─ Position: 8pt below input
├─ Text: "Please enter a valid 10-digit mobile number"
├─ Font: SF Pro Regular, 13pt
├─ Color: #EA5455 (error red)
└─ Icon: exclamationmark.circle.fill, 14x14pt
```

### Send OTP Button
```
Position: 24pt below phone input
Padding: 0 32pt horizontal

Button:
├─ Width: Full (390pt - 64pt padding)
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Background: #0D7377 (enabled), #E0E0E0 (disabled)
├─ Shadow: 0 4px 12px rgba(13,115,119,0.2) (enabled)
└─ Shadow: None (disabled)

Text:
├─ Text: "Send OTP"
├─ Font: Inter SemiBold, 16pt
├─ Color: White (#FFFFFF)
├─ Letter Spacing: 0.5pt
└─ Icon (loading): ProgressView (spinner), white

States:
├─ Default: Enabled if phone valid (10 digits)
├─ Disabled: Phone invalid
├─ Loading: Sending OTP request
└─ Error: Shake animation if send fails
```

### OR Divider
```
Position: 32pt below Send OTP button
Padding: 0 32pt horizontal

Layout: HStack with line + text + line
├─ Left Line: 1pt height, #E0E0E0, flex width
├─ Text: "OR"
│   ├─ Font: SF Pro Medium, 13pt
│   ├─ Color: #999999
│   ├─ Padding: 16pt horizontal
│   └─ Background: White (overlaps lines)
└─ Right Line: 1pt height, #E0E0E0, flex width
```

### Google Sign In Button (Optional)
```
Position: 24pt below divider
Padding: 0 32pt horizontal

Button:
├─ Width: Full
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Border: 1pt solid #E0E0E0
├─ Background: White (#FFFFFF), Dark (#2A2A2A)
├─ Shadow: 0 2px 4px rgba(0,0,0,0.08)
└─ Tap: Scale 0.98

Content:
├─ Google Icon: 20x20pt (official Google G logo)
├─ Text: "Continue with Google"
├─ Font: SF Pro Medium, 15pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Layout: HStack, icon + text, centered
└─ Gap: 8pt between icon and text

Action:
└─ Trigger Google Sign-In OAuth flow
```

### Create Account Link
```
Position: 32pt below Google button (or 32pt below Send OTP if no Google)
Alignment: Center
Padding Bottom: 40pt

Text:
├─ "Don't have an account?" - Regular text
├─ Font: SF Pro Regular, 14pt
├─ Color: #666666
└─ "Create Account" - Link text
    ├─ Font: SF Pro Medium, 14pt
    ├─ Color: #0D7377
    ├─ Underline: On tap (active state)
    └─ Action: Navigate to Phone Registration (03)
```

---

## Component Breakdown

### 1. Phone Input Component
```
Component: PhoneTextField (reused from registration)
Features:
├─ Country code picker (+91 default)
├─ 10-digit input with auto-formatting
├─ Real-time validation
├─ Clear button
└─ Error states

Reused: Yes (from 03_PHONE_REGISTRATION)
```

### 2. Send OTP Button
```
Component: PrimaryButton (from component library)
Props:
├─ title: "Send OTP"
├─ action: sendOTP
├─ isLoading: Bool
├─ isDisabled: !isPhoneValid
└─ hapticFeedback: Medium impact
```

### 3. Social Sign In Button (Optional)
```
Component: SocialSignInButton
Provider: Google
Features:
├─ Google branding (official icon + colors)
├─ OAuth 2.0 flow integration
├─ Automatic account creation if new user
└─ Link to existing account if phone matches
```

---

## Animations & Transitions

### Entry Animation
```
Duration: 500ms
Easing: Ease Out

Sequence:
0ms   - Screen appears (fade in from black/splash)
100ms - Logo fades in + scale (0.9 → 1.0)
200ms - Title + subtitle fade in + slide up (10pt)
300ms - Phone input fades in + slide up (10pt)
400ms - Send OTP button fades in + slide up (10pt)
500ms - Divider + Google button + Create link fade in
600ms - Auto-focus phone input (keyboard appears)
```

### Button Press Animation
```
Duration: 100ms
Easing: Ease Out

Changes:
├─ Scale: 1.0 → 0.98
├─ Haptic: Medium impact
└─ Trigger action on release
```

### Send OTP Success
```
Trigger: OTP sent successfully
Duration: 300ms

Sequence:
├─ Button briefly shows "Sent ✓" (200ms)
├─ Navigate to OTP Verification screen
└─ Transition: Slide left (push navigation)
```

### Error Shake Animation
```
Trigger: Invalid phone or network error
Duration: 600ms

Sequence:
├─ Input shakes (±10pt horizontal translation)
├─ Border turns red
├─ Error message appears
├─ Haptic: Error notification
└─ Refocus input
```

---

## States

### Default State
```
Status: User lands on login screen
Visual:
├─ Phone input: Empty with placeholder
├─ Send OTP button: Disabled (gray)
├─ Google button: Enabled (if implemented)
├─ Create Account link: Visible
└─ Keyboard: Number pad (auto-focused)
```

### Typing State (1-9 digits)
```
Status: User entering phone number
Visual:
├─ Phone input: Focused (blue border)
├─ Real-time formatting: "12345 67890"
├─ Button: Still disabled until 10 digits
└─ Clear button: Visible
```

### Valid Ready State (10 digits)
```
Status: Phone number complete and valid
Visual:
├─ Phone input: Green checkmark icon (right)
├─ Button: Enabled (teal with shadow)
└─ Ready to send OTP
```

### Sending OTP (Loading)
```
Trigger: User taps "Send OTP"
Status: Requesting OTP from backend
Visual:
├─ Button: Spinner replacing text
├─ Phone input: Disabled (non-editable)
├─ Google button: Disabled
├─ Create link: Disabled
└─ Screen interactions: Disabled

Duration: 2-3 seconds typical
Timeout: 15 seconds
```

### OTP Sent → Navigation
```
Status: OTP successfully sent
Action:
├─ Button briefly shows "Sent ✓" (200ms)
├─ Navigate to OTP Verification screen (04)
├─ Pass phone number + verification ID
└─ Transition: Slide left (300ms)
```

### Error State (Invalid Phone)
```
Trigger: User taps Send with invalid number
Visual:
├─ Input: Red border + shake animation
├─ Error message: "Please enter a valid 10-digit mobile number"
├─ Button: Returns to disabled
└─ Haptic: Error notification
```

### Error State (Account Not Found)
```
Trigger: Backend returns "no account with this number"
Visual:
├─ Error message: "No account found. Create one?"
├─ "Create Account" link: Highlighted/emphasized
├─ Button: Re-enabled (can retry)
└─ Option: Auto-redirect to registration
```

### Error State (Network Failure)
```
Trigger: No internet or backend timeout
Visual:
├─ Toast: "Unable to send OTP. Check your connection."
├─ Button: Returns to enabled (retry)
├─ Phone number: Retained
└─ Retry option: Tap button again
```

### Google Sign In (Loading)
```
Trigger: User taps "Continue with Google"
Status: OAuth flow in progress
Visual:
├─ Google button: Spinner
├─ Phone input: Disabled
├─ Send OTP button: Disabled
├─ Full-screen overlay (iOS system Google Sign-In)
└─ Duration: 2-10 seconds (user interaction)
```

### Google Sign In Success
```
Status: Google account authenticated
Action:
├─ Check if account exists (email match)
├─ If exists: Sign in → Navigate to Home
├─ If new: Create account → Navigate to Profile Setup or Home
└─ Transition: Fade (300ms)
```

### Google Sign In Error
```
Trigger: User cancels or OAuth fails
Visual:
├─ Google button: Returns to normal
├─ Toast: "Sign-in cancelled" or "Sign-in failed. Try again."
├─ Phone input: Re-enabled
└─ User can retry or use phone login
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E (dark background)
Logo: White version (if logo has variants)
Text Primary: #E0E0E0 (light text)
Text Secondary: #A0A0A0 (secondary light text)
Input Background: #2A2A2A (dark surface)
Input Border: #3A3A3A (dark border)
Input Border (focused): #14A0A5 (lighter teal)
Button Disabled: #3A3A3A
Button Enabled: #0D7377 (same)
Google Button Background: #2A2A2A
Google Button Border: #3A3A3A
Divider: #3A3A3A
Create Link: #14A0A5 (lighter teal)
```

---

## Accessibility

### VoiceOver

**Element Labels:**
```
Logo: Decorative (hidden from VoiceOver)
Title: "Welcome Back, heading"
Subtitle: "Sign in to continue"
Phone Input: "Mobile number, text field"
Country Code: "Country code, India +91, button"
Send OTP Button: "Send OTP, button, disabled" / "Send OTP, button"
Google Button: "Continue with Google, button"
Create Link: "Don't have an account? Create Account, link"
```

**Announcements:**
```
On screen appear: "Welcome Back. Sign in to continue."
On phone valid: "Valid phone number"
On OTP sending: "Sending verification code"
On OTP sent: "Code sent"
On error: "Error. Please enter a valid phone number"
On account not found: "No account found. Create one?"
```

**Focus Order:**
```
1. Phone input (auto-focused)
2. Country code picker
3. Send OTP button
4. Google button (if present)
5. Create Account link
```

### Dynamic Type

**Supported Sizes:** -2 to +3

**Scaling:**
```
Title: 28pt → 24pt (min) to 34pt (max)
Subtitle: 15pt → 13pt (min) to 18pt (max)
Input text: 16pt → 14pt (min) to 20pt (max)
Button text: 16pt → 14pt (min) to 19pt (max)
Link text: 14pt → 12pt (min) to 17pt (max)

Layout Adjustments:
├─ At +2: Input height 56pt → 60pt
├─ At +3: Button height 52pt → 60pt
└─ Vertical spacing increases proportionally
```

### Reduced Motion

**If "Reduce Motion" enabled:**
```
Entry animation: Instant appear (no fade/slide)
Logo animation: Instant appear (no scale)
Button press: No scale animation
Success: Instant navigation (no fade)
Error shake: Red border flash (no shake)
All transitions: Crossfade only
```

### Color Contrast

**WCAG AA (4.5:1):**
```
✅ Title (#1E1E1E on #FFFFFF): 16.1:1
✅ Subtitle (#666666 on #FFFFFF): 5.7:1
✅ Input text (#1E1E1E on #F8F8F8): 14.8:1
✅ Button text (White on #0D7377): 5.2:1
✅ Link (#0D7377 on #FFFFFF): 4.9:1
✅ Dark mode title (#E0E0E0 on #1E1E1E): 12.6:1
```

### Touch Targets

**Minimum 44x44pt:**
```
✅ Country code picker: 80x56pt
✅ Phone input: Full width x 56pt
✅ Send OTP button: Full width x 52pt
✅ Google button: Full width x 52pt
✅ Create Account link: Full width x 44pt
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var phoneNumber: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @State private var isGoogleSigningIn: Bool = false
    @FocusState private var isPhoneFocused: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Logo
                Image("logo-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .padding(.top, 100)

                // Title
                VStack(spacing: 8) {
                    Text("Welcome Back!")
                        .font(.custom("Inter-Bold", size: 28))
                        .foregroundColor(.textPrimary)

                    Text("Sign in to continue")
                        .font(.system(size: 15))
                        .foregroundColor(.textSecondary)
                }
                .padding(.top, 24)

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
                        errorMessage = nil
                        viewModel.validatePhone(newValue)
                    }

                    if let error = errorMessage {
                        ErrorLabel(message: error)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 48)

                // Send OTP Button
                PrimaryButton(
                    title: "Send OTP",
                    action: sendOTP,
                    isLoading: isLoading,
                    isDisabled: !viewModel.isPhoneValid
                )
                .padding(.horizontal, 32)
                .padding(.top, 24)

                // OR Divider
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.gray300)
                        .frame(height: 1)

                    Text("OR")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.gray500)
                        .padding(.horizontal, 16)
                        .background(Color.white)

                    Rectangle()
                        .fill(Color.gray300)
                        .frame(height: 1)
                }
                .padding(.horizontal, 32)
                .padding(.top, 32)

                // Google Sign In
                Button(action: signInWithGoogle) {
                    HStack(spacing: 8) {
                        if isGoogleSigningIn {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        } else {
                            Image("google-logo") // Google G icon
                                .resizable()
                                .frame(width: 20, height: 20)

                            Text("Continue with Google")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.textPrimary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray300, lineWidth: 1)
                    )
                    .shadow(radius: 2, y: 2)
                }
                .disabled(isGoogleSigningIn || isLoading)
                .padding(.horizontal, 32)
                .padding(.top, 24)

                // Create Account Link
                HStack(spacing: 4) {
                    Text("Don't have an account?")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)

                    Button(action: navigateToRegistration) {
                        Text("Create Account")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.brandPrimary)
                    }
                }
                .padding(.top, 32)
                .padding(.bottom, 40)

                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            isPhoneFocused = true
        }
    }

    private func sendOTP() {
        guard viewModel.isPhoneValid else {
            errorMessage = "Please enter a valid 10-digit mobile number"
            return
        }

        isLoading = true
        isPhoneFocused = false

        Task {
            do {
                let verificationID = try await viewModel.sendOTP(to: phoneNumber)
                isLoading = false

                // Navigate to OTP screen
                // navigationController.push(OTPVerificationView(phone: phoneNumber, verificationID: verificationID))

            } catch {
                isLoading = false
                handleLoginError(error)
            }
        }
    }

    private func signInWithGoogle() {
        isGoogleSigningIn = true

        Task {
            do {
                let user = try await viewModel.signInWithGoogle()
                isGoogleSigningIn = false

                // Navigate based on user status
                if user.isNewUser {
                    // Navigate to Profile Setup
                } else {
                    // Navigate to Home
                }

            } catch {
                isGoogleSigningIn = false
                showToast(message: "Google sign-in failed. Try again.", type: .error)
            }
        }
    }

    private func handleLoginError(_ error: Error) {
        if let nsError = error as NSError? {
            if nsError.code == 404 {
                // Account not found
                errorMessage = "No account found."
                showAccountNotFoundAlert()
            } else {
                errorMessage = error.localizedDescription
            }
        }
    }

    private func showAccountNotFoundAlert() {
        // Show alert with "Create Account" option
    }

    private func navigateToRegistration() {
        // Navigate to Phone Registration (03)
    }

    private func showToast(message: String, type: ToastType) {
        // Show toast notification
    }
}
```

### ViewModel

```swift
@MainActor
class LoginViewModel: ObservableObject {
    @Published var isPhoneValid: Bool = false

    func validatePhone(_ phone: String) {
        let digits = phone.filter { $0.isNumber }
        isPhoneValid = digits.count == 10 && digits.first != "0"
    }

    func sendOTP(to phoneNumber: String) async throws -> String {
        let fullNumber = "+91" + phoneNumber.filter { $0.isNumber }

        // Check if account exists
        let accountExists = try await checkAccountExists(phoneNumber: fullNumber)
        guard accountExists else {
            throw NSError(domain: "", code: 404, userInfo: [
                NSLocalizedDescriptionKey: "No account found with this number"
            ])
        }

        // Send OTP
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return "verification-id-12345"

        // Real implementation:
        // return try await PhoneAuthProvider.provider()
        //     .verifyPhoneNumber(fullNumber, uiDelegate: nil)
    }

    func checkAccountExists(phoneNumber: String) async throws -> Bool {
        // Check Firestore for existing customer
        // Simulated:
        try await Task.sleep(nanoseconds: 500_000_000)
        return true // Assume exists

        // Real:
        // let snapshot = try await Firestore.firestore()
        //     .collection("customers")
        //     .whereField("phoneNumber", isEqualTo: phoneNumber)
        //     .getDocuments()
        // return !snapshot.documents.isEmpty
    }

    func signInWithGoogle() async throws -> User {
        // Google Sign-In OAuth flow
        // Simulated:
        try await Task.sleep(nanoseconds: 3_000_000_000)
        return User(id: "google-123", email: "user@gmail.com", isNewUser: false)

        // Real implementation:
        // 1. Get Google ID token
        // 2. Create Firebase credential
        // 3. Sign in with credential
        // 4. Check if new user or returning
    }
}
```

---

## Assets Required

### Images
```
1. logo-icon.png
   - Size: @1x: 80x80px, @2x: 160x160px, @3x: 240x240px
   - Content: UrbanNest app icon or wordmark
   - Format: PNG with or without transparency

2. google-logo.png (if using Google Sign-In)
   - Size: @1x: 20x20px, @2x: 40x40px, @3x: 60x60px
   - Content: Official Google "G" logo
   - Format: PNG with transparency
   - Source: Google Brand Resources (official)
```

### SF Symbols
```
- chevron.down (Country code picker)
- checkmark.circle.fill (Valid phone indicator)
- exclamationmark.circle.fill (Error indicator)
- xmark.circle.fill (Clear button)
```

### Colors from Design System
```
- brandPrimary (#0D7377)
- textPrimary (#1E1E1E)
- textSecondary (#666666)
- gray100 (#F8F8F8)
- gray300 (#E0E0E0)
- gray500 (#999999)
- success (#28C76F)
- error (#EA5455)
- white (#FFFFFF)
```

---

## Navigation Flow

### Entry Points
```
1. App Launch (no valid session):
   └─ Direct navigation (no animation)

2. From Registration Flow:
   └─ User taps "Login here" link
   └─ Transition: Replace/pop (slide right)

3. Session Expired:
   └─ Forced navigation from any screen
   └─ Transition: Fade in
```

### Exit Points
```
1. OTP Sent Success:
   └─ Navigate to: OTP Verification (04)
   └─ Transition: Slide left (push)
   └─ Data: { phoneNumber, verificationID }

2. Google Sign In Success (Returning User):
   └─ Navigate to: Home Screen
   └─ Transition: Fade (300ms)

3. Google Sign In Success (New User):
   └─ Navigate to: Profile Setup (05)
   └─ Transition: Slide left

4. Create Account Link:
   └─ Navigate to: Phone Registration (03)
   └─ Transition: Slide left or replace

5. Account Not Found:
   └─ Show alert, then optionally redirect to Registration
```

---

## Error Handling

### Invalid Phone Number
```
Trigger: Phone < 10 digits or invalid format
Action:
├─ Show error message below input
├─ Red border on input
├─ Shake animation
├─ Keep button disabled
└─ Haptic: Error notification
```

### Account Not Found
```
Trigger: Backend returns "no account"
Response: 404 error
Action:
├─ Show alert:
│   ├─ Title: "No Account Found"
│   ├─ Message: "Would you like to create an account with this number?"
│   ├─ Action 1: "Cancel"
│   └─ Action 2: "Create Account" → Navigate to Registration
└─ Alternative: Show inline error + highlight Create Account link
```

### Network Error
```
Trigger: No internet or backend timeout
Action:
├─ Stop loading
├─ Toast: "Unable to send OTP. Check your connection."
├─ Return button to enabled
├─ Keep phone number
└─ Allow immediate retry
```

### Google Sign-In Cancelled
```
Trigger: User dismisses Google Sign-In dialog
Action:
├─ Stop Google button loading
├─ Toast: "Sign-in cancelled" (optional, subtle)
├─ Re-enable all inputs
└─ No error state (user action)
```

### Google Sign-In Failed
```
Trigger: OAuth error or network failure
Action:
├─ Stop Google button loading
├─ Toast: "Google sign-in failed. Try again."
├─ Re-enable all inputs
└─ User can retry
```

### Rate Limiting (OTP)
```
Trigger: Too many OTP requests
Response: 429 "Too Many Requests"
Action:
├─ Show error: "Too many attempts. Try again in 15 minutes."
├─ Disable Send OTP button
├─ Show countdown timer
├─ Offer Google Sign-In as alternative
└─ Re-enable after cooldown
```

---

## Performance Requirements

```
Screen load: < 300ms
Phone validation: < 100ms
OTP request: 2-3 seconds typical, 15s timeout
Google Sign-In: 2-10 seconds (user interaction)
Memory: < 30MB
Animations: 60fps
```

---

## Testing Checklist

- [ ] Phone input accepts 10 digits
- [ ] Phone input auto-formats (12345 67890)
- [ ] Country code picker works
- [ ] Send OTP button disabled when phone invalid
- [ ] Send OTP button enabled when phone valid
- [ ] OTP sends successfully to existing account
- [ ] Error shown if account not found
- [ ] "Create Account" redirect works
- [ ] Network error handled gracefully
- [ ] Google Sign-In button works (if implemented)
- [ ] Google OAuth flow completes
- [ ] Google sign-in creates/links account correctly
- [ ] Cancel Google sign-in handled
- [ ] Navigation to OTP screen works
- [ ] "Create Account" link navigates to Registration
- [ ] Dark mode looks correct
- [ ] VoiceOver works
- [ ] Dynamic Type scales
- [ ] Reduced Motion respected
- [ ] Works on all device sizes
- [ ] No memory leaks
- [ ] Haptic feedback on interactions

---

## Analytics Events

```swift
// Screen view
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "login"
])

// Phone input started
Analytics.logEvent("login_phone_started", parameters: [:])

// OTP request initiated
Analytics.logEvent("login_otp_requested", parameters: [
    "phone_country_code": "+91"
])

// OTP request success
Analytics.logEvent("login_otp_success", parameters: [:])

// OTP request failed
Analytics.logEvent("login_otp_failed", parameters: [
    "error": "account_not_found" // or "network_error"
])

// Google Sign-In started
Analytics.logEvent("login_google_started", parameters: [:])

// Google Sign-In success
Analytics.logEvent("login_google_success", parameters: [
    "is_new_user": false
])

// Google Sign-In cancelled
Analytics.logEvent("login_google_cancelled", parameters: [:])

// Navigate to Create Account
Analytics.logEvent("login_create_account_tapped", parameters: [:])
```

---

## Design Rationale

**Why this design:**

- **Phone-first login**: Consistent with registration, familiar to users
- **No password**: Reduces friction, OTP is more secure for service apps
- **Google Sign-In option**: Convenience for users with Google accounts, faster login
- **Clear "Create Account" path**: Easy discovery for new users who landed here by mistake
- **Minimal fields**: Just phone number, maximum simplicity
- **Account check before OTP**: Prevents OTP spam for non-existent accounts
- **Auto-focus phone input**: Reduces taps, faster flow

**Alternatives Considered:**

- Email + password login: More traditional but adds friction, requires password recovery
- Magic link email: Slower than OTP, requires email inbox access
- Biometric-only: Not suitable for first-time device login
- Combined registration/login screen: Confusing, cluttered UI

---

**This login screen is the returning user's entry point. It must be fast, simple, and reliable to maintain user engagement.**
