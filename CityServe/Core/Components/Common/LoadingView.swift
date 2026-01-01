//
//  LoadingView.swift
//  CityServe
//
//  Loading State Component
//  Design System Component
//

import SwiftUI

/// Loading indicator view with optional message
/// Usage: Data fetching, processing, waiting states
struct LoadingView: View {

    var message: String? = nil
    var style: LoadingStyle = .spinner

    enum LoadingStyle {
        case spinner          // Standard spinner
        case shimmer         // Shimmer skeleton
        case inline          // Small inline spinner
    }

    var body: some View {
        switch style {
        case .spinner:
            spinnerView
        case .shimmer:
            shimmerView
        case .inline:
            inlineView
        }
    }

    // MARK: - Spinner View

    private var spinnerView: some View {
        VStack(spacing: Spacing.md) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                .scaleEffect(1.2)

            if let message = message {
                Text(message)
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }

    // MARK: - Shimmer View

    private var shimmerView: some View {
        VStack(spacing: Spacing.md) {
            ForEach(0..<5, id: \.self) { _ in
                ShimmerBox()
            }
        }
        .padding(Spacing.screenPadding)
    }

    // MARK: - Inline View

    private var inlineView: some View {
        HStack(spacing: Spacing.xs) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                .scaleEffect(0.8)

            if let message = message {
                Text(message)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
            }
        }
    }
}

// MARK: - Shimmer Box Component

struct ShimmerBox: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        RoundedRectangle(cornerRadius: Spacing.radiusMd)
            .fill(Color.neutralGray)
            .frame(height: 80)
            .overlay(
                GeometryReader { geometry in
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0),
                            Color.white.opacity(0.5),
                            Color.white.opacity(0)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geometry.size.width * 0.3)
                    .offset(x: phase * geometry.size.width)
                }
            )
            .clipped()
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false)
                ) {
                    phase = 1.0
                }
            }
    }
}

// MARK: - Preview

#Preview("Loading View Styles") {
    VStack(spacing: Spacing.xxl) {
        // Spinner
        LoadingView(
            message: "Loading services...",
            style: .spinner
        )
        .frame(height: 200)

        Divider()

        // Inline
        LoadingView(
            message: "Please wait",
            style: .inline
        )

        Divider()

        // Shimmer
        LoadingView(style: .shimmer)
            .frame(height: 400)
    }
}

#Preview("Loading View Dark Mode") {
    LoadingView(
        message: "Loading your bookings...",
        style: .spinner
    )
    .preferredColorScheme(.dark)
}
