//
//  ServiceCard.swift
//  CityServe
//
//  Service Card Component
//  Design System Component
//

import SwiftUI

/// Service card displaying service information with image, name, price, and rating
/// Usage: Home screen service grid, category listings, search results
struct ServiceCard: View {

    // MARK: - Properties

    let service: ServiceCardModel
    let action: () -> Void

    var style: CardStyle = .vertical
    @State private var isPressed = false

    // MARK: - Card Styles

    enum CardStyle {
        case vertical    // Image on top, details below (grid)
        case horizontal  // Image on left, details on right (list)
        case compact     // Small square with icon only (home grid)
    }

    // MARK: - Body

    var body: some View {
        Button(action: handleTap) {
            switch style {
            case .vertical:
                verticalLayout
            case .horizontal:
                horizontalLayout
            case .compact:
                compactLayout
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(Animations.buttonTap, value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }

    // MARK: - Layouts

    private var verticalLayout: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            // Image
            serviceImage
                .aspectRatio(4/3, contentMode: .fill)
                .frame(height: 140)
                .clipped()
                .cornerRadius(Spacing.radiusMd, corners: [.topLeft, .topRight])

            // Details
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(service.name)
                    .font(.h5)
                    .foregroundColor(.textPrimary)
                    .lineLimit(2)

                if let rating = service.rating {
                    ratingView(rating: rating, reviewCount: service.reviewCount)
                }

                priceView
            }
            .padding(Spacing.sm)
        }
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .mediumShadow()
    }

    private var horizontalLayout: some View {
        HStack(spacing: Spacing.md) {
            // Image
            serviceImage
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(Spacing.radiusMd)

            // Details
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text(service.name)
                    .font(.h5)
                    .foregroundColor(.textPrimary)
                    .lineLimit(2)

                if let description = service.shortDescription {
                    Text(description)
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                        .lineLimit(2)
                }

                Spacer()

                HStack {
                    if let rating = service.rating {
                        ratingView(rating: rating, reviewCount: service.reviewCount)
                    }

                    Spacer()

                    priceView
                }
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.textTertiary)
        }
        .padding(Spacing.sm)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .mediumShadow()
    }

    private var compactLayout: some View {
        VStack(spacing: Spacing.xs) {
            // Icon or Image
            ZStack {
                if let icon = service.icon {
                    Circle()
                        .fill(Color.primary.opacity(0.1))
                        .frame(width: 56, height: 56)

                    Text(icon)
                        .font(.system(size: 28))
                } else {
                    serviceImage
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                }
            }

            // Name
            Text(service.name)
                .font(.bodySmall)
                .foregroundColor(.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            // Price
            if let price = service.basePrice {
                Text("₹\(Int(price))+")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.sm)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .mediumShadow()
    }

    // MARK: - Subviews

    private var serviceImage: some View {
        Group {
            if let imageURL = service.imageURL {
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        placeholderImage
                    case .success(let image):
                        image
                            .resizable()
                    case .failure:
                        placeholderImage
                    @unknown default:
                        placeholderImage
                    }
                }
            } else {
                placeholderImage
            }
        }
    }

    private var placeholderImage: some View {
        ZStack {
            Color.neutralGray
            if let icon = service.icon {
                Text(icon)
                    .font(.system(size: 40))
            } else {
                Image(systemName: "wrench.and.screwdriver")
                    .font(.system(size: 32))
                    .foregroundColor(.textTertiary)
            }
        }
    }

    private func ratingView(rating: Double, reviewCount: Int?) -> some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundColor(.secondary)

            Text(String(format: "%.1f", rating))
                .font(.rating)
                .foregroundColor(.textPrimary)

            if let count = reviewCount, count > 0 {
                Text("(\(count))")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
            }
        }
    }

    private var priceView: some View {
        HStack(spacing: 2) {
            if let price = service.basePrice {
                if let maxPrice = service.maxPrice, maxPrice != price {
                    Text("₹\(Int(price))-\(Int(maxPrice))")
                        .font(.priceSmall)
                        .foregroundColor(.textPrimary)
                } else {
                    Text("₹\(Int(price))+")
                        .font(.priceSmall)
                        .foregroundColor(.textPrimary)
                }
            }
        }
    }

    // MARK: - Actions

    private func handleTap() {
        Haptics.light()
        action()
    }
}

// MARK: - Service Card Model

struct ServiceCardModel: Identifiable {
    let id: String
    let name: String
    let icon: String?
    let imageURL: String?
    let shortDescription: String?
    let basePrice: Double?
    let maxPrice: Double?
    let rating: Double?
    let reviewCount: Int?

    // Convenience initializers for different use cases
    static func preview(
        name: String = "AC Repair & Service",
        icon: String? = "❄️",
        price: Double = 499
    ) -> ServiceCardModel {
        ServiceCardModel(
            id: UUID().uuidString,
            name: name,
            icon: icon,
            imageURL: nil,
            shortDescription: "Complete AC repair and servicing with gas refill",
            basePrice: price,
            maxPrice: 799,
            rating: 4.6,
            reviewCount: 89
        )
    }
}

// MARK: - Corner Radius Extension

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview

#Preview("Service Card Styles") {
    ScrollView {
        VStack(spacing: Spacing.xl) {
            // Vertical (Grid)
            Text("Vertical Style")
                .h4Style()

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: Spacing.md) {
                ServiceCard(
                    service: .preview(name: "AC Repair"),
                    action: { print("Tapped") }
                )

                ServiceCard(
                    service: .preview(name: "Plumbing Service", icon: "🚿", price: 349),
                    action: { print("Tapped") }
                )
            }

            Divider()

            // Horizontal (List)
            Text("Horizontal Style")
                .h4Style()

            VStack(spacing: Spacing.md) {
                ServiceCard(
                    service: .preview(),
                    action: { print("Tapped") },
                    style: .horizontal
                )

                ServiceCard(
                    service: .preview(name: "Electrical Work", icon: "💡", price: 299),
                    action: { print("Tapped") },
                    style: .horizontal
                )
            }

            Divider()

            // Compact (Home Grid)
            Text("Compact Style")
                .h4Style()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: Spacing.sm) {
                ServiceCard(
                    service: .preview(name: "AC Repair", icon: "❄️"),
                    action: { print("Tapped") },
                    style: .compact
                )

                ServiceCard(
                    service: .preview(name: "Plumbing", icon: "🚿"),
                    action: { print("Tapped") },
                    style: .compact
                )

                ServiceCard(
                    service: .preview(name: "Electrical", icon: "💡"),
                    action: { print("Tapped") },
                    style: .compact
                )

                ServiceCard(
                    service: .preview(name: "Cleaning", icon: "🧹"),
                    action: { print("Tapped") },
                    style: .compact
                )
            }
        }
        .padding(Spacing.screenPadding)
    }
}

#Preview("Service Card Dark Mode") {
    VStack(spacing: Spacing.lg) {
        ServiceCard(
            service: .preview(),
            action: { print("Tapped") }
        )

        ServiceCard(
            service: .preview(),
            action: { print("Tapped") },
            style: .horizontal
        )
    }
    .padding(Spacing.screenPadding)
    .preferredColorScheme(.dark)
}
