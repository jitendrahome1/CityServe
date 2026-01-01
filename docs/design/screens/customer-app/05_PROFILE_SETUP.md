# 05 - Profile Setup

**Screen ID:** 05
**Screen Name:** Profile Setup
**User Flow:** OTP Verification → Profile Setup → Home
**Entry Point:** After new user successfully verifies phone number
**Next Screen:** Home Screen (06) with tab bar

---

## Overview

The profile setup screen is where new users complete their basic profile information after phone verification. This step collects essential details needed for service bookings and personalizes the user experience.

**Purpose:**
- Collect user's full name (required)
- Collect email address (optional but recommended)
- Optionally add profile photo
- Create personalized user account
- Enable future communications and receipts
- Complete the onboarding funnel
- Transition to main app experience

---

## ASCII Wireframe

```
┌────────────────────────────────────────┐
│  ‹                         Skip  →     │ ← Back Button + Skip Link
├────────────────────────────────────────┤
│                                        │
│       Complete Your Profile            │ ← Title
│                                        │
│   Help us personalize your experience  │ ← Subtitle
│                                        │
│                                        │
│            ┌──────────┐                │
│            │          │                │
│            │    👤    │                │ ← Profile Photo
│            │          │                │   (96x96pt circle)
│            └──────────┘                │
│          [Add Photo]                   │ ← Add Photo Link
│                                        │
│                                        │
│  Full Name *                           │ ← Label (required)
│  ┌────────────────────────────────┐   │
│  │  Rahul Kumar                   │   │ ← Text Input
│  └────────────────────────────────┘   │
│                                        │
│                                        │
│  Email Address (Optional)              │ ← Label
│  ┌────────────────────────────────┐   │
│  │  rahul@example.com             │   │ ← Text Input
│  └────────────────────────────────┘   │
│                                        │
│   📧 We'll send booking confirmations  │ ← Info Text
│       and receipts here                │
│                                        │
│                                        │
│  ┌────────────────────────────────┐   │
│  │     Continue to Home           │   │ ← Primary Button
│  └────────────────────────────────┘   │
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
Scrollable: Yes (for keyboard + smaller screens)
```

### Background
```
Color: White (#FFFFFF) / Dark (#1E1E1E)
```

### Top Navigation
```
Position: Top edge, 8pt from safe area
Layout: HStack with space between

Back Button (Left):
├─ Icon: chevron.left (SF Symbol)
├─ Size: 24x24pt
├─ Color: #333333 (light), #E0E0E0 (dark)
├─ Tap Target: 44x44pt
├─ Position: 16pt from left edge
└─ Action: Navigate back to OTP screen (with confirmation)

Skip Link (Right):
├─ Text: "Skip"
├─ Icon: arrow.right (SF Symbol), 16x16pt
├─ Font: SF Pro Medium, 16pt
├─ Color: #666666 (light), #A0A0A0 (dark)
├─ Tap Target: 44x44pt
├─ Position: 16pt from right edge
└─ Action: Navigate to Home (skip profile completion)
```

### Title Section
```
Position: 24pt below top navigation
Alignment: Center
Padding: 0 32pt horizontal

Title:
├─ Text: "Complete Your Profile"
├─ Font: Inter SemiBold, 26pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Letter Spacing: -0.5pt
└─ Alignment: Center

Subtitle:
├─ Text: "Help us personalize your experience"
├─ Font: SF Pro Regular, 15pt
├─ Color: #666666 (light), #A0A0A0 (dark)
├─ Alignment: Center
└─ Margin Top: 8pt
```

### Profile Photo Section
```
Position: 32pt below subtitle
Alignment: Center

Photo Container:
├─ Size: 96x96pt (circle)
├─ Border: 3pt solid #E0E0E0 (empty state)
├─ Border: None (with photo)
├─ Background: #F5F5F5 (empty state)
├─ Icon (empty): person.fill (SF Symbol), 48x48pt, #CCCCCC
└─ Shadow: 0 4px 12px rgba(0,0,0,0.1) (with photo)

Photo (if added):
├─ Size: 96x96pt
├─ Aspect Ratio: Fill (cropped to circle)
├─ Border Radius: 50% (circle)
└─ Quality: Compressed (max 500KB)

Add Photo Link:
├─ Position: 12pt below photo
├─ Text: "Add Photo" (empty state) / "Change Photo" (with photo)
├─ Font: SF Pro Medium, 14pt
├─ Color: #0D7377 (brand primary)
├─ Alignment: Center
└─ Action: Show photo picker (Camera or Photo Library)

Camera Icon Badge (if no photo):
├─ Position: Bottom-right of circle
├─ Size: 32x32pt
├─ Background: #0D7377 (brand primary)
├─ Icon: camera.fill, 16x16pt, White
├─ Border: 2pt solid white
└─ Border Radius: 50% (circle)
```

### Full Name Input
```
Position: 32pt below photo section
Padding: 0 32pt horizontal

Label:
├─ Text: "Full Name *" (* indicates required)
├─ Font: SF Pro Medium, 14pt
├─ Color: #333333 (light), #E0E0E0 (dark)
└─ Margin Bottom: 8pt

Input Field:
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Border: 1pt solid #E0E0E0 (default)
├─ Border (focused): 2pt solid #0D7377
├─ Border (error): 2pt solid #EA5455
├─ Background: #F8F8F8 (light), #2A2A2A (dark)
├─ Padding: 16pt horizontal
├─ Font: SF Pro Regular, 16pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Placeholder: "Enter your full name"
├─ Placeholder Color: #999999
├─ Keyboard: Default (text)
├─ Autocapitalization: Words
├─ Autocorrect: Yes
└─ Max Length: 50 characters

Validation:
├─ Min Length: 2 characters
├─ Format: Letters and spaces only (no numbers or special chars)
├─ Required: Yes (can't proceed without it)
└─ Error Message: "Please enter your full name (2+ characters)"

Clear Button (when filled):
├─ Icon: xmark.circle.fill (SF Symbol)
├─ Size: 20x20pt
├─ Color: #999999
├─ Position: Right side, 16pt from edge
└─ Action: Clear text field
```

### Email Input
```
Position: 24pt below name input
Padding: 0 32pt horizontal

Label:
├─ Text: "Email Address (Optional)"
├─ Font: SF Pro Medium, 14pt
├─ Color: #333333 (light), #E0E0E0 (dark)
└─ Margin Bottom: 8pt

Input Field:
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Border: 1pt solid #E0E0E0 (default)
├─ Border (focused): 2pt solid #0D7377
├─ Border (error): 2pt solid #EA5455
├─ Background: #F8F8F8 (light), #2A2A2A (dark)
├─ Padding: 16pt horizontal
├─ Font: SF Pro Regular, 16pt
├─ Color: #1E1E1E (light), #E0E0E0 (dark)
├─ Placeholder: "you@example.com"
├─ Placeholder Color: #999999
├─ Keyboard: Email Address
├─ Autocapitalization: None
├─ Autocorrect: No
└─ Max Length: 100 characters

Validation (if filled):
├─ Format: Valid email pattern (regex)
├─ Error Message: "Please enter a valid email address"
└─ Required: No (can skip)

Clear Button (when filled):
├─ Icon: xmark.circle.fill
├─ Size: 20x20pt
├─ Color: #999999
└─ Position: Right side, 16pt from edge

Info Text:
├─ Position: 8pt below input
├─ Icon: envelope.fill (SF Symbol), 14x14pt, #666666
├─ Text: "We'll send booking confirmations and receipts here"
├─ Font: SF Pro Regular, 13pt
├─ Color: #666666 (light), #A0A0A0 (dark)
├─ Layout: HStack with icon on left
└─ Max Width: Full (input width)
```

### Continue Button
```
Position: 32pt below email section
Padding: 0 32pt horizontal

Button:
├─ Width: Full (390pt - 64pt padding)
├─ Height: 52pt
├─ Border Radius: 12pt
├─ Background: #0D7377 (enabled), #E0E0E0 (disabled)
├─ Shadow: 0 4px 12px rgba(13,115,119,0.2) (enabled)
└─ Shadow: None (disabled)

Text:
├─ Text: "Continue to Home"
├─ Font: Inter SemiBold, 16pt
├─ Color: White (#FFFFFF)
└─ Icon (loading): ProgressView (spinner), white

States:
├─ Disabled: Name empty or invalid
├─ Enabled: Name valid (2+ characters)
├─ Loading: Saving profile data
└─ Error: Shake animation if save fails

Behavior:
├─ Enabled when: Name field has 2+ characters (email validation only if filled)
├─ Action: Save profile → Navigate to Home Screen
├─ Haptic: Medium impact on tap
└─ Loading: 1-2 seconds (create user profile in backend)
```

---

## Component Breakdown

### 1. Profile Photo Picker
```
Component: ProfilePhotoPicker
States:
├─ Empty (default icon + "Add Photo" link)
├─ Loading (uploading photo, spinner overlay)
├─ Filled (photo displayed + "Change Photo" link)
└─ Error (upload failed, show retry)

Functionality:
├─ Tap photo or link: Show action sheet
│   ├─ "Take Photo" - Opens camera
│   ├─ "Choose from Library" - Opens photo picker
│   └─ "Cancel"
├─ Photo selected: Crop to square (1:1 aspect ratio)
├─ Upload: Compress to max 500KB, upload to Firebase Storage
├─ Success: Display photo, store URL in user profile
└─ Error: Show toast, allow retry

Permissions:
├─ Camera: Request on "Take Photo"
├─ Photo Library: Request on "Choose from Library"
└─ Handle denied permissions gracefully
```

### 2. Name TextField Component
```
Component: ValidatedTextField (from component library)
Props:
├─ label: "Full Name *"
├─ placeholder: "Enter your full name"
├─ text: Binding<String>
├─ validation: .name (2+ chars, letters only)
├─ isRequired: true
└─ keyboard: .default

Validation Rules:
├─ Min length: 2 characters
├─ Max length: 50 characters
├─ Pattern: ^[a-zA-Z ]+$ (letters and spaces)
├─ Trim whitespace on submit
└─ Error shown on blur if invalid
```

### 3. Email TextField Component
```
Component: ValidatedTextField
Props:
├─ label: "Email Address (Optional)"
├─ placeholder: "you@example.com"
├─ text: Binding<String>
├─ validation: .email
├─ isRequired: false
└─ keyboard: .emailAddress

Validation Rules (only if not empty):
├─ Pattern: Standard email regex
├─ Example: user@domain.com
├─ Case insensitive
├─ Trim whitespace
└─ Error shown on blur if invalid format
```

---

## Animations & Transitions

### Entry Animation
```
Duration: 500ms
Easing: Ease Out

Sequence:
0ms   - Screen slides in from right
100ms - Title + subtitle fade in + slide up (10pt)
200ms - Profile photo fades in + scale (0.9 → 1.0)
300ms - "Add Photo" link fades in
400ms - Name input fades in + slide up (10pt)
500ms - Email input + info text fade in + slide up (10pt)
600ms - Continue button fades in + slide up (10pt)
700ms - Auto-focus name input (keyboard appears)
```

### Photo Upload Animation
```
Trigger: User selects photo from picker
Duration: 1-2 seconds

Sequence:
├─ Selected photo appears (fade in)
├─ Spinner overlay (on photo, semi-transparent background)
├─ Upload progress (indeterminate spinner)
├─ Success: Spinner fades out, photo remains
├─ Error: Photo fades out, error message appears
└─ Haptic: Success or error notification
```

### Input Focus Animation
```
Duration: 200ms
Easing: Ease Out

Changes:
├─ Border color: #E0E0E0 → #0D7377
├─ Border width: 1pt → 2pt
├─ Shadow: Appear (0 0 0 4px rgba(13,115,119,0.1))
└─ Keyboard slides up (iOS system animation)
```

### Button Enable Animation
```
Trigger: Name becomes valid (2+ characters)
Duration: 200ms
Easing: Ease Out

Changes:
├─ Background: #E0E0E0 → #0D7377
├─ Shadow: Appear (0 4px 12px rgba(13,115,119,0.2))
├─ Slight scale: 1.0 → 1.02 → 1.0
└─ Haptic: Light impact
```

### Save Success Animation
```
Trigger: Profile saved successfully
Duration: 800ms

Sequence:
├─ Button text: "Continue to Home" → "Done ✓"
├─ Button background: #0D7377 → #28C76F (success green)
├─ Wait 400ms (show success state)
├─ Entire screen fades out (opacity 1 → 0, 300ms)
├─ Navigate to Home Screen
└─ Haptic: Success notification
```

---

## States

### Default State (Initial)
```
Status: New user lands on profile setup
Visual:
├─ Profile photo: Empty (default icon)
├─ Name input: Empty, focused (keyboard visible)
├─ Email input: Empty
├─ Button: Disabled (gray)
└─ Skip link: Visible, enabled
```

### Name Being Entered (1 character)
```
Status: User typing name
Visual:
├─ Name input: Focused, text appearing
├─ Button: Still disabled (< 2 characters)
├─ Email: Not focused
└─ Keyboard: Visible
```

### Name Valid (2+ characters)
```
Status: Minimum name requirement met
Visual:
├─ Name input: Filled, valid
├─ Button: Enabled (teal background with shadow)
├─ Email: Optional, can be empty
└─ User can now proceed
```

### Photo Upload in Progress
```
Status: Uploading selected photo
Visual:
├─ Photo: Displayed with spinner overlay
├─ Name/Email inputs: Disabled during upload
├─ Button: Disabled during upload
├─ "Add Photo" link: Hidden, replaced by spinner
└─ User must wait for upload to complete
```

### Photo Upload Success
```
Status: Photo uploaded successfully
Visual:
├─ Photo: Displayed (no spinner)
├─ Link: "Change Photo" (instead of "Add Photo")
├─ Inputs: Re-enabled
├─ Button: Enabled (if name valid)
└─ Photo URL stored in state
```

### Photo Upload Failed
```
Status: Upload error (network, size limit, etc.)
Visual:
├─ Photo: Reverts to empty state (default icon)
├─ Toast: "Failed to upload photo. Try again."
├─ Link: "Add Photo" (can retry)
└─ Inputs: Re-enabled, user can proceed without photo
```

### Email Invalid (if filled)
```
Trigger: User enters invalid email format
Visual:
├─ Email input: Red border (on blur)
├─ Error message: "Please enter a valid email address"
├─ Button: Still enabled (email is optional)
└─ User can proceed, but encouraged to fix
```

### Saving Profile (Loading)
```
Trigger: User taps "Continue to Home"
Status: Creating user profile in backend
Visual:
├─ Button: Spinner replacing text
├─ Inputs: Disabled (non-editable)
├─ Back/Skip: Disabled
├─ Keyboard: Dismissed
└─ Screen interactions: Disabled

Duration: 1-2 seconds
Timeout: 15 seconds (then show error)
```

### Save Success → Navigation
```
Status: Profile created successfully
Visual:
├─ Button: "Done ✓" with green background
├─ Success animation plays (400ms)
├─ Screen fades out (300ms)
├─ Navigate to Home Screen with tab bar
└─ Haptic: Success notification

Data Saved:
├─ Full name
├─ Email (if provided)
├─ Profile photo URL (if uploaded)
├─ Phone number (from previous step)
└─ User ID, created timestamp
```

### Save Error (Network Failure)
```
Trigger: Backend unreachable or error
Visual:
├─ Button: Returns to enabled state
├─ Toast: "Unable to save profile. Please try again."
├─ Inputs: Re-enabled (user can edit/retry)
└─ Data: Retained in form (not lost)

User Action: Can retry immediately
Auto-retry: No (explicit user action required)
```

### Skip Confirmation (if tapped)
```
Trigger: User taps "Skip" link
Action:
├─ Show alert:
│   ├─ Title: "Skip profile setup?"
│   ├─ Message: "You can complete your profile later from Settings"
│   ├─ Action 1: "Cancel" (dismiss alert)
│   └─ Action 2: "Skip" (navigate to Home)
└─ If confirmed: Navigate to Home (profile incomplete)

Profile State (if skipped):
├─ Name: Empty or phone number as fallback
├─ Email: Empty
├─ Photo: Default avatar
└─ Flag: profileIncomplete = true (show reminder in profile later)
```

---

## Dark Mode

### Colors
```
Background: #1E1E1E (dark background)
Text Primary: #E0E0E0 (light text)
Text Secondary: #A0A0A0 (secondary light text)
Input Background: #2A2A2A (dark surface)
Input Border: #3A3A3A (dark border)
Input Border (focused): #14A0A5 (lighter teal)
Photo Border (empty): #3A3A3A
Photo Icon: #666666
Camera Badge: #0D7377 (same brand primary)
Button Disabled: #3A3A3A
Button Enabled: #0D7377 (same)
Info Text: #A0A0A0
Skip Link: #A0A0A0
```

---

## Accessibility

### VoiceOver

**Element Labels:**
```
Back Button: "Back, button"
Skip Link: "Skip profile setup, button"
Title: "Complete Your Profile, heading"
Profile Photo (empty): "Add profile photo, button"
Profile Photo (with photo): "Profile photo, Change photo, button"
Add Photo Link: "Add photo, button"
Name Input: "Full name, required, text field"
Email Input: "Email address, optional, text field"
Continue Button: "Continue to Home, button" / "Disabled, button"
```

**Announcements:**
```
On screen appear: "Complete your profile. Full name is required."
On photo upload start: "Uploading photo"
On photo upload success: "Photo uploaded"
On photo upload error: "Upload failed. Try again."
On name valid: "Full name entered"
On email invalid: "Invalid email format"
On save start: "Saving profile"
On save success: "Profile saved. Continuing to home."
On save error: "Error. Unable to save profile."
```

**Focus Order:**
```
1. Back button
2. Skip link
3. Profile photo / Add photo link
4. Name input (auto-focused)
5. Email input
6. Continue button
```

### Dynamic Type

**Supported Sizes:** -2 to +3

**Scaling:**
```
Title: 26pt → 22pt (min) to 32pt (max)
Subtitle: 15pt → 13pt (min) to 18pt (max)
Input labels: 14pt → 12pt (min) to 17pt (max)
Input text: 16pt → 14pt (min) to 20pt (max)
Info text: 13pt → 11pt (min) to 16pt (max)
Button text: 16pt → 14pt (min) to 19pt (max)

Layout Adjustments:
├─ At +2: Input height 52pt → 60pt
├─ At +3: Photo size 96pt → 104pt
├─ Vertical spacing: Increases proportionally
└─ Button height: 52pt → 60pt at +3
```

### Reduced Motion

**If "Reduce Motion" enabled:**
```
Entry animation: Instant appear (no slide/fade)
Photo upload: No animations, instant state changes
Input focus: Instant border color change (no shadow animation)
Button enable: Instant color change (no scale)
Save success: Instant navigation (no fade out)
All transitions: Crossfade only
```

### Color Contrast

**WCAG AA (4.5:1):**
```
✅ Title (#1E1E1E on #FFFFFF): 16.1:1
✅ Subtitle (#666666 on #FFFFFF): 5.7:1
✅ Input text (#1E1E1E on #F8F8F8): 14.8:1
✅ Button text (White on #0D7377): 5.2:1
✅ Info text (#666666 on #FFFFFF): 5.7:1
✅ Skip link (#666666 on #FFFFFF): 5.7:1
✅ Dark mode title (#E0E0E0 on #1E1E1E): 12.6:1
```

### Touch Targets

**Minimum 44x44pt:**
```
✅ Back button: 44x44pt
✅ Skip link: 44x44pt
✅ Profile photo: 96x96pt (exceeds minimum)
✅ Add photo link: 44pt height
✅ Name input: Full width x 52pt
✅ Email input: Full width x 52pt
✅ Continue button: Full width x 52pt
```

---

## Implementation Notes

### SwiftUI Structure

```swift
struct ProfileSetupView: View {
    let phoneNumber: String
    let userId: String

    @StateObject private var viewModel: ProfileSetupViewModel
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var profilePhoto: UIImage? = nil
    @State private var photoURL: String? = nil
    @State private var isUploadingPhoto: Bool = false
    @State private var isSaving: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var showSkipConfirmation: Bool = false
    @State private var nameError: String? = nil
    @State private var emailError: String? = nil
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) var dismiss

    enum Field: Hashable {
        case name, email
    }

    init(phoneNumber: String, userId: String) {
        self.phoneNumber = phoneNumber
        self.userId = userId
        _viewModel = StateObject(wrappedValue: ProfileSetupViewModel(userId: userId))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Title
                VStack(spacing: 8) {
                    Text("Complete Your Profile")
                        .font(.custom("Inter-SemiBold", size: 26))
                        .foregroundColor(.textPrimary)

                    Text("Help us personalize your experience")
                        .font(.system(size: 15))
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 24)
                .padding(.horizontal, 32)

                // Profile Photo
                VStack(spacing: 12) {
                    ZStack {
                        if let photo = profilePhoto {
                            Image(uiImage: photo)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 96, height: 96)
                                .clipShape(Circle())
                                .shadow(radius: 4, y: 4)
                        } else {
                            Circle()
                                .stroke(Color.gray300, lineWidth: 3)
                                .frame(width: 96, height: 96)
                                .background(
                                    Circle()
                                        .fill(Color.gray100)
                                )
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 48))
                                        .foregroundColor(.gray400)
                                )

                            // Camera badge
                            Circle()
                                .fill(Color.brandPrimary)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                )
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .offset(x: 32, y: 32)
                        }

                        if isUploadingPhoto {
                            Circle()
                                .fill(Color.black.opacity(0.5))
                                .frame(width: 96, height: 96)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                    }
                    .onTapGesture {
                        showImagePicker = true
                    }

                    Button(profilePhoto == nil ? "Add Photo" : "Change Photo") {
                        showImagePicker = true
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.brandPrimary)
                }
                .padding(.top, 32)

                // Name Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Full Name *")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.textPrimary)

                    ValidatedTextField(
                        text: $fullName,
                        placeholder: "Enter your full name",
                        validation: .name,
                        errorMessage: $nameError
                    )
                    .focused($focusedField, equals: .name)
                    .onChange(of: fullName) { _ in
                        nameError = nil
                    }

                    if let error = nameError {
                        ErrorLabel(message: error)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 32)

                // Email Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email Address (Optional)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.textPrimary)

                    ValidatedTextField(
                        text: $email,
                        placeholder: "you@example.com",
                        validation: .email,
                        errorMessage: $emailError,
                        keyboardType: .emailAddress
                    )
                    .focused($focusedField, equals: .email)
                    .onChange(of: email) { _ in
                        emailError = nil
                    }

                    if let error = emailError {
                        ErrorLabel(message: error)
                    }

                    // Info Text
                    HStack(spacing: 6) {
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.textSecondary)

                        Text("We'll send booking confirmations and receipts here")
                            .font(.system(size: 13))
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, 32)
                .padding(.top, 24)

                // Continue Button
                PrimaryButton(
                    title: "Continue to Home",
                    action: saveProfile,
                    isLoading: isSaving,
                    isDisabled: !isFormValid
                )
                .padding(.horizontal, 32)
                .padding(.top, 32)
                .padding(.bottom, 40)

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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showSkipConfirmation = true }) {
                    HStack(spacing: 4) {
                        Text("Skip")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.textSecondary)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14))
                            .foregroundColor(.textSecondary)
                    }
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $profilePhoto) { image in
                uploadPhoto(image)
            }
        }
        .alert("Skip profile setup?", isPresented: $showSkipConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Skip", role: .destructive) {
                navigateToHome(profileComplete: false)
            }
        } message: {
            Text("You can complete your profile later from Settings")
        }
        .onAppear {
            focusedField = .name
        }
    }

    private var isFormValid: Bool {
        viewModel.validateName(fullName) && (email.isEmpty || viewModel.validateEmail(email))
    }

    private func uploadPhoto(_ image: UIImage) {
        isUploadingPhoto = true

        Task {
            do {
                let url = try await viewModel.uploadProfilePhoto(image, userId: userId)
                photoURL = url
                isUploadingPhoto = false
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            } catch {
                profilePhoto = nil
                photoURL = nil
                isUploadingPhoto = false
                showToast(message: "Failed to upload photo. Try again.", type: .error)
            }
        }
    }

    private func saveProfile() {
        guard isFormValid else {
            if !viewModel.validateName(fullName) {
                nameError = "Please enter your full name (2+ characters)"
            }
            if !email.isEmpty && !viewModel.validateEmail(email) {
                emailError = "Please enter a valid email address"
            }
            return
        }

        isSaving = true
        focusedField = nil // Dismiss keyboard

        Task {
            do {
                try await viewModel.saveProfile(
                    userId: userId,
                    name: fullName,
                    email: email.isEmpty ? nil : email,
                    photoURL: photoURL,
                    phoneNumber: phoneNumber
                )

                isSaving = false

                // Show success briefly
                try? await Task.sleep(nanoseconds: 400_000_000)

                navigateToHome(profileComplete: true)

            } catch {
                isSaving = false
                showToast(message: "Unable to save profile. Please try again.", type: .error)
            }
        }
    }

    private func navigateToHome(profileComplete: Bool) {
        // Navigate to Home Screen
        // Store profileComplete flag if needed
    }

    private func handleBackButton() {
        // Show confirmation if form has data
        if !fullName.isEmpty || !email.isEmpty || profilePhoto != nil {
            // Show alert
        } else {
            dismiss()
        }
    }

    private func showToast(message: String, type: ToastType) {
        // Show toast notification
    }
}
```

### ViewModel

```swift
@MainActor
class ProfileSetupViewModel: ObservableObject {
    let userId: String

    init(userId: String) {
        self.userId = userId
    }

    func validateName(_ name: String) -> Bool {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count >= 2 && trimmed.count <= 50 &&
               trimmed.range(of: "^[a-zA-Z ]+$", options: .regularExpression) != nil
    }

    func validateEmail(_ email: String) -> Bool {
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        return email.range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }

    func uploadProfilePhoto(_ image: UIImage, userId: String) async throws -> String {
        // Compress and upload to Firebase Storage
        guard let imageData = image.jpegData(compressionQuality: 0.7),
              imageData.count < 500_000 else { // Max 500KB
            throw NSError(domain: "", code: 413, userInfo: [
                NSLocalizedDescriptionKey: "Image too large. Please choose a smaller photo."
            ])
        }

        // Simulated upload
        try await Task.sleep(nanoseconds: 2_000_000_000)

        // Return URL
        return "https://storage.googleapis.com/urbannest/users/\(userId)/profile.jpg"

        // Real implementation:
        // let storageRef = Storage.storage().reference()
        // let profileRef = storageRef.child("users/\(userId)/profile.jpg")
        // let metadata = StorageMetadata()
        // metadata.contentType = "image/jpeg"
        // _ = try await profileRef.putDataAsync(imageData, metadata: metadata)
        // let url = try await profileRef.downloadURL()
        // return url.absoluteString
    }

    func saveProfile(
        userId: String,
        name: String,
        email: String?,
        photoURL: String?,
        phoneNumber: String
    ) async throws {
        // Save to Firestore
        let userData: [String: Any] = [
            "fullName": name.trimmingCharacters(in: .whitespacesAndNewlines),
            "email": email ?? "",
            "phoneNumber": phoneNumber,
            "profilePhotoURL": photoURL ?? "",
            "profileComplete": true,
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp()
        ]

        // Simulated save
        try await Task.sleep(nanoseconds: 1_500_000_000)

        // Real implementation:
        // try await Firestore.firestore()
        //     .collection("customers")
        //     .document(userId)
        //     .setData(userData, merge: true)
    }
}
```

---

## Assets Required

### SF Symbols
```
- chevron.left (Back button)
- arrow.right (Skip link)
- person.fill (Default profile icon)
- camera.fill (Camera badge)
- envelope.fill (Email info icon)
- xmark.circle.fill (Clear button)
- checkmark (Success indicator)
```

### Colors from Design System
```
- brandPrimary (#0D7377)
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
1. From OTP Verification: New user successfully verified
   └─ Transition: Slide in from right (300ms)
   └─ Data: { userId, phoneNumber }
```

### Exit Points
```
1. Complete Profile (Success):
   └─ Navigate to: Home Screen (06) with tab bar
   └─ Transition: Fade out + slide in (400ms)
   └─ Data: { userId, profile complete }

2. Skip Profile:
   └─ Navigate to: Home Screen (06)
   └─ Transition: Fade + slide (300ms)
   └─ Data: { userId, profile incomplete flag }

3. Tap Back:
   └─ Show confirmation (if data entered)
   └─ Navigate back to: OTP Verification
```

---

## Error Handling

### Photo Upload Failed
```
Scenario: Network error, file too large, or permission denied
Action:
├─ Stop spinner
├─ Remove photo from view (revert to empty)
├─ Toast: "Failed to upload photo. Try again."
├─ Allow retry
└─ User can proceed without photo
```

### Profile Save Failed
```
Scenario: Backend error, network timeout
Action:
├─ Stop loading
├─ Return button to enabled
├─ Toast: "Unable to save profile. Please try again."
├─ Keep form data (not lost)
└─ Allow immediate retry
```

---

## Testing Checklist

- [ ] Name input validates correctly (2+ chars, letters only)
- [ ] Email validation works (optional but format checked if filled)
- [ ] Profile photo picker opens (camera + library)
- [ ] Photo upload compresses to < 500KB
- [ ] Photo upload shows spinner
- [ ] Photo upload success displays photo
- [ ] Photo upload failure shows error
- [ ] Continue button disabled when name invalid
- [ ] Continue button enabled when name valid (email optional)
- [ ] Save profile creates user in backend
- [ ] Success navigates to Home screen
- [ ] Skip shows confirmation alert
- [ ] Skip navigates to Home (profile incomplete)
- [ ] Back button works (with confirmation if data entered)
- [ ] Dark mode looks correct
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
    "screen_name": "profile_setup"
])

// Photo added
Analytics.logEvent("profile_photo_added", parameters: [:])

// Profile saved
Analytics.logEvent("profile_setup_completed", parameters: [
    "has_email": !email.isEmpty,
    "has_photo": photoURL != nil
])

// Profile skipped
Analytics.logEvent("profile_setup_skipped", parameters: [:])
```

---

## Design Rationale

**Why this design:**

- **Optional email**: Reduces friction, phone is sufficient for auth
- **Profile photo optional**: Not required to use the app
- **Skip option**: Users can complete later if in hurry
- **Simple 2-field form**: Minimal cognitive load, fast completion
- **Info text for email**: Explains value proposition
- **Auto-focus name**: Reduces taps, faster input

**Alternatives Considered:**

- Required email: Higher drop-off rate
- More fields (DOB, gender, address): Too much upfront, collect when needed
- No skip option: Forces completion, may frustrate users
- Multi-step wizard: Overkill for 2 fields

---

**This profile setup screen completes the onboarding funnel. It should be fast, friendly, and flexible to maximize completion rates.**
