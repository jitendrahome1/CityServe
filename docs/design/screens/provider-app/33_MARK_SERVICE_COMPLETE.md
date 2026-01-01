# Mark Service Complete

## Overview
- **Screen ID**: 33
- **Screen Name**: Mark Service Complete
- **User Role**: Service Provider
- **Platform**: iOS, Android
- **Navigation**: From Job In Progress (Screen 29) → Tap "Mark as Complete" button

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ✕  Complete Service                     │
├──────────────────────────────────────────┤
│                                          │
│  🔧 AC Repair & Service                  │
│  #BK789012 • ₹850                        │
│                                          │
│  👤 Amit Kumar                           │
│  📍 123 MG Road, HSR Layout              │
│  ⏱️ Duration: 1h 45m                     │
│                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                          │
│  ✅ Completion Checklist                 │
│  ┌────────────────────────────────────┐ │
│  │ ☑ Service completed successfully   │ │
│  │ ☑ Customer satisfied               │ │
│  │ ☑ Work area cleaned                │ │
│  │ ☑ Before/After photos uploaded     │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📸 Service Photos (4/6)                 │
│  ┌────────────────────────────────────┐ │
│  │ [Photo1] [Photo2] [Photo3] [Photo4]│ │
│  │              [+ Add More]          │ │
│  └────────────────────────────────────┘ │
│                                          │
│  💰 Final Charges                        │
│  ┌────────────────────────────────────┐ │
│  │ Base Service:            ₹550      │ │
│  │ Gas Refill (Added):      ₹300      │ │
│  │ ─────────────────────────          │ │
│  │ Total Amount:            ₹850      │ │
│  │ Your Earnings (85%):     ₹722.50   │ │
│  │ Platform Fee (15%):      ₹127.50   │ │
│  │                                    │ │
│  │ Payment: Paid via UPI              │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📝 Service Summary (Optional)           │
│  ┌────────────────────────────────────┐ │
│  │ What did you do?                   │ │
│  │                                    │ │
│  │ Checked AC, refilled R32 gas,      │ │
│  │ cleaned filters, tested cooling... │ │
│  │                                    │ │
│  │ (150/500 characters)               │ │
│  └────────────────────────────────────┘ │
│                                          │
│  🎯 Request Customer Feedback            │
│  ┌────────────────────────────────────┐ │
│  │ ⭐ Ask for Rating                  │ │
│  │                                    │ │
│  │ Customer will receive a request to │ │
│  │ rate this service after completion │ │
│  │                                    │ │
│  │ ☑ Send feedback request            │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ⚠️ Important                            │
│  Once marked complete, you cannot undo  │
│  this action. Ensure all work is done.  │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │     Mark as Complete               │ │ ← Primary button
│  └────────────────────────────────────┘ │
│                                          │
│              Cancel                      │
│                                          │
└──────────────────────────────────────────┘
```

## Key Features

### Completion Checklist

Required items before completion:
1. **Service completed successfully**: Core work finished
2. **Customer satisfied**: Verbal confirmation received
3. **Work area cleaned**: No debris or tools left behind
4. **Photos uploaded**: Documentation provided (minimum 2 photos)

All items must be checked to enable completion button.

### Service Photos Review

- Display uploaded photos from Screen 29
- Option to add more photos (up to 6 total)
- Minimum 2 photos required
- Before/after comparison encouraged
- Photos serve as proof of work

### Final Charges Summary

**Breakdown Display:**
- Base service price
- Additional items/services
- Total amount
- Provider earnings (after commission)
- Platform fee
- Payment method and status

**Validation:**
- All charges must be approved (if additional items added)
- Payment status confirmed
- Total matches what customer paid

### Service Summary

Optional text field for provider to:
- Describe work completed
- Note any issues found
- Provide maintenance recommendations
- Add warranty information
- Document parts replaced

Maximum 500 characters, helps with:
- Customer records
- Future service reference
- Quality assurance
- Dispute resolution

### Feedback Request

Toggle to send rating request to customer:
- Default: Enabled (checked)
- Sends notification after completion
- Improves provider rating opportunities
- Better customer engagement

### Warning Message

Clear disclaimer that:
- Action is irreversible
- Customer will be notified
- Payment will be processed
- Job cannot be reopened

## Component Breakdown

### Completion Checklist Component

```swift
struct CompletionChecklist: View {
    @Binding var serviceCompleted: Bool
    @Binding var customerSatisfied: Bool
    @Binding var areaCleaned: Bool
    @Binding var photosUploaded: Bool
    let photoCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("✅ Completion Checklist")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(.gray900)

            VStack(spacing: 12) {
                ChecklistItem(
                    title: "Service completed successfully",
                    isChecked: $serviceCompleted,
                    isRequired: true
                )

                ChecklistItem(
                    title: "Customer satisfied",
                    isChecked: $customerSatisfied,
                    isRequired: true
                )

                ChecklistItem(
                    title: "Work area cleaned",
                    isChecked: $areaCleaned,
                    isRequired: true
                )

                ChecklistItem(
                    title: "Before/After photos uploaded (\(photoCount)/6)",
                    isChecked: $photosUploaded,
                    isRequired: true,
                    subtitle: photoCount < 2 ? "Minimum 2 photos required" : nil,
                    subtitleColor: photoCount < 2 ? .error : .success
                )
            }

            // Progress indicator
            if !allChecked {
                HStack(spacing: 6) {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.brandPrimary)

                    Text("Complete all items to mark service complete")
                        .font(.system(size: 12))
                        .foregroundColor(.gray600)
                }
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }

    var allChecked: Bool {
        serviceCompleted && customerSatisfied && areaCleaned && photosUploaded && photoCount >= 2
    }
}

struct ChecklistItem: View {
    let title: String
    @Binding var isChecked: Bool
    let isRequired: Bool
    var subtitle: String? = nil
    var subtitleColor: Color = .gray500

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: { isChecked.toggle() }) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .font(.system(size: 24))
                    .foregroundColor(isChecked ? .success : .gray300)
            }
            .buttonStyle(ScaleButtonStyle())

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(.gray800)

                    if isRequired {
                        Text("*")
                            .foregroundColor(.error)
                    }
                }

                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(subtitleColor)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
    }
}
```

### Service Photos Review

```swift
struct ServicePhotosReview: View {
    let photos: [UIImage]
    let onAddPhoto: () -> Void
    let onRemovePhoto: (Int) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("📸 Service Photos (\(photos.count)/6)")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(.gray900)

                Spacer()

                if photos.count < 6 {
                    Button(action: onAddPhoto) {
                        HStack(spacing: 4) {
                            Image(systemName: "plus")
                                .font(.system(size: 12))

                            Text("Add More")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundColor(.brandPrimary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.brandPrimary.opacity(0.1))
                        .cornerRadius(6)
                    }
                }
            }

            if photos.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 32))
                        .foregroundColor(.gray300)

                    Text("No photos uploaded yet")
                        .font(.system(size: 14))
                        .foregroundColor(.gray500)

                    Text("Add at least 2 photos to complete service")
                        .font(.system(size: 12))
                        .foregroundColor(.gray400)

                    Button(action: onAddPhoto) {
                        Text("Upload Photos")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.brandPrimary)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.brandPrimary.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(Color.gray50)
                .cornerRadius(8)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(photos.indices, id: \.self) { index in
                            PhotoThumbnail(
                                image: photos[index],
                                index: index,
                                onRemove: { onRemovePhoto(index) }
                            )
                        }

                        if photos.count < 6 {
                            AddPhotoButton(action: onAddPhoto)
                        }
                    }
                }
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

struct PhotoThumbnail: View {
    let image: UIImage
    let index: Int
    let onRemove: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.black.opacity(0.5)))
            }
            .offset(x: 8, y: -8)
        }
    }
}
```

### Final Charges Summary

```swift
struct FinalChargesSummary: View {
    let baseAmount: Double
    let additionalCharges: [(String, Double)]
    let platformFee: Double
    let paymentMethod: String
    let isPaid: Bool

    var totalAmount: Double {
        baseAmount + additionalCharges.reduce(0) { $0 + $1.1 }
    }

    var providerEarnings: Double {
        totalAmount * 0.85 // 85% to provider
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("💰 Final Charges")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(.gray900)

            VStack(spacing: 8) {
                ChargeRow(label: "Base Service", amount: baseAmount)

                ForEach(additionalCharges.indices, id: \.self) { index in
                    let (item, amount) = additionalCharges[index]
                    ChargeRow(
                        label: "\(item) (Added)",
                        amount: amount,
                        highlight: true
                    )
                }

                Divider()
                    .padding(.vertical, 4)

                ChargeRow(
                    label: "Total Amount",
                    amount: totalAmount,
                    bold: true,
                    large: true
                )

                ChargeRow(
                    label: "Your Earnings (85%)",
                    amount: providerEarnings,
                    color: .success,
                    bold: true
                )

                ChargeRow(
                    label: "Platform Fee (15%)",
                    amount: platformFee,
                    color: .gray500
                )

                Divider()

                HStack {
                    Text("Payment:")
                        .font(.system(size: 14))
                        .foregroundColor(.gray600)

                    Spacer()

                    HStack(spacing: 6) {
                        if isPaid {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.success)
                        }

                        Text(isPaid ? "Paid via \(paymentMethod)" : "Pending")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(isPaid ? .success : .warning)
                    }
                }
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

struct ChargeRow: View {
    let label: String
    let amount: Double
    var color: Color = .gray800
    var bold: Bool = false
    var large: Bool = false
    var highlight: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: large ? 16 : 14, weight: bold ? .semibold : .regular))
                .foregroundColor(highlight ? .secondary : .gray600)

            Spacer()

            Text("₹\(amount, specifier: "%.2f")")
                .font(.system(size: large ? 18 : 14, weight: bold ? .semibold : .regular))
                .foregroundColor(color)
        }
    }
}
```

### Service Summary Input

```swift
struct ServiceSummaryInput: View {
    @Binding var summary: String
    let maxCharacters: Int = 500

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📝 Service Summary (Optional)")
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(.gray800)

            VStack(alignment: .leading, spacing: 8) {
                Text("What did you do?")
                    .font(.system(size: 12))
                    .foregroundColor(.gray600)

                TextEditor(text: $summary)
                    .font(.system(size: 14))
                    .frame(height: 100)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray200, lineWidth: 1)
                    )

                HStack {
                    Text("Helps with future service reference")
                        .font(.system(size: 11))
                        .foregroundColor(.gray500)

                    Spacer()

                    Text("\(summary.count)/\(maxCharacters)")
                        .font(.system(size: 11))
                        .foregroundColor(summary.count > maxCharacters ? .error : .gray500)
                }
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}
```

## Interactions

### Mark Complete Action

```swift
func markServiceComplete() {
    // Final validation
    guard validateCompletion() else { return }

    // Show confirmation
    AlertManager.show(
        title: "Complete Service?",
        message: "Once marked complete, you cannot undo this action. Customer will be notified and payment will be processed.",
        primaryButton: "Mark Complete",
        secondaryButton: "Review Again",
        primaryAction: {
            proceedWithCompletion()
        }
    )
}

func validateCompletion() -> Bool {
    // Check all checklist items
    guard serviceCompleted && customerSatisfied && areaCleaned else {
        AlertManager.showError("Please complete all checklist items")
        return false
    }

    // Check minimum photos
    guard photoCount >= 2 else {
        AlertManager.showError("Please upload at least 2 photos")
        return false
    }

    // Check payment status
    guard isPaid else {
        AlertManager.showError("Payment not received. Cannot complete service.")
        return false
    }

    // Check summary length if provided
    if !summary.isEmpty && summary.count > 500 {
        AlertManager.showError("Service summary too long (max 500 characters)")
        return false
    }

    return true
}

func proceedWithCompletion() {
    isLoading = true

    Task {
        do {
            let result = await viewModel.completeService(
                jobId: job.id,
                summary: summary.isEmpty ? nil : summary,
                sendFeedbackRequest: sendFeedbackRequest
            )

            isLoading = false

            if result.success {
                // Show success screen
                showCompletionSuccess(earnings: result.earnings)

                // Track analytics
                analytics.track("service_completed", [
                    "job_id": job.id,
                    "earnings": result.earnings,
                    "duration": job.duration,
                    "photo_count": photoCount,
                    "has_summary": !summary.isEmpty
                ])

                // Haptic feedback
                HapticManager.notification(.success)
            } else {
                AlertManager.showError("Failed to complete service. Please try again.")
            }
        } catch {
            isLoading = false
            AlertManager.showError(error.localizedDescription)
        }
    }
}

func showCompletionSuccess(earnings: Double) {
    let successView = ServiceCompletedSuccessView(
        jobId: job.id,
        earnings: earnings,
        duration: job.duration,
        customerName: job.customerName,
        onDone: {
            // Navigate back to dashboard
            navigationController?.popToRoot()
        }
    )

    presentFullScreen(successView, animated: true)
}
```

### Add/Remove Photos

```swift
func addPhoto() {
    guard photoCount < 6 else {
        ToastManager.show("Maximum 6 photos allowed")
        return
    }

    presentSheet(PhotoPickerSheet(
        allowsMultipleSelection: true,
        maxSelection: 6 - photoCount,
        onPhotosSelected: { images in
            Task {
                for image in images {
                    await viewModel.uploadPhoto(image)
                }

                // Update checklist
                photosUploaded = photoCount >= 2
            }
        }
    ))
}

func removePhoto(at index: Int) {
    AlertManager.show(
        title: "Remove Photo?",
        message: "This photo will be permanently deleted",
        primaryButton: "Remove",
        secondaryButton: "Cancel",
        destructive: true,
        primaryAction: {
            viewModel.removePhoto(at: index)
            photosUploaded = photoCount >= 2
        }
    )
}
```

## States

### Default State
- All checklist items unchecked
- Photos from previous screen displayed
- Charges summary calculated
- Service summary empty
- Feedback request enabled

### Incomplete State
- Complete button disabled
- Missing items highlighted
- Helper messages shown

### Loading State
- Complete button shows spinner
- "Completing service..." text
- All inputs disabled

### Success State
- Navigate to Screen 35 (Completion Success)
- Celebration animation
- Earnings displayed

## API Integration

### Complete Service
```typescript
POST /bookings/{bookingId}/complete
Body:
{
  "summary": "Checked AC, refilled R32 gas, cleaned filters...",
  "photoUrls": ["url1", "url2", "url3", "url4"],
  "finalAmount": 850,
  "duration": "1h 45m",
  "sendFeedbackRequest": true
}

Response:
{
  "success": true,
  "earnings": 722.50,
  "platformFee": 127.50,
  "paymentProcessed": true,
  "completedAt": "2025-01-15T16:45:00Z"
}
```

## Navigation

### Entry Points
- Screen 29 (Job In Progress) → "Mark as Complete" button

### Exit Points
- Tap "Mark Complete" → Screen 35 (Success)
- Tap "Cancel" → Return to Screen 29
- Add photos → Screen 34 (Upload Photos)

## Accessibility

### VoiceOver
- Checklist: "Service completed, Checkbox, Checked"
- Photos: "Service photos, 4 of 6 uploaded"
- Complete button: "Mark as complete, Disabled, Complete all required items"

### Touch Targets
- All checkboxes: 44x44pt
- Photo thumbnails: 100x100pt (tap to view full)
- Complete button: 48pt height

## Analytics

```typescript
analytics.track('mark_complete_viewed', {
  job_id: 'BK789012',
  photo_count: 4,
  checklist_progress: 0.75
})

analytics.track('service_completed', {
  job_id: 'BK789012',
  total_amount: 850,
  earnings: 722.50,
  duration: '1h 45m',
  photo_count: 4,
  has_summary: true,
  feedback_requested: true
})
```

## Testing Checklist

- [ ] All checklist items required
- [ ] Minimum 2 photos enforced
- [ ] Payment status validated
- [ ] Charges calculated correctly
- [ ] Summary character limit works
- [ ] Completion confirmation shows
- [ ] Success screen displays
- [ ] Cannot complete without payment
- [ ] Photos upload successfully
- [ ] Undo warning clear

## Design Notes

- Clear visual hierarchy for checklist
- Prominent earnings display
- Easy photo management
- Irreversible action warning prominent
- Success celebration important for provider motivation
