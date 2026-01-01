//
//  HelpCenterViewModel.swift
//  CityServe
//
//  Help Center ViewModel - Support and FAQs
//

import Foundation
import SwiftUI
import Combine

@MainActor
class HelpCenterViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var popularTopics: [HelpTopic] = []
    @Published var topFAQs: [HelpFAQ] = []
    @Published var allFAQs: [HelpFAQ] = []
    @Published var supportContact: SupportContact?
    @Published var appVersion: String = ""

    @Published var searchText = ""
    @Published var searchResults: [HelpArticle] = []
    @Published var isSearching = false

    @Published var expandedFAQId: String?
    @Published var isLoading = false
    @Published var errorMessage: String?

    // Sheet presentation states
    @Published var showingChat = false
    @Published var showingContactForm = false
    @Published var showingAllFAQs = false

    // MARK: - Computed Properties

    var hasSearchResults: Bool {
        !searchText.isEmpty && !searchResults.isEmpty
    }

    var isSearchEmpty: Bool {
        !searchText.isEmpty && searchResults.isEmpty
    }

    // MARK: - Initialization

    init() {
        loadHelpCenterData()
        getAppVersion()
    }

    // MARK: - Data Loading

    func loadHelpCenterData() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                // Simulate network delay
                try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds

                // Load mock data
                let helpData = HelpCenterData.mockData
                popularTopics = helpData.popularTopics
                topFAQs = helpData.topFAQs
                allFAQs = HelpFAQ.mockFAQs
                supportContact = helpData.supportContact
                appVersion = helpData.appVersion

                isLoading = false
            } catch {
                errorMessage = "Failed to load help center. Please try again."
                isLoading = false
            }
        }
    }

    func refreshData() async {
        isLoading = true
        errorMessage = nil

        do {
            // Simulate API call
            try await Task.sleep(nanoseconds: 500_000_000)

            // Reload data
            let helpData = HelpCenterData.mockData
            popularTopics = helpData.popularTopics
            topFAQs = helpData.topFAQs
            allFAQs = HelpFAQ.mockFAQs
            supportContact = helpData.supportContact

            isLoading = false
        } catch {
            errorMessage = "Failed to refresh. Please try again."
            isLoading = false
        }
    }

    // MARK: - Search Functions

    func searchArticles(query: String) {
        guard !query.isEmpty else {
            searchResults = []
            isSearching = false
            return
        }

        isSearching = true

        Task {
            // Simulate search delay
            try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds

            // Perform search (mock implementation)
            // In real app, this would be an API call
            let results = performMockSearch(query: query)
            searchResults = results
            isSearching = false
        }
    }

    private func performMockSearch(query: String) -> [HelpArticle] {
        let lowercasedQuery = query.lowercased()

        // Simple mock search - in real app this would be server-side
        if lowercasedQuery.contains("refund") || lowercasedQuery.contains("money") {
            return [HelpArticle.mockArticle1]
        }

        return []
    }

    // MARK: - FAQ Functions

    func toggleFAQ(_ faqId: String) {
        if expandedFAQId == faqId {
            expandedFAQId = nil
        } else {
            expandedFAQId = faqId
        }
    }

    func markFAQHelpful(_ faqId: String, helpful: Bool) {
        // Find and update the FAQ
        if let index = topFAQs.firstIndex(where: { $0.id == faqId }) {
            var updatedFAQ = topFAQs[index]
            updatedFAQ.wasHelpful = helpful
            topFAQs[index] = updatedFAQ

            // In real app, send feedback to server
            sendFAQFeedback(faqId: faqId, helpful: helpful)
        }
    }

    private func sendFAQFeedback(faqId: String, helpful: Bool) {
        Task {
            // Simulate API call to record feedback
            try? await Task.sleep(nanoseconds: 200_000_000)
            print("FAQ feedback sent: \(faqId), helpful: \(helpful)")
        }
    }

    func showAllFAQs() {
        showingAllFAQs = true
    }

    // MARK: - Quick Actions

    func callSupport() {
        guard let phoneNumber = supportContact?.phone else { return }

        // Remove non-numeric characters
        let cleanedNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        if let url = URL(string: "tel://\(cleanedNumber)") {
            #if !targetEnvironment(simulator)
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            #else
            print("📞 Call action (simulator): \(phoneNumber)")
            #endif
        }
    }

    func openChat() {
        showingChat = true
    }

    func emailSupport() {
        guard let email = supportContact?.email else { return }

        let subject = "Help Request - UrbanNest"
        let body = "Hi Support Team,\n\n"

        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        if let url = URL(string: "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedBody)") {
            #if !targetEnvironment(simulator)
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            #else
            print("📧 Email action (simulator): \(email)")
            #endif
        }
    }

    func scrollToFAQ() {
        // This will be handled by the view with ScrollViewReader
        print("Scroll to FAQ section")
    }

    func openContactSupport() {
        showingContactForm = true
    }

    // MARK: - Navigation

    func showSettings() {
        // Navigate to settings
        print("Show settings")
    }

    func openTerms() {
        if let url = URL(string: "https://urbannest.com/terms") {
            #if !targetEnvironment(simulator)
            UIApplication.shared.open(url)
            #else
            print("🌐 Open URL (simulator): Terms of Service")
            #endif
        }
    }

    func openPrivacy() {
        if let url = URL(string: "https://urbannest.com/privacy") {
            #if !targetEnvironment(simulator)
            UIApplication.shared.open(url)
            #else
            print("🌐 Open URL (simulator): Privacy Policy")
            #endif
        }
    }

    // MARK: - Utilities

    private func getAppVersion() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersion = version
        } else {
            appVersion = "1.0.0"
        }
    }

    func retry() {
        loadHelpCenterData()
    }
}
