# Set Availability

## Overview
- **Screen ID**: 31
- **Screen Name**: Set Availability
- **User Role**: Service Provider
- **Platform**: iOS, Android
- **Navigation**: From Availability Calendar (Screen 30) → Tap "Edit Availability" or from Date Detail Card

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ✕  Set Availability              Save   │
├──────────────────────────────────────────┤
│                                          │
│  📅 Date Range                           │
│  ┌────────────────────────────────────┐ │
│  │ From: 15 Jan 2025          ▼      │ │  ← Date picker
│  └────────────────────────────────────┘ │
│  ┌────────────────────────────────────┐ │
│  │ To: 15 Jan 2025            ▼      │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ☑ Apply to multiple days               │
│                                          │
│  ⏰ Working Hours                        │
│  ┌──────────────┐    to   ┌──────────┐ │
│  │ 09:00 AM  ▼ │         │ 06:00 PM▼││  ← Time pickers
│  └──────────────┘         └──────────┘ │
│                                          │
│  Break Time (Optional)                   │
│  ┌──────────────┐    to   ┌──────────┐ │
│  │ 01:00 PM  ▼ │         │ 02:00 PM▼││
│  └──────────────┘         └──────────┘ │
│                                          │
│  📊 Capacity                             │
│  Maximum jobs per day                    │
│  ┌────────────────────────────────────┐ │
│  │ [−]      3      [+]                │ │  ← Stepper
│  └────────────────────────────────────┘ │
│                                          │
│  Estimated working time per job: 2-3 hrs│
│                                          │
│  🔄 Repeat                               │
│  ┌────────────────────────────────────┐ │
│  │ Don't repeat               ▼       │ │  ← Dropdown
│  └────────────────────────────────────┘ │
│                                          │
│  Options:                                │
│  • Don't repeat                          │
│  • Every week                            │
│  • Every weekday (Mon-Fri)               │
│  • Every weekend (Sat-Sun)               │
│  • Custom...                             │
│                                          │
│  ☑ Override existing availability        │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │        Save Availability           │ │  ← Primary button
│  └────────────────────────────────────┘ │
│                                          │
│              Cancel                      │  ← Text button
│                                          │
└──────────────────────────────────────────┘
```

## Key Features

### Date Range Selection
- Single date or date range
- Visual date picker
- Quick presets (Today, Tomorrow, This Week, Next Week)
- Maximum 90 days in future
- Cannot select past dates

### Working Hours Configuration
- Start time and end time pickers
- 24-hour or 12-hour format (based on device settings)
- 30-minute intervals
- Validation: End time must be after start time
- Minimum 2 hours working window

### Break Time (Optional)
- Optional lunch/break period
- Automatically excluded from booking slots
- Must be within working hours
- Affects available booking windows

### Capacity Management
- Set maximum jobs per day
- Stepper control (+/-)
- Range: 1-10 jobs
- Shows estimated working time based on average service duration
- Warning if capacity too high for working hours

### Repeat Options

**Don't Repeat:**
- Apply only to selected date(s)

**Every Week:**
- Repeat same availability every week
- Until manually changed or end date specified

**Every Weekday:**
- Monday to Friday only
- Useful for regular work schedule

**Every Weekend:**
- Saturday and Sunday only

**Custom:**
- Select specific days of week
- Set end date for repetition
- More granular control

### Override Settings
- Option to override existing availability
- If unchecked and conflict exists, shows warning
- Confirmation dialog for overrides

## Component Breakdown

### Date Range Selector

```swift
struct DateRangeSelector: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @State private var applyToMultipleDays = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📅 Date Range")
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(.gray800)

            // From date
            DatePickerField(
                label: "From",
                date: $startDate,
                minimumDate: Date(),
                maximumDate: Date().addingDays(90)
            )

            // To date (only if applying to multiple days)
            if applyToMultipleDays {
                DatePickerField(
                    label: "To",
                    date: $endDate,
                    minimumDate: startDate,
                    maximumDate: Date().addingDays(90)
                )
            }

            // Toggle for multiple days
            Toggle(isOn: $applyToMultipleDays) {
                Text("Apply to multiple days")
                    .font(.system(size: 14))
                    .foregroundColor(.gray700)
            }
            .tint(.brandPrimary)
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

struct DatePickerField: View {
    let label: String
    @Binding var date: Date
    let minimumDate: Date
    let maximumDate: Date

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.system(size: 14))
                .foregroundColor(.gray600)
                .frame(width: 50, alignment: .leading)

            DatePicker(
                "",
                selection: $date,
                in: minimumDate...maximumDate,
                displayedComponents: .date
            )
            .labelsHidden()
            .accentColor(.brandPrimary)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
    }
}
```

### Working Hours Picker

```swift
struct WorkingHoursPicker: View {
    @Binding var startTime: Date
    @Binding var endTime: Date
    @State private var showBreakTime = false
    @Binding var breakStart: Date?
    @Binding var breakEnd: Date?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("⏰ Working Hours")
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(.gray800)

            // Working hours
            HStack(spacing: 12) {
                TimePickerField(
                    time: $startTime,
                    label: "Start"
                )

                Text("to")
                    .font(.system(size: 14))
                    .foregroundColor(.gray500)

                TimePickerField(
                    time: $endTime,
                    label: "End"
                )
            }

            // Validation message
            if !isValidTimeRange {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.error)

                    Text("End time must be after start time")
                        .font(.system(size: 12))
                        .foregroundColor(.error)
                }
            }

            // Total working hours
            Text("Total: \(totalWorkingHours) hours")
                .font(.system(size: 12))
                .foregroundColor(.gray600)

            Divider()

            // Break time toggle
            Toggle(isOn: $showBreakTime) {
                Text("Add break time")
                    .font(.system(size: 14))
                    .foregroundColor(.gray700)
            }
            .tint(.brandPrimary)

            // Break time pickers
            if showBreakTime {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Break Time")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(.gray700)

                    HStack(spacing: 12) {
                        TimePickerField(
                            time: Binding(
                                get: { breakStart ?? startTime },
                                set: { breakStart = $0 }
                            ),
                            label: "Start"
                        )

                        Text("to")
                            .font(.system(size: 14))
                            .foregroundColor(.gray500)

                        TimePickerField(
                            time: Binding(
                                get: { breakEnd ?? endTime },
                                set: { breakEnd = $0 }
                            ),
                            label: "End"
                        )
                    }
                }
                .padding(12)
                .background(Color.gray100)
                .cornerRadius(8)
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }

    var isValidTimeRange: Bool {
        endTime > startTime && totalWorkingHours >= 2
    }

    var totalWorkingHours: Int {
        let hours = Calendar.current.dateComponents([.hour], from: startTime, to: endTime).hour ?? 0
        let breakHours = breakStart != nil && breakEnd != nil ?
            Calendar.current.dateComponents([.hour], from: breakStart!, to: breakEnd!).hour ?? 0 : 0
        return max(0, hours - breakHours)
    }
}

struct TimePickerField: View {
    @Binding var time: Date
    let label: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.gray600)

            DatePicker(
                "",
                selection: $time,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            .datePickerStyle(.compact)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(Color.white)
            .cornerRadius(8)
        }
    }
}
```

### Capacity Stepper

```swift
struct CapacityStepper: View {
    @Binding var maxJobs: Int
    let workingHours: Int
    let averageJobDuration: Double = 2.5 // hours

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📊 Capacity")
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(.gray800)

            Text("Maximum jobs per day")
                .font(.system(size: 14))
                .foregroundColor(.gray600)

            HStack {
                // Minus button
                Button(action: { if maxJobs > 1 { maxJobs -= 1 } }) {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(maxJobs > 1 ? .brandPrimary : .gray300)
                        .frame(width: 44, height: 44)
                        .background(Color.gray100)
                        .clipShape(Circle())
                }
                .disabled(maxJobs <= 1)

                // Value
                Text("\(maxJobs)")
                    .font(.custom("Inter-SemiBold", size: 32))
                    .foregroundColor(.gray900)
                    .frame(maxWidth: .infinity)

                // Plus button
                Button(action: { if maxJobs < 10 { maxJobs += 1 } }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(maxJobs < 10 ? .brandPrimary : .gray300)
                        .frame(width: 44, height: 44)
                        .background(Color.gray100)
                        .clipShape(Circle())
                }
                .disabled(maxJobs >= 10)
            }

            // Estimated time
            HStack(spacing: 6) {
                Image(systemName: "clock")
                    .font(.system(size: 12))
                    .foregroundColor(.gray500)

                Text(estimatedTimeText)
                    .font(.system(size: 12))
                    .foregroundColor(.gray600)
            }

            // Warning if capacity too high
            if isCapacityTooHigh {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.warning)

                    Text("High capacity may cause scheduling conflicts")
                        .font(.system(size: 12))
                        .foregroundColor(.warning)
                }
                .padding(8)
                .background(Color.warning.opacity(0.1))
                .cornerRadius(6)
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }

    var estimatedTimeText: String {
        let totalHours = averageJobDuration * Double(maxJobs)
        return "Estimated working time per job: \(Int(averageJobDuration))-\(Int(averageJobDuration + 1)) hrs"
    }

    var isCapacityTooHigh: Bool {
        let totalEstimatedHours = averageJobDuration * Double(maxJobs)
        return totalEstimatedHours > Double(workingHours)
    }
}
```

### Repeat Options Selector

```swift
struct RepeatOptionsSelector: View {
    @Binding var repeatOption: RepeatOption
    @State private var showCustomSheet = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("🔄 Repeat")
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(.gray800)

            Menu {
                ForEach(RepeatOption.allCases, id: \.self) { option in
                    Button(action: {
                        if option == .custom {
                            showCustomSheet = true
                        } else {
                            repeatOption = option
                        }
                    }) {
                        HStack {
                            Text(option.displayName)
                            if repeatOption == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(repeatOption.displayName)
                        .font(.system(size: 14))
                        .foregroundColor(.gray800)

                    Spacer()

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.gray500)
                }
                .padding(12)
                .background(Color.white)
                .cornerRadius(8)
            }

            // Explanation text
            if repeatOption != .none {
                Text(repeatOption.description)
                    .font(.system(size: 12))
                    .foregroundColor(.gray600)
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
        .sheet(isPresented: $showCustomSheet) {
            CustomRepeatSheet(
                repeatOption: $repeatOption,
                onSave: { showCustomSheet = false }
            )
        }
    }
}

enum RepeatOption: CaseIterable {
    case none
    case everyWeek
    case weekdays
    case weekends
    case custom

    var displayName: String {
        switch self {
        case .none: return "Don't repeat"
        case .everyWeek: return "Every week"
        case .weekdays: return "Every weekday (Mon-Fri)"
        case .weekends: return "Every weekend (Sat-Sun)"
        case .custom: return "Custom..."
        }
    }

    var description: String {
        switch self {
        case .none: return "Apply only to selected date(s)"
        case .everyWeek: return "Same availability every week until changed"
        case .weekdays: return "Monday through Friday only"
        case .weekends: return "Saturday and Sunday only"
        case .custom: return "Custom repeat pattern"
        }
    }
}
```

## Interactions

### Save Availability
```swift
func saveAvailability() {
    // Validate inputs
    guard validateInputs() else { return }

    // Show loading
    isLoading = true

    Task {
        do {
            // Build availability data
            let availabilityData = AvailabilityData(
                dateRange: startDate...endDate,
                workingHours: TimeRange(start: startTime, end: endTime),
                breakTime: breakStart != nil ? TimeRange(start: breakStart!, end: breakEnd!) : nil,
                maxJobs: maxJobs,
                repeatOption: repeatOption,
                overrideExisting: overrideExisting
            )

            // Check for conflicts
            if !overrideExisting {
                let conflicts = await viewModel.checkConflicts(availabilityData)
                if !conflicts.isEmpty {
                    showConflictAlert(conflicts)
                    isLoading = false
                    return
                }
            }

            // Save availability
            let success = await viewModel.saveAvailability(availabilityData)

            isLoading = false

            if success {
                ToastManager.show("Availability saved successfully")
                HapticManager.notification(.success)
                dismiss()
            } else {
                AlertManager.showError("Failed to save availability")
            }
        } catch {
            isLoading = false
            AlertManager.showError(error.localizedDescription)
        }
    }
}

func validateInputs() -> Bool {
    // Validate date range
    guard startDate <= endDate else {
        AlertManager.showError("Start date must be before end date")
        return false
    }

    // Validate working hours
    guard endTime > startTime else {
        AlertManager.showError("End time must be after start time")
        return false
    }

    // Validate minimum working hours
    let workingHours = Calendar.current.dateComponents([.hour], from: startTime, to: endTime).hour ?? 0
    guard workingHours >= 2 else {
        AlertManager.showError("Minimum 2 hours working time required")
        return false
    }

    // Validate break time if provided
    if let breakStart = breakStart, let breakEnd = breakEnd {
        guard breakEnd > breakStart else {
            AlertManager.showError("Invalid break time")
            return false
        }

        // Break must be within working hours
        guard breakStart >= startTime && breakEnd <= endTime else {
            AlertManager.showError("Break time must be within working hours")
            return false
        }
    }

    // Validate capacity
    guard maxJobs >= 1 && maxJobs <= 10 else {
        AlertManager.showError("Capacity must be between 1 and 10 jobs")
        return false
    }

    return true
}
```

### Conflict Handling
```swift
func showConflictAlert(_ conflicts: [AvailabilityConflict]) {
    let message = conflicts.map { conflict in
        "\(conflict.date.formatted): \(conflict.existingBookings) existing bookings"
    }.joined(separator: "\n")

    AlertManager.show(
        title: "Availability Conflicts",
        message: "The following dates have existing bookings:\n\n\(message)\n\nDo you want to override?",
        primaryButton: "Override",
        secondaryButton: "Cancel",
        primaryAction: {
            overrideExisting = true
            saveAvailability()
        }
    )
}
```

### Cancel Action
```swift
func handleCancel() {
    if hasUnsavedChanges {
        AlertManager.show(
            title: "Discard Changes?",
            message: "You have unsaved changes. Are you sure you want to discard them?",
            primaryButton: "Discard",
            secondaryButton: "Keep Editing",
            destructive: true,
            primaryAction: {
                dismiss()
            }
        )
    } else {
        dismiss()
    }
}

var hasUnsavedChanges: Bool {
    // Check if any field has been modified from initial values
    startDate != initialStartDate ||
    endDate != initialEndDate ||
    startTime != initialStartTime ||
    endTime != initialEndTime ||
    maxJobs != initialMaxJobs ||
    repeatOption != initialRepeatOption
}
```

## States

### Default State
- All fields pre-filled with current availability (if editing)
- Or defaults for new availability:
  - Date: Today
  - Working hours: 9:00 AM - 6:00 PM
  - Max jobs: 3
  - No break time
  - Don't repeat

### Loading State
- Save button shows spinner
- All inputs disabled
- "Saving..." text

### Validation Error State
- Red border on invalid fields
- Error message below field
- Save button disabled

### Conflict Warning State
- Orange banner showing conflicts
- Option to override or cancel
- List of conflicting dates

## API Integration

### Save Availability
```typescript
POST /providers/{providerId}/availability
Body:
{
  "dateRange": {
    "start": "2025-01-15",
    "end": "2025-01-15"
  },
  "workingHours": {
    "start": "09:00",
    "end": "18:00"
  },
  "breakTime": {
    "start": "13:00",
    "end": "14:00"
  },
  "maxJobs": 3,
  "repeatPattern": "everyWeek",
  "overrideExisting": false
}

Response:
{
  "success": true,
  "message": "Availability saved for 52 dates",
  "conflicts": []
}
```

### Check Conflicts
```typescript
POST /providers/{providerId}/availability/check-conflicts
Body:
{
  "dateRange": {
    "start": "2025-01-15",
    "end": "2025-01-31"
  }
}

Response:
{
  "success": true,
  "conflicts": [
    {
      "date": "2025-01-20",
      "existingBookings": 2,
      "reason": "Has confirmed bookings"
    }
  ]
}
```

## Navigation

### Entry Points
- Screen 30 (Availability Calendar) → Tap "Edit Availability"
- Screen 30 → Tap date, then "Edit Availability" button
- Provider Dashboard → "Quick Set Availability"

### Exit Points
- Tap "Save" → Return to Screen 30 with updated calendar
- Tap "Cancel" / Close button → Return to previous screen
- Successful save → Dismiss sheet

## Accessibility

### VoiceOver Labels
- Date pickers: "From date, 15 January 2025, Picker"
- Time pickers: "Start time, 9:00 AM, Picker"
- Stepper: "Maximum jobs, 3, Stepper, Increase, Decrease"
- Save button: "Save availability, Button"

### Touch Targets
- All pickers: 44pt minimum height
- Stepper buttons: 44x44pt
- Save button: 48pt height

## Analytics Events

```typescript
analytics.track('set_availability_opened', {
  source: 'calendar', // or 'dashboard' or 'job_request'
  edit_mode: true, // false if new
  date: '2025-01-15'
})

analytics.track('availability_saved', {
  date_range_days: 7,
  working_hours: 9,
  max_jobs: 3,
  has_break_time: true,
  repeat_option: 'everyWeek',
  override_conflicts: false
})

analytics.track('availability_save_failed', {
  error: 'validation_error',
  field: 'working_hours'
})
```

## Testing Checklist

- [ ] Date range validation works
- [ ] Time pickers show correct format
- [ ] Working hours validation (minimum 2 hours)
- [ ] Break time must be within working hours
- [ ] Capacity stepper range (1-10)
- [ ] Repeat options work correctly
- [ ] Conflict detection works
- [ ] Override confirmation shows
- [ ] Save button disabled during save
- [ ] Success message shows
- [ ] Calendar updates after save
- [ ] Cancel confirmation if changes made
- [ ] Validation errors display correctly
- [ ] All touch targets meet minimum size
- [ ] VoiceOver navigation works
- [ ] Keyboard dismisses appropriately

## Design Notes

**iOS**: Use native date/time pickers
**Android**: Use Material Design date/time pickers
**Validation**: Real-time validation with debounce
**Autosave**: Consider draft auto-save for long forms
