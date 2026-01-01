//
//  BookingViewModel.swift
//  CityServe
//
//  Booking Flow State Management
//

import Foundation
import SwiftUI
import Combine

@MainActor
class BookingViewModel: ObservableObject {

    // MARK: - Published Properties

    // Service & User Info
    @Published var service: Service
    @Published var currentUser: User?

    // Booking Flow Step
    @Published var currentStep: BookingStep = .address

    // Address Selection
    @Published var addresses: [Address] = []
    @Published var selectedAddress: Address?

    // Date & Time Selection
    @Published var selectedDate: Date = Date()
    @Published var availableTimeSlots: [TimeSlot] = []
    @Published var selectedTimeSlot: TimeSlot?

    // Additional Details
    @Published var specialInstructions: String = ""
    @Published var uploadedImages: [String] = []

    // Pricing
    @Published var pricing: BookingPricing?
    @Published var appliedPromoCode: PromoCode?

    // Payment
    @Published var paymentMethods: [SavedPaymentMethod] = []
    @Published var selectedPaymentMethod: PaymentMethod = .upi
    @Published var savedPaymentMethodId: String?

    // State
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var createdBooking: Booking?

    // MARK: - Computed Properties

    var canProceedToNextStep: Bool {
        switch currentStep {
        case .address:
            return selectedAddress != nil
        case .dateTime:
            return selectedDate != nil && selectedTimeSlot != nil
        case .summary:
            return true
        case .payment:
            return selectedPaymentMethod != nil
        }
    }

    var progressPercentage: Double {
        let steps = BookingStep.allCases.count
        let currentIndex = BookingStep.allCases.firstIndex(of: currentStep) ?? 0
        return Double(currentIndex + 1) / Double(steps)
    }

    var totalAmount: Double {
        pricing?.total ?? service.basePrice
    }

    // MARK: - Booking Steps

    enum BookingStep: Int, CaseIterable {
        case address = 0
        case dateTime = 1
        case summary = 2
        case payment = 3

        var title: String {
            switch self {
            case .address: return "Select Address"
            case .dateTime: return "Choose Date & Time"
            case .summary: return "Review Booking"
            case .payment: return "Payment"
            }
        }

        var icon: String {
            switch self {
            case .address: return "location.fill"
            case .dateTime: return "calendar"
            case .summary: return "doc.text"
            case .payment: return "creditcard"
            }
        }
    }

    // MARK: - Initialization

    init(service: Service, user: User? = nil) {
        self.service = service
        self.currentUser = user
        loadInitialData()
    }

    // MARK: - Data Loading

    func loadInitialData() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await Task.sleep(nanoseconds: 800_000_000)

                // Load user addresses
                if let user = currentUser {
                    addresses = user.addresses
                    selectedAddress = addresses.first(where: { $0.isDefault }) ?? addresses.first
                }

                // Load available time slots
                loadTimeSlots(for: selectedDate)

                // Calculate initial pricing
                calculatePricing()

                // Load saved payment methods
                paymentMethods = SavedPaymentMethod.mockSavedMethods

                isLoading = false
            } catch {
                errorMessage = "Failed to load booking data"
                isLoading = false
            }
        }
    }

    // MARK: - Address Management

    func selectAddress(_ address: Address) {
        selectedAddress = address
        Haptics.light()
    }

    func addNewAddress(_ address: Address) {
        addresses.append(address)
        selectedAddress = address
    }

    // MARK: - Date & Time Selection

    func selectDate(_ date: Date) {
        selectedDate = date
        selectedTimeSlot = nil // Reset time slot when date changes
        loadTimeSlots(for: date)
        Haptics.light()
    }

    func selectTimeSlot(_ slot: TimeSlot) {
        guard slot.isAvailable else { return }
        selectedTimeSlot = slot
        Haptics.medium()
    }

    private func loadTimeSlots(for date: Date) {
        // Simulate loading time slots from backend
        availableTimeSlots = TimeSlot.mockTimeSlots
    }

    // MARK: - Pricing & Promo Codes

    func calculatePricing() {
        let basePrice = service.basePrice
        let taxes = basePrice * 0.18 // 18% GST
        let platformFee = 20.0
        var discount = 0.0

        if let promo = appliedPromoCode {
            switch promo.discountType {
            case .percentage:
                discount = basePrice * (promo.discountValue / 100)
                if let maxDiscount = promo.maxDiscount {
                    discount = min(discount, maxDiscount)
                }
            case .fixed:
                discount = promo.discountValue
            }
        }

        let total = basePrice + taxes + platformFee - discount

        pricing = BookingPricing(
            basePrice: basePrice,
            taxes: taxes,
            platformFee: platformFee,
            discount: discount,
            promoCode: appliedPromoCode?.code,
            total: total
        )
    }

    func applyPromoCode(_ code: String) async -> Bool {
        isLoading = true
        errorMessage = nil

        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)

            // Check if promo code is valid
            if let promo = PromoCode.mockPromoCodes.first(where: { $0.code.uppercased() == code.uppercased() && $0.isActive }) {
                // Check minimum order value
                if let minValue = promo.minOrderValue, service.basePrice < minValue {
                    errorMessage = "Minimum order value of ₹\(Int(minValue)) required"
                    isLoading = false
                    return false
                }

                appliedPromoCode = promo
                calculatePricing()
                isLoading = false
                Haptics.success()
                return true
            } else {
                errorMessage = "Invalid promo code"
                isLoading = false
                Haptics.error()
                return false
            }
        } catch {
            errorMessage = "Failed to apply promo code"
            isLoading = false
            return false
        }
    }

    func removePromoCode() {
        appliedPromoCode = nil
        calculatePricing()
        Haptics.light()
    }

    // MARK: - Payment

    func selectPaymentMethod(_ method: PaymentMethod) {
        selectedPaymentMethod = method
        Haptics.light()
    }

    func selectSavedPaymentMethod(_ methodId: String) {
        savedPaymentMethodId = methodId
        if let method = paymentMethods.first(where: { $0.id == methodId }) {
            selectedPaymentMethod = method.type
        }
        Haptics.light()
    }

    // MARK: - Booking Creation

    func createBooking() async -> Bool {
        guard let address = selectedAddress,
              let timeSlot = selectedTimeSlot,
              let pricing = pricing else {
            errorMessage = "Please complete all booking details"
            return false
        }

        isLoading = true
        errorMessage = nil

        do {
            // Simulate payment processing
            try await Task.sleep(nanoseconds: 2_000_000_000)

            // Create payment info
            let payment = PaymentInfo(
                id: UUID().uuidString,
                method: selectedPaymentMethod,
                status: .completed,
                amount: pricing.total,
                transactionId: "TXN\(Int.random(in: 100000...999999))",
                razorpayOrderId: "order_\(UUID().uuidString.prefix(10))",
                razorpayPaymentId: "pay_\(UUID().uuidString.prefix(10))",
                timestamp: Date()
            )

            // Create booking
            let booking = Booking(
                id: UUID().uuidString,
                serviceId: service.id,
                serviceName: service.name,
                categoryId: service.categoryId,
                customerId: currentUser?.id ?? "mock_user",
                providerId: nil,
                providerName: nil,
                address: address,
                scheduledDate: selectedDate,
                scheduledTimeSlot: timeSlot,
                pricing: pricing,
                payment: payment,
                status: .pending,
                statusHistory: [
                    BookingStatusUpdate(
                        id: UUID().uuidString,
                        status: .pending,
                        timestamp: Date(),
                        note: "Booking created"
                    )
                ],
                instructions: specialInstructions.isEmpty ? nil : specialInstructions,
                images: uploadedImages.isEmpty ? nil : uploadedImages,
                createdAt: Date(),
                updatedAt: Date(),
                completedAt: nil,
                cancelledAt: nil
            )

            createdBooking = booking
            isLoading = false
            Haptics.success()
            return true

        } catch {
            errorMessage = "Failed to create booking. Please try again."
            isLoading = false
            Haptics.error()
            return false
        }
    }

    // MARK: - Navigation

    func goToNextStep() {
        guard canProceedToNextStep else { return }

        if let nextStep = BookingStep(rawValue: currentStep.rawValue + 1) {
            withAnimation {
                currentStep = nextStep
            }
            Haptics.light()
        }
    }

    func goToPreviousStep() {
        if let previousStep = BookingStep(rawValue: currentStep.rawValue - 1) {
            withAnimation {
                currentStep = previousStep
            }
            Haptics.light()
        }
    }

    func goToStep(_ step: BookingStep) {
        withAnimation {
            currentStep = step
        }
        Haptics.light()
    }

    // MARK: - Reset

    func resetBooking() {
        currentStep = .address
        selectedAddress = addresses.first(where: { $0.isDefault }) ?? addresses.first
        selectedDate = Date()
        selectedTimeSlot = nil
        specialInstructions = ""
        uploadedImages = []
        appliedPromoCode = nil
        calculatePricing()
        createdBooking = nil
    }
}
