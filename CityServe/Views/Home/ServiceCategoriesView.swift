//
//  ServiceCategoriesView.swift
//  CityServe
//
//  All Service Categories Grid View
//

import SwiftUI

struct ServiceCategoriesView: View {

    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
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
                        NavigationLink(destination: CategoryDetailView(category: category)
                            .environmentObject(authViewModel)) {
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
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(
        id: "123",
        fullName: "Rahul Sharma",
        email: "rahul@example.com",
        phoneNumber: "9876543210",
        photoURL: nil,
        userType: .customer,
        city: "Delhi",
        addresses: [],
        createdAt: Date(),
        updatedAt: Date()
    )
    authViewModel.isAuthenticated = true

    return NavigationStack {
        ServiceCategoriesView()
            .environmentObject(authViewModel)
    }
}

#Preview("Dark Mode") {
    let authViewModel = AuthViewModel()
    authViewModel.currentUser = User(
        id: "123",
        fullName: "Rahul Sharma",
        email: "rahul@example.com",
        phoneNumber: "9876543210",
        photoURL: nil,
        userType: .customer,
        city: "Delhi",
        addresses: [],
        createdAt: Date(),
        updatedAt: Date()
    )
    authViewModel.isAuthenticated = true

    return NavigationStack {
        ServiceCategoriesView()
            .environmentObject(authViewModel)
    }
    .preferredColorScheme(.dark)
}
