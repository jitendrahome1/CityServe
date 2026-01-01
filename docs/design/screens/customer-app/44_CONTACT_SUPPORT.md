# Screen 44: Contact Support

## Overview

- **Screen ID**: 44
- **Screen Name**: Contact Support
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 43 (Help Center) → Tap "Contact Support"
  - From: Screen 21 (Profile Dashboard) → Tap "Contact Support"
  - From: Any screen → "Report Issue" button

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  ← Contact Support                      │ Header
├─────────────────────────────────────────┤
│                                         │
│  We're here to help!                    │ Heading
│  Tell us what's going on                │ Subheading
│                                         │
│  ───── Issue Type ─────                 │
│                                         │
│  Select Issue Category *                │
│  ┌────────────────────────────────┐    │
│  │ Booking Issue              ▼   │    │ Dropdown
│  └────────────────────────────────┘    │
│                                         │
│  Common issues:                         │
│  • Booking not confirmed                │ Quick Select
│  • Provider not arrived                 │
│  • Service quality issue                │
│  • Payment problem                      │
│                                         │
│  ───── Order Details ─────              │
│                                         │
│  Related to a Booking?                  │
│  ○ Yes  ● No                            │ Radio
│                                         │
│  Select Booking (Optional)              │
│  ┌────────────────────────────────┐    │
│  │ #BKG123 - Electrician - Dec 30 │    │ Booking Card
│  │ Provider: John Doe             │    │
│  │ [Select]                       │    │
│  └────────────────────────────────┘    │
│                                         │
│  ───── Your Message ─────               │
│                                         │
│  Subject *                              │
│  ┌────────────────────────────────┐    │
│  │ Enter subject                  │    │ Text Input
│  └────────────────────────────────┘    │
│                                         │
│  Description *                          │
│  ┌────────────────────────────────┐    │
│  │ Describe your issue in detail  │    │ Text Area
│  │                                 │    │ (500 chars)
│  │                                 │    │
│  │                                 │    │
│  │ 0/500                           │    │ Char Counter
│  └────────────────────────────────┘    │
│                                         │
│  ───── Attachments ─────                │
│                                         │
│  Add Photos/Screenshots (Optional)      │
│  ┌────┬────┬────┬────┐                 │
│  │📷  │📷  │📷  │ +  │                 │ Upload Grid
│  └────┴────┴────┴────┘                 │
│  Max 5 files, 10MB each                 │
│                                         │
│  ───── Contact Preference ─────         │
│                                         │
│  How should we reach you?               │
│  ☑ Email (user@example.com)            │ Checkboxes
│  ☑ Phone (+91 98765 43210)             │
│  ☐ In-App Notification                 │
│                                         │
│  Priority                               │
│  ○ Low    ● Normal    ○ High            │ Radio
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Submit Ticket               │   │ CTA Button
│  └─────────────────────────────────┘   │
│                                         │
│  💡 Expected response time: 2-4 hours   │ Info
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Issue Category Selection
- Dropdown with predefined categories:
  - Booking Issue
  - Payment Problem
  - Account & Profile
  - Service Quality
  - Refund Request
  - App Bug/Technical Issue
  - Safety Concern
  - Other
- Quick select common issues for selected category

### 2. Booking Association
- Toggle to link issue to specific booking
- Recent bookings list (last 10)
- Auto-populate booking details
- Optional field

### 3. Message Form
- **Subject**: Single-line input (max 100 chars)
- **Description**: Multi-line text area (500 chars)
- Character counter
- Real-time validation
- Required fields marked with *

### 4. Attachments
- Photo/screenshot upload
- Max 5 files, 10MB each
- Preview thumbnails
- Remove individual files
- Supported formats: JPG, PNG, PDF

### 5. Contact Preference
- Email (default, pre-filled)
- Phone (from profile)
- In-app notification
- Multiple selections allowed

### 6. Priority Selection
- Low: General inquiry
- Normal: Standard issue (default)
- High: Urgent problem (requires justification)

### 7. Submit & Confirmation
- Validation before submit
- Loading state during submission
- Success confirmation
- Ticket ID generation

## Component Breakdown

```swift
struct ContactSupportView: View {
    @StateObject private var viewModel = ContactSupportViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var selectedCategory: IssueCategory = .bookingIssue
    @State private var relatedToBooking = false
    @State private var selectedBooking: Booking?
    @State private var subject = ""
    @State private var description = ""
    @State private var attachments: [UIImage] = []
    @State private var contactByEmail = true
    @State private var contactByPhone = true
    @State private var contactByNotification = false
    @State private var priority: Priority = .normal
    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("We're here to help!")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("TextPrimary"))

                        Text("Tell us what's going on")
                            .font(.custom("Inter-Regular", size: 15))
                            .foregroundColor(Color("TextSecondary"))
                    }
                    .padding(.horizontal, 16)

                    // Issue Type Section
                    FormSection(title: "Issue Type") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Select Issue Category *")
                                .font(.custom("Inter-Medium", size: 14))
                                .foregroundColor(Color("TextSecondary"))

                            Picker("Category", selection: $selectedCategory) {
                                ForEach(IssueCategory.allCases, id: \.self) { category in
                                    Text(category.displayName).tag(category)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(Color("PrimaryTeal"))
                            .padding(14)
                            .background(Color("BackgroundSecondary"))
                            .cornerRadius(8)

                            // Common Issues for Selected Category
                            if !selectedCategory.commonIssues.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Common issues:")
                                        .font(.custom("Inter-Medium", size: 13))
                                        .foregroundColor(Color("TextSecondary"))

                                    ForEach(selectedCategory.commonIssues, id: \.self) { issue in
                                        Button(action: {
                                            subject = issue
                                        }) {
                                            HStack(spacing: 8) {
                                                Image(systemName: "circle.fill")
                                                    .font(.system(size: 4))
                                                    .foregroundColor(Color("TextTertiary"))

                                                Text(issue)
                                                    .font(.custom("Inter-Regular", size: 14))
                                                    .foregroundColor(Color("PrimaryTeal"))

                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                .padding(.top, 4)
                            }
                        }
                    }

                    // Order Details Section
                    FormSection(title: "Order Details") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Related to a Booking?")
                                .font(.custom("Inter-Medium", size: 14))
                                .foregroundColor(Color("TextSecondary"))

                            HStack(spacing: 24) {
                                RadioButton(
                                    title: "Yes",
                                    isSelected: relatedToBooking,
                                    onTap: { relatedToBooking = true }
                                )

                                RadioButton(
                                    title: "No",
                                    isSelected: !relatedToBooking,
                                    onTap: { relatedToBooking = false }
                                )
                            }

                            if relatedToBooking {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Select Booking (Optional)")
                                        .font(.custom("Inter-Medium", size: 14))
                                        .foregroundColor(Color("TextSecondary"))

                                    ForEach(viewModel.recentBookings.prefix(3)) { booking in
                                        BookingSelectionCard(
                                            booking: booking,
                                            isSelected: selectedBooking?.id == booking.id,
                                            onSelect: { selectedBooking = booking }
                                        )
                                    }
                                }
                            }
                        }
                    }

                    // Message Section
                    FormSection(title: "Your Message") {
                        VStack(alignment: .leading, spacing: 16) {
                            // Subject
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Subject *")
                                    .font(.custom("Inter-Medium", size: 14))
                                    .foregroundColor(Color("TextSecondary"))

                                TextField("Enter subject", text: $subject)
                                    .font(.custom("Inter-Regular", size: 15))
                                    .padding(14)
                                    .background(Color("BackgroundSecondary"))
                                    .cornerRadius(8)
                                    .onChange(of: subject) { newValue in
                                        if newValue.count > 100 {
                                            subject = String(newValue.prefix(100))
                                        }
                                    }
                            }

                            // Description
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description *")
                                    .font(.custom("Inter-Medium", size: 14))
                                    .foregroundColor(Color("TextSecondary"))

                                ZStack(alignment: .topLeading) {
                                    if description.isEmpty {
                                        Text("Describe your issue in detail")
                                            .font(.custom("Inter-Regular", size: 15))
                                            .foregroundColor(Color("TextTertiary"))
                                            .padding(.horizontal, 18)
                                            .padding(.vertical, 18)
                                    }

                                    TextEditor(text: $description)
                                        .font(.custom("Inter-Regular", size: 15))
                                        .foregroundColor(Color("TextPrimary"))
                                        .frame(height: 120)
                                        .padding(10)
                                        .background(Color("BackgroundSecondary"))
                                        .cornerRadius(8)
                                        .onChange(of: description) { newValue in
                                            if newValue.count > 500 {
                                                description = String(newValue.prefix(500))
                                            }
                                        }
                                }

                                Text("\(description.count)/500")
                                    .font(.custom("Inter-Regular", size: 12))
                                    .foregroundColor(Color("TextTertiary"))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }

                    // Attachments Section
                    FormSection(title: "Attachments") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Add Photos/Screenshots (Optional)")
                                .font(.custom("Inter-Medium", size: 14))
                                .foregroundColor(Color("TextSecondary"))

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    // Existing attachments
                                    ForEach(Array(attachments.enumerated()), id: \.offset) { index, image in
                                        AttachmentThumbnail(
                                            image: image,
                                            onRemove: {
                                                attachments.remove(at: index)
                                            }
                                        )
                                    }

                                    // Add button
                                    if attachments.count < 5 {
                                        Button(action: { showImagePicker = true }) {
                                            VStack(spacing: 6) {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 24))
                                                    .foregroundColor(Color("PrimaryTeal"))

                                                Text("Add")
                                                    .font(.custom("Inter-Medium", size: 12))
                                                    .foregroundColor(Color("PrimaryTeal"))
                                            }
                                            .frame(width: 80, height: 80)
                                            .background(Color("PrimaryTeal").opacity(0.1))
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color("PrimaryTeal"), lineWidth: 1, style: StrokeStyle(dash: [5]))
                                            )
                                        }
                                    }
                                }
                            }

                            Text("Max 5 files, 10MB each")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("TextTertiary"))
                        }
                    }

                    // Contact Preference Section
                    FormSection(title: "Contact Preference") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("How should we reach you?")
                                .font(.custom("Inter-Medium", size: 14))
                                .foregroundColor(Color("TextSecondary"))

                            Toggle(isOn: $contactByEmail) {
                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(Color("PrimaryTeal"))
                                    Text("Email (\(viewModel.userEmail))")
                                        .font(.custom("Inter-Regular", size: 14))
                                }
                            }
                            .tint(Color("PrimaryTeal"))

                            Toggle(isOn: $contactByPhone) {
                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(Color("PrimaryTeal"))
                                    Text("Phone (\(viewModel.userPhone))")
                                        .font(.custom("Inter-Regular", size: 14))
                                }
                            }
                            .tint(Color("PrimaryTeal"))

                            Toggle(isOn: $contactByNotification) {
                                HStack {
                                    Image(systemName: "bell.fill")
                                        .foregroundColor(Color("PrimaryTeal"))
                                    Text("In-App Notification")
                                        .font(.custom("Inter-Regular", size: 14))
                                }
                            }
                            .tint(Color("PrimaryTeal"))
                        }
                    }

                    // Priority Section
                    FormSection(title: "Priority") {
                        HStack(spacing: 16) {
                            ForEach(Priority.allCases, id: \.self) { priorityOption in
                                RadioButton(
                                    title: priorityOption.displayName,
                                    isSelected: priority == priorityOption,
                                    onTap: { priority = priorityOption }
                                )
                            }
                        }
                    }

                    // Submit Button
                    Button(action: submitTicket) {
                        if viewModel.isSubmitting {
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                        } else {
                            Text("Submit Ticket")
                                .font(.custom("Inter-SemiBold", size: 16))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                        }
                    }
                    .background(isFormValid ? Color("PrimaryTeal") : Color("TextTertiary"))
                    .cornerRadius(10)
                    .disabled(!isFormValid || viewModel.isSubmitting)
                    .padding(.horizontal, 16)

                    // Info Message
                    HStack(spacing: 8) {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color("SecondaryOrange"))

                        Text("Expected response time: 2-4 hours")
                            .font(.custom("Inter-Regular", size: 13))
                            .foregroundColor(Color("TextSecondary"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color("SecondaryOrange").opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("Contact Support")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color("TextPrimary"))
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImages: $attachments, maxSelection: 5)
        }
        .alert("Ticket Submitted", isPresented: $viewModel.showSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your ticket #\(viewModel.ticketId) has been created. We'll get back to you soon!")
        }
    }

    var isFormValid: Bool {
        !selectedCategory.displayName.isEmpty &&
        !subject.isEmpty &&
        !description.isEmpty &&
        description.count >= 20 &&
        (contactByEmail || contactByPhone || contactByNotification)
    }

    func submitTicket() {
        viewModel.submitSupportTicket(
            category: selectedCategory,
            booking: selectedBooking,
            subject: subject,
            description: description,
            attachments: attachments,
            contactEmail: contactByEmail,
            contactPhone: contactByPhone,
            contactNotification: contactByNotification,
            priority: priority
        )
    }
}

struct FormSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))
                .padding(.horizontal, 16)

            content
                .padding(.horizontal, 16)

            Divider()
                .padding(.horizontal, 16)
        }
    }
}

struct BookingSelectionCard: View {
    let booking: Booking
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("#\(booking.id) - \(booking.serviceName)")
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color("TextPrimary"))

                    Text("Provider: \(booking.providerName)")
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color("TextSecondary"))

                    Text(booking.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))
                }

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? Color("PrimaryTeal") : Color("TextTertiary"))
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color("PrimaryTeal") : Color("BorderLight"), lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AttachmentThumbnail: View {
    let image: UIImage
    let onRemove: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .offset(x: 6, y: -6)
        }
    }
}

enum IssueCategory: String, CaseIterable {
    case bookingIssue = "Booking Issue"
    case paymentProblem = "Payment Problem"
    case accountProfile = "Account & Profile"
    case serviceQuality = "Service Quality"
    case refundRequest = "Refund Request"
    case technicalIssue = "App Bug/Technical Issue"
    case safetyConcern = "Safety Concern"
    case other = "Other"

    var displayName: String { rawValue }

    var commonIssues: [String] {
        switch self {
        case .bookingIssue:
            return ["Booking not confirmed", "Provider not arrived", "Wrong service booked"]
        case .paymentProblem:
            return ["Payment failed", "Double charged", "Refund not received"]
        case .serviceQuality:
            return ["Poor service quality", "Incomplete work", "Unprofessional behavior"]
        case .refundRequest:
            return ["Cancel and refund", "Partial refund request"]
        default:
            return []
        }
    }
}

enum Priority: String, CaseIterable {
    case low = "Low"
    case normal = "Normal"
    case high = "High"

    var displayName: String { rawValue }
}
```

## Interactions

### Form Filling
1. **Select Category**: Dropdown shows all categories, common issues update
2. **Tap Common Issue**: Auto-fills subject field
3. **Type Subject**: Character limit 100, real-time counter
4. **Type Description**: Character limit 500, real-time counter, minimum 20 chars
5. **Toggle Booking Related**: Shows/hides booking selection

### Attachments
1. **Tap Add (+)**: Opens image picker (camera/gallery)
2. **Select Image**: Shows thumbnail with remove button
3. **Tap Remove (X)**: Removes attachment
4. **Max 5 Files**: Add button disappears after 5 attachments

### Contact Preference
1. **Toggle Email/Phone/Notification**: At least one must be selected
2. **Pre-filled Contact Info**: Email and phone from profile

### Submit
1. **Validation**: All required fields + min 20 chars description
2. **Submit Button**: Disabled if invalid, enabled when valid
3. **Submitting State**: Loading spinner, button disabled
4. **Success**: Alert with ticket ID, dismiss screen

## States

### Default State
- Form empty except pre-filled user info
- Category: Booking Issue (default)
- Priority: Normal (default)
- Contact by Email and Phone: checked

### Validation Error States
```swift
// Subject too short
if subject.isEmpty {
    // Show red border on subject field
}

// Description too short
if description.count < 20 {
    // Show error: "Minimum 20 characters required"
}

// No contact method selected
if !contactByEmail && !contactByPhone && !contactByNotification {
    // Show error: "Please select at least one contact method"
}
```

### Submitting State
```swift
viewModel.isSubmitting = true
// Show loading spinner in submit button
// Disable all form fields
```

### Success State
```swift
Alert(title: "Ticket Submitted",
      message: "Your ticket #TKT12345 has been created. We'll get back to you soon!")
// On dismiss: Return to Help Center or previous screen
```

### Error State
```swift
Alert(title: "Submission Failed",
      message: "Unable to submit your ticket. Please try again.")
// Retry button
```

## API Integration

### Submit Support Ticket
```
POST /support/tickets

Request (multipart/form-data):
{
  "customerId": "cust_123",
  "category": "booking_issue",
  "bookingId": "bkg_456", // optional
  "subject": "Provider did not arrive",
  "description": "I booked an electrician for today at 2 PM...",
  "priority": "high",
  "contactPreferences": ["email", "phone"],
  "attachments": [File, File] // multipart files
}

Response:
{
  "success": true,
  "data": {
    "ticketId": "TKT12345",
    "status": "open",
    "estimatedResponseTime": "2-4 hours",
    "createdAt": "2025-12-31T10:30:00Z"
  },
  "message": "Your ticket has been submitted successfully"
}
```

### Get Recent Bookings
```
GET /customers/{customerId}/bookings/recent?limit=10

Response:
{
  "success": true,
  "data": {
    "bookings": [
      {
        "id": "BKG123",
        "serviceName": "Electrician",
        "providerName": "John Doe",
        "date": "2025-12-30T14:00:00Z",
        "status": "completed"
      }
    ]
  }
}
```

## Navigation

### Entry Points
- **From Screen 43** (Help Center): Tap "Contact Support"
- **From Screen 21** (Profile): Direct "Contact Support" link
- **From Booking Detail**: "Report Issue" button
- **Deep Link**: `urbannest://support/contact`

### Exit Points
- **Cancel Button**: Dismiss sheet, show confirmation if form dirty
- **Submit Success**: Auto-dismiss after alert, return to previous screen
- **Back Gesture**: iOS swipe down to dismiss

## Accessibility

### VoiceOver
```swift
.accessibilityLabel("Issue category picker")
.accessibilityHint("Select the type of issue you're experiencing")

.accessibilityLabel("Subject text field")
.accessibilityValue(subject.isEmpty ? "Empty" : subject)

.accessibilityLabel("Description, \(description.count) of 500 characters")
```

### Touch Targets
- All form fields: 44pt minimum height
- Radio buttons: 44x44pt
- Attachment thumbnails: 80x80pt (sufficient)
- Submit button: 52pt height

### Dynamic Type
- All text scales
- Form fields expand vertically
- Attachments grid adapts

## Analytics Events

### Screen View
```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "contact_support"
])
```

### Category Selected
```swift
Analytics.logEvent("support_category_selected", parameters: [
    "category": selectedCategory.rawValue
])
```

### Ticket Submitted
```swift
Analytics.logEvent("support_ticket_submitted", parameters: [
    "ticket_id": ticketId,
    "category": category,
    "has_booking": selectedBooking != nil,
    "has_attachments": !attachments.isEmpty,
    "priority": priority.rawValue
])
```

## Testing Checklist

- [ ] All form fields validate correctly
- [ ] Subject limited to 100 characters
- [ ] Description limited to 500 characters
- [ ] Description minimum 20 characters enforced
- [ ] Common issues auto-fill subject
- [ ] Booking selection toggles correctly
- [ ] Image picker opens for attachments
- [ ] Max 5 attachments enforced
- [ ] Remove attachment works
- [ ] At least one contact method required
- [ ] Priority selection works
- [ ] Submit button disabled when form invalid
- [ ] Loading state shows during submission
- [ ] Success alert displays ticket ID
- [ ] Error alert shows on API failure
- [ ] Cancel button shows confirmation if form dirty
- [ ] VoiceOver announces fields correctly
- [ ] Keyboard dismisses when tapping outside
- [ ] Form scrolls when keyboard appears

## Design Notes

### Platform-Specific Considerations

**iOS**:
- Native image picker (PHPickerViewController)
- Native alerts for success/error
- Keyboard avoidance with `.ignoresSafeArea(.keyboard)`
- Dismiss sheet with swipe down

**Android**:
- Material pickers for images
- Material alerts/snackbars
- Keyboard handling with manifest settings

**Web**:
- File input for attachments
- Browser-native form validation
- Responsive form layout

### Form Validation
- Real-time validation as user types
- Red border on invalid fields
- Error messages below fields
- Submit button disabled until valid

### Edge Cases
- Handle image upload failure gracefully
- Show file size error if > 10MB
- Handle unsupported file formats
- Prevent double-submission

### Future Enhancements
- Voice recording for description
- Video attachment support
- Live chat handoff from form
- Auto-save draft to local storage
- Suggest articles based on description (AI)

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
