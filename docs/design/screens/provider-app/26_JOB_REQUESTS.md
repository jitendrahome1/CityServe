# Job Requests

## Overview
- **Screen ID**: 26
- **Screen Name**: Job Requests (All Pending Jobs)
- **User Flow**: View all available job requests to accept or decline
- **Navigation**: From Dashboard "View All", Bottom Tab "Jobs"

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ←  Job Requests        [Filter] [Sort] │
├──────────────────────────────────────────┤
│  ┌──────────┐ ┌──────────┐ ┌─────────┐ │
│  │   All (5)│ │ Today (3)│ │ Urgent  │ │ ← Filter Tabs
│  └──────────┘ └──────────┘ └─────────┘ │
│   (selected)                             │
│                                          │
│  🔧 AC Repair & Service                  │
│  ┌────────────────────────────────────┐ │
│  │ 📍 Koramangala • 3.2 km            │ │
│  │ 📅 Today • 2:00 PM - 3:30 PM       │ │
│  │ 👤 Amit Kumar • ⭐ 4.5             │ │
│  │ 💰 ₹650                            │ │
│  │                                    │ │
│  │ ⏰ Respond in 8 minutes            │ │
│  │                                    │ │
│  │ [Decline]  [Accept]                │ │
│  └────────────────────────────────────┘ │
│                                          │
│  💡 Electrical Work                      │
│  ┌────────────────────────────────────┐ │
│  │ 📍 Indiranagar • 5.8 km            │ │
│  │ 📅 Tomorrow • 10:00 AM             │ │
│  │ 👤 Priya Sharma • ⭐ 4.8           │ │
│  │ 💰 ₹450                            │ │
│  │                                    │ │
│  │ ⏰ Respond in 12 minutes           │ │
│  │                                    │ │
│  │ [Decline]  [Accept]                │ │
│  └────────────────────────────────────┘ │
│                                          │
│  🔧 AC Installation                      │
│  ┌────────────────────────────────────┐ │
│  │ 📍 HSR Layout • 7.1 km             │ │
│  │ 📅 Dec 25 • 11:00 AM               │ │
│  │ 👤 Rahul Singh • ⭐ New Customer   │ │
│  │ 💰 ₹1,200                          │ │
│  │                                    │ │
│  │ ⏰ Respond in 25 minutes           │ │
│  │                                    │ │
│  │ [Decline]  [Accept]                │ │
│  └────────────────────────────────────┘ │
│                                          │
├──────────────────────────────────────────┤
│  🏠   💼   💰   👤                       │ ← Bottom Tab
│ Home  Jobs Earnings Profile             │
│      (selected)                          │
└──────────────────────────────────────────┘
```

## Key Features

### Filter Tabs
- **All**: All available requests
- **Today**: Jobs scheduled for today
- **Urgent**: Expiring soon (< 10 min)
- **Nearby**: Within 5km

### Sorting Options
- **Time** (default): By job scheduled time
- **Distance**: Nearest first
- **Price**: Highest first
- **Expiry**: Expiring soon first

### Job Card Elements
- Service icon and name
- Location with distance
- Date and time
- Customer name and rating
- Job amount
- Countdown timer (auto-updates)
- Accept/Decline buttons

## Interactions

### Accept Job
- Confirmation alert
- Add to active jobs
- Remove from requests
- Notify customer
- Success haptic + toast

### Decline Job
- Show decline reason sheet
- Log reason for analytics
- Remove from list
- Offer to next provider

### Filter Tap
- Switch filter category
- Cross-fade content
- Update count badge

### Sort Button
- Show sort options sheet
- Apply sorting
- Persist preference

### Pull to Refresh
- Reload available jobs
- Update countdown timers

## Real-time Updates
- Auto-refresh every 30 seconds
- Remove expired jobs
- Add new requests
- Update countdown timers

## Empty States
- **No Jobs**: "No job requests available. We'll notify you when jobs arrive."
- **Filtered**: "No jobs match your filter"

## SwiftUI Implementation (Condensed)

```swift
struct JobRequestsView: View {
    @StateObject private var viewModel = JobRequestsViewModel()
    @State private var selectedFilter: JobFilter = .all

    var body: some View {
        VStack {
            // Filter Tabs
            ScrollView(.horizontal) {
                HStack {
                    ForEach(JobFilter.allCases, id: \.self) { filter in
                        FilterTab(
                            title: filter.title,
                            count: viewModel.jobCount(for: filter),
                            isSelected: selectedFilter == filter,
                            onTap: { selectedFilter = filter }
                        )
                    }
                }
            }

            // Job List
            if filteredJobs.isEmpty {
                EmptyJobsView()
            } else {
                List(filteredJobs) { job in
                    JobRequestCard(
                        job: job,
                        onAccept: { acceptJob(job) },
                        onDecline: { declineJob(job) }
                    )
                }
            }
        }
        .onAppear { loadJobs() }
        .refreshable { await viewModel.refresh() }
    }

    var filteredJobs: [Job] {
        viewModel.filter(jobs: viewModel.jobs, by: selectedFilter)
    }
}
```

## Analytics
- `job_requests_viewed`: Screen loaded
- `job_filter_changed`: Filter switched
- `job_sorted`: Sort applied
- `job_accepted_from_list`: Quick accept
- `job_declined_from_list`: Quick decline
