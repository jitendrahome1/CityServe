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
    let action: (() -> Void)?

    var style: CardStyle = .vertical
    @State private var isPressed = false

    init(service: ServiceCardModel, action: (() -> Void)? = nil, style: CardStyle = .vertical) {
        self.service = service
        self.action = action
        self.style = style
    }

    // MARK: - Card Styles

    enum CardStyle {
        case vertical    // Image on top, details below (grid)
        case horizontal  // Image on left, details on right (list)
        case compact     // Small square with icon only (home grid)
    }

    // MARK: - Body

    var body: some View {
        Group {
            switch style {
            case .vertical:
                verticalLayout
            case .horizontal:
                horizontalLayout
            case .compact:
                compactLayout
            }
        }
        .if(action != nil) { view in
            view.onTapGesture {
                handleTap()
            }
        }
    }

    // MARK: - Layouts

    private var verticalLayout: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image with overlay gradient
            ZStack(alignment: .topTrailing) {
                serviceImage
                    .aspectRatio(4/3, contentMode: .fill)
                    .frame(height: 130)
                    .clipped()

                // Rating badge overlay
                if let rating = service.rating {
                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.white)

                        Text(String(format: "%.1f", rating))
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.6))
                            .background(.ultraThinMaterial)
                    )
                    .padding(10)
                }
            }
            .cornerRadius(Spacing.radiusLg, corners: [.topLeft, .topRight])

            // Details
            VStack(alignment: .leading, spacing: 8) {
                Text(service.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.textPrimary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                if let description = service.shortDescription {
                    Text(description)
                        .font(.system(size: 12))
                        .foregroundColor(.textSecondary)
                        .lineLimit(2)
                }

                Spacer()

                // Price with gradient background
                HStack {
                    if let price = service.basePrice {
                        Text("₹\(Int(price))")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)

                        if let maxPrice = service.maxPrice, maxPrice != price {
                            Text("- ₹\(Int(maxPrice))")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.textSecondary)
                        }
                    }

                    Spacer()

                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.primary.opacity(0.8))
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 240)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .shadow(color: Color.primary.opacity(0.08), radius: 12, x: 0, y: 4)
        .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
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
        VStack(spacing: 8) {
            // Icon or Image
            ZStack {
                if let icon = service.icon {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.primary.opacity(0.1))
                        .frame(width: 64, height: 64)

                    Image(systemName: icon)
                        .font(.system(size: 32))
                        .foregroundColor(.primary)
                } else {
                    serviceImage
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: 64, height: 64)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }

            // Name
            Text(service.name)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)

            // Price
            if let price = service.basePrice {
                Text("₹\(Int(price))+")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.textSecondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusMd)
        .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
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
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(.textTertiary)
            } else {
                Image(systemName: "wrench.and.screwdriver")
                    .font(.system(size: 32))
                    .foregroundColor(.textTertiary)
            }
        }
    }

    private func ratingView(rating: Double, reviewCount: Int?) -> some View {
        HStack(spacing: 3) {
            Image(systemName: "star.fill")
                .font(.system(size: 11))
                .foregroundColor(.secondary)

            Text(String(format: "%.1f", rating))
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.textPrimary)

            if let count = reviewCount, count > 0 {
                Text("(\(count))")
                    .font(.system(size: 11))
                    .foregroundColor(.textSecondary)
            }
        }
    }

    private var priceView: some View {
        HStack(spacing: 2) {
            if let price = service.basePrice {
                if let maxPrice = service.maxPrice, maxPrice != price {
                    Text("₹\(Int(price))-\(Int(maxPrice))")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.textPrimary)
                } else {
                    Text("₹\(Int(price))+")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.textPrimary)
                }
            }
        }
    }

    // MARK: - Actions

    private func handleTap() {
        isPressed = true
        Haptics.light()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPressed = false
            action?()
        }
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

// MARK: - View Extensions

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
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
