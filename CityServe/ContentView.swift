//
//  ContentView.swift
//  CityServe
//
//  Main Content View - Entry Point
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                // Main Tab Navigation
                MainTabView()
                    .environmentObject(authViewModel)
            } else {
                // Authentication Flow - CRITICAL: Pass authViewModel to avoid multiple instances
                SplashView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}

#Preview("Authenticated") {
    let viewModel = AuthViewModel()
    viewModel.currentUser = User(
        id: "123",
        fullName: "John Doe",
        email: "john@example.com",
        phoneNumber: "9876543210",
        photoURL: nil,
        userType: .customer,
        city: "Delhi",
        addresses: [],
        createdAt: Date(),
        updatedAt: Date()
    )
    viewModel.isAuthenticated = true

    return ContentView()
        .environmentObject(viewModel)
}

#Preview("Dark Mode") {
    ContentView()
        .preferredColorScheme(.dark)
}
