//
//  OrdersViewModel.swift
//  CityServe
//
//  Orders and Bookings Management
//

import Foundation
import SwiftUI
import Combine

@MainActor
class OrdersViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var activeBookings: [Booking] = []
    @Published var pastBookings: [Booking] = []
    @Published var allBookings: [Booking] = []

    @Published var selectedBooking: Booking?

    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var filterStatus: BookingFilterStatus = .all

    // MARK: - Computed Properties

    var filteredActiveBookings: [Booking] {
        activeBookings.filter { booking in
            switch filterStatus {
            case .all:
                return true
            case .pending:
                return booking.status == .pending
            case .confirmed:
                return booking.status == .confirmed || booking.status == .providerAssigned
            case .inProgress:
                return booking.status == .inProgress || booking.status == .providerEnRoute
            }
        }
    }

    var hasActiveBookings: Bool {
        !activeBookings.isEmpty
    }

    var hasPastBookings: Bool {
        !pastBookings.isEmpty
    }

    // MARK: - Filter Status

    enum BookingFilterStatus: String, CaseIterable {
        case all = "All"
        case pending = "Pending"
        case confirmed = "Confirmed"
        case inProgress = "In Progress"
    }

    // MARK: - Initialization

    init() {
        loadBookings()
    }

    // MARK: - Data Loading

    func loadBookings() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await Task.sleep(nanoseconds: 1_000_000_000)

                // Load mock bookings
                allBookings = Booking.mockBookings

                // Separate active and past bookings
                activeBookings = allBookings.filter { booking in
                    [.pending, .confirmed, .providerAssigned, .providerEnRoute, .inProgress].contains(booking.status)
                }

                pastBookings = allBookings.filter { booking in
                    [.completed, .cancelled, .refunded].contains(booking.status)
                }

                // Sort by date
                activeBookings.sort { $0.scheduledDate > $1.scheduledDate }
                pastBookings.sort { $0.updatedAt > $1.updatedAt }

                isLoading = false
            } catch {
                errorMessage = "Failed to load bookings"
                isLoading = false
            }
        }
    }

    func refreshBookings() async {
        isLoading = true
        errorMessage = nil

        do {
            try await Task.sleep(nanoseconds: 1_500_000_000)

            // Reload bookings
            allBookings = Booking.mockBookings

            activeBookings = allBookings.filter { booking in
                [.pending, .confirmed, .providerAssigned, .providerEnRoute, .inProgress].contains(booking.status)
            }

            pastBookings = allBookings.filter { booking in
                [.completed, .cancelled, .refunded].contains(booking.status)
            }

            activeBookings.sort { $0.scheduledDate > $1.scheduledDate }
            pastBookings.sort { $0.updatedAt > $1.updatedAt }

            isLoading = false
        } catch {
            errorMessage = "Failed to refresh bookings"
            isLoading = false
        }
    }

    // MARK: - Booking Actions

    func cancelBooking(_ bookingId: String) async -> Bool {
        isLoading = true
        errorMessage = nil

        do {
            try await Task.sleep(nanoseconds: 1_500_000_000)

            // Find and update booking
            if let index = allBookings.firstIndex(where: { $0.id == bookingId }) {
                // In real app, this would call the API
                // For now, just simulate success
                isLoading = false
                Haptics.success()

                // Reload bookings to reflect changes
                await refreshBookings()
                return true
            }

            isLoading = false
            return false
        } catch {
            errorMessage = "Failed to cancel booking"
            isLoading = false
            Haptics.error()
            return false
        }
    }

    func rescheduleBooking(_ bookingId: String, newDate: Date, newTimeSlot: TimeSlot) async -> Bool {
        isLoading = true
        errorMessage = nil

        do {
            try await Task.sleep(nanoseconds: 1_500_000_000)

            // In real app, this would call the API
            isLoading = false
            Haptics.success()

            // Reload bookings
            await refreshBookings()
            return true
        } catch {
            errorMessage = "Failed to reschedule booking"
            isLoading = false
            Haptics.error()
            return false
        }
    }

    // MARK: - Filter

    func setFilter(_ status: BookingFilterStatus) {
        filterStatus = status
        Haptics.light()
    }
}

// MARK: - Mock Bookings

extension Booking {
    static var mockBookings: [Booking] {
        let address1: Address = .init(id: "1", label: "Home", fullAddress: "123, MG Road, Connaught Place, New Delhi - 110001", city: "Delhi", isDefault: true)
        let address2: Address = .init(id: "2", label: "Office", fullAddress: "456, Cyber City, Sector 29, Gurugram - 122002", city: "Gurugram", isDefault: false)

        let booking1: Booking = .init(
            id: "BK001",
            serviceId: "1",
            serviceName: "AC Repair & Service",
            categoryId: "1",
            customerId: "U123",
            providerId: nil,
            providerName: nil,
            address: address1,
            scheduledDate: Date().addingTimeInterval(2 * 24 * 60 * 60),
            scheduledTimeSlot: .init(id: "1", startTime: "10:00", endTime: "11:00", isAvailable: true),
            pricing: .init(basePrice: 499, taxes: 89.82, platformFee: 20, discount: 0, promoCode: nil, total: 608.82),
            payment: .init(id: "PAY001", method: .upi, status: .completed, amount: 608.82, transactionId: "TXN123456", razorpayOrderId: "order_001", razorpayPaymentId: "pay_001", timestamp: Date()),
            status: .pending,
            statusHistory: [.init(id: "SH001", status: .pending, timestamp: Date(), note: "Booking created and payment completed")],
            instructions: nil,
            images: nil,
            createdAt: Date(),
            updatedAt: Date(),
            completedAt: nil,
            cancelledAt: nil
        )

        let booking2: Booking = .init(
            id: "BK002",
            serviceId: "2",
            serviceName: "Tap Repair",
            categoryId: "2",
            customerId: "U123",
            providerId: "P2",
            providerName: "Amit Sharma",
            address: address1,
            scheduledDate: Date().addingTimeInterval(-7 * 24 * 60 * 60),
            scheduledTimeSlot: .init(id: "2", startTime: "10:00", endTime: "11:00", isAvailable: true),
            pricing: .init(basePrice: 299, taxes: 53.82, platformFee: 20, discount: 0, promoCode: nil, total: 372.82),
            payment: .init(id: "PAY002", method: .upi, status: .completed, amount: 372.82, transactionId: "TXN345678", razorpayOrderId: "order_002", razorpayPaymentId: "pay_002", timestamp: Date().addingTimeInterval(-7 * 24 * 60 * 60)),
            status: .completed,
            statusHistory: [.init(id: "SH002", status: .completed, timestamp: Date().addingTimeInterval(-7 * 24 * 60 * 60 + 2 * 60 * 60), note: "Service completed successfully")],
            instructions: nil,
            images: nil,
            createdAt: Date().addingTimeInterval(-7 * 24 * 60 * 60),
            updatedAt: Date().addingTimeInterval(-7 * 24 * 60 * 60 + 2 * 60 * 60),
            completedAt: Date().addingTimeInterval(-7 * 24 * 60 * 60 + 2 * 60 * 60),
            cancelledAt: nil
        )

        return [booking1, booking2]
    }
}
