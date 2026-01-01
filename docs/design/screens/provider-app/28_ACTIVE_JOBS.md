# Active Jobs

## Overview
- **Screen ID**: 28
- **Screen Name**: Active Jobs List
- **User Flow**: View and manage accepted jobs
- **Navigation**: From Dashboard, Bottom Tab "Jobs" → "Active" tab

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  Active Jobs                    [Filter] │
├──────────────────────────────────────────┤
│  ┌──────────┐ ┌──────────┐ ┌─────────┐ │
│  │Upcoming  │ │In Progress│ │Completed│ │ ← Tabs
│  └──────────┘ └──────────┘ └─────────┘ │
│  (selected)                              │
│                                          │
│  Today                                   │ ← Date Group
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 🔥 Starting in 45 minutes           │ │ ← Urgent Job
│  │                                    │ │
│  │ 🔧 AC Repair & Service             │ │
│  │ #BK789012                          │ │
│  │                                    │ │
│  │ 📍 HSR Layout • 5.2 km             │ │
│  │ ⏰ 2:00 PM - 3:30 PM               │ │
│  │ 👤 Amit Kumar                      │ │
│  │ 💰 ₹650 (You earn ₹552)            │ │
│  │                                    │ │
│  │ ┌──────────────────────────────┐  │ │
│  │ │ 📞 Call  │ 🗺️ Navigate  │ ▶️ Start│ │
│  │ └──────────────────────────────┘  │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 💡 Electrical Work                  │ │ ← Scheduled Job
│  │ #BK789013                          │ │
│  │                                    │ │
│  │ 📍 Koramangala • 3.1 km            │ │
│  │ ⏰ 5:00 PM - 6:00 PM               │ │
│  │ 👤 Priya Sharma                    │ │
│  │ 💰 ₹450 (You earn ₹382)            │ │
│  │                                    │ │
│  │ Starts in 4 hours 30 minutes       │ │
│  │                                    │ │
│  │ [View Details] [Get Directions]    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Tomorrow                                │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ 🚿 Plumbing Service                 │ │
│  │ #BK789014                          │ │
│  │                                    │ │
│  │ 📍 Indiranagar • 6.8 km            │ │
│  │ ⏰ 10:00 AM - 11:00 AM             │ │
│  │ 👤 Rahul Singh                     │ │
│  │ 💰 ₹550 (You earn ₹467)            │ │
│  │                                    │ │
│  │ [View Details] [Reschedule]        │ │
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

## Job States

### Upcoming (Not Started)
- **Urgent**: < 1 hour to start (orange badge)
- **Today**: Same day
- **Future**: Tomorrow onwards

**Actions**:
- Call customer
- Get directions
- View details
- Start (if within start window)
- Reschedule (if > 2 hours)
- Cancel (emergency only, penalty applies)

### In Progress
- Job started by provider
- Service being performed
- Real-time updates

**Actions**:
- Update status
- Add notes/photos
- Request additional charges
- Mark complete
- Contact customer

### Completed (Today)
- Finished jobs
- Payment processing
- Review pending

**Actions**:
- View summary
- Download invoice
- View review (if customer reviewed)

## Key Features

### Urgency Indicators
- **< 30 min**: Red banner "Starting soon!"
- **< 1 hour**: Orange badge "Urgent"
- **< 3 hours**: Yellow badge "Today"
- **Tomorrow**: Normal display

### Quick Actions
- **Call**: Direct call to customer
- **Navigate**: Open Maps with route
- **Start**: Begin job (enabled within 15 min window)
- **View Details**: Full job information

### Job Cards
```swift
struct ActiveJobCard: View {
    let job: Job

    var urgencyBadge: some View {
        if job.minutesUntilStart < 30 {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                Text("Starting in \(job.minutesUntilStart) minutes!")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.red)
            .cornerRadius(6)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            urgencyBadge

            HStack {
                Text(job.service.icon)
                    .font(.system(size: 24))
                VStack(alignment: .leading) {
                    Text(job.service.name)
                        .font(.custom("Inter-SemiBold", size: 17))
                    Text("#\(job.bookingId)")
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundColor(.secondary)
                }
            }

            // Location, time, customer, payment...

            HStack(spacing: 12) {
                if job.canCall {
                    ActionButton(icon: "phone.fill", title: "Call")
                }
                if job.canNavigate {
                    ActionButton(icon: "map.fill", title: "Navigate")
                }
                if job.canStart {
                    PrimaryButton(title: "Start Job")
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
```

## Interactions

### Start Job
- Verify location (must be near customer)
- Confirm start time
- Notify customer
- Navigate to Job In Progress screen

### Call Customer
- Show customer phone
- Initiate call
- Log communication

### Navigate
- Open Apple Maps/Google Maps
- Route to customer location
- ETA calculation

### View Details
- Navigate to full job detail screen
- All information visible

### Reschedule
- Only if > 2 hours away
- Show available slots
- Notify customer
- Admin approval may be needed

### Cancel (Emergency)
- Show warning (penalty applies)
- Require reason
- Contact support automatically
- Affects provider rating

## Real-time Updates
- Job status changes
- Customer messages
- Time countdown
- Location proximity alerts

## Empty States
- **No Upcoming**: "No upcoming jobs. Accept requests from the Jobs tab."
- **No In Progress**: "No jobs in progress"
- **No Completed Today**: "No jobs completed today"

## Analytics
- `active_jobs_viewed`: Screen loaded
- `job_started`: Start button clicked
- `customer_called_from_active`: Call initiated
- `navigation_opened`: Directions requested
- `job_rescheduled`: Reschedule completed
- `job_cancelled_emergency`: Emergency cancellation
