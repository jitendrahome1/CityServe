//
//  ContactSupportViewModel.swift
//  CityServe
//
//  Contact Support ViewModel - Support Ticket Submission
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ContactSupportViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var recentBookings: [Booking] = []
    @Published var userEmail: String = ""
    @Published var userPhone: String = ""

    @Published var isSubmitting = false
    @Published var showSuccess = false
    @Published var showError = false
    @Published var errorMessage: String?
    @Published var ticketId: String = ""

    // MARK: - Initialization

    init() {
        loadUserInfo()
        loadRecentBookings()
    }

    // MARK: - Data Loading

    private func loadUserInfo() {
        // In a real app, get this from AuthViewModel or User defaults
        userEmail = "user@example.com"
        userPhone = "+91 98765 43210"
    }

    func loadRecentBookings() {
        Task {
            do {
                // Simulate network delay
                try await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds

                // Load mock bookings (last 10)
                // In a real app, this would be an API call
                recentBookings = Booking.mockBookings.prefix(10).map { $0 }
            } catch {
                print("Error loading recent bookings: \(error)")
            }
        }
    }

    // MARK: - Submit Ticket

    func submitSupportTicket(
        category: IssueCategory,
        booking: Booking?,
        subject: String,
        description: String,
        attachments: [UIImage],
        contactEmail: Bool,
        contactPhone: Bool,
        contactNotification: Bool,
        priority: TicketPriority
    ) {
        isSubmitting = true
        errorMessage = nil

        Task {
            do {
                // Simulate API call
                try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds

                // Build contact preferences array
                var contactPreferences: [ContactPreference] = []
                if contactEmail { contactPreferences.append(.email) }
                if contactPhone { contactPreferences.append(.phone) }
                if contactNotification { contactPreferences.append(.notification) }

                // Generate ticket ID
                ticketId = generateTicketId()

                // In a real app, upload attachments and create ticket via API
                // For now, just simulate success
                print("📧 Support Ticket Created:")
                print("  ID: \(ticketId)")
                print("  Category: \(category.displayName)")
                print("  Subject: \(subject)")
                print("  Description: \(description)")
                print("  Priority: \(priority.displayName)")
                print("  Booking: \(booking?.id ?? "None")")
                print("  Attachments: \(attachments.count)")
                print("  Contact: \(contactPreferences.map { $0.rawValue }.joined(separator: ", "))")

                isSubmitting = false
                showSuccess = true
            } catch {
                isSubmitting = false
                errorMessage = "Failed to submit ticket. Please try again."
                showError = true
            }
        }
    }

    // MARK: - Utilities

    private func generateTicketId() -> String {
        let randomNumber = Int.random(in: 10000...99999)
        return "TKT\(randomNumber)"
    }

    func uploadAttachments(_ images: [UIImage]) async throws -> [String] {
        // In a real app, upload images to cloud storage
        // Return URLs of uploaded images
        var urls: [String] = []

        for (index, _) in images.enumerated() {
            // Simulate upload delay
            try await Task.sleep(nanoseconds: 500_000_000) // 0.5s per image

            // Generate mock URL
            let url = "https://storage.urbannest.com/tickets/\(UUID().uuidString).jpg"
            urls.append(url)

            print("📤 Uploaded attachment \(index + 1): \(url)")
        }

        return urls
    }
}
