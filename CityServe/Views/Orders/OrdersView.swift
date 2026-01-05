//
//  OrdersView.swift
//  CityServe
//
//  Orders and Bookings List
//

import SwiftUI

struct OrdersView: View {

    @StateObject private var viewModel = OrdersViewModel()
    @State private var selectedTab: OrderTab = .active

    enum OrderTab: String, CaseIterable {
        case active = "Active"
        case past = "Past"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Tab Selector
                    tabSelector

                    // Content
                    if viewModel.isLoading && viewModel.allBookings.isEmpty {
                        LoadingView(message: "Loading bookings...", style: .spinner)
                    } else {
                        tabContent
                    }
                }
            }
            .navigationTitle("My Bookings")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await viewModel.refreshBookings()
            }
        }
    }

    // MARK: - Subviews

    private var tabSelector: some View {
        HStack(spacing: 0) {
            ForEach(OrderTab.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation {
                        selectedTab = tab
                    }
                    Haptics.light()
                }) {
                    VStack(spacing: Spacing.xs) {
                        Text(tab.rawValue)
                            .font(.bodyLarge)
                            .fontWeight(selectedTab == tab ? .semibold : .regular)
                            .foregroundColor(selectedTab == tab ? .primary : .textSecondary)

                        Rectangle()
                            .fill(selectedTab == tab ? Color.primary : Color.clear)
                            .frame(height: 2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.surface)
        .padding(.top, Spacing.sm)
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case .active:
            activeBookingsView
        case .past:
            pastBookingsView
        }
    }

    private var activeBookingsView: some View {
        Group {
            if viewModel.activeBookings.isEmpty {
                emptyStateView(
                    icon: "calendar.badge.clock",
                    title: "No Active Bookings",
                    message: "You don't have any upcoming bookings"
                )
            } else {
                ScrollView {
                    VStack(spacing: Spacing.md) {
                        // Filter chips
                        if viewModel.activeBookings.count > 1 {
                            filterChips
                        }

                        // Bookings list
                        LazyVStack(spacing: Spacing.md) {
                            ForEach(viewModel.filteredActiveBookings) { booking in
                                NavigationLink(destination: BookingDetailView(booking: booking)) {
                                    BookingCard(booking: booking, isActive: true)
                                }
                            }
                        }
                    }
                    .padding(Spacing.screenPadding)
                }
            }
        }
    }

    private var pastBookingsView: some View {
        Group {
            if viewModel.pastBookings.isEmpty {
                emptyStateView(
                    icon: "clock.arrow.circlepath",
                    title: "No Past Bookings",
                    message: "Your completed bookings will appear here"
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: Spacing.md) {
                        ForEach(viewModel.pastBookings) { booking in
                            NavigationLink(destination: BookingDetailView(booking: booking)) {
                                BookingCard(booking: booking, isActive: false)
                            }
                        }
                    }
                    .padding(Spacing.screenPadding)
                }
            }
        }
    }

    private var filterChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                ForEach(OrdersViewModel.BookingFilterStatus.allCases, id: \.self) { filter in
                    FilterChipButton(
                        title: filter.rawValue,
                        isSelected: viewModel.filterStatus == filter,
                        action: {
                            viewModel.setFilter(filter)
                        }
                    )
                }
            }
        }
    }

    private func emptyStateView(icon: String, title: String, message: String) -> some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            EmptyStateView(
                icon: icon,
                title: title,
                description: message
            )

            Spacer()
        }
    }
}

// MARK: - Booking Card

struct BookingCard: View {
    let booking: Booking
    let isActive: Bool

    var body: some View {
        VStack(spacing: Spacing.md) {
            // Header with status
            HStack {
                // Service Icon
                ZStack {
                    Circle()
                        .fill(statusColor.opacity(0.1))
                        .frame(width: 40, height: 40)

                    Image(systemName: serviceIcon)
                        .font(.h4)
                        .foregroundColor(statusColor)
                }

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(booking.serviceName)
                        .font(.bodyLarge)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    Text("Booking #\(booking.id.prefix(8).uppercased())")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }

                Spacer()

                // Status Badge
                StatusBadge(status: booking.status)
            }

            Divider()

            // Details
            VStack(spacing: Spacing.sm) {
                // Date & Time
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "calendar")
                        .font(.body)
                        .foregroundColor(.textSecondary)

                    Text(formatDate(booking.scheduledDate))
                        .font(.body)
                        .foregroundColor(.textSecondary)

                    Text("•")
                        .foregroundColor(.textTertiary)

                    Text(booking.scheduledTimeSlot.displayText)
                        .font(.body)
                        .foregroundColor(.textSecondary)

                    Spacer()
                }

                // Address
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "location.fill")
                        .font(.body)
                        .foregroundColor(.textSecondary)

                    Text(booking.address.label)
                        .font(.body)
                        .foregroundColor(.textSecondary)

                    Spacer()
                }

                // Provider (if assigned)
                if let providerName = booking.providerName {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "person.fill")
                            .font(.body)
                            .foregroundColor(.textSecondary)

                        Text(providerName)
                            .font(.body)
                            .foregroundColor(.textSecondary)

                        Spacer()
                    }
                }
            }

            // Footer
            HStack {
                // Amount
                Text("₹\(Int(booking.pricing.total))")
                    .font(.h5)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Spacer()

                // Action indicator
                Image(systemName: "chevron.right")
                    .font(.body)
                    .foregroundColor(.textTertiary)
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
    }

    private var serviceIcon: String {
        switch booking.categoryId {
        case "1": return "air.conditioner.horizontal"
        case "2": return "drop.fill"
        case "3": return "bolt.fill"
        case "4": return "scissors"
        case "5": return "sparkles"
        case "6": return "paintbrush.fill"
        default: return "wrench.and.screwdriver.fill"
        }
    }

    private var statusColor: Color {
        switch booking.status {
        case .pending: return .warning
        case .confirmed, .providerAssigned: return .info
        case .providerEnRoute, .inProgress: return .primary
        case .completed: return .success
        case .cancelled, .refunded: return .error
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}

// MARK: - Status Badge

struct StatusBadge: View {
    let status: BookingStatus

    var body: some View {
        Text(status.displayText)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(textColor)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .cornerRadius(Spacing.radiusPill)
    }

    private var textColor: Color {
        switch status {
        case .pending: return .warning
        case .confirmed, .providerAssigned: return .info
        case .providerEnRoute, .inProgress: return .primary
        case .completed: return .success
        case .cancelled, .refunded: return .error
        }
    }

    private var backgroundColor: Color {
        textColor.opacity(0.15)
    }
}

// MARK: - Filter Chip Button

struct FilterChipButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.bodySmall)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .textPrimary)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.xs)
                .background(isSelected ? Color.primary : Color.surface)
                .cornerRadius(Spacing.radiusPill)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.radiusPill)
                        .stroke(isSelected ? Color.clear : Color.divider, lineWidth: 1)
                )
        }
    }
}

// MARK: - Preview

#Preview {
    OrdersView()
}

#Preview("Dark Mode") {
    OrdersView()
        .preferredColorScheme(.dark)
}
