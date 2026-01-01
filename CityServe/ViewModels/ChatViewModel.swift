//
//  ChatViewModel.swift
//  CityServe
//
//  Chat ViewModel - Real-time Support Chat
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ChatViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var messages: [ChatMessage] = []
    @Published var currentAgent: ChatAgent?
    @Published var connectionStatus: ConnectionStatus = .connecting
    @Published var isAgentTyping = false
    @Published var quickReplies: [String] = []
    @Published var hasMoreMessages = false
    @Published var showMenu = false
    @Published var chatEnded = false

    // MARK: - Private Properties

    private var chatId: String
    var userId: String
    private var sessionStartTime: Date?
    private var typingTimer: Timer?
    private var autoReplyTimer: Timer?

    // MARK: - Initialization

    init() {
        self.chatId = UUID().uuidString
        self.userId = "cust_\(UUID().uuidString.prefix(8))"
    }

    // MARK: - Connection

    func connectToChat() {
        connectionStatus = .connecting

        Task {
            // Simulate connection delay
            try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds

            // Assign agent
            currentAgent = ChatAgent.mockSarah
            connectionStatus = .connected
            sessionStartTime = Date()

            // Load initial messages
            loadInitialMessages()

            // Set initial quick replies
            updateQuickReplies()

            print("💬 Chat connected - Session ID: \(chatId)")
        }
    }

    func disconnectFromChat() {
        connectionStatus = .disconnected
        typingTimer?.invalidate()
        autoReplyTimer?.invalidate()

        print("💬 Chat disconnected")
    }

    func reconnect() {
        connectionStatus = .reconnecting

        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second

            connectionStatus = .connected
            print("💬 Chat reconnected")
        }
    }

    // MARK: - Load Messages

    private func loadInitialMessages() {
        // Load mock conversation history
        messages = ChatMessage.createMockMessages(chatId: chatId, userId: userId)

        // Add system message
        let systemMessage = ChatMessage(
            chatId: chatId,
            senderId: "system",
            senderName: "System",
            text: "Chat started with \(currentAgent?.name ?? "Support"). We're here to help!",
            timestamp: Date().addingTimeInterval(-360),
            type: .system,
            isRead: true
        )
        messages.insert(systemMessage, at: 0)

        hasMoreMessages = true
    }

    func loadMoreMessages() {
        guard hasMoreMessages else { return }

        Task {
            // Simulate loading delay
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds

            // For demo, we don't load more messages
            hasMoreMessages = false
        }
    }

    // MARK: - Send Message

    func sendMessage(text: String) {
        let message = ChatMessage(
            chatId: chatId,
            senderId: userId,
            senderName: "You",
            text: text,
            timestamp: Date(),
            type: .text,
            isRead: false
        )

        messages.append(message)

        // Simulate sending to server
        Task {
            try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds

            // Mark as read (simulating server acknowledgment)
            if let index = messages.firstIndex(where: { $0.id == message.id }) {
                messages[index].isRead = true
            }

            // Trigger agent response
            simulateAgentResponse(to: text)
        }

        // Update quick replies based on context
        updateQuickReplies()

        print("📤 Sent message: \(text)")
    }

    func sendImage(image: UIImage) {
        // In a real app, upload image to server first
        let message = ChatMessage(
            chatId: chatId,
            senderId: userId,
            senderName: "You",
            text: "Shared an image",
            timestamp: Date(),
            type: .image,
            isRead: false,
            imageURL: "https://placeholder.com/image.jpg" // Mock URL
        )

        messages.append(message)

        print("📤 Sent image")
    }

    // MARK: - Agent Simulation

    private func simulateAgentResponse(to userMessage: String) {
        // Show typing indicator
        isAgentTyping = true

        // Simulate agent typing delay (1-3 seconds)
        let typingDelay = Double.random(in: 1.0...3.0)

        Task {
            try? await Task.sleep(nanoseconds: UInt64(typingDelay * 1_000_000_000))

            isAgentTyping = false

            // Generate contextual response
            let response = generateAgentResponse(to: userMessage)

            let agentMessage = ChatMessage(
                chatId: chatId,
                senderId: currentAgent?.id ?? "agent_001",
                senderName: currentAgent?.name ?? "Sarah",
                text: response,
                timestamp: Date(),
                type: .text,
                isRead: true
            )

            messages.append(agentMessage)

            print("📥 Received agent message: \(response)")
        }
    }

    private func generateAgentResponse(to message: String) -> String {
        let lowercased = message.lowercased()

        if lowercased.contains("help") || lowercased.contains("issue") || lowercased.contains("problem") {
            return "I understand you're having an issue. Can you please provide more details so I can assist you better?"
        } else if lowercased.contains("booking") || lowercased.contains("bkg") {
            return "I can help you with your booking. Let me check the details for you..."
        } else if lowercased.contains("refund") || lowercased.contains("money") || lowercased.contains("payment") {
            return "I see you're asking about a refund. Let me look into this for you. This usually takes 5-7 business days to process."
        } else if lowercased.contains("cancel") {
            return "I can help you cancel your booking. Please note that cancellation charges may apply depending on the timing."
        } else if lowercased.contains("thank") {
            return "You're welcome! Is there anything else I can help you with?"
        } else if lowercased.contains("no") && messages.suffix(3).contains(where: { $0.text.contains("else") }) {
            return "Great! Feel free to reach out if you need anything else. Have a wonderful day! 😊"
        } else if message.starts(with: "#") {
            return "Thanks for sharing the booking ID. Let me pull up the details... One moment please."
        } else {
            return "I understand. Let me check that for you right away."
        }
    }

    // MARK: - Quick Replies

    private func updateQuickReplies() {
        let recentMessages = messages.suffix(5)
        let hasAskedAboutBooking = recentMessages.contains(where: { $0.text.lowercased().contains("booking") })

        if hasAskedAboutBooking {
            quickReplies = ["My booking", "Cancel booking", "Change date", "Talk to manager"]
        } else if messages.count < 3 {
            quickReplies = ["Booking issue", "Payment problem", "Refund request", "General inquiry"]
        } else {
            quickReplies = ["Yes, that helps", "No, still need help", "Speak to someone else"]
        }
    }

    // MARK: - Chat Actions

    func endChat() {
        let systemMessage = ChatMessage(
            chatId: chatId,
            senderId: "system",
            senderName: "System",
            text: "Chat ended. Thank you for contacting UrbanNest Support!",
            timestamp: Date(),
            type: .system,
            isRead: true
        )

        messages.append(systemMessage)
        chatEnded = true
        disconnectFromChat()

        print("💬 Chat ended - Duration: \(sessionDuration())")
    }

    func emailTranscript() {
        // In a real app, send transcript to user's email
        let transcript = messages.map { "\($0.senderName): \($0.text)" }.joined(separator: "\n")

        print("📧 Email transcript:")
        print(transcript)

        // Show success message
        let systemMessage = ChatMessage(
            chatId: chatId,
            senderId: "system",
            senderName: "System",
            text: "Chat transcript has been sent to your email.",
            timestamp: Date(),
            type: .system,
            isRead: true
        )

        messages.append(systemMessage)
    }

    func shareChat() {
        // In a real app, open native share sheet
        print("📤 Share chat transcript")
    }

    // MARK: - Utilities

    private func sessionDuration() -> String {
        guard let start = sessionStartTime else { return "0s" }
        let duration = Int(Date().timeIntervalSince(start))
        let minutes = duration / 60
        let seconds = duration % 60
        return "\(minutes)m \(seconds)s"
    }
}
