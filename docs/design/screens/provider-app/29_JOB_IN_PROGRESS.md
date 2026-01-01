# Job In Progress

## Overview
- **Screen ID**: 29
- **Screen Name**: Job In Progress (Active Service)
- **User Flow**: Manage ongoing job, update status, complete job
- **Navigation**: From Active Jobs "Start Job" button

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ←  Service In Progress            •••   │
├──────────────────────────────────────────┤
│                                          │
│  ⏱️ 00:45:32                             │ ← Timer (auto)
│  Started at 2:00 PM                      │
│                                          │
│  🔧 AC Repair & Service                  │
│  #BK789012                               │
│                                          │
│  👤 Customer: Amit Kumar                 │
│  ┌────────────────────────────────────┐ │
│  │ [Photo] ⭐ 4.5                      │ │
│  │                                    │ │
│  │ [📞 Call Customer] [💬 Message]    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📍 123 MG Road, HSR Layout              │
│                                          │
│  📝 Service Progress                     │
│  ┌────────────────────────────────────┐ │
│  │ ✅ Arrived at location              │ │ ← Timeline
│  │    2:05 PM                         │ │
│  │                                    │ │
│  │ ✅ Started diagnosis                │ │
│  │    2:10 PM                         │ │
│  │    Issue: Low gas, compressor OK   │ │
│  │                                    │ │
│  │ ⏳ Gas refilling in progress        │ │
│  │    Started at 2:30 PM              │ │
│  │                                    │ │
│  │ ┌────────────────────────────────┐│ │
│  │ │ + Add Update                   ││ │
│  │ └────────────────────────────────┘│ │
│  └────────────────────────────────────┘ │
│                                          │
│  📸 Service Photos                       │
│  ┌────────────────────────────────────┐ │
│  │ [Photo1] [Photo2]        [+ Add]   │ │ ← Photo Gallery
│  └────────────────────────────────────┘ │
│                                          │
│  💰 Charges                              │
│  ┌────────────────────────────────────┐ │
│  │ Base Service:            ₹550      │ │
│  │ Gas Refill (Extra):      ₹300      │ │ ← Additional
│  │ ─────────────────────────          │ │
│  │ Total:                   ₹850      │ │
│  │ Your Earnings (85%):     ₹722      │ │
│  │                                    │ │
│  │ [+ Add Extra Charges]              │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ✅ Service completed successfully?     │ ← Checklist
│  ☑️ Customer satisfied                  │
│  ☑️ Area cleaned                        │
│  ☑️ Photos uploaded                     │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Mark as Complete                  │ │ ← Complete CTA
│  └────────────────────────────────────┘ │
│                                          │
│         Report Issue                     │ ← Issue Link
│                                          │
└──────────────────────────────────────────┘
```

## Key Features

### Auto Timer
- Starts when job begins
- Tracks total service time
- Displays elapsed time (HH:MM:SS)
- Used for analytics and performance

### Service Progress Timeline
- Chronological updates
- Provider adds status updates
- Timestamps auto-added
- Customer can view in real-time

**Update Types**:
- Arrived
- Started diagnosis
- Issue identified
- Work in progress
- Testing
- Completed

### Photo Documentation
- Before/after photos
- Issue documentation
- Completed work proof
- Customer approval

**Photo Features**:
- Camera or gallery
- Max 6 photos per job
- Auto-compress
- Upload to cloud

### Additional Charges
- Add extra items/services
- Must explain reason
- Customer approval required (for high amounts)
- Transparent breakdown

**Common Extras**:
- Parts/materials used
- Additional services
- Travel charges (if applicable)

### Completion Checklist
```swift
struct CompletionChecklist: View {
    @State private var serviceDone = false
    @State private var customerSatisfied = false
    @State private var areaCleaned = false
    @State private var photosUploaded = false

    var canComplete: Bool {
        serviceDone && customerSatisfied && areaCleaned && photosUploaded
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            CheckboxItem(
                "Service completed successfully",
                isChecked: $serviceDone
            )
            CheckboxItem(
                "Customer satisfied",
                isChecked: $customerSatisfied
            )
            CheckboxItem(
                "Work area cleaned",
                isChecked: $areaCleaned
            )
            CheckboxItem(
                "Photos uploaded",
                isChecked: $photosUploaded
            )
        }

        PrimaryButton(
            title: "Mark as Complete",
            action: completeJob,
            isDisabled: !canComplete
        )
    }
}
```

## Interactions

### Add Update
```swift
func addUpdate() {
    presentSheet(AddUpdateSheet(
        updateTypes: [
            .arrived, .diagnosis, .issueFound,
            .workInProgress, .testing, .completed
        ],
        onSubmit: { type, notes in
            Task {
                await viewModel.addUpdate(type: type, notes: notes)
            }
        }
    ))
}
```

### Add Photo
```swift
func addPhoto() {
    presentSheet(PhotoPickerSheet(
        maxPhotos: 6,
        currentCount: viewModel.photos.count,
        onPhotoSelected: { image in
            Task {
                await viewModel.uploadPhoto(image)
            }
        }
    ))
}
```

### Add Extra Charges
```swift
func addExtraCharges() {
    presentSheet(ExtraChargesSheet(
        onSubmit: { item, amount, reason in
            Task {
                let approved = await viewModel.addExtraCharge(
                    item: item,
                    amount: amount,
                    reason: reason
                )

                if approved {
                    ToastManager.show("Charge added")
                } else {
                    AlertManager.show(
                        title: "Customer Approval Needed",
                        message: "Customer will be notified. Proceed only after approval."
                    )
                }
            }
        }
    ))
}
```

### Mark as Complete
```swift
func completeJob() {
    guard canComplete else { return }

    AlertManager.show(
        title: "Complete Job?",
        message: "Confirm that service is completed and customer is satisfied.",
        primaryButton: "Mark Complete",
        primaryAction: {
            Task {
                let success = await viewModel.completeJob()
                if success {
                    showCompletionSuccess()
                }
            }
        }
    )
}

func showCompletionSuccess() {
    // Show success screen
    let successView = JobCompletedSuccessView(
        jobId: viewModel.job.id,
        earnings: viewModel.totalEarnings,
        onDone: {
            navigationController?.popToRoot()
        }
    )
    presentFullScreen(successView)
}
```

### Report Issue
- Show issue types:
  - Customer not available
  - Wrong address
  - Customer cancelled
  - Parts not available
  - Safety concern
  - Other

- Submit report
- Contact support automatically
- Handle appropriately

## Real-time Features

### Customer Can View
- Service progress updates
- Photos uploaded
- Estimated completion time
- Additional charges (for approval)

### Provider Updates
- Customer messages
- Approval for extra charges
- Rating/feedback (after completion)

## Completion Flow

1. **Provider clicks "Mark Complete"**
2. **Validation**: All checklist items checked
3. **Confirmation**: Alert with summary
4. **API Call**: Update job status
5. **Notify Customer**: Service completed
6. **Success Screen**: Shows earnings, asks for feedback
7. **Navigate**: Back to dashboard or active jobs

## Success Screen (After Completion)

```
┌──────────────────────────────────────────┐
│                                          │
│         ✅                               │
│                                          │
│  Job Completed!                          │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  You Earned:  ₹722                 │ │
│  │                                    │ │
│  │  Service time: 1h 45min            │ │
│  │  Customer: Amit Kumar              │ │
│  │                                    │ │
│  │  Payment will be transferred       │ │
│  │  within 24 hours                   │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ⭐ Rate Your Experience                │
│  ★★★★★                                  │
│                                          │
│  [Submit Feedback]                       │
│                                          │
│  [View Next Job]  [Back to Dashboard]   │
│                                          │
└──────────────────────────────────────────┘
```

## Analytics
- `job_started`: Timer started
- `service_update_added`: Progress update
- `photo_uploaded`: Documentation
- `extra_charge_added`: Additional amount
- `job_completed`: Service finished
- `completion_time`: Duration tracked
- `customer_rating_received`: Feedback

## Testing
- ✅ Timer accuracy
- ✅ Update timeline order
- ✅ Photo upload/compression
- ✅ Extra charges calculation
- ✅ Checklist validation
- ✅ Complete button state
- ✅ Real-time sync
- ✅ Network error handling
- ✅ App background/foreground
