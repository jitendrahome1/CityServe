//
//  DateTimeSelectionView.swift
//  CityServe
//
//  Date and Time Slot Selection
//

import SwiftUI

struct DateTimeSelectionView: View {

    @ObservedObject var viewModel: BookingViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.xl) {
                // Header
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("When do you need the service?")
                        .font(.h3)
                        .foregroundColor(.textPrimary)
                        .fontWeight(.semibold)

                    Text("Select a convenient date and time")
                        .font(.body)
                        .foregroundColor(.textSecondary)
                }

                // Date Selection
                dateSelection

                // Time Slot Selection
                if !viewModel.availableTimeSlots.isEmpty {
                    timeSlotSelection
                }

                Spacer(minLength: Spacing.xl)
            }
            .padding(Spacing.screenPadding)
        }
    }

    // MARK: - Subviews

    private var dateSelection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Select Date")
                .font(.h5)
                .foregroundColor(.textPrimary)
                .fontWeight(.semibold)

            // Date Picker
            DatePicker(
                "",
                selection: Binding(
                    get: { viewModel.selectedDate },
                    set: { viewModel.selectDate($0) }
                ),
                in: Date()...,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .tint(.primary)
            .padding(Spacing.md)
            .background(Color.surface)
            .cornerRadius(Spacing.radiusMd)

            // Selected Date Display
            if viewModel.selectedDate != Date() {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "calendar")
                        .font(.body)
                        .foregroundColor(.primary)

                    Text("Selected: \(formatDate(viewModel.selectedDate))")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                }
                .padding(.horizontal, Spacing.sm)
            }
        }
    }

    private var timeSlotSelection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text("Select Time Slot")
                    .font(.h5)
                    .foregroundColor(.textPrimary)
                    .fontWeight(.semibold)

                Spacer()

                if viewModel.selectedTimeSlot != nil {
                    Text("✓ Selected")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.success)
                }
            }

            // Time Slots Grid
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: Spacing.sm),
                GridItem(.flexible(), spacing: Spacing.sm)
            ], spacing: Spacing.sm) {
                ForEach(viewModel.availableTimeSlots) { slot in
                    TimeSlotCard(
                        slot: slot,
                        isSelected: viewModel.selectedTimeSlot?.id == slot.id,
                        onSelect: {
                            viewModel.selectTimeSlot(slot)
                        }
                    )
                }
            }

            // Time Slot Info
            HStack(spacing: Spacing.sm) {
                Image(systemName: "info.circle")
                    .font(.body)
                    .foregroundColor(.info)

                Text("Service duration: \(viewModel.service.formattedDuration)")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
            .padding(Spacing.sm)
            .background(Color.info.opacity(0.1))
            .cornerRadius(Spacing.radiusMd)
        }
    }

    // MARK: - Helper Methods

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

// MARK: - Time Slot Card

struct TimeSlotCard: View {
    let slot: TimeSlot
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: {
            if slot.isAvailable {
                onSelect()
            }
        }) {
            VStack(spacing: Spacing.xs) {
                Text(slot.displayText)
                    .font(.bodyLarge)
                    .fontWeight(isSelected ? .semibold : .medium)
                    .foregroundColor(textColor)

                if !slot.isAvailable {
                    Text("Not Available")
                        .font(.caption)
                        .foregroundColor(.error)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.md)
            .background(backgroundColor)
            .cornerRadius(Spacing.radiusMd)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .stroke(borderColor, lineWidth: isSelected ? 2 : 1)
            )
        }
        .disabled(!slot.isAvailable)
        .buttonStyle(.plain)
    }

    private var textColor: Color {
        if !slot.isAvailable {
            return .textTertiary
        } else if isSelected {
            return .white
        } else {
            return .textPrimary
        }
    }

    private var backgroundColor: Color {
        if !slot.isAvailable {
            return Color.surface.opacity(0.5)
        } else if isSelected {
            return .primary
        } else {
            return .surface
        }
    }

    private var borderColor: Color {
        if !slot.isAvailable {
            return Color.divider.opacity(0.5)
        } else if isSelected {
            return .primary
        } else {
            return .divider
        }
    }
}

// MARK: - Preview

#Preview {
    let viewModel = BookingViewModel(service: Service.mockServices[0])
    viewModel.availableTimeSlots = TimeSlot.mockTimeSlots
    viewModel.selectedDate = Date()

    return NavigationStack {
        DateTimeSelectionView(viewModel: viewModel)
    }
}
