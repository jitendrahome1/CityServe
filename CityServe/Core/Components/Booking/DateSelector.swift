//
//  DateSelector.swift
//  CityServe
//
//  Horizontal Scrollable Date Picker Component
//  Design System Component - From designs
//

import SwiftUI

/// Horizontal scrollable date selector for booking flow
/// Usage: Date/time selection screen, appointment booking
struct DateSelector: View {

    // MARK: - Properties

    @Binding var selectedDate: Date

    var numberOfDays: Int = 14
    var onDateChanged: ((Date) -> Void)? = nil

    @State private var dates: [Date] = []

    // MARK: - Body

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                ForEach(dates, id: \.self) { date in
                    DateCard(
                        date: date,
                        isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate)
                    ) {
                        selectDate(date)
                    }
                }
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
        .onAppear {
            generateDates()
        }
    }

    // MARK: - Helper Methods

    private func generateDates() {
        let calendar = Calendar.current
        let today = Date()

        dates = (0..<numberOfDays).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: today)
        }
    }

    private func selectDate(_ date: Date) {
        selectedDate = date
        Haptics.light()
        onDateChanged?(date)
    }
}

// MARK: - Date Card

private struct DateCard: View {
    let date: Date
    let isSelected: Bool
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: {
            action()
        }) {
            VStack(spacing: Spacing.xxs) {
                // Day name
                Text(dayName)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(textColor)

                // Date number
                Text(dayNumber)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(textColor)
            }
            .frame(width: 60, height: 70)
            .background(backgroundColor)
            .cornerRadius(Spacing.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .stroke(borderColor, lineWidth: isSelected ? 2 : 0)
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(Animations.cardPress) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(Animations.cardPress) {
                        isPressed = false
                    }
                }
        )
    }

    // MARK: - Computed Properties

    private var dayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date).uppercased()
    }

    private var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }

    private var backgroundColor: Color {
        if isSelected {
            return .primary
        } else if isToday {
            return Color.primary.opacity(0.08)
        } else {
            return Color.surface
        }
    }

    private var textColor: Color {
        if isSelected {
            return .white
        } else {
            return .textPrimary
        }
    }

    private var borderColor: Color {
        isSelected ? .primary : .clear
    }
}

// MARK: - Preview

#Preview("Date Selector") {
    VStack(spacing: Spacing.xl) {
        // Default
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Select date of service")
                .font(.sectionHeader)
                .foregroundColor(.textPrimary)

            DateSelector(
                selectedDate: .constant(Date()),
                onDateChanged: { date in
                    print("Selected date: \(date)")
                }
            )
        }

        Divider()

        // With more days
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Next 30 days")
                .font(.sectionHeader)
                .foregroundColor(.textPrimary)

            DateSelector(
                selectedDate: .constant(Date().addingTimeInterval(86400 * 3)), // 3 days from now
                numberOfDays: 30
            )
        }
    }
    .padding(.vertical, Spacing.screenPadding)
    .background(Color.background)
}

#Preview("Date Selector in Booking Flow") {
    ScrollView {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            // Address section
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack {
                    Image(systemName: "location.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.primary)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Kesnand Rd, opp. Ayurvedic college...")
                            .font(.bodySmall)
                            .fontWeight(.medium)
                            .foregroundColor(.textPrimary)
                            .lineLimit(1)
                    }

                    Spacer()

                    Button("Change") {
                        print("Change address")
                    }
                    .font(.bodySmall)
                    .foregroundColor(.primary)
                }
                .padding(Spacing.md)
                .background(Color.surface)
                .cornerRadius(Spacing.radiusMd)
            }
            .padding(.horizontal, Spacing.screenPadding)

            // Date selection
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Select date of service")
                    .font(.sectionHeader)
                    .foregroundColor(.textPrimary)
                    .padding(.horizontal, Spacing.screenPadding)

                DateSelector(selectedDate: .constant(Date().addingTimeInterval(86400)))
            }

            // Cancellation policy
            HStack(spacing: Spacing.xs) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.success)

                Text("Free cancellation till 2 hrs before")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
            .padding(.horizontal, Spacing.screenPadding)

            // Time slots would go here
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Time to start the service")
                    .font(.sectionHeader)
                    .foregroundColor(.textPrimary)

                // Placeholder for TimeSlotGrid
                Text("(Time slots will appear here)")
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }
            .padding(.horizontal, Spacing.screenPadding)

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

#Preview("Date Selector Dark Mode") {
    VStack(spacing: Spacing.xl) {
        Text("Select date of service")
            .font(.sectionHeader)
            .foregroundColor(.textPrimary)

        DateSelector(
            selectedDate: .constant(Date()),
            numberOfDays: 14
        )
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
    .preferredColorScheme(.dark)
}
