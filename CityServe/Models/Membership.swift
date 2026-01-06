//
//  Membership.swift
//  CityServe
//
//  Plus Membership and Rewards Data Models
//  Mock data for UI implementation
//

import Foundation

// MARK: - Membership Plan

struct MembershipPlan: Identifiable, Codable {
    let id: String
    let name: String
    let displayName: String
    let price: Double
    let currency: String
    let billingPeriod: BillingPeriod
    let benefits: [String]
    let discount: Double // Discount percentage (e.g., 15.0 for 15%)
    let isPopular: Bool
    let savingsAmount: Double? // Annual savings compared to monthly

    enum BillingPeriod: String, Codable {
        case monthly = "month"
        case annual = "year"

        var displayText: String {
            switch self {
            case .monthly: return "/month"
            case .annual: return "/year"
            }
        }
    }
}

// MARK: - User Membership

struct UserMembership: Identifiable, Codable {
    let id: String
    let userId: String
    let planId: String
    let status: MembershipStatus
    let startDate: Date
    let expiryDate: Date
    let autoRenew: Bool
    let discountPercentage: Double

    enum MembershipStatus: String, Codable {
        case active
        case expired
        case cancelled
        case trial

        var displayText: String {
            switch self {
            case .active: return "Active"
            case .expired: return "Expired"
            case .cancelled: return "Cancelled"
            case .trial: return "Trial"
            }
        }
    }

    var isActive: Bool {
        status == .active && Date() < expiryDate
    }

    var daysRemaining: Int {
        let days = Calendar.current.dateComponents([.day], from: Date(), to: expiryDate).day ?? 0
        return max(0, days)
    }
}

// MARK: - Rewards Points

struct RewardsAccount: Identifiable, Codable {
    let id: String
    let userId: String
    var pointsBalance: Int
    var lifetimePoints: Int
    let tier: RewardsTier
    let createdAt: Date
    var lastUpdated: Date

    enum RewardsTier: String, Codable {
        case bronze
        case silver
        case gold
        case platinum

        var displayName: String {
            rawValue.capitalized
        }

        var minPoints: Int {
            switch self {
            case .bronze: return 0
            case .silver: return 500
            case .gold: return 2000
            case .platinum: return 5000
            }
        }

        var iconName: String {
            switch self {
            case .bronze: return "shield.fill"
            case .silver: return "star.fill"
            case .gold: return "crown.fill"
            case .platinum: return "sparkles"
            }
        }
    }
}

// MARK: - Points Transaction

struct PointsTransaction: Identifiable, Codable {
    let id: String
    let userId: String
    let amount: Int // Positive for earning, negative for redemption
    let type: TransactionType
    let reason: String
    let relatedId: String? // Booking ID, referral ID, etc.
    let timestamp: Date

    enum TransactionType: String, Codable {
        case earned
        case redeemed
        case expired
        case adjusted

        var displayText: String {
            switch self {
            case .earned: return "Earned"
            case .redeemed: return "Redeemed"
            case .expired: return "Expired"
            case .adjusted: return "Adjusted"
            }
        }
    }

    var isPositive: Bool {
        amount > 0
    }
}

// MARK: - Reward Item

struct RewardItem: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let pointsCost: Int
    let category: RewardCategory
    let imageURL: String?
    let isAvailable: Bool
    let expiryDate: Date?
    let termsAndConditions: String

    enum RewardCategory: String, Codable {
        case discount
        case freeService
        case upgrade
        case special

        var displayName: String {
            switch self {
            case .discount: return "Discounts"
            case .freeService: return "Free Services"
            case .upgrade: return "Upgrades"
            case .special: return "Special Offers"
            }
        }
    }
}

// MARK: - Points Earning Rules

struct PointsEarningRule: Identifiable {
    let id: String
    let action: String
    let points: Int
    let description: String
    let icon: String
    let color: String

    static let defaultRules: [PointsEarningRule] = [
        PointsEarningRule(
            id: "booking_complete",
            action: "Complete Bookings",
            points: 50,
            description: "Earn points for every completed service",
            icon: "checkmark.circle.fill",
            color: "success"
        ),
        PointsEarningRule(
            id: "write_review",
            action: "Write Reviews",
            points: 20,
            description: "Share your feedback on completed services",
            icon: "star.fill",
            color: "warning"
        ),
        PointsEarningRule(
            id: "refer_friend",
            action: "Refer Friends",
            points: 100,
            description: "Invite friends and earn when they book",
            icon: "person.2.fill",
            color: "info"
        ),
        PointsEarningRule(
            id: "special_offer",
            action: "Special Offers",
            points: 0,
            description: "Complete challenges for extra rewards",
            icon: "trophy.fill",
            color: "secondary"
        )
    ]
}

// MARK: - Mock Data

extension MembershipPlan {
    static let monthly = MembershipPlan(
        id: "plan_monthly",
        name: "monthly",
        displayName: "Monthly",
        price: 299,
        currency: "INR",
        billingPeriod: .monthly,
        benefits: [
            "All Plus benefits",
            "Cancel anytime"
        ],
        discount: 15.0,
        isPopular: false,
        savingsAmount: nil
    )

    static let annual = MembershipPlan(
        id: "plan_annual",
        name: "annual",
        displayName: "Annual",
        price: 2999,
        currency: "INR",
        billingPeriod: .annual,
        benefits: [
            "All Plus benefits",
            "Save ₹588/year",
            "Best value"
        ],
        discount: 15.0,
        isPopular: true,
        savingsAmount: 588
    )

    static let allPlans: [MembershipPlan] = [monthly, annual]
}

extension UserMembership {
    static let mockActive = UserMembership(
        id: "membership_123",
        userId: "user_123",
        planId: "plan_annual",
        status: .active,
        startDate: Date().addingTimeInterval(-30 * 24 * 60 * 60), // 30 days ago
        expiryDate: Date().addingTimeInterval(335 * 24 * 60 * 60), // 335 days from now
        autoRenew: true,
        discountPercentage: 15.0
    )

    static let mockExpired = UserMembership(
        id: "membership_124",
        userId: "user_124",
        planId: "plan_monthly",
        status: .expired,
        startDate: Date().addingTimeInterval(-60 * 24 * 60 * 60),
        expiryDate: Date().addingTimeInterval(-5 * 24 * 60 * 60),
        autoRenew: false,
        discountPercentage: 15.0
    )
}

extension RewardsAccount {
    static let mockAccount = RewardsAccount(
        id: "rewards_123",
        userId: "user_123",
        pointsBalance: 450,
        lifetimePoints: 1250,
        tier: .bronze,
        createdAt: Date().addingTimeInterval(-90 * 24 * 60 * 60),
        lastUpdated: Date()
    )

    static let mockEmptyAccount = RewardsAccount(
        id: "rewards_124",
        userId: "user_124",
        pointsBalance: 0,
        lifetimePoints: 0,
        tier: .bronze,
        createdAt: Date(),
        lastUpdated: Date()
    )
}

extension PointsTransaction {
    static let mockTransactions: [PointsTransaction] = [
        PointsTransaction(
            id: "txn_001",
            userId: "user_123",
            amount: 50,
            type: .earned,
            reason: "Booking completed - AC Repair",
            relatedId: "booking_001",
            timestamp: Date().addingTimeInterval(-2 * 24 * 60 * 60)
        ),
        PointsTransaction(
            id: "txn_002",
            userId: "user_123",
            amount: 20,
            type: .earned,
            reason: "Review submitted for Plumbing Service",
            relatedId: "review_001",
            timestamp: Date().addingTimeInterval(-5 * 24 * 60 * 60)
        ),
        PointsTransaction(
            id: "txn_003",
            userId: "user_123",
            amount: 100,
            type: .earned,
            reason: "Friend referral - Rahul joined",
            relatedId: "referral_001",
            timestamp: Date().addingTimeInterval(-10 * 24 * 60 * 60)
        ),
        PointsTransaction(
            id: "txn_004",
            userId: "user_123",
            amount: -50,
            type: .redeemed,
            reason: "Redeemed for 10% discount",
            relatedId: "reward_001",
            timestamp: Date().addingTimeInterval(-15 * 24 * 60 * 60)
        )
    ]
}

extension RewardItem {
    static let mockRewards: [RewardItem] = [
        RewardItem(
            id: "reward_001",
            name: "₹100 Off Next Booking",
            description: "Get ₹100 discount on your next service booking (min. order ₹500)",
            pointsCost: 500,
            category: .discount,
            imageURL: nil,
            isAvailable: true,
            expiryDate: Date().addingTimeInterval(30 * 24 * 60 * 60),
            termsAndConditions: "Valid for 30 days. Minimum order value ₹500."
        ),
        RewardItem(
            id: "reward_002",
            name: "Free Home Cleaning",
            description: "Redeem for one free basic home cleaning service",
            pointsCost: 1000,
            category: .freeService,
            imageURL: nil,
            isAvailable: true,
            expiryDate: nil,
            termsAndConditions: "Valid for standard 2BHK cleaning only."
        ),
        RewardItem(
            id: "reward_003",
            name: "Priority Booking",
            description: "Get priority booking for 1 month",
            pointsCost: 750,
            category: .upgrade,
            imageURL: nil,
            isAvailable: true,
            expiryDate: Date().addingTimeInterval(60 * 24 * 60 * 60),
            termsAndConditions: "Priority booking for 30 days from redemption."
        ),
        RewardItem(
            id: "reward_004",
            name: "Partner Discount - Swiggy",
            description: "₹50 off on Swiggy orders",
            pointsCost: 200,
            category: .special,
            imageURL: nil,
            isAvailable: false,
            expiryDate: nil,
            termsAndConditions: "Coming soon!"
        )
    ]
}
