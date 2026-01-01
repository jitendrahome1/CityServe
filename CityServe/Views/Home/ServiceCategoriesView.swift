//
//  ServiceCategoriesView.swift
//  CityServe
//
//  All Service Categories Grid View
//

import SwiftUI

struct ServiceCategoriesView: View {

    @StateObject private var viewModel = HomeViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: Spacing.md),
                    GridItem(.flexible(), spacing: Spacing.md)
                ], spacing: Spacing.md) {
                    ForEach(viewModel.categories) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            CategoryCard(category: category)
                        }
                    }
                }
                .padding(Spacing.screenPadding)
            }
        }
        .navigationTitle("All Categories")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ServiceCategoriesView()
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        ServiceCategoriesView()
    }
    .preferredColorScheme(.dark)
}
