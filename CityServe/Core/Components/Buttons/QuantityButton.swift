//
//  QuantityButton.swift
//  CityServe
//
//  Quantity Selector Component (+/- buttons with counter)
//  Design System Component - From designs
//

import SwiftUI

/// Quantity selector with +/- buttons for booking summary
/// Usage: Service quantity selection, item counter
struct QuantityButton: View {

    // MARK: - Properties

    @Binding var quantity: Int

    var minQuantity: Int = 1
    var maxQuantity: Int = 10
    var onQuantityChanged: ((Int) -> Void)? = nil

    @State private var isPlusPressed = false
    @State private var isMinusPressed = false

    // MARK: - Initializer

    init(
        quantity: Binding<Int>,
        minQuantity: Int = 1,
        maxQuantity: Int = 10,
        onQuantityChanged: ((Int) -> Void)? = nil
    ) {
        self._quantity = quantity
        self.minQuantity = minQuantity
        self.maxQuantity = maxQuantity
        self.onQuantityChanged = onQuantityChanged
    }

    // MARK: - Body

    var body: some View {
        HStack(spacing: 0) {
            // Minus button
            Button(action: decrementQuantity) {
                Image(systemName: "minus")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(canDecrement ? .primary : .textDisabled)
                    .frame(width: 32, height: 32)
                    .background(Color.surface)
                    .scaleEffect(isMinusPressed ? 0.9 : 1.0)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(!canDecrement)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if canDecrement {
                            withAnimation(Animations.buttonTap) {
                                isMinusPressed = true
                            }
                        }
                    }
                    .onEnded { _ in
                        withAnimation(Animations.buttonTap) {
                            isMinusPressed = false
                        }
                    }
            )

            // Quantity display
            Text("\(quantity)")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .frame(width: 40, height: 32)
                .background(Color.surface)

            // Plus button
            Button(action: incrementQuantity) {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(canIncrement ? .primary : .textDisabled)
                    .frame(width: 32, height: 32)
                    .background(Color.surface)
                    .scaleEffect(isPlusPressed ? 0.9 : 1.0)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(!canIncrement)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if canIncrement {
                            withAnimation(Animations.buttonTap) {
                                isPlusPressed = true
                            }
                        }
                    }
                    .onEnded { _ in
                        withAnimation(Animations.buttonTap) {
                            isPlusPressed = false
                        }
                    }
            )
        }
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusMd)
                .stroke(Color.divider, lineWidth: 1)
        )
        .cornerRadius(Spacing.radiusMd)
    }

    // MARK: - Computed Properties

    private var canIncrement: Bool {
        quantity < maxQuantity
    }

    private var canDecrement: Bool {
        quantity > minQuantity
    }

    // MARK: - Actions

    private func incrementQuantity() {
        guard canIncrement else { return }

        Haptics.light()
        quantity += 1
        onQuantityChanged?(quantity)
    }

    private func decrementQuantity() {
        guard canDecrement else { return }

        Haptics.light()
        quantity -= 1
        onQuantityChanged?(quantity)
    }
}

// MARK: - Preview

#Preview("Quantity Button") {
    VStack(spacing: Spacing.xl) {
        // Default (min: 1, max: 10)
        QuantityButton(quantity: .constant(1))

        // Mid range
        QuantityButton(quantity: .constant(5))

        // At maximum
        QuantityButton(quantity: .constant(10))

        // Custom range (0-20)
        QuantityButton(
            quantity: .constant(15),
            minQuantity: 0,
            maxQuantity: 20
        )

        // With callback
        QuantityButton(
            quantity: .constant(3),
            onQuantityChanged: { newQuantity in
                print("Quantity changed to: \(newQuantity)")
            }
        )
    }
    .padding(Spacing.screenPadding)
}

#Preview("Quantity Button in Context") {
    // Example: Service card with quantity selector
    VStack(spacing: Spacing.lg) {
        HStack(spacing: Spacing.md) {
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text("AC Repair Service")
                    .font(.h5)
                    .foregroundColor(.textPrimary)

                Text("₹499")
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }

            Spacer()

            QuantityButton(quantity: .constant(2))
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .floatingCardShadow()

        HStack(spacing: Spacing.md) {
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                Text("Plumbing Service")
                    .font(.h5)
                    .foregroundColor(.textPrimary)

                Text("₹299")
                    .font(.body)
                    .foregroundColor(.textSecondary)
            }

            Spacer()

            QuantityButton(quantity: .constant(1))
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .floatingCardShadow()
    }
    .padding(Spacing.screenPadding)
    .background(Color.background)
}

#Preview("Quantity Button Dark Mode") {
    VStack(spacing: Spacing.lg) {
        QuantityButton(quantity: .constant(1))
        QuantityButton(quantity: .constant(5))
        QuantityButton(quantity: .constant(10))
    }
    .padding(Spacing.screenPadding)
    .preferredColorScheme(.dark)
}
