//
//  Help.swift
//  CityServe
//
//  Data Models for Help Center, FAQs, and Support
//

import Foundation

// MARK: - Help Topic

struct HelpTopic: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let icon: String // Emoji icon
    let articleCount: Int
    let sortOrder: Int
    let isActive: Bool

    init(id: String, title: String, icon: String, articleCount: Int, sortOrder: Int = 0, isActive: Bool = true) {
        self.id = id
        self.title = title
        self.icon = icon
        self.articleCount = articleCount
        self.sortOrder = sortOrder
        self.isActive = isActive
    }
}

// MARK: - Help FAQ

struct HelpFAQ: Codable, Identifiable, Hashable {
    let id: String
    let question: String
    let answer: String
    let topicId: String?
    let sortOrder: Int
    let viewCount: Int
    let helpfulCount: Int
    let notHelpfulCount: Int
    var wasHelpful: Bool? // Local user feedback (not sent to server)

    init(id: String, question: String, answer: String, topicId: String? = nil, sortOrder: Int = 0, viewCount: Int = 0, helpfulCount: Int = 0, notHelpfulCount: Int = 0, wasHelpful: Bool? = nil) {
        self.id = id
        self.question = question
        self.answer = answer
        self.topicId = topicId
        self.sortOrder = sortOrder
        self.viewCount = viewCount
        self.helpfulCount = helpfulCount
        self.notHelpfulCount = notHelpfulCount
        self.wasHelpful = wasHelpful
    }
}

// MARK: - Help Article

struct HelpArticle: Codable, Identifiable, Hashable {
    let id: String
    let topicId: String
    let title: String
    let content: String
    let snippet: String // Short preview for search results
    let keywords: [String]
    let viewCount: Int
    let helpfulCount: Int
    let notHelpfulCount: Int
    let lastUpdated: Date
    let isActive: Bool

    init(id: String, topicId: String, title: String, content: String, snippet: String, keywords: [String] = [], viewCount: Int = 0, helpfulCount: Int = 0, notHelpfulCount: Int = 0, lastUpdated: Date = Date(), isActive: Bool = true) {
        self.id = id
        self.topicId = topicId
        self.title = title
        self.content = content
        self.snippet = snippet
        self.keywords = keywords
        self.viewCount = viewCount
        self.helpfulCount = helpfulCount
        self.notHelpfulCount = notHelpfulCount
        self.lastUpdated = lastUpdated
        self.isActive = isActive
    }
}

// MARK: - Support Contact

struct SupportContact: Codable, Hashable {
    let phone: String
    let email: String
    let operatingHours: String
    let isCurrentlyOpen: Bool

    init(phone: String, email: String, operatingHours: String, isCurrentlyOpen: Bool) {
        self.phone = phone
        self.email = email
        self.operatingHours = operatingHours
        self.isCurrentlyOpen = isCurrentlyOpen
    }
}

// MARK: - Help Center Data

struct HelpCenterData: Codable {
    let popularTopics: [HelpTopic]
    let topFAQs: [HelpFAQ]
    let supportContact: SupportContact
    let appVersion: String
}

// MARK: - Mock Data

extension HelpTopic {
    static let mockBookingPayments = HelpTopic(
        id: "topic_001",
        title: "Booking & Payments",
        icon: "📖",
        articleCount: 5,
        sortOrder: 1
    )

    static let mockServiceIssues = HelpTopic(
        id: "topic_002",
        title: "Service Issues & Complaints",
        icon: "🔧",
        articleCount: 8,
        sortOrder: 2
    )

    static let mockAccountProfile = HelpTopic(
        id: "topic_003",
        title: "Account & Profile",
        icon: "👤",
        articleCount: 6,
        sortOrder: 3
    )

    static let mockReviewsRatings = HelpTopic(
        id: "topic_004",
        title: "Reviews & Ratings",
        icon: "⭐",
        articleCount: 4,
        sortOrder: 4
    )

    static let mockRefundsCancellations = HelpTopic(
        id: "topic_005",
        title: "Refunds & Cancellations",
        icon: "💰",
        articleCount: 7,
        sortOrder: 5
    )

    static let mockSafetyPrivacy = HelpTopic(
        id: "topic_006",
        title: "Safety & Privacy",
        icon: "🔒",
        articleCount: 5,
        sortOrder: 6
    )

    static let mockTopics: [HelpTopic] = [
        mockBookingPayments,
        mockServiceIssues,
        mockAccountProfile,
        mockReviewsRatings,
        mockRefundsCancellations,
        mockSafetyPrivacy
    ]
}

extension HelpFAQ {
    static let mockBookService = HelpFAQ(
        id: "faq_001",
        question: "How do I book a service?",
        answer: "To book a service, tap on the service you need from the home screen. Select a provider, choose your preferred date and time, add your address, and proceed to payment. You'll receive instant confirmation once your booking is complete.",
        topicId: "topic_001",
        sortOrder: 1,
        viewCount: 1250,
        helpfulCount: 980,
        notHelpfulCount: 45
    )

    static let mockTrackBooking = HelpFAQ(
        id: "faq_002",
        question: "How do I track my booking?",
        answer: "Go to the 'Orders' tab at the bottom of the screen. You can see all your active bookings with real-time status updates. Tap on any booking to see detailed tracking information including provider location and estimated arrival time.",
        topicId: "topic_001",
        sortOrder: 2,
        viewCount: 890,
        helpfulCount: 720,
        notHelpfulCount: 32
    )

    static let mockCancelBooking = HelpFAQ(
        id: "faq_003",
        question: "Can I cancel after booking?",
        answer: "Yes, you can cancel your booking up to 2 hours before the scheduled time for a full refund. After that, cancellation charges may apply. To cancel, go to Orders > Select booking > Cancel Booking. The refund will be processed within 5-7 business days.",
        topicId: "topic_005",
        sortOrder: 3,
        viewCount: 1500,
        helpfulCount: 1200,
        notHelpfulCount: 89
    )

    static let mockGetRefund = HelpFAQ(
        id: "faq_004",
        question: "How do I get a refund?",
        answer: "Refunds are automatically processed when you cancel a booking within the allowed timeframe. You can also request a refund for unsatisfactory service by going to Orders > Select booking > Report Issue > Request Refund. Our support team will review and process approved refunds within 5-7 business days to your original payment method.",
        topicId: "topic_005",
        sortOrder: 4,
        viewCount: 1100,
        helpfulCount: 850,
        notHelpfulCount: 120
    )

    static let mockChangeAddress = HelpFAQ(
        id: "faq_005",
        question: "How do I change my address?",
        answer: "Go to Profile > Saved Addresses. You can add a new address, edit existing ones, or set a default address. If you need to change the address for an existing booking, go to Orders > Select booking > Edit Details (available up to 4 hours before service).",
        topicId: "topic_003",
        sortOrder: 5,
        viewCount: 650,
        helpfulCount: 520,
        notHelpfulCount: 28
    )

    static let mockFAQs: [HelpFAQ] = [
        mockBookService,
        mockTrackBooking,
        mockCancelBooking,
        mockGetRefund,
        mockChangeAddress
    ]
}

extension SupportContact {
    static let mockContact = SupportContact(
        phone: "1800-123-4567",
        email: "support@urbannest.com",
        operatingHours: "Mon-Sat: 9 AM - 9 PM | Sun: 10 AM - 6 PM",
        isCurrentlyOpen: true
    )
}

extension HelpCenterData {
    static let mockData = HelpCenterData(
        popularTopics: HelpTopic.mockTopics,
        topFAQs: HelpFAQ.mockFAQs,
        supportContact: SupportContact.mockContact,
        appVersion: "1.0.0"
    )
}

// MARK: - Support Ticket

enum IssueCategory: String, CaseIterable, Codable {
    case bookingIssue = "Booking Issue"
    case paymentProblem = "Payment Problem"
    case accountProfile = "Account & Profile"
    case serviceQuality = "Service Quality"
    case refundRequest = "Refund Request"
    case technicalIssue = "App Bug/Technical Issue"
    case safetyConcern = "Safety Concern"
    case other = "Other"

    var displayName: String { rawValue }

    var commonIssues: [String] {
        switch self {
        case .bookingIssue:
            return ["Booking not confirmed", "Provider not arrived", "Wrong service booked"]
        case .paymentProblem:
            return ["Payment failed", "Double charged", "Refund not received"]
        case .serviceQuality:
            return ["Poor service quality", "Incomplete work", "Unprofessional behavior"]
        case .refundRequest:
            return ["Cancel and refund", "Partial refund request"]
        default:
            return []
        }
    }
}

enum TicketPriority: String, CaseIterable, Codable {
    case low = "Low"
    case normal = "Normal"
    case high = "High"

    var displayName: String { rawValue }
}

enum TicketStatus: String, Codable {
    case open = "Open"
    case inProgress = "In Progress"
    case resolved = "Resolved"
    case closed = "Closed"
}

struct SupportTicket: Codable, Identifiable {
    let id: String
    let customerId: String
    let category: IssueCategory
    let bookingId: String?
    let subject: String
    let description: String
    let priority: TicketPriority
    let status: TicketStatus
    let contactPreferences: [ContactPreference]
    let attachmentURLs: [String]
    let createdAt: Date
    let updatedAt: Date
    let estimatedResponseTime: String

    init(id: String, customerId: String, category: IssueCategory, bookingId: String? = nil, subject: String, description: String, priority: TicketPriority, status: TicketStatus = .open, contactPreferences: [ContactPreference], attachmentURLs: [String] = [], createdAt: Date = Date(), updatedAt: Date = Date(), estimatedResponseTime: String = "2-4 hours") {
        self.id = id
        self.customerId = customerId
        self.category = category
        self.bookingId = bookingId
        self.subject = subject
        self.description = description
        self.priority = priority
        self.status = status
        self.contactPreferences = contactPreferences
        self.attachmentURLs = attachmentURLs
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.estimatedResponseTime = estimatedResponseTime
    }
}

enum ContactPreference: String, Codable {
    case email = "Email"
    case phone = "Phone"
    case notification = "In-App Notification"
}

// MARK: - Chat Models

enum MessageType: String, Codable {
    case text = "text"
    case image = "image"
    case system = "system"
}

struct ChatMessage: Codable, Identifiable, Hashable {
    let id: String
    let chatId: String
    let senderId: String
    let senderName: String
    let text: String
    let timestamp: Date
    let type: MessageType
    var isRead: Bool
    let imageURL: String?

    init(id: String = UUID().uuidString, chatId: String, senderId: String, senderName: String, text: String, timestamp: Date = Date(), type: MessageType = .text, isRead: Bool = false, imageURL: String? = nil) {
        self.id = id
        self.chatId = chatId
        self.senderId = senderId
        self.senderName = senderName
        self.text = text
        self.timestamp = timestamp
        self.type = type
        self.isRead = isRead
        self.imageURL = imageURL
    }
}

struct ChatAgent: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let photoURL: String?
    let isOnline: Bool
    let role: String

    init(id: String = UUID().uuidString, name: String, photoURL: String? = nil, isOnline: Bool = true, role: String = "Support Agent") {
        self.id = id
        self.name = name
        self.photoURL = photoURL
        self.isOnline = isOnline
        self.role = role
    }
}

enum ConnectionStatus: String, Codable {
    case connecting = "Connecting"
    case connected = "Connected"
    case disconnected = "Disconnected"
    case reconnecting = "Reconnecting"

    var displayText: String {
        switch self {
        case .connecting: return "Connecting..."
        case .connected: return "Online • Avg wait: 2 mins"
        case .disconnected: return "Offline"
        case .reconnecting: return "Reconnecting..."
        }
    }
}

struct ChatSession: Codable, Identifiable {
    let id: String
    let customerId: String
    let agentId: String?
    let status: String
    let startedAt: Date
    let endedAt: Date?
    let messagesCount: Int

    init(id: String = UUID().uuidString, customerId: String, agentId: String? = nil, status: String = "active", startedAt: Date = Date(), endedAt: Date? = nil, messagesCount: Int = 0) {
        self.id = id
        self.customerId = customerId
        self.agentId = agentId
        self.status = status
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.messagesCount = messagesCount
    }
}

// MARK: - Chat Mock Data

extension ChatAgent {
    static let mockSarah = ChatAgent(
        id: "agent_001",
        name: "Sarah",
        photoURL: nil,
        isOnline: true,
        role: "Senior Support Agent"
    )

    static let mockJohn = ChatAgent(
        id: "agent_002",
        name: "John",
        photoURL: nil,
        isOnline: true,
        role: "Support Agent"
    )
}

extension ChatMessage {
    static func createMockMessages(chatId: String, userId: String) -> [ChatMessage] {
        let now = Date()
        return [
            ChatMessage(
                chatId: chatId,
                senderId: "agent_001",
                senderName: "Sarah",
                text: "Hi! How can I help you today?",
                timestamp: now.addingTimeInterval(-300), // 5 mins ago
                type: .text,
                isRead: true
            ),
            ChatMessage(
                chatId: chatId,
                senderId: userId,
                senderName: "You",
                text: "I need help with my booking",
                timestamp: now.addingTimeInterval(-240), // 4 mins ago
                type: .text,
                isRead: true
            ),
            ChatMessage(
                chatId: chatId,
                senderId: "agent_001",
                senderName: "Sarah",
                text: "Sure! Can you share your booking ID?",
                timestamp: now.addingTimeInterval(-180), // 3 mins ago
                type: .text,
                isRead: true
            ),
            ChatMessage(
                chatId: chatId,
                senderId: userId,
                senderName: "You",
                text: "#BKG123",
                timestamp: now.addingTimeInterval(-120), // 2 mins ago
                type: .text,
                isRead: true
            ),
            ChatMessage(
                chatId: chatId,
                senderId: "agent_001",
                senderName: "Sarah",
                text: "Got it! Let me check the details of your booking...",
                timestamp: now.addingTimeInterval(-60), // 1 min ago
                type: .text,
                isRead: true
            )
        ]
    }
}

// MARK: - Help Article Mock Data

extension HelpArticle {
    static let mockArticle1 = HelpArticle(
        id: "article_001",
        topicId: "topic_001",
        title: "How to Request a Refund",
        content: """
        # How to Request a Refund

        If you're not satisfied with the service you received, you can request a refund by following these steps:

        ## Step 1: Report the Issue
        Go to the Orders tab and select the booking in question. Tap on "Report Issue" and select the reason for your dissatisfaction.

        ## Step 2: Submit Evidence
        Provide photos or detailed description of the issue. This helps our team process your request faster.

        ## Step 3: Wait for Review
        Our support team will review your request within 24-48 hours. You'll receive a notification once the review is complete.

        ## Step 4: Receive Refund
        If approved, the refund will be processed to your original payment method within 5-7 business days.

        ## Refund Policy
        - Full refund: Cancel 2+ hours before service
        - Partial refund: Cancel 1-2 hours before service
        - Service quality issues: Case-by-case review

        For urgent issues, contact our support team directly at 1800-123-4567.
        """,
        snippet: "Learn how to request and track refunds for cancelled or unsatisfactory services.",
        keywords: ["refund", "cancellation", "money back", "return"],
        viewCount: 2500,
        helpfulCount: 1980,
        notHelpfulCount: 120,
        lastUpdated: Date()
    )
}
