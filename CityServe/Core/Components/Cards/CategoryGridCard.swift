//
//  CategoryGridCard.swift
//  CityServe
//
//  Compact Category Card for 4-Column Grid
//  Design System Component - From designs
//

import SwiftUI

/// Compact category card for home screen 4-column grid layout
/// Usage: Home screen category sections, service discovery
struct CategoryGridCard: View {

    // MARK: - Properties

    let category: CategoryCardModel
    let action: (() -> Void)?

    @State private var isPressed = false

    init(category: CategoryCardModel, action: (() -> Void)? = nil) {
        self.category = category
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button(action: handleTap) {
            VStack(spacing: Spacing.xs) {
                // Icon or Image
                iconView
                    .frame(width: 56, height: 56)
                    .background(iconBackground)
                    .cornerRadius(Spacing.radiusLg)

                // Name
                Text(category.name)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.textPrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.xs)
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(Animations.cardPress) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(Animations.cardPress) {
                        isPressed = false
                    }
                }
        )
    }

    // MARK: - Subviews

    private var iconView: some View {
        Group {
            if let imageURL = category.imageURL {
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
            } else if let icon = category.icon {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(category.iconColor ?? .primary)
            } else {
                placeholderIcon
            }
        }
    }

    private var placeholderIcon: some View {
        Image(systemName: "square.grid.2x2")
            .font(.system(size: 28))
            .foregroundColor(.textTertiary)
    }

    private var iconBackground: some View {
        LinearGradient(
            colors: category.gradientColors ?? [
                Color.primary.opacity(0.1),
                Color.primary.opacity(0.05)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // MARK: - Actions

    private func handleTap() {
        Haptics.light()
        action?()
    }
}

// MARK: - Category Card Model

struct CategoryCardModel: Identifiable {
    let id: String
    let name: String
    let icon: String?
    let imageURL: String?
    let iconColor: Color?
    let gradientColors: [Color]?

    init(
        id: String = UUID().uuidString,
        name: String,
        icon: String? = nil,
        imageURL: String? = nil,
        iconColor: Color? = nil,
        gradientColors: [Color]? = nil
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.imageURL = imageURL
        self.iconColor = iconColor
        self.gradientColors = gradientColors
    }

    // Preview helpers
    static func preview(
        name: String,
        icon: String,
        color: Color = .primary
    ) -> CategoryCardModel {
        CategoryCardModel(
            name: name,
            icon: icon,
            iconColor: color,
            gradientColors: [
                color.opacity(0.15),
                color.opacity(0.05)
            ]
        )
    }
}

// MARK: - Extension for ServiceCategory

extension CategoryCardModel {
    init(from category: ServiceCategory) {
        self.id = category.id
        self.name = category.name
        self.icon = category.icon
        self.imageURL = category.imageURL
        self.iconColor = nil
        self.gradientColors = nil
    }
}

// MARK: - Preview

#Preview("Category Grid Cards") {
    ScrollView {
        VStack(spacing: Spacing.xl) {
            // 4-column grid
            Text("Personal Services")
                .font(.sectionHeader)
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Spacing.screenPadding)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: Spacing.gridItemSpacing), count: 4),
                spacing: Spacing.gridItemSpacing
            ) {
                CategoryGridCard(
                    category: .preview(
                        name: "Salon for Women",
                        icon: "scissors",
                        color: Color(hex: "#FF6B9D")
                    ),
                    action: { print("Salon") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Spa for Women",
                        icon: "sparkles",
                        color: Color(hex: "#C77DFF")
                    ),
                    action: { print("Spa") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Men's Salon",
                        icon: "mustache",
                        color: Color(hex: "#4CC9F0")
                    ),
                    action: { print("Men's Salon") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Massage Therapy",
                        icon: "hands.sparkles",
                        color: Color(hex: "#06FFA5")
                    ),
                    action: { print("Massage") }
                )
            }
            .padding(.horizontal, Spacing.screenPadding)

            Divider()

            // Home Services
            Text("Home Services")
                .font(.sectionHeader)
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Spacing.screenPadding)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: Spacing.gridItemSpacing), count: 4),
                spacing: Spacing.gridItemSpacing
            ) {
                CategoryGridCard(
                    category: .preview(
                        name: "AC Repair",
                        icon: "snowflake",
                        color: Color(hex: "#4ECDC4")
                    ),
                    action: { print("AC") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Cleaning",
                        icon: "sparkles.rectangle.stack",
                        color: Color(hex: "#FFB627")
                    ),
                    action: { print("Cleaning") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Plumbing",
                        icon: "wrench.and.screwdriver",
                        color: Color(hex: "#FF6B6B")
                    ),
                    action: { print("Plumbing") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Electrical",
                        icon: "bolt.fill",
                        color: Color(hex: "#FFA500")
                    ),
                    action: { print("Electrical") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Painting",
                        icon: "paintbrush.fill",
                        color: Color(hex: "#9B59B6")
                    ),
                    action: { print("Painting") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Carpentry",
                        icon: "hammer.fill",
                        color: Color(hex: "#8B4513")
                    ),
                    action: { print("Carpentry") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Pest Control",
                        icon: "ant.fill",
                        color: Color(hex: "#2ECC71")
                    ),
                    action: { print("Pest") }
                )

                CategoryGridCard(
                    category: .preview(
                        name: "Appliance Repair",
                        icon: "refrigerator.fill",
                        color: Color(hex: "#3498DB")
                    ),
                    action: { print("Appliance") }
                )
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
        .padding(.vertical, Spacing.lg)
    }
    .background(Color.background)
}

#Preview("Category Grid Dark Mode") {
    LazyVGrid(
        columns: Array(repeating: GridItem(.flexible(), spacing: Spacing.gridItemSpacing), count: 4),
        spacing: Spacing.gridItemSpacing
    ) {
        CategoryGridCard(
            category: .preview(
                name: "Salon",
                icon: "scissors",
                color: .primary
            )
        )

        CategoryGridCard(
            category: .preview(
                name: "Spa",
                icon: "sparkles"
            )
        )

        CategoryGridCard(
            category: .preview(
                name: "AC Repair",
                icon: "snowflake"
            )
        )

        CategoryGridCard(
            category: .preview(
                name: "Cleaning",
                icon: "sparkles.rectangle.stack"
            )
        )
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
    .preferredColorScheme(.dark)
}
