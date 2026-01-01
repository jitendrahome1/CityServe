# Screen 44: Edit Provider Profile

## Overview

- **Screen ID**: 44
- **Screen Name**: Edit Provider Profile
- **User Role**: Provider
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 23 (Provider Dashboard) → Tap profile photo/name
  - From: Screen 48 (Provider App Settings) → Tap "Edit Profile"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ✕  Edit Profile                  ✓     │ Header (Modal)
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │                                 │   │ Profile Photo
│  │         📷                       │   │ Upload Section
│  │    [Upload Photo]               │   │
│  │                                 │   │
│  │    JPG/PNG, max 5MB             │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Personal Information                   │
│                                         │
│  Full Name *                            │
│  ┌────────────────────────────────┐    │
│  │ John Doe                        │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  Phone Number                           │
│  ┌────────────────────────────────┐    │
│  │ +91 98765 43210  🔒 Verified   │    │ Read-only (verified)
│  └────────────────────────────────┘    │
│  ⓘ Contact support to change           │
│                                         │
│  Email Address                          │
│  ┌────────────────────────────────┐    │
│  │ john.doe@example.com            │    │ Text Input
│  └────────────────────────────────┘    │
│  ☐ Make email visible to customers      │ Checkbox
│                                         │
│  Date of Birth                          │
│  ┌────────────────────────────────┐    │
│  │ 15 Jan 1990              📅     │    │ Date Picker
│  └────────────────────────────────┘    │
│                                         │
│  Gender                                 │
│  ┌────────────────────────────────┐    │
│  │ Male ▼                          │    │ Dropdown
│  └────────────────────────────────┘    │
│                                         │
│  ─────────────────────────────────      │
│                                         │
│  Professional Information               │
│                                         │
│  Bio / About Me                         │
│  ┌────────────────────────────────┐    │
│  │ Experienced electrician with    │    │ Text Area
│  │ 10+ years in residential and    │    │
│  │ commercial services...          │    │
│  │                                 │    │
│  └────────────────────────────────┘    │
│  50 / 250 characters                    │
│                                         │
│  Years of Experience *                  │
│  ┌────────────────────────────────┐    │
│  │ 10 ▼                            │    │ Dropdown (1-50)
│  └────────────────────────────────┘    │
│                                         │
│  Languages Spoken                       │
│  ┌────────────────────────────────┐    │
│  │ [English ✕] [Hindi ✕]           │    │ Tag Input
│  │ + Add Language                  │    │
│  └────────────────────────────────┘    │
│                                         │
│  Certifications                         │
│  ┌────────────────────────────────┐    │
│  │ Certified Electrician (IEE)     │    │ Tag Input
│  │ + Add Certification             │    │
│  └────────────────────────────────┘    │
│                                         │
│  ─────────────────────────────────      │
│                                         │
│  Work Address                           │
│                                         │
│  Street Address                         │
│  ┌────────────────────────────────┐    │
│  │ 123 Main Street, Apartment 4B   │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  City                                   │
│  ┌────────────────────────────────┐    │
│  │ Delhi ▼                         │    │ Dropdown
│  └────────────────────────────────┘    │
│                                         │
│  Pincode                                │
│  ┌────────────────────────────────┐    │
│  │ 110001                          │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  ☐ Use this as default service area     │ Checkbox
│                                         │
│  ─────────────────────────────────      │
│                                         │
│  Emergency Contact (Optional)           │
│                                         │
│  Contact Name                           │
│  ┌────────────────────────────────┐    │
│  │ Jane Doe                        │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  Contact Phone                          │
│  ┌────────────────────────────────┐    │
│  │ +91 98765 12345                 │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  Relationship                           │
│  ┌────────────────────────────────┐    │
│  │ Spouse ▼                        │    │ Dropdown
│  └────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Save Changes                │   │ Primary CTA
│  └─────────────────────────────────┘   │
│                                         │
│  [Delete Account]                       │ Destructive Link
│                                         │
└─────────────────────────────────────────┘

PHOTO UPLOAD MODAL:

┌─────────────────────────────────────────┐
│         Upload Profile Photo        ✕   │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │                                 │   │ Photo Preview
│  │         [Photo Preview]         │   │ (if selected)
│  │                                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  📷  Take Photo                  │   │ Option Button
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  🖼️  Choose from Gallery         │   │ Option Button
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  🗑️  Remove Current Photo        │   │ Delete Button
│  └─────────────────────────────────┘   │
│                                         │
│  Requirements:                          │
│  • JPG or PNG format                    │
│  • Maximum file size: 5MB               │
│  • Minimum resolution: 400x400px        │
│  • Square photos work best              │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Upload Photo                │   │ Primary Button
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘

DELETE ACCOUNT CONFIRMATION:

┌─────────────────────────────────────────┐
│         Delete Account              ✕   │
├─────────────────────────────────────────┤
│                                         │
│  ⚠️  Warning: This action cannot be     │
│      undone                             │
│                                         │
│  Deleting your account will:            │
│                                         │
│  • Permanently remove your profile      │
│  • Cancel all active bookings           │
│  • Remove you from job recommendations  │
│  • Forfeit any pending payouts          │
│  • Delete all your reviews and ratings  │
│                                         │
│  If you have concerns, please contact   │
│  our support team instead.              │
│                                         │
│  To confirm deletion, type: DELETE      │
│                                         │
│  ┌────────────────────────────────┐    │
│  │                                 │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   Yes, Delete My Account         │   │ Destructive Button
│  └─────────────────────────────────┘   │
│                                         │
│  [Cancel]                               │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Profile Photo Upload
- Upload from camera or gallery
- Square crop for consistency
- Max file size: 5MB
- Format: JPG or PNG
- Remove current photo option
- Auto-compression on upload

### 2. Personal Information
- **Full Name**: Text input, required
- **Phone Number**: Read-only (verified during registration)
- **Email**: Text input, optional visibility toggle
- **Date of Birth**: Date picker
- **Gender**: Dropdown (Male, Female, Other, Prefer not to say)

### 3. Professional Information
- **Bio/About Me**: Text area (max 250 chars)
- **Years of Experience**: Dropdown (1-50 years)
- **Languages Spoken**: Multi-select tag input
- **Certifications**: Tag input with add/remove

### 4. Work Address
- **Street Address**: Text input
- **City**: Dropdown (from available cities)
- **Pincode**: Text input with validation
- **Default Service Area**: Checkbox option

### 5. Emergency Contact
- Optional but recommended
- Contact name, phone, relationship
- Used for safety and emergencies

### 6. Save & Validation
- Real-time field validation
- Required fields marked with *
- Save button enabled only when valid
- Success confirmation on save

### 7. Delete Account
- Destructive action at bottom
- Requires confirmation with typed "DELETE"
- Warns about consequences
- Cannot be undone

## Component Breakdown

### 1. Header (Navigation Bar)
```swift
struct EditProfileHeader: View {
    @Environment(\.dismiss) var dismiss
    let onSave: () -> Void
    let isSaveEnabled: Bool
    @Binding var isSaving: Bool

    var body: some View {
        HStack {
            // Cancel Button
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }

            Spacer()

            Text("Edit Profile")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(Color("TextPrimary"))

            Spacer()

            // Save Button
            Button(action: onSave) {
                if isSaving {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("PrimaryTeal")))
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(isSaveEnabled ? Color("PrimaryTeal") : Color("DisabledGray"))
                }
            }
            .disabled(!isSaveEnabled || isSaving)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
```

### 2. Profile Photo Section
```swift
struct ProfilePhotoSection: View {
    @Binding var profileImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        VStack(spacing: 12) {
            // Photo Display
            ZStack(alignment: .bottomTrailing) {
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color("BackgroundSecondary"))
                        .frame(width: 120, height: 120)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 48))
                                .foregroundColor(Color("TextTertiary"))
                        )
                }

                // Camera Icon Button
                Button(action: { showingImagePicker = true }) {
                    Circle()
                        .fill(Color("PrimaryTeal"))
                        .frame(width: 36, height: 36)
                        .overlay(
                            Image(systemName: "camera.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        )
                }
                .offset(x: -4, y: -4)
            }

            Button(action: { showingImagePicker = true }) {
                Text("Upload Photo")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color("PrimaryTeal"))
            }

            Text("JPG/PNG, max 5MB")
                .font(.custom("Inter-Regular", size: 11))
                .foregroundColor(Color("TextTertiary"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .sheet(isPresented: $showingImagePicker) {
            ImagePickerView(image: $profileImage)
        }
    }
}
```

### 3. Form Input Field
```swift
struct FormInputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    var isReadOnly: Bool = false
    var keyboardType: UIKeyboardType = .default
    var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Text(label)
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(Color("TextPrimary"))

                if isRequired {
                    Text("*")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("ErrorRed"))
                }
            }

            TextField(placeholder, text: $text)
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(isReadOnly ? Color("TextTertiary") : Color("TextPrimary"))
                .padding(12)
                .background(isReadOnly ? Color("DisabledGray").opacity(0.1) : Color("BackgroundSecondary"))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(errorMessage != nil ? Color("ErrorRed") : Color("BorderLight"), lineWidth: 1)
                )
                .disabled(isReadOnly)
                .keyboardType(keyboardType)

            if let error = errorMessage {
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color("ErrorRed"))

                    Text(error)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("ErrorRed"))
                }
            }
        }
    }
}
```

### 4. Form Text Area
```swift
struct FormTextArea: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    let maxCharacters: Int
    var isRequired: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Text(label)
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(Color("TextPrimary"))

                if isRequired {
                    Text("*")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("ErrorRed"))
                }
            }

            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.custom("Inter-Regular", size: 16))
                        .foregroundColor(Color("TextTertiary"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                }

                TextEditor(text: $text)
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(Color("TextPrimary"))
                    .frame(minHeight: 80)
                    .padding(8)
                    .onChange(of: text) { newValue in
                        if newValue.count > maxCharacters {
                            text = String(newValue.prefix(maxCharacters))
                        }
                    }
            }
            .background(Color("BackgroundSecondary"))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("BorderLight"), lineWidth: 1)
            )

            HStack {
                Spacer()
                Text("\(text.count) / \(maxCharacters) characters")
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(text.count >= maxCharacters ? Color("ErrorRed") : Color("TextTertiary"))
            }
        }
    }
}
```

### 5. Tag Input Field
```swift
struct TagInputField: View {
    let label: String
    @Binding var tags: [String]
    let placeholder: String = "Add..."
    @State private var inputText = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.custom("Inter-Medium", size: 14))
                .foregroundColor(Color("TextPrimary"))

            VStack(alignment: .leading, spacing: 10) {
                // Display existing tags
                if !tags.isEmpty {
                    FlowLayout(spacing: 8) {
                        ForEach(tags, id: \.self) { tag in
                            HStack(spacing: 6) {
                                Text(tag)
                                    .font(.custom("Inter-Medium", size: 14))
                                    .foregroundColor(Color("PrimaryTeal"))

                                Button(action: { removeTag(tag) }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("TextTertiary"))
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color("PrimaryTeal").opacity(0.1))
                            .cornerRadius(16)
                        }
                    }
                }

                // Add new tag button
                Button(action: { /* Show dropdown or input */ }) {
                    HStack(spacing: 6) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 14))
                            .foregroundColor(Color("PrimaryTeal"))

                        Text("Add \(label)")
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(Color("PrimaryTeal"))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color("BackgroundSecondary"))
                    .cornerRadius(20)
                }
            }
            .padding(12)
            .background(Color("BackgroundSecondary"))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("BorderLight"), lineWidth: 1)
            )
        }
    }

    func removeTag(_ tag: String) {
        tags.removeAll { $0 == tag }
    }
}
```

### 6. Delete Account Button
```swift
struct DeleteAccountButton: View {
    @Binding var showingDeleteConfirmation: Bool

    var body: some View {
        Button(action: { showingDeleteConfirmation = true }) {
            Text("Delete Account")
                .font(.custom("Inter-SemiBold", size: 15))
                .foregroundColor(Color("ErrorRed"))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color("ErrorRed").opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("ErrorRed"), lineWidth: 1)
                )
        }
        .padding(.top, 24)
    }
}
```

## Interactions

### 1. Upload Profile Photo
- **Trigger**: Tap camera icon or "Upload Photo" button
- **Action**: Show image picker modal
- **Options**:
  - Take Photo (opens camera)
  - Choose from Gallery (opens photo library)
  - Remove Current Photo (if photo exists)
- **Visual**: Modal slides up
- **Haptic**: Medium impact
- **Validation**: Max 5MB, JPG/PNG only, min 400x400px
- **Processing**: Auto-crop to square, compress if > 1MB

### 2. Edit Text Fields
- **Trigger**: Tap text input field
- **Action**: Show keyboard, focus field
- **Visual**: Border highlights in teal
- **Haptic**: None
- **Validation**: Real-time for required fields

### 3. Select Date of Birth
- **Trigger**: Tap date field
- **Action**: Show date picker (wheel or calendar style)
- **Visual**: Native iOS date picker
- **Haptic**: Light impact
- **Validation**: Must be 18+ years old

### 4. Select Gender/Dropdown
- **Trigger**: Tap dropdown field
- **Action**: Show options menu
- **Visual**: Bottom sheet or dropdown menu
- **Haptic**: Light impact

### 5. Add Language/Certification
- **Trigger**: Tap "+ Add Language" button
- **Action**: Show selection list or input field
- **Visual**: Dropdown or modal
- **Haptic**: Light impact
- **Result**: Add tag to list

### 6. Remove Tag
- **Trigger**: Tap X icon on tag
- **Action**: Remove tag from list
- **Visual**: Fade-out animation
- **Haptic**: Light impact

### 7. Save Changes
- **Trigger**: Tap save (✓) button in header
- **Action**:
  1. Validate all fields
  2. Show loading spinner
  3. Upload photo (if changed)
  4. Update profile via API
  5. Show success message
  6. Dismiss modal
- **Visual**: Button shows spinner while saving
- **Haptic**: Success (on completion)
- **Error**: Show error message, stay on screen

### 8. Cancel/Discard Changes
- **Trigger**: Tap cancel (✕) button in header
- **Action**:
  - If no changes: Dismiss immediately
  - If changes: Show discard confirmation alert
- **Visual**: Alert dialog
- **Haptic**: Warning (for discard)

### 9. Delete Account
- **Trigger**: Tap "Delete Account" button
- **Action**: Show delete confirmation modal
- **Visual**: Destructive alert modal
- **Haptic**: Warning (heavy impact)
- **Steps**:
  1. Show warnings about consequences
  2. Require typing "DELETE" to confirm
  3. Verify match
  4. Final confirmation
  5. Delete account via API
  6. Logout and navigate to splash screen

## States

### 1. Default State (View Mode)
- All fields populated with current data
- Profile photo displayed
- Save button enabled if form valid

### 2. Loading State (Initial)
- Skeleton shimmer for fields
- Profile photo placeholder

### 3. Editing State
- Active field highlighted
- Keyboard visible
- Character count updates in real-time

### 4. Validation Error State
- Invalid fields show red border
- Error message below field
- Save button disabled

### 5. Saving State
- Save button shows spinner
- All inputs disabled
- Cannot dismiss modal

### 6. Success State
- Success toast: "Profile updated successfully!"
- Modal dismisses automatically
- Return to previous screen

### 7. Error State
- Error banner at top: "Failed to update profile. Please try again."
- Save button re-enabled
- Retry option

### 8. Photo Upload State
- Loading spinner overlay on photo
- Progress indicator (if large file)

## API Integration

### 1. Get Provider Profile
```
GET /providers/{providerId}/profile

Headers:
- Authorization: Bearer {firebase_id_token}

Response:
{
  "success": true,
  "data": {
    "profile": {
      "id": "prov_abc123",
      "fullName": "John Doe",
      "phoneNumber": "+919876543210",
      "email": "john.doe@example.com",
      "emailVisible": false,
      "dateOfBirth": "1990-01-15",
      "gender": "male",
      "profilePhotoUrl": "https://...",
      "bio": "Experienced electrician with 10+ years...",
      "yearsOfExperience": 10,
      "languagesSpoken": ["English", "Hindi"],
      "certifications": ["Certified Electrician (IEE)"],
      "workAddress": {
        "street": "123 Main Street, Apartment 4B",
        "city": "Delhi",
        "pincode": "110001",
        "isDefaultServiceArea": true
      },
      "emergencyContact": {
        "name": "Jane Doe",
        "phone": "+919876512345",
        "relationship": "spouse"
      }
    }
  }
}
```

### 2. Update Provider Profile
```
PUT /providers/{providerId}/profile

Headers:
- Authorization: Bearer {firebase_id_token}
- Content-Type: application/json

Request:
{
  "fullName": "John Doe",
  "email": "john.doe@example.com",
  "emailVisible": false,
  "dateOfBirth": "1990-01-15",
  "gender": "male",
  "bio": "Experienced electrician with 10+ years...",
  "yearsOfExperience": 10,
  "languagesSpoken": ["English", "Hindi", "Punjabi"],
  "certifications": ["Certified Electrician (IEE)", "Safety Training"],
  "workAddress": {
    "street": "123 Main Street, Apartment 4B",
    "city": "Delhi",
    "pincode": "110001",
    "isDefaultServiceArea": true
  },
  "emergencyContact": {
    "name": "Jane Doe",
    "phone": "+919876512345",
    "relationship": "spouse"
  }
}

Response:
{
  "success": true,
  "data": {
    "profile": { /* updated profile */ }
  },
  "message": "Profile updated successfully"
}
```

### 3. Upload Profile Photo
```
POST /providers/{providerId}/profile/photo

Headers:
- Authorization: Bearer {firebase_id_token}
- Content-Type: multipart/form-data

Request:
- photo: File (JPG/PNG, max 5MB)

Response:
{
  "success": true,
  "data": {
    "photoUrl": "https://storage.googleapis.com/..."
  },
  "message": "Profile photo uploaded successfully"
}
```

### 4. Delete Account
```
DELETE /providers/{providerId}/account

Headers:
- Authorization: Bearer {firebase_id_token}
- Content-Type: application/json

Request:
{
  "confirmation": "DELETE",
  "reason": "No longer providing services" // optional
}

Response:
{
  "success": true,
  "message": "Account deleted successfully"
}
```

## Navigation

### Entry Points
1. **From Screen 23** (Provider Dashboard):
   - Tap profile photo/name → Navigate to Edit Profile

2. **From Screen 48** (Provider App Settings):
   - Tap "Edit Profile" menu item → Navigate to Edit Profile

### Exit Points
1. **Cancel Button**: Dismiss modal, return to previous screen
2. **Save Success**: Auto-dismiss modal, return to previous screen with updated data
3. **Delete Account**: Logout, navigate to Splash Screen (Screen 01)

### Modal Presentation
- Presented as full-screen modal
- Slide-up animation
- Cannot dismiss by swiping down (prevent accidental data loss)
- Must tap Cancel or Save

## Accessibility

### VoiceOver Labels
- "Cancel editing" (cancel button)
- "Save profile changes" (save button)
- "Profile photo, double-tap to change"
- "Full name text field, required"
- "Phone number, verified, cannot be edited"
- "Bio text area, 50 of 250 characters"
- "Languages: English, Hindi, double-tap to edit"
- "Add language button"
- "Remove English tag button"
- "Delete account button, warning: this action cannot be undone"

### Dynamic Type
- All text scales with system font size
- Input fields expand vertically for larger text
- Minimum touch targets: 44x44pt

### Color Contrast
- All text meets WCAG AA (4.5:1)
- Error messages: Red text on white background
- Form labels: Dark text on white

### Keyboard Navigation (Web)
- Tab through all input fields
- Enter to submit form (save)
- Escape to cancel

## Analytics Events

### Track Screen View
```javascript
analytics.logEvent('screen_view', {
  screen_name: 'edit_provider_profile',
  screen_class: 'EditProviderProfileView',
  user_role: 'provider'
});
```

### Track Profile Photo Upload
```javascript
analytics.logEvent('provider_photo_uploaded', {
  photo_size_kb: 1250,
  upload_source: 'gallery' // or 'camera'
});
```

### Track Profile Update
```javascript
analytics.logEvent('provider_profile_updated', {
  fields_changed: ['bio', 'languages', 'certifications'],
  update_duration_seconds: 45
});
```

### Track Account Deletion
```javascript
analytics.logEvent('provider_account_deleted', {
  account_age_days: 180,
  total_jobs_completed: 156,
  reason: 'user_initiated'
});
```

## Testing Checklist

### Functional Tests
- [ ] Load existing profile data correctly
- [ ] Upload profile photo (camera)
- [ ] Upload profile photo (gallery)
- [ ] Remove profile photo
- [ ] Edit full name
- [ ] Edit email
- [ ] Toggle email visibility
- [ ] Select date of birth
- [ ] Select gender
- [ ] Edit bio (with character limit)
- [ ] Select years of experience
- [ ] Add/remove languages
- [ ] Add/remove certifications
- [ ] Edit work address
- [ ] Select city (dropdown)
- [ ] Edit emergency contact
- [ ] Save changes successfully
- [ ] Cancel with unsaved changes (confirmation)
- [ ] Delete account (full flow)

### Validation Tests
- [ ] Required fields cannot be empty
- [ ] Email format validation
- [ ] Phone number format (read-only but validate display)
- [ ] Date of birth (must be 18+)
- [ ] Bio character limit (250)
- [ ] Pincode format (6 digits)
- [ ] Photo max file size (5MB)
- [ ] Photo format (JPG/PNG only)
- [ ] Photo minimum resolution (400x400px)

### UI/UX Tests
- [ ] Profile photo displays correctly
- [ ] Form fields scroll smoothly
- [ ] Keyboard doesn't obscure active field
- [ ] Character count updates in real-time
- [ ] Tags display and wrap properly
- [ ] Dropdowns show all options
- [ ] Save button enables/disables correctly
- [ ] Success toast appears after save
- [ ] Error banner displays on failure

### Edge Cases
- [ ] Very long name (truncate if needed)
- [ ] Very long bio (enforce 250 limit)
- [ ] Many languages/certifications (scroll/wrap)
- [ ] Upload photo > 5MB (show error)
- [ ] Upload non-image file (show error)
- [ ] Network error during save
- [ ] Network error during photo upload
- [ ] Unsaved changes on cancel
- [ ] Delete account with pending payouts (warn)
- [ ] Delete account with active bookings (prevent)

### Accessibility Tests
- [ ] VoiceOver announces all elements
- [ ] Dynamic Type scales correctly
- [ ] Touch targets minimum 44pt
- [ ] Color contrast meets WCAG AA
- [ ] Keyboard navigation works (web)

### Performance Tests
- [ ] Profile loads within 1 second
- [ ] Photo upload completes within 5 seconds
- [ ] Save operation completes within 2 seconds
- [ ] No memory leaks
- [ ] Smooth scrolling with keyboard open

## Design Notes

### Photo Guidelines
- Encourage professional, clear photos
- Tips: Good lighting, smile, facing camera, no sunglasses
- Auto-crop to 1:1 aspect ratio
- Compress to max 200KB for storage
- Generate thumbnail (100x100px) for listings

### Required vs Optional Fields
**Required**:
- Full Name
- Years of Experience

**Optional but Recommended**:
- Email
- Bio
- Languages
- Certifications
- Emergency Contact

**Cannot Edit**:
- Phone Number (verified, contact support to change)

### Delete Account Restrictions
- Cannot delete if:
  - Active bookings exist
  - Pending payouts > ₹0
  - Under investigation for violations
- Must type "DELETE" exactly (case-sensitive)
- Final confirmation required
- Account soft-deleted (can be restored by admin within 30 days)

### Data Privacy
- Email visibility toggle lets providers control if customers see their email
- Phone number always visible to assigned customers only
- Emergency contact never visible to customers (admin only)
- Profile photo visible to all users

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
