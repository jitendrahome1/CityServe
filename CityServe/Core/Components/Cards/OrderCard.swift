//
//  OrderCard.swift
//  CityServe
//
//  Past Order Display Card Component
//  Design System Component - From designs
//

import SwiftUI

/// Card displaying past order information with action buttons
/// Usage: Orders list, profile screen past orders section
struct OrderCard: View {

    // MARK: - Properties

    let order: OrderCardModel
    var onReorder: (() -> Void)? = nil
    var onRate: (() -> Void)? = nil
    var onViewDetails: (() -> Void)? = nil

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Header with service info
            HStack(spacing: Spacing.sm) {
                // Service image/icon
                serviceIcon
                    .frame(width: 60, height: 60)
                    .background(Color.neutralGray)
                    .cornerRadius(Spacing.radiusMd)

                // Service details
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text(order.serviceName)
                        .font(.h5)
                        .foregroundColor(.textPrimary)
                        .lineLimit(2)

                    if let providerName = order.providerName {
                        Text(providerName)
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)
                    }

                    HStack(spacing: Spacing.xs) {
                        statusBadge

                        Text("•")
                            .foregroundColor(.textTertiary)

                        Text(order.formattedDate)
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }
                }

                Spacer()

                // Price
                VStack(alignment: .trailing, spacing: Spacing.xxs) {
                    Text("₹\(Int(order.totalAmount))")
                        .font(.priceSmall)
                        .foregroundColor(.textPrimary)

                    if order.status == .completed && !order.isRated {
                        Image(systemName: "star")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }
            }

            // Action buttons
            HStack(spacing: Spacing.sm) {
                if order.status == .completed {
                    // Reorder button
                    SecondaryButton(
                        "REORDER",
                        size: .small,
                        style: .outlined
                    ) {
                        handleReorder()
                    }

                    // Rate button (only if not rated)
                    if !order.isRated {
                        PrimaryButton(
                            "RATE ORDER",
                            size: .small
                        ) {
                            handleRate()
                        }
                    }
                } else {
                    // View details button for non-completed orders
                    SecondaryButton(
                        "VIEW DETAILS",
                        size: .small,
                        style: .outlined
                    ) {
                        handleViewDetails()
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .floatingCardShadow()
        .onTapGesture {
            handleViewDetails()
        }
    }

    // MARK: - Subviews

    private var serviceIcon: some View {
        Group {
            if let imageURL = order.serviceImageURL {
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        placeholderIcon
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        placeholderIcon
                    @unknown default:
                        placeholderIcon
                    }
                }
            } else {
                placeholderIcon
            }
        }
    }

    private var placeholderIcon: some View {
        ZStack {
            Color.neutralGray

            Image(systemName: order.serviceIcon ?? "wrench.and.screwdriver")
                .font(.system(size: 24))
                .foregroundColor(.textTertiary)
        }
    }

    private var statusBadge: some View {
        Text(order.status.displayText)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(order.status.color)
            .padding(.horizontal, Spacing.xs)
            .padding(.vertical, 3)
            .background(order.status.color.opacity(0.12))
            .cornerRadius(Spacing.radiusSm)
    }

    // MARK: - Actions

    private func handleReorder() {
        Haptics.light()
        onReorder?()
    }

    private func handleRate() {
        Haptics.light()
        onRate?()
    }

    private func handleViewDetails() {
        Haptics.light()
        onViewDetails?()
    }
}

// MARK: - Order Card Model

struct OrderCardModel: Identifiable {
    let id: String
    let serviceName: String
    let serviceIcon: String?
    let serviceImageURL: String?
    let providerName: String?
    let status: OrderStatus
    let orderDate: Date
    let totalAmount: Double
    let isRated: Bool

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter.string(from: orderDate)
    }

    enum OrderStatus {
        case pending
        case confirmed
        case inProgress
        case completed
        case cancelled

        var displayText: String {
            switch self {
            case .pending: return "Pending"
            case .confirmed: return "Confirmed"
            case .inProgress: return "In Progress"
            case .completed: return "Completed"
            case .cancelled: return "Cancelled"
            }
        }

        var color: Color {
            switch self {
            case .pending: return .secondary
            case .confirmed: return .info
            case .inProgress: return .primary
            case .completed: return .success
            case .cancelled: return .error
            }
        }
    }

    // Preview helper
    static func preview(
        serviceName: String = "AC Repair & Service",
        status: OrderStatus = .completed,
        amount: Double = 999,
        isRated: Bool = false
    ) -> OrderCardModel {
        OrderCardModel(
            id: UUID().uuidString,
            serviceName: serviceName,
            serviceIcon: "snowflake",
            serviceImageURL: nil,
            providerName: "John Doe",
            status: status,
            orderDate: Date().addingTimeInterval(-86400 * 7), // 7 days ago
            totalAmount: amount,
            isRated: isRated
        )
    }
}

// MARK: - Preview

#Preview("Order Cards - All States") {
    ScrollView {
        VStack(spacing: Spacing.lg) {
            // Completed - Not rated
            OrderCard(
                order: .preview(
                    serviceName: "AC Repair & Service",
                    status: .completed,
                    isRated: false
                ),
                onReorder: { print("Reorder") },
                onRate: { print("Rate") },
                onViewDetails: { print("Details") }
            )

            // Completed - Already rated
            OrderCard(
                order: .preview(
                    serviceName: "Home Deep Cleaning",
                    status: .completed,
                    amount: 1499,
                    isRated: true
                ),
                onReorder: { print("Reorder") },
                onViewDetails: { print("Details") }
            )

            // In Progress
            OrderCard(
                order: .preview(
                    serviceName: "Plumbing Service",
                    status: .inProgress,
                    amount: 599,
                    isRated: false
                ),
                onViewDetails: { print("Details") }
            )

            // Confirmed
            OrderCard(
                order: .preview(
                    serviceName: "Electrical Work",
                    status: .confirmed,
                    amount: 799,
                    isRated: false
                ),
                onViewDetails: { print("Details") }
            )

            // Cancelled
            OrderCard(
                order: .preview(
                    serviceName: "Painting Service",
                    status: .cancelled,
                    amount: 2999,
                    isRated: false
                ),
                onViewDetails: { print("Details") }
            )
        }
        .padding(Spacing.screenPadding)
    }
    .background(Color.background)
}

#Preview("Order Card Dark Mode") {
    VStack(spacing: Spacing.lg) {
        OrderCard(
            order: .preview(
                serviceName: "AC Repair & Service",
                status: .completed,
                isRated: false
            ),
            onReorder: { print("Reorder") },
            onRate: { print("Rate") }
        )

        OrderCard(
            order: .preview(
                serviceName: "Home Cleaning",
                status: .inProgress
            )
        )
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
    .preferredColorScheme(.dark)
}
