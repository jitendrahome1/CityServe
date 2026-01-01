# Job Detail (Accept/Reject)

## Overview
- **Screen ID**: 27
- **Screen Name**: Job Detail & Decision
- **User Flow**: View full job details before accepting or declining
- **Navigation**: From Dashboard job card, Job Requests list

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ←  Job Details                     •••  │
├──────────────────────────────────────────┤
│                                          │
│  🔧 AC Repair & Service                  │
│                                          │
│  ⏰ Respond in 8 minutes                 │ ← Countdown
│                                          │
│  📋 Service Details                      │
│  ┌────────────────────────────────────┐ │
│  │ • Window AC not cooling            │ │
│  │ • Gas refilling may be needed      │ │
│  │ • Estimated time: 1.5 hours        │ │
│  └────────────────────────────────────┘ │
│                                          │
│  👤 Customer Information                 │
│  ┌────────────────────────────────────┐ │
│  │ [Photo] Amit Kumar                 │ │
│  │         ⭐ 4.5 (28 bookings)        │ │
│  │         📞 +91 98765 43210          │ │
│  │                                    │ │
│  │ [Call Customer] [Message]          │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📍 Service Location                     │
│  ┌────────────────────────────────────┐ │
│  │ 123 MG Road, Koramangala           │ │
│  │ Bangalore - 560034                 │ │
│  │                                    │ │
│  │ 📏 3.2 km away • ~15 mins          │ │
│  │                                    │ │
│  │ [View on Map] [Get Directions]     │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📅 Schedule                             │
│  ┌────────────────────────────────────┐ │
│  │ Date: Today, Dec 20, 2024          │ │
│  │ Time: 2:00 PM - 3:30 PM            │ │
│  │ ⏱️ Starts in 2 hours 15 minutes    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  💰 Payment                              │
│  ┌────────────────────────────────────┐ │
│  │ Service Charge:        ₹550        │ │
│  │ Your Earnings (85%):   ₹467        │ │
│  │ Platform Fee (15%):    ₹83         │ │
│  │ ─────────────────────────          │ │
│  │ Customer Pays:         ₹650        │ │
│  │                                    │ │
│  │ Payment Mode: Online (Prepaid)     │ │
│  └────────────────────────────────────┘ │
│                                          │
│  📝 Special Instructions                 │
│  ┌────────────────────────────────────┐ │
│  │ "Please carry gas cylinder. Parking│ │
│  │ available in basement."            │ │
│  └────────────────────────────────────┘ │
│                                          │
├──────────────────────────────────────────┤
│  ┌────────────────────────────────────┐ │
│  │  Accept Job                        │ │ ← Primary CTA
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │  Decline                           │ │ ← Secondary CTA
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

## Key Sections

### Service Details
- Service type and description
- Reported issue
- Estimated duration
- Required tools/materials

### Customer Info
- Name, photo, rating
- Phone number
- Call and message buttons
- Booking history count

### Location
- Full address
- Distance and ETA
- Map preview
- Directions button (opens Maps app)

### Schedule
- Date and time slot
- Time remaining until job starts
- Duration estimate

### Payment Breakdown
- Service charge
- Provider earnings (85%)
- Platform fee (15%)
- Total customer payment
- Payment mode (prepaid/COD)

### Special Instructions
- Customer notes
- Parking info
- Access instructions

## Interactions

### Accept Job
```swift
func acceptJob() {
    AlertManager.show(
        title: "Accept Job?",
        message: "Confirm accepting this job. You cannot cancel within 2 hours of start time.",
        primaryButton: "Accept & Notify Customer",
        primaryAction: {
            Task {
                await viewModel.acceptJob()
                navigateToActiveJobs()
            }
        }
    )
}
```

### Decline Job
```swift
func declineJob() {
    presentSheet(DeclineReasonSheet(
        reasons: [.tooFar, .busy, .lowPrice, .unavailable, .other],
        onDecline: { reason in
            Task { await viewModel.declineJob(reason: reason) }
        }
    ))
}
```

### Call Customer
- Confirmation alert
- Initiate phone call
- Log communication

### View on Map
- Full-screen map modal
- Customer location marked
- Provider current location
- Route displayed

### Get Directions
- Open Apple Maps/Google Maps
- Navigate to customer location

## Analytics
- `job_detail_viewed`: Job opened
- `job_accepted_from_detail`: Accepted
- `job_declined_from_detail`: Declined with reason
- `customer_called`: Phone call initiated
- `directions_requested`: Navigation opened
