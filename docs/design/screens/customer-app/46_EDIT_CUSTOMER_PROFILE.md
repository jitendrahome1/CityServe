# Screen 46: Edit Customer Profile

## Overview

- **Screen ID**: 46
- **Screen Name**: Edit Customer Profile
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 21 (Profile Dashboard) → Tap "Edit Profile"
  - From: Settings → "Profile" section

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  ← Edit Profile                  Save   │ Header
├─────────────────────────────────────────┤
│                                         │
│              ┌───────┐                  │
│              │       │                  │ Profile Photo
│              │  👤   │                  │
│              │       │                  │
│              └───────┘                  │
│         [Change Photo]                  │
│                                         │
│  ───── Personal Information ─────       │
│                                         │
│  Full Name *                            │
│  ┌────────────────────────────────┐    │
│  │ John Smith                     │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  Email Address *                        │
│  ┌────────────────────────────────┐    │
│  │ john.smith@email.com           │    │
│  └────────────────────────────────┘    │
│  ✓ Verified                             │
│                                         │
│  Phone Number *                         │
│  ┌────────────────────────────────┐    │
│  │ +91 98765 43210                │    │
│  └────────────────────────────────┘    │
│  ✓ Verified                             │
│                                         │
│  Date of Birth                          │
│  ┌────────────────────────────────┐    │
│  │ January 15, 1990               │    │ Date Picker
│  └────────────────────────────────┘    │
│                                         │
│  Gender                                 │
│  ┌────────────────────────────────┐    │
│  │ Male                       ▼   │    │ Dropdown
│  └────────────────────────────────┘    │
│                                         │
│  ───── Additional Details ─────         │
│                                         │
│  Alternate Phone                        │
│  ┌────────────────────────────────┐    │
│  │ +91 12345 67890                │    │
│  └────────────────────────────────┘    │
│                                         │
│  Language Preference                    │
│  ┌────────────────────────────────┐    │
│  │ English (India)            ▼   │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Account Settings ─────           │
│                                         │
│  ☑ Send me promotional offers          │ Checkboxes
│  ☐ Share data for personalized         │
│     experience                          │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │     💳 Manage Payment Methods    │   │ Action Button
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │     📍 Manage Saved Addresses    │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ───── Danger Zone ─────                │
│                                         │
│  🔒 Change Password                 →   │
│  🗑️  Delete Account                 →   │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Profile Photo
- Current photo display (circular)
- "Change Photo" button
- Options:
  - Take Photo (camera)
  - Choose from Library
  - Remove Photo
- Image crop/resize interface
- Max size: 5MB
- Formats: JPG, PNG

### 2. Personal Information
- **Full Name**: Required, min 2 chars
- **Email**: Required, validated format, verification badge
- **Phone**: Required, verified badge
- **Date of Birth**: Optional, date picker
- **Gender**: Optional, dropdown (Male, Female, Other, Prefer not to say)

### 3. Email/Phone Verification
- Green checkmark if verified
- "Verify" button if unverified
- Resend verification option
- OTP flow for verification

### 4. Additional Details
- Alternate phone number (optional)
- Language preference (affects app language)
- Notification preferences

### 5. Quick Actions
- Navigate to Payment Methods (Screen 48)
- Navigate to Saved Addresses (Screen 47)

### 6. Account Settings
- Marketing preferences toggles
- Privacy opt-ins/outs

### 7. Danger Zone
- Change Password (secure flow)
- Delete Account (confirmation required)

### 8. Save Changes
- Save button in header
- Validation before save
- Loading state during save
- Success/error feedback

## Component Breakdown

```swift
struct EditCustomerProfileView: View {
    @StateObject private var viewModel = EditProfileViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var showImagePicker = false
    @State private var showDeleteConfirmation = false

    var body: some View {
        NavigationView {
            Form {
                // Profile Photo Section
                Section {
                    VStack(spacing: 12) {
                        // Profile Photo
                        ZStack(alignment: .bottomTrailing) {
                            if let image = viewModel.profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color("BackgroundSecondary"))
                                    .frame(width: 100, height: 100)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(Color("TextTertiary"))
                                    )
                            }

                            Button(action: { showImagePicker = true }) {
                                Image(systemName: "camera.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(Color("PrimaryTeal"))
                                    .background(Circle().fill(Color.white))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)

                        Button("Change Photo") {
                            showImagePicker = true
                        }
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("PrimaryTeal"))
                    }
                }

                // Personal Information
                Section(header: Text("Personal Information")) {
                    // Full Name
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Full Name *")
                            .font(.custom("Inter-Medium", size: 13))
                            .foregroundColor(Color("TextSecondary"))

                        TextField("Enter your full name", text: $viewModel.fullName)
                            .font(.custom("Inter-Regular", size: 15))
                            .textContentType(.name)
                    }

                    // Email Address
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Email Address *")
                                .font(.custom("Inter-Medium", size: 13))
                                .foregroundColor(Color("TextSecondary"))

                            Spacer()

                            if viewModel.isEmailVerified {
                                HStack(spacing: 4) {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color("SuccessGreen"))
                                    Text("Verified")
                                        .font(.custom("Inter-Medium", size: 11))
                                        .foregroundColor(Color("SuccessGreen"))
                                }
                            } else {
                                Button("Verify") {
                                    viewModel.sendEmailVerification()
                                }
                                .font(.custom("Inter-Medium", size: 12))
                                .foregroundColor(Color("SecondaryOrange"))
                            }
                        }

                        TextField("email@example.com", text: $viewModel.email)
                            .font(.custom("Inter-Regular", size: 15))
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }

                    // Phone Number
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Phone Number *")
                                .font(.custom("Inter-Medium", size: 13))
                                .foregroundColor(Color("TextSecondary"))

                            Spacer()

                            if viewModel.isPhoneVerified {
                                HStack(spacing: 4) {
                                    Image(systemName: "checkmark.seal.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color("SuccessGreen"))
                                    Text("Verified")
                                        .font(.custom("Inter-Medium", size: 11))
                                        .foregroundColor(Color("SuccessGreen"))
                                }
                            } else {
                                Button("Verify") {
                                    viewModel.sendPhoneVerification()
                                }
                                .font(.custom("Inter-Medium", size: 12))
                                .foregroundColor(Color("SecondaryOrange"))
                            }
                        }

                        TextField("+91 98765 43210", text: $viewModel.phone)
                            .font(.custom("Inter-Regular", size: 15))
                            .textContentType(.telephoneNumber)
                            .keyboardType(.phonePad)
                    }

                    // Date of Birth
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Date of Birth")
                            .font(.custom("Inter-Medium", size: 13))
                            .foregroundColor(Color("TextSecondary"))

                        DatePicker(
                            "",
                            selection: $viewModel.dateOfBirth,
                            in: ...Date(),
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    }

                    // Gender
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Gender")
                            .font(.custom("Inter-Medium", size: 13))
                            .foregroundColor(Color("TextSecondary"))

                        Picker("Gender", selection: $viewModel.gender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.displayName).tag(gender)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(Color("PrimaryTeal"))
                    }
                }

                // Additional Details
                Section(header: Text("Additional Details")) {
                    // Alternate Phone
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Alternate Phone")
                            .font(.custom("Inter-Medium", size: 13))
                            .foregroundColor(Color("TextSecondary"))

                        TextField("+91 12345 67890", text: $viewModel.alternatePhone)
                            .font(.custom("Inter-Regular", size: 15))
                            .textContentType(.telephoneNumber)
                            .keyboardType(.phonePad)
                    }

                    // Language Preference
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Language Preference")
                            .font(.custom("Inter-Medium", size: 13))
                            .foregroundColor(Color("TextSecondary"))

                        Picker("Language", selection: $viewModel.language) {
                            ForEach(Language.allCases, id: \.self) { lang in
                                Text(lang.displayName).tag(lang)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(Color("PrimaryTeal"))
                    }
                }

                // Account Settings
                Section(header: Text("Account Settings")) {
                    Toggle(isOn: $viewModel.receivePromotions) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Send me promotional offers")
                                .font(.custom("Inter-Regular", size: 15))

                            Text("Get exclusive deals and discounts")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("TextTertiary"))
                        }
                    }
                    .tint(Color("PrimaryTeal"))

                    Toggle(isOn: $viewModel.shareDataForPersonalization) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Share data for personalized experience")
                                .font(.custom("Inter-Regular", size: 15))

                            Text("Help us improve your recommendations")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("TextTertiary"))
                        }
                    }
                    .tint(Color("PrimaryTeal"))
                }

                // Quick Actions
                Section {
                    NavigationLink(destination: PaymentMethodsView()) {
                        HStack(spacing: 12) {
                            Image(systemName: "creditcard.fill")
                                .font(.system(size: 18))
                                .foregroundColor(Color("PrimaryTeal"))

                            Text("Manage Payment Methods")
                                .font(.custom("Inter-Regular", size: 15))
                        }
                    }

                    NavigationLink(destination: SavedAddressesView()) {
                        HStack(spacing: 12) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.system(size: 18))
                                .foregroundColor(Color("PrimaryTeal"))

                            Text("Manage Saved Addresses")
                                .font(.custom("Inter-Regular", size: 15))
                        }
                    }
                }

                // Danger Zone
                Section(header: Text("Danger Zone")) {
                    Button(action: { viewModel.changePassword() }) {
                        HStack(spacing: 12) {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 18))
                                .foregroundColor(Color("TextPrimary"))

                            Text("Change Password")
                                .font(.custom("Inter-Regular", size: 15))
                                .foregroundColor(Color("TextPrimary"))

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(Color("TextTertiary"))
                        }
                    }

                    Button(action: { showDeleteConfirmation = true }) {
                        HStack(spacing: 12) {
                            Image(systemName: "trash.fill")
                                .font(.system(size: 18))
                                .foregroundColor(Color("ErrorRed"))

                            Text("Delete Account")
                                .font(.custom("Inter-Regular", size: 15))
                                .foregroundColor(Color("ErrorRed"))

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(Color("ErrorRed"))
                        }
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.saveProfile()
                    }
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(viewModel.hasChanges ? Color("PrimaryTeal") : Color("TextTertiary"))
                    .disabled(!viewModel.hasChanges || viewModel.isSaving)
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $viewModel.profileImage, maxSelection: 1)
        }
        .alert("Delete Account", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteAccount()
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
        .alert("Profile Updated", isPresented: $viewModel.showSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your profile has been updated successfully.")
        }
    }
}

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
    case preferNotToSay = "Prefer not to say"

    var displayName: String { rawValue }
}

enum Language: String, CaseIterable {
    case englishIndia = "English (India)"
    case hindi = "हिन्दी (Hindi)"
    case bengali = "বাংলা (Bengali)"
    case tamil = "தமிழ் (Tamil)"
    case telugu = "తెలుగు (Telugu)"
    case marathi = "मराठी (Marathi)"

    var displayName: String { rawValue }
}
```

## Interactions

### Profile Photo
1. **Tap Change Photo**: Shows action sheet
   - "Take Photo" → Opens camera
   - "Choose from Library" → Opens photo picker
   - "Remove Photo" → Deletes current photo
   - "Cancel"
2. **Select Photo**: Shows crop interface
3. **Crop & Confirm**: Updates preview

### Form Editing
1. **Edit Field**: Tap to focus, keyboard appears
2. **Validation**: Real-time as user types
3. **Unsaved Changes**: "Cancel" shows confirmation dialog

### Verification
1. **Tap Verify Email**: Sends verification email, shows success toast
2. **Tap Verify Phone**: Opens OTP screen
3. **Enter OTP**: Verifies and updates badge

### Save Changes
1. **Tap Save**: Validates all fields
2. **If Valid**: Shows loading, saves to API
3. **Success**: Shows success alert, dismisses screen
4. **Error**: Shows error alert with retry option

## States

### Default State
- Form populated with current user data
- Save button disabled (no changes)
- Verified badges shown

### Editing State
```swift
viewModel.hasChanges = true
// Save button enabled
// Cancel shows confirmation
```

### Saving State
```swift
viewModel.isSaving = true
// Save button shows spinner
// Form fields disabled
```

### Validation Error
```swift
if !viewModel.isEmailValid {
    // Show red border on email field
    // Show error message below field
}
```

## API Integration

### Get Profile
```
GET /customers/{customerId}/profile

Response:
{
  "success": true,
  "data": {
    "id": "cust_123",
    "fullName": "John Smith",
    "email": "john@email.com",
    "isEmailVerified": true,
    "phone": "+919876543210",
    "isPhoneVerified": true,
    "photoURL": "https://storage.../profile.jpg",
    "dateOfBirth": "1990-01-15",
    "gender": "male",
    "alternatePhone": "+911234567890",
    "language": "english_india",
    "receivePromotions": true,
    "shareDataForPersonalization": false
  }
}
```

### Update Profile
```
PUT /customers/{customerId}/profile

Request (multipart/form-data):
{
  "fullName": "John Smith",
  "email": "john@email.com",
  "phone": "+919876543210",
  "dateOfBirth": "1990-01-15",
  "gender": "male",
  "alternatePhone": "+911234567890",
  "language": "english_india",
  "receivePromotions": true,
  "shareDataForPersonalization": false,
  "profilePhoto": File // if changed
}

Response:
{
  "success": true,
  "data": {
    "profileURL": "https://storage.../profile_new.jpg"
  },
  "message": "Profile updated successfully"
}
```

### Send Email Verification
```
POST /customers/{customerId}/verify-email

Response:
{
  "success": true,
  "message": "Verification email sent"
}
```

### Delete Account
```
DELETE /customers/{customerId}/account

Request:
{
  "password": "current_password",
  "reason": "optional_reason"
}

Response:
{
  "success": true,
  "message": "Account deleted successfully"
}
```

## Navigation

### Entry Points
- **From Screen 21** (Profile Dashboard): Tap "Edit Profile"
- **From Settings**: Profile section

### Exit Points
- **Cancel**: Dismiss with confirmation if changes
- **Save Success**: Auto-dismiss, return to profile
- **Manage Payments**: Navigate to Screen 48
- **Manage Addresses**: Navigate to Screen 47

## Accessibility

### VoiceOver
```swift
.accessibilityLabel("Profile photo")
.accessibilityHint("Double tap to change photo")

.accessibilityLabel("Email verified")
.accessibilityValue(viewModel.email)
```

### Touch Targets
- All buttons: 44x44pt minimum
- Form fields: 44pt height
- Profile photo: 100x100pt (sufficient)

## Analytics Events

### Screen View
```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "edit_profile"
])
```

### Profile Updated
```swift
Analytics.logEvent("profile_updated", parameters: [
    "fields_changed": changedFields,
    "photo_changed": photoChanged
])
```

### Account Deleted
```swift
Analytics.logEvent("account_deleted", parameters: [
    "reason": deletionReason
])
```

## Testing Checklist

- [ ] Profile data loads correctly
- [ ] Photo picker opens
- [ ] Photo crop/resize works
- [ ] Remove photo works
- [ ] All fields editable
- [ ] Email validation works
- [ ] Phone validation works
- [ ] Send verification email works
- [ ] Send verification SMS works
- [ ] Save button enabled on changes
- [ ] Save button disabled when no changes
- [ ] Cancel shows confirmation if dirty
- [ ] Save validates all fields
- [ ] Save updates profile
- [ ] Success alert shows
- [ ] Error handling works
- [ ] Delete account confirmation works
- [ ] Change password navigates
- [ ] VoiceOver announces fields
- [ ] Keyboard dismisses correctly

## Design Notes

### Validation Rules
- **Full Name**: Min 2 chars, max 50 chars
- **Email**: Valid email format, unique
- **Phone**: Valid phone format (E.164), unique
- **Date of Birth**: Must be 18+ years old
- **Photo**: Max 5MB, JPG/PNG only

### Edge Cases
- Handle photo upload failure
- Handle email already taken
- Handle phone already taken
- Handle network errors gracefully

### Future Enhancements
- Social login connections (Google, Facebook)
- Two-factor authentication setup
- Activity log (login history)
- Export user data (GDPR compliance)

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
