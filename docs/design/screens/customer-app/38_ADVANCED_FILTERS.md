# Screen 38: Advanced Filters

## Overview

- **Screen ID**: 38
- **Screen Name**: Advanced Filters
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 37 (Search Results) → Tap filter icon (⋮)
  - From: Screen 03 (Home) → Tap "Filters" in search

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  Filters                    ✕    Reset │ Header
├─────────────────────────────────────────┤
│                                         │
│  ───── Location ─────                   │
│                                         │
│  ● Current Location (Auto-detect)       │ Radio
│  ○ Custom Location                      │
│                                         │
│  Distance Range                         │
│  ┌────────────────────────────────┐    │
│  │ ●──────────────────○            │    │ Slider
│  └────────────────────────────────┘    │
│  Within 5 km                            │
│                                         │
│  ───── Price Range ─────                │
│                                         │
│  ┌──────────────┬──────────────┐       │
│  │ Min: ₹ 0     │ Max: ₹ 5,000 │       │ Number Inputs
│  └──────────────┴──────────────┘       │
│                                         │
│  ┌────────────────────────────────┐    │
│  │ ●──────────────────────○        │    │ Range Slider
│  └────────────────────────────────┘    │
│  ₹ 0                          ₹ 10,000 │
│                                         │
│  ───── Rating ─────                     │
│                                         │
│  Minimum Rating                         │
│  ○ Any                                  │ Radio
│  ○ 3.0+ ⭐⭐⭐                           │
│  ● 4.0+ ⭐⭐⭐⭐                         │
│  ○ 4.5+ ⭐⭐⭐⭐⭐                       │
│  ○ 5.0 ⭐⭐⭐⭐⭐ only                   │
│                                         │
│  ───── Availability ─────               │
│                                         │
│  ☑ Available Today                      │ Checkboxes
│  ☐ Available This Week                  │
│  ☐ Available Anytime                    │
│                                         │
│  Preferred Time Slot                    │
│  ┌────────────────────────────────┐    │
│  │ Morning (6 AM - 12 PM)       ▼  │    │ Dropdown
│  └────────────────────────────────┘    │
│                                         │
│  ───── Provider Preferences ─────       │
│                                         │
│  ☑ Verified Providers Only              │ Checkboxes
│  ☐ Top Rated (4.5+)                     │
│  ☐ Experienced (5+ years)               │
│  ☐ Fast Response Time (< 5 mins)        │
│                                         │
│  ───── Service Type ─────               │
│                                         │
│  ☐ Residential                          │
│  ☐ Commercial                           │
│  ☐ Emergency/24x7                       │
│                                         │
│  ───── Languages ─────                  │
│                                         │
│  ☐ English                              │
│  ☑ Hindi                                │
│  ☐ Bengali                              │
│  ☐ Tamil                                │
│  ☐ Telugu                               │
│  [+ More Languages]                     │
│                                         │
│  ───── Additional Filters ─────         │
│                                         │
│  ☐ Offers Available                     │
│  ☐ Free Cancellation                    │
│  ☐ Same Day Service                     │
│  ☐ Warranty Included                    │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │    Apply Filters (45 results)    │   │ Primary CTA
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Location Filters
- Current location (auto-detect)
- Custom location (enter address)
- Distance radius slider (1-50 km)
- "Near Me" quick toggle

### 2. Price Range
- Min/max price inputs
- Dual-handle range slider
- Preset price ranges
- "Budget-friendly" / "Premium" quick filters

### 3. Rating Filter
- Minimum rating selector (Any, 3.0+, 4.0+, 4.5+, 5.0)
- Star visualization
- Review count filter (min reviews)

### 4. Availability
- Available today, this week, anytime
- Preferred time slots (morning, afternoon, evening, night)
- Specific date/time picker

### 5. Provider Preferences
- Verified only
- Top rated (4.5+)
- Experienced (5+ years)
- Fast response time
- Background verified

### 6. Service Type
- Residential, Commercial, Emergency/24x7
- Multi-select

### 7. Languages
- Provider language preferences
- Multi-select common languages
- "More Languages" expansion

### 8. Additional Filters
- Offers/discounts available
- Free cancellation
- Same-day service
- Warranty included
- Insurance covered

## Component Breakdown

```swift
struct AdvancedFiltersView: View {
    @StateObject private var viewModel = FiltersViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Location Section
                    FilterSection(title: "Location") {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(LocationOption.allCases, id: \.self) { option in
                                RadioButton(
                                    title: option.displayName,
                                    isSelected: viewModel.locationOption == option,
                                    onTap: { viewModel.locationOption = option }
                                )
                            }

                            // Distance Slider
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Distance Range")
                                    .font(.custom("Inter-Medium", size: 14))
                                    .foregroundColor(Color("TextSecondary"))

                                Slider(value: $viewModel.distanceKm, in: 1...50, step: 1)
                                    .tint(Color("PrimaryTeal"))

                                Text("Within \(Int(viewModel.distanceKm)) km")
                                    .font(.custom("Inter-Regular", size: 12))
                                    .foregroundColor(Color("TextTertiary"))
                            }
                        }
                    }

                    // Price Range Section
                    FilterSection(title: "Price Range") {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Min")
                                        .font(.custom("Inter-Regular", size: 12))
                                        .foregroundColor(Color("TextSecondary"))

                                    HStack {
                                        Text("₹")
                                            .foregroundColor(Color("TextSecondary"))
                                        TextField("0", value: $viewModel.minPrice, format: .number)
                                            .keyboardType(.numberPad)
                                    }
                                    .font(.custom("Inter-Regular", size: 16))
                                    .padding(12)
                                    .background(Color("BackgroundSecondary"))
                                    .cornerRadius(8)
                                }

                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Max")
                                        .font(.custom("Inter-Regular", size: 12))
                                        .foregroundColor(Color("TextSecondary"))

                                    HStack {
                                        Text("₹")
                                            .foregroundColor(Color("TextSecondary"))
                                        TextField("10,000", value: $viewModel.maxPrice, format: .number)
                                            .keyboardType(.numberPad)
                                    }
                                    .font(.custom("Inter-Regular", size: 16))
                                    .padding(12)
                                    .background(Color("BackgroundSecondary"))
                                    .cornerRadius(8)
                                }
                            }

                            // Range Slider
                            RangeSlider(
                                minValue: $viewModel.minPrice,
                                maxValue: $viewModel.maxPrice,
                                bounds: 0...10000
                            )
                            .tint(Color("PrimaryTeal"))
                        }
                    }

                    // Rating Section
                    FilterSection(title: "Rating") {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Minimum Rating")
                                .font(.custom("Inter-Medium", size: 14))
                                .foregroundColor(Color("TextSecondary"))

                            ForEach(RatingFilter.allCases, id: \.self) { rating in
                                RadioButton(
                                    title: rating.displayName,
                                    isSelected: viewModel.minRating == rating,
                                    onTap: { viewModel.minRating = rating }
                                )
                            }
                        }
                    }

                    // Availability Section
                    FilterSection(title: "Availability") {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(AvailabilityOption.allCases, id: \.self) { option in
                                CheckboxRow(
                                    title: option.displayName,
                                    isChecked: viewModel.availability.contains(option),
                                    onToggle: { viewModel.toggleAvailability(option) }
                                )
                            }

                            // Time Slot Picker
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Preferred Time Slot")
                                    .font(.custom("Inter-Medium", size: 14))
                                    .foregroundColor(Color("TextSecondary"))

                                Picker("", selection: $viewModel.timeSlot) {
                                    ForEach(TimeSlot.allCases, id: \.self) { slot in
                                        Text(slot.displayName).tag(slot)
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(Color("PrimaryTeal"))
                            }
                        }
                    }

                    // Provider Preferences
                    FilterSection(title: "Provider Preferences") {
                        VStack(alignment: .leading, spacing: 12) {
                            CheckboxRow(title: "Verified Providers Only", isChecked: $viewModel.verifiedOnly)
                            CheckboxRow(title: "Top Rated (4.5+)", isChecked: $viewModel.topRatedOnly)
                            CheckboxRow(title: "Experienced (5+ years)", isChecked: $viewModel.experiencedOnly)
                            CheckboxRow(title: "Fast Response Time (< 5 mins)", isChecked: $viewModel.fastResponseOnly)
                        }
                    }

                    // Apply Button
                    Button(action: applyFilters) {
                        Text("Apply Filters (\(viewModel.resultCount) results)")
                            .font(.custom("Inter-SemiBold", size: 16))
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .foregroundColor(.white)
                            .background(Color("PrimaryTeal"))
                            .cornerRadius(8)
                    }
                }
                .padding(16)
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color("TextPrimary"))
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        viewModel.resetFilters()
                    }
                    .foregroundColor(Color("PrimaryTeal"))
                }
            }
        }
    }

    func applyFilters() {
        viewModel.saveFilters()
        dismiss()
    }
}

struct FilterSection<Content: View>: View {
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

            content
        }
        .padding(.bottom, 8)
    }
}

struct RadioButton: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: isSelected ? "circle.fill" : "circle")
                    .foregroundColor(isSelected ? Color("PrimaryTeal") : Color("TextTertiary"))
                    .font(.system(size: 18))

                Text(title)
                    .font(.custom("Inter-Regular", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                Spacer()
            }
            .padding(.vertical, 6)
        }
    }
}

struct CheckboxRow: View {
    let title: String
    @Binding var isChecked: Bool
    var onToggle: (() -> Void)? = nil

    init(title: String, isChecked: Binding<Bool>, onToggle: (() -> Void)? = nil) {
        self.title = title
        self._isChecked = isChecked
        self.onToggle = onToggle
    }

    var body: some View {
        Toggle(isOn: Binding(
            get: { isChecked },
            set: { newValue in
                isChecked = newValue
                onToggle?()
            }
        )) {
            Text(title)
                .font(.custom("Inter-Regular", size: 15))
                .foregroundColor(Color("TextPrimary"))
        }
        .tint(Color("PrimaryTeal"))
    }
}

enum LocationOption: CaseIterable {
    case current, custom

    var displayName: String {
        switch self {
        case .current: return "Current Location (Auto-detect)"
        case .custom: return "Custom Location"
        }
    }
}

enum RatingFilter: Double, CaseIterable {
    case any = 0
    case threeP lus = 3.0
    case fourPlus = 4.0
    case fourHalfPlus = 4.5
    case fiveOnly = 5.0

    var displayName: String {
        switch self {
        case .any: return "Any"
        case .threePlus: return "3.0+ ⭐⭐⭐"
        case .fourPlus: return "4.0+ ⭐⭐⭐⭐"
        case .fourHalfPlus: return "4.5+ ⭐⭐⭐⭐⭐"
        case .fiveOnly: return "5.0 ⭐⭐⭐⭐⭐ only"
        }
    }
}

enum AvailabilityOption: CaseIterable {
    case today, thisWeek, anytime

    var displayName: String {
        switch self {
        case .today: return "Available Today"
        case .thisWeek: return "Available This Week"
        case .anytime: return "Available Anytime"
        }
    }
}

enum TimeSlot: CaseIterable {
    case morning, afternoon, evening, night

    var displayName: String {
        switch self {
        case .morning: return "Morning (6 AM - 12 PM)"
        case .afternoon: return "Afternoon (12 PM - 6 PM)"
        case .evening: return "Evening (6 PM - 10 PM)"
        case .night: return "Night (10 PM - 6 AM)"
        }
    }
}
```

## API Integration

```
PUT /search/filters

Request:
{
  "location": {
    "type": "current",
    "distanceKm": 5
  },
  "priceRange": {
    "min": 0,
    "max": 5000
  },
  "minRating": 4.0,
  "availability": ["today"],
  "timeSlot": "morning",
  "verifiedOnly": true,
  "topRatedOnly": false,
  "experiencedOnly": false,
  "fastResponseOnly": false,
  "serviceTypes": [],
  "languages": ["hindi"],
  "additionalFilters": []
}

Response:
{
  "success": true,
  "data": {
    "resultCount": 45,
    "appliedFilters": { /* filters */ }
  }
}
```

## Testing Checklist

- [ ] All filters apply correctly
- [ ] Reset button clears all filters
- [ ] Result count updates in real-time
- [ ] Sliders work smoothly
- [ ] Checkboxes toggle correctly
- [ ] Radio buttons select one option
- [ ] Apply button returns to search results
- [ ] Filters persist across sessions

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
