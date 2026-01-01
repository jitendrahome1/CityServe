//
//  Booking.swift
//  CityServe
//
//  Booking and Payment Data Models
//

import Foundation

// MARK: - Booking

struct Booking: Codable, Identifiable {
    let id: String
    let serviceId: String
    let serviceName: String
    let categoryId: String
    let customerId: String
    let providerId: String?
    let providerName: String?

    let address: Address
    let scheduledDate: Date
    let scheduledTimeSlot: TimeSlot

    let pricing: BookingPricing
    let payment: PaymentInfo?

    let status: BookingStatus
    let statusHistory: [BookingStatusUpdate]

    let instructions: String?
    let images: [String]?

    let createdAt: Date
    let updatedAt: Date
    let completedAt: Date?
    let cancelledAt: Date?

    // Computed properties
    var statusColor: String {
        switch status {
        case .pending: return "warning"
        case .confirmed: return "info"
        case .providerAssigned: return "primary"
        case .providerEnRoute: return "primary"
        case .inProgress: return "success"
        case .completed: return "success"
        case .cancelled: return "error"
        case .refunded: return "error"
        }
    }

    var canCancel: Bool {
        [.pending, .confirmed, .providerAssigned].contains(status)
    }

    var canReschedule: Bool {
        [.pending, .confirmed, .providerAssigned].contains(status)
    }

    var formattedScheduledTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: scheduledDate) + ", " + scheduledTimeSlot.displayText
    }
}

// MARK: - Booking Status

enum BookingStatus: String, Codable {
    case pending = "pending"
    case confirmed = "confirmed"
    case providerAssigned = "provider_assigned"
    case providerEnRoute = "provider_en_route"
    case inProgress = "in_progress"
    case completed = "completed"
    case cancelled = "cancelled"
    case refunded = "refunded"

    var displayText: String {
        switch self {
        case .pending: return "Pending"
        case .confirmed: return "Confirmed"
        case .providerAssigned: return "Provider Assigned"
        case .providerEnRoute: return "Provider En Route"
        case .inProgress: return "In Progress"
        case .completed: return "Completed"
        case .cancelled: return "Cancelled"
        case .refunded: return "Refunded"
        }
    }
}

// MARK: - Booking Status Update

struct BookingStatusUpdate: Codable, Identifiable {
    let id: String
    let status: BookingStatus
    let timestamp: Date
    let note: String?
}

// MARK: - Time Slot

struct TimeSlot: Codable, Hashable, Identifiable {
    let id: String
    let startTime: String // "09:00"
    let endTime: String // "10:00"
    let isAvailable: Bool

    var displayText: String {
        "\(startTime) - \(endTime)"
    }
}

// MARK: - Booking Pricing

struct BookingPricing: Codable {
    let basePrice: Double
    let taxes: Double
    let platformFee: Double
    let discount: Double
    let promoCode: String?
    let total: Double

    var subtotal: Double {
        basePrice
    }

    var formattedTotal: String {
        "₹\(Int(total))"
    }

    var formattedSubtotal: String {
        "₹\(Int(subtotal))"
    }

    var formattedTaxes: String {
        "₹\(Int(taxes))"
    }

    var formattedPlatformFee: String {
        "₹\(Int(platformFee))"
    }

    var formattedDiscount: String {
        "₹\(Int(discount))"
    }
}

// MARK: - Payment Info

struct PaymentInfo: Codable {
    let id: String
    let method: PaymentMethod
    let status: PaymentStatus
    let amount: Double
    let transactionId: String?
    let razorpayOrderId: String?
    let razorpayPaymentId: String?
    let timestamp: Date

    var formattedAmount: String {
        "₹\(Int(amount))"
    }
}

// MARK: - Payment Method

enum PaymentMethod: String, Codable, CaseIterable {
    case upi = "upi"
    case card = "card"
    case netbanking = "netbanking"
    case wallet = "wallet"
    case cashOnService = "cash_on_service"

    var displayText: String {
        switch self {
        case .upi: return "UPI"
        case .card: return "Credit/Debit Card"
        case .netbanking: return "Net Banking"
        case .wallet: return "Wallet"
        case .cashOnService: return "Cash on Service"
        }
    }

    var icon: String {
        switch self {
        case .upi: return "indianrupeesign.circle"
        case .card: return "creditcard"
        case .netbanking: return "building.columns"
        case .wallet: return "wallet.pass"
        case .cashOnService: return "banknote"
        }
    }
}

// MARK: - Payment Status

enum PaymentStatus: String, Codable {
    case pending = "pending"
    case processing = "processing"
    case completed = "completed"
    case failed = "failed"
    case refunded = "refunded"

    var displayText: String {
        switch self {
        case .pending: return "Pending"
        case .processing: return "Processing"
        case .completed: return "Completed"
        case .failed: return "Failed"
        case .refunded: return "Refunded"
        }
    }
}

// MARK: - Saved Payment Method

struct SavedPaymentMethod: Codable, Identifiable {
    let id: String
    let type: PaymentMethod
    let displayName: String // "HDFC **** 1234", "paytm@upi"
    let isDefault: Bool
}

// MARK: - Promo Code

struct PromoCode: Codable, Identifiable {
    let id: String
    let code: String
    let description: String
    let discountType: DiscountType
    let discountValue: Double
    let minOrderValue: Double?
    let maxDiscount: Double?
    let expiresAt: Date
    let isActive: Bool

    enum DiscountType: String, Codable {
        case percentage = "percentage"
        case fixed = "fixed"
    }

    var formattedDiscount: String {
        switch discountType {
        case .percentage:
            return "\(Int(discountValue))% OFF"
        case .fixed:
            return "₹\(Int(discountValue)) OFF"
        }
    }
}

// MARK: - Mock Data

extension TimeSlot {
    static let mockTimeSlots: [TimeSlot] = [
        TimeSlot(id: "1", startTime: "09:00", endTime: "10:00", isAvailable: true),
        TimeSlot(id: "2", startTime: "10:00", endTime: "11:00", isAvailable: true),
        TimeSlot(id: "3", startTime: "11:00", endTime: "12:00", isAvailable: false),
        TimeSlot(id: "4", startTime: "12:00", endTime: "13:00", isAvailable: true),
        TimeSlot(id: "5", startTime: "14:00", endTime: "15:00", isAvailable: true),
        TimeSlot(id: "6", startTime: "15:00", endTime: "16:00", isAvailable: true),
        TimeSlot(id: "7", startTime: "16:00", endTime: "17:00", isAvailable: true),
        TimeSlot(id: "8", startTime: "17:00", endTime: "18:00", isAvailable: false),
        TimeSlot(id: "9", startTime: "18:00", endTime: "19:00", isAvailable: true)
    ]
}

extension SavedPaymentMethod {
    static let mockSavedMethods: [SavedPaymentMethod] = [
        SavedPaymentMethod(
            id: "1",
            type: .upi,
            displayName: "user@paytm",
            isDefault: true
        ),
        SavedPaymentMethod(
            id: "2",
            type: .card,
            displayName: "HDFC **** 1234",
            isDefault: false
        ),
        SavedPaymentMethod(
            id: "3",
            type: .wallet,
            displayName: "Paytm Wallet",
            isDefault: false
        )
    ]
}

extension PromoCode {
    static let mockPromoCodes: [PromoCode] = [
        PromoCode(
            id: "1",
            code: "FIRST20",
            description: "Get 20% off on your first booking",
            discountType: .percentage,
            discountValue: 20,
            minOrderValue: 500,
            maxDiscount: 200,
            expiresAt: Date().addingTimeInterval(30 * 24 * 60 * 60),
            isActive: true
        ),
        PromoCode(
            id: "2",
            code: "SAVE100",
            description: "Flat ₹100 off on orders above ₹999",
            discountType: .fixed,
            discountValue: 100,
            minOrderValue: 999,
            maxDiscount: nil,
            expiresAt: Date().addingTimeInterval(15 * 24 * 60 * 60),
            isActive: true
        ),
        PromoCode(
            id: "3",
            code: "WEEKEND50",
            description: "50% off on weekend bookings",
            discountType: .percentage,
            discountValue: 50,
            minOrderValue: 300,
            maxDiscount: 500,
            expiresAt: Date().addingTimeInterval(7 * 24 * 60 * 60),
            isActive: true
        )
    ]
}
