//
//  TimeSlotGrid.swift
//  CityServe
//
//  Grid of Selectable Time Slots Component
//  Design System Component - From designs
//

import SwiftUI

/// Grid of selectable time slots for booking appointments
/// Usage: Date/time selection screen, booking flow
struct TimeSlotGrid: View {

    // MARK: - Properties

    @Binding var selectedSlot: BookingTimeSlot?

    let slots: [BookingTimeSlot]
    var columns: Int = 3
    var onSlotSelected: ((BookingTimeSlot) -> Void)? = nil

    // MARK: - Body

    var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: Spacing.sm), count: columns),
            spacing: Spacing.sm
        ) {
            ForEach(slots) { slot in
                BookingTimeSlotCard(
                    slot: slot,
                    isSelected: selectedSlot?.id == slot.id
                ) {
                    selectSlot(slot)
                }
            }
        }
    }

    // MARK: - Actions

    private func selectSlot(_ slot: BookingTimeSlot) {
        guard slot.isAvailable else {
            Haptics.warning()
            return
        }

        selectedSlot = slot
        Haptics.light()
        onSlotSelected?(slot)
    }
}

// MARK: - Time Slot Card

private struct BookingTimeSlotCard: View {
    let slot: BookingTimeSlot
    let isSelected: Bool
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: {
            action()
        }) {
            VStack(spacing: Spacing.xxs) {
                // Time
                Text(slot.displayTime)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(textColor)

                // Badge (if any)
                if let badge = slot.badge {
                    badgeView(badge)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: slot.badge != nil ? 60 : 50)
            .background(backgroundColor)
            .cornerRadius(Spacing.radiusMd)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .opacity(slot.isAvailable ? 1.0 : 0.5)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!slot.isAvailable)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if slot.isAvailable {
                        withAnimation(Animations.cardPress) {
                            isPressed = true
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation(Animations.cardPress) {
                        isPressed = false
                    }
                }
        )
    }

    // MARK: - Subviews

    @ViewBuilder
    private func badgeView(_ badge: BookingTimeSlot.SlotBadge) -> some View {
        Text(badge.text)
            .font(.system(size: 9, weight: .bold))
            .foregroundColor(badge.color)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(badge.color.opacity(0.12))
            .cornerRadius(Spacing.radiusSm)
    }

    // MARK: - Computed Properties

    private var backgroundColor: Color {
        if isSelected {
            return .primary
        } else if slot.isAvailable {
            return .surface
        } else {
            return Color.neutralGray.opacity(0.5)
        }
    }

    private var textColor: Color {
        if isSelected {
            return .white
        } else if slot.isAvailable {
            return .textPrimary
        } else {
            return .textDisabled
        }
    }

    private var borderColor: Color {
        if isSelected {
            return .primary
        } else if slot.isAvailable {
            return .divider
        } else {
            return .divider.opacity(0.5)
        }
    }

    private var borderWidth: CGFloat {
        isSelected ? 2 : 1
    }
}

// MARK: - Time Slot Option Model

struct BookingTimeSlot: Identifiable {
    let id: String
    let time: Date
    let isAvailable: Bool
    let badge: SlotBadge?

    var displayTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: time)
    }

    init(
        id: String = UUID().uuidString,
        time: Date,
        isAvailable: Bool = true,
        badge: SlotBadge? = nil
    ) {
        self.id = id
        self.time = time
        self.isAvailable = isAvailable
        self.badge = badge
    }

    enum SlotBadge {
        case highDemand
        case discount(String)
        case custom(text: String, color: Color)

        var text: String {
            switch self {
            case .highDemand:
                return "HIGH DEMAND"
            case .discount(let amount):
                return amount
            case .custom(let text, _):
                return text
            }
        }

        var color: Color {
            switch self {
            case .highDemand:
                return .highDemand
            case .discount:
                return .success
            case .custom(_, let color):
                return color
            }
        }
    }

    // Preview helper
    static func generate(count: Int = 12, startHour: Int = 7) -> [BookingTimeSlot] {
        let calendar = Calendar.current
        var slots: [BookingTimeSlot] = []

        for i in 0..<count {
            guard let time = calendar.date(bySettingHour: startHour + i, minute: 0, second: 0, of: Date()) else { continue }

            // Add some variety
            let isAvailable = i != 2 && i != 5 // Make some unavailable
            var badge: SlotBadge? = nil

            if i == 3 || i == 4 {
                badge = .highDemand
            } else if i == 8 {
                badge = .discount("10% OFF")
            }

            slots.append(BookingTimeSlot(time: time, isAvailable: isAvailable, badge: badge))
        }

        return slots
    }
}

// MARK: - Preview

#Preview("Time Slot Grid") {
    ScrollView {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            // Basic grid
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Time to start the service")
                    .font(.sectionHeader)
                    .foregroundColor(.textPrimary)

                TimeSlotGrid(
                    selectedSlot: .constant(nil),
                    slots: BookingTimeSlot.generate(count: 12),
                    onSlotSelected: { slot in
                        print("Selected: \(slot.displayTime)")
                    }
                )
            }

            Divider()

            // With selected slot
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("With selection")
                    .font(.sectionHeader)
                    .foregroundColor(.textPrimary)

                TimeSlotGrid(
                    selectedSlot: .constant(BookingTimeSlot.generate(count: 12)[3]),
                    slots: BookingTimeSlot.generate(count: 12)
                )
            }

            Divider()

            // 2 columns
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("2 Columns")
                    .font(.sectionHeader)
                    .foregroundColor(.textPrimary)

                TimeSlotGrid(
                    selectedSlot: .constant(nil),
                    slots: BookingTimeSlot.generate(count: 8),
                    columns: 2
                )
            }

            Divider()

            // 4 columns
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("4 Columns")
                    .font(.sectionHeader)
                    .foregroundColor(.textPrimary)

                TimeSlotGrid(
                    selectedSlot: .constant(nil),
                    slots: BookingTimeSlot.generate(count: 12),
                    columns: 4
                )
            }
        }
        .padding(Spacing.screenPadding)
    }
    .background(Color.background)
}

#Preview("Complete Booking Flow") {
    ScrollView {
        VStack(alignment: .leading, spacing: Spacing.xl) {
            // Header
            Text("Select Date & Time")
                .font(.h2)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            // Date selector
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Select date of service")
                    .font(.sectionHeader)
                    .foregroundColor(.textPrimary)
                    .padding(.horizontal, Spacing.screenPadding)

                DateSelector(selectedDate: .constant(Date()))
            }

            // Cancellation note
            HStack(spacing: Spacing.xs) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.success)

                Text("Free cancellation till 2 hrs before")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
            .padding(.horizontal, Spacing.screenPadding)

            // Time slots
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Time to start the service")
                    .font(.sectionHeader)
                    .foregroundColor(.textPrimary)
                    .padding(.horizontal, Spacing.screenPadding)

                TimeSlotGrid(
                    selectedSlot: .constant(BookingTimeSlot.generate()[3]),
                    slots: BookingTimeSlot.generate(count: 15)
                )
                .padding(.horizontal, Spacing.screenPadding)
            }

            Spacer()

            // Bottom button
            PrimaryButton("Proceed to checkout") {
                print("Proceed")
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
        .padding(.vertical, Spacing.lg)
    }
    .background(Color.background)
}

#Preview("Time Slot Grid Dark Mode") {
    VStack(alignment: .leading, spacing: Spacing.md) {
        Text("Time to start the service")
            .font(.sectionHeader)
            .foregroundColor(.textPrimary)

        TimeSlotGrid(
            selectedSlot: .constant(BookingTimeSlot.generate()[2]),
            slots: BookingTimeSlot.generate(count: 12)
        )
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
    .preferredColorScheme(.dark)
}
