//
//  AdvancedFiltersView.swift
//  CityServe
//
//  Advanced Search Filters with comprehensive filtering options
//  Design Spec: 38_ADVANCED_FILTERS.md
//

import SwiftUI

struct AdvancedFiltersView: View {

    @Binding var filters: ServiceFilters
    @Environment(\.dismiss) var dismiss
    let onApply: () -> Void

    @State private var localFilters: ServiceFilters
    @State private var resultCount: Int = 0

    init(filters: Binding<ServiceFilters>, onApply: @escaping () -> Void) {
        self._filters = filters
        self.onApply = onApply
        self._localFilters = State(initialValue: filters.wrappedValue)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: Spacing.lg) {
                        locationSection
                        priceRangeSection
                        ratingSection
                        availabilitySection
                        providerPreferencesSection
                        serviceTypeSection
                        additionalFiltersSection
                    }
                    .padding(Spacing.screenPadding)
                }

                applyButtonOverlay
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: Spacing.iconMD))
                            .foregroundColor(.textPrimary)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        resetFilters()
                    }
                    .font(.button)
                    .foregroundColor(.primary)
                }
            }
        }
        .onAppear {
            updateResultCount()
        }
    }

    // MARK: - View Components

    private var locationSection: some View {
        FilterSection(title: "Location") {
            VStack(alignment: .leading, spacing: Spacing.md) {
                RadioButton(
                    title: "Current Location (Auto-detect)",
                    isSelected: localFilters.useCurrentLocation,
                    onTap: {
                        localFilters.useCurrentLocation = true
                        updateResultCount()
                    }
                )

                RadioButton(
                    title: "Custom Location",
                    isSelected: !localFilters.useCurrentLocation,
                    onTap: {
                        localFilters.useCurrentLocation = false
                        updateResultCount()
                    }
                )

                // Distance Slider
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Distance Range")
                        .font(.label)
                        .foregroundColor(.textSecondary)

                    Slider(value: $localFilters.distanceKm, in: 1...50, step: 1)
                        .tint(Color.primary)
                        .onChange(of: localFilters.distanceKm) { _, _ in
                            updateResultCount()
                        }

                    Text("Within \(Int(localFilters.distanceKm)) km")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }
            }
        }
    }

    private var minPriceBinding: Binding<Double> {
        Binding(
            get: { localFilters.priceRange?.min ?? 0 },
            set: { newValue in
                if let existingRange = localFilters.priceRange {
                    localFilters.priceRange = PriceRange(min: newValue, max: existingRange.max)
                } else {
                    localFilters.priceRange = PriceRange(min: newValue, max: 10000)
                }
                updateResultCount()
            }
        )
    }

    private var maxPriceBinding: Binding<Double> {
        Binding(
            get: { localFilters.priceRange?.max ?? 10000 },
            set: { newValue in
                if let existingRange = localFilters.priceRange {
                    localFilters.priceRange = PriceRange(min: existingRange.min, max: newValue)
                } else {
                    localFilters.priceRange = PriceRange(min: 0, max: newValue)
                }
                updateResultCount()
            }
        )
    }

    private var priceRangeSection: some View {
        FilterSection(title: "Price Range") {
            VStack(alignment: .leading, spacing: Spacing.md) {
                HStack(spacing: Spacing.md) {
                    minPriceField
                    maxPriceField
                }
            }
        }
    }

    private var minPriceField: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("Min")
                .font(.caption)
                .foregroundColor(.textSecondary)

            HStack(spacing: Spacing.xxs) {
                Text("₹")
                    .font(.h5)
                    .foregroundColor(.textSecondary)

                TextField("0", value: minPriceBinding, format: .number)
                    .keyboardType(.numberPad)
                    .font(.h5)
                    .foregroundColor(.textPrimary)
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusMd)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .stroke(Color.divider, lineWidth: 1)
            )
        }
    }

    private var maxPriceField: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("Max")
                .font(.caption)
                .foregroundColor(.textSecondary)

            HStack(spacing: Spacing.xxs) {
                Text("₹")
                    .font(.h5)
                    .foregroundColor(.textSecondary)

                TextField("10,000", value: maxPriceBinding, format: .number)
                    .keyboardType(.numberPad)
                    .font(.h5)
                    .foregroundColor(.textPrimary)
            }
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusMd)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .stroke(Color.divider, lineWidth: 1)
            )
        }
    }

    private var ratingSection: some View {
        FilterSection(title: "Rating") {
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Minimum Rating")
                    .font(.label)
                    .foregroundColor(.textSecondary)

                ForEach(RatingFilter.allCases, id: \.self) { rating in
                    RadioButton(
                        title: rating.displayName,
                        isSelected: localFilters.minRating == rating.rawValue,
                        onTap: {
                            localFilters.minRating = rating.rawValue == 0 ? nil : rating.rawValue
                            updateResultCount()
                        }
                    )
                }
            }
        }
    }

    private var availabilitySection: some View {
        FilterSection(title: "Availability") {
            VStack(alignment: .leading, spacing: Spacing.md) {
                CheckboxRow(
                    title: "Available Today",
                    isChecked: Binding(
                        get: { localFilters.availableToday },
                        set: { localFilters.availableToday = $0; updateResultCount() }
                    )
                )

                CheckboxRow(
                    title: "Available This Week",
                    isChecked: Binding(
                        get: { localFilters.availableThisWeek },
                        set: { localFilters.availableThisWeek = $0; updateResultCount() }
                    )
                )

                // Preferred Time Slot
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Preferred Time Slot")
                        .font(.label)
                        .foregroundColor(.textSecondary)

                    Menu {
                        ForEach(TimeSlotOption.allCases, id: \.self) { slot in
                            Button(action: {
                                localFilters.preferredTimeSlot = slot
                                updateResultCount()
                            }) {
                                HStack {
                                    Text(slot.displayName)
                                    if localFilters.preferredTimeSlot == slot {
                                        Spacer()
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text(localFilters.preferredTimeSlot?.displayName ?? "Any Time")
                                .font(.h5)
                                .foregroundColor(.textPrimary)

                            Spacer()

                            Image(systemName: "chevron.down")
                                .font(.system(size: Spacing.iconXS))
                                .foregroundColor(.textTertiary)
                        }
                        .padding(Spacing.md)
                        .background(Color.surface)
                        .cornerRadius(Spacing.radiusMd)
                        .overlay(
                            RoundedRectangle(cornerRadius: Spacing.radiusMd)
                                .stroke(Color.divider, lineWidth: 1)
                        )
                    }
                }
            }
        }
    }

    private var providerPreferencesSection: some View {
        FilterSection(title: "Provider Preferences") {
            VStack(alignment: .leading, spacing: Spacing.md) {
                CheckboxRow(
                    title: "Verified Providers Only",
                    isChecked: Binding(
                        get: { localFilters.verifiedOnly },
                        set: { localFilters.verifiedOnly = $0; updateResultCount() }
                    )
                )

                CheckboxRow(
                    title: "Top Rated (4.5+)",
                    isChecked: Binding(
                        get: { localFilters.topRatedOnly },
                        set: { localFilters.topRatedOnly = $0; updateResultCount() }
                    )
                )

                CheckboxRow(
                    title: "Experienced (5+ years)",
                    isChecked: Binding(
                        get: { localFilters.experiencedOnly },
                        set: { localFilters.experiencedOnly = $0; updateResultCount() }
                    )
                )

                CheckboxRow(
                    title: "Fast Response Time (< 5 mins)",
                    isChecked: Binding(
                        get: { localFilters.fastResponseOnly },
                        set: { localFilters.fastResponseOnly = $0; updateResultCount() }
                    )
                )
            }
        }
    }

    private var serviceTypeSection: some View {
        FilterSection(title: "Service Type") {
            VStack(alignment: .leading, spacing: Spacing.md) {
                CheckboxRow(
                    title: "Residential",
                    isChecked: Binding(
                        get: { localFilters.residentialServices },
                        set: { localFilters.residentialServices = $0; updateResultCount() }
                    )
                )

                CheckboxRow(
                    title: "Commercial",
                    isChecked: Binding(
                        get: { localFilters.commercialServices },
                        set: { localFilters.commercialServices = $0; updateResultCount() }
                    )
                )

                CheckboxRow(
                    title: "Emergency/24x7",
                    isChecked: Binding(
                        get: { localFilters.emergencyServices },
                        set: { localFilters.emergencyServices = $0; updateResultCount() }
                    )
                )
            }
        }
    }

    private var additionalFiltersSection: some View {
        FilterSection(title: "Additional Filters") {
            VStack(alignment: .leading, spacing: Spacing.md) {
                CheckboxRow(
                    title: "Offers Available",
                    isChecked: Binding(
                        get: { localFilters.offersAvailable },
                        set: { localFilters.offersAvailable = $0; updateResultCount() }
                    )
                )

                CheckboxRow(
                    title: "Free Cancellation",
                    isChecked: Binding(
                        get: { localFilters.freeCancellation },
                        set: { localFilters.freeCancellation = $0; updateResultCount() }
                    )
                )

                CheckboxRow(
                    title: "Same Day Service",
                    isChecked: Binding(
                        get: { localFilters.sameDayService },
                        set: { localFilters.sameDayService = $0; updateResultCount() }
                    )
                )

                CheckboxRow(
                    title: "Warranty Included",
                    isChecked: Binding(
                        get: { localFilters.warrantyIncluded },
                        set: { localFilters.warrantyIncluded = $0; updateResultCount() }
                    )
                )
            }
        }
    }

    private var applyButtonOverlay: some View {
        VStack {
            Spacer()

            PrimaryButton(
                "Apply Filters (\(resultCount) results)",
                size: .large
            ) {
                applyFilters()
            }
            .padding(.horizontal, Spacing.screenPadding)
            .padding(.bottom, Spacing.lg)
            .background(
                LinearGradient(
                    colors: [Color.background.opacity(0), Color.background],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 100)
            )
        }
    }

    // MARK: - Actions

    private func applyFilters() {
        Haptics.medium()
        filters = localFilters
        onApply()
        dismiss()
    }

    private func resetFilters() {
        Haptics.light()
        localFilters = ServiceFilters()
        updateResultCount()
    }

    private func updateResultCount() {
        // TODO: Calculate actual result count based on filters
        // For now, simulate with a random count
        resultCount = Int.random(in: 10...50)
    }
}

// MARK: - Filter Section

struct FilterSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(title)
                .font(.h5)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)

            content
        }
    }
}

// MARK: - Radio Button

struct RadioButton: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: {
            Haptics.light()
            onTap()
        }) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: isSelected ? "circle.inset.filled" : "circle")
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(isSelected ? Color.primary : Color.textTertiary)

                Text(title)
                    .font(.body)
                    .foregroundColor(.textPrimary)

                Spacer()
            }
            .padding(.vertical, Spacing.xs)
        }
    }
}

// MARK: - Checkbox Row

struct CheckboxRow: View {
    let title: String
    @Binding var isChecked: Bool

    var body: some View {
        Toggle(isOn: Binding(
            get: { isChecked },
            set: { newValue in
                Haptics.light()
                isChecked = newValue
            }
        )) {
            Text(title)
                .font(.body)
                .foregroundColor(.textPrimary)
        }
        .tint(Color.primary)
    }
}

// MARK: - Supporting Enums

enum RatingFilter: Double, CaseIterable {
    case any = 0
    case threePlus = 3.0
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

// MARK: - Preview

#Preview("Advanced Filters - Light") {
    AdvancedFiltersView(
        filters: .constant(ServiceFilters()),
        onApply: { print("Filters applied") }
    )
}

#Preview("Advanced Filters - Dark") {
    AdvancedFiltersView(
        filters: .constant(ServiceFilters()),
        onApply: { print("Filters applied") }
    )
    .preferredColorScheme(.dark)
}

#Preview("Advanced Filters - With Active Filters") {
    var filters = ServiceFilters()
    filters.minRating = 4.0
    filters.verifiedOnly = true
    filters.availableToday = true

    return AdvancedFiltersView(
        filters: .constant(filters),
        onApply: { print("Filters applied") }
    )
}
