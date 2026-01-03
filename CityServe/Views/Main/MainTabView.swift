//
//  MainTabView.swift
//  CityServe
//
//  Main Tab Bar Navigation
//

import SwiftUI

struct MainTabView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedTab: Tab = .home

    enum Tab: Int {
        case home = 0
        case explore = 1
        case orders = 2
        case profile = 3

        var title: String {
            switch self {
            case .home: return "Home"
            case .explore: return "Explore"
            case .orders: return "Orders"
            case .profile: return "Profile"
            }
        }

        var icon: String {
            switch self {
            case .home: return "house"
            case .explore: return "square.grid.2x2"
            case .orders: return "clock.arrow.circlepath"
            case .profile: return "person"
            }
        }

        var iconFilled: String {
            switch self {
            case .home: return "house.fill"
            case .explore: return "square.grid.2x2.fill"
            case .orders: return "clock.arrow.circlepath"
            case .profile: return "person.fill"
            }
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            HomeView()
                .environmentObject(authViewModel)
                .tabItem {
                    Label(Tab.home.title, systemImage: selectedTab == .home ? Tab.home.iconFilled : Tab.home.icon)
                }
                .tag(Tab.home)

            // Explore Tab
            ServiceCategoriesView()
                .environmentObject(authViewModel)
                .tabItem {
                    Label(Tab.explore.title, systemImage: selectedTab == .explore ? Tab.explore.iconFilled : Tab.explore.icon)
                }
                .tag(Tab.explore)

            // Orders Tab
            OrdersView()
                .environmentObject(authViewModel)
                .tabItem {
                    Label(Tab.orders.title, systemImage: selectedTab == .orders ? Tab.orders.iconFilled : Tab.orders.icon)
                }
                .tag(Tab.orders)

            // Profile Tab
            ProfileView()
                .environmentObject(authViewModel)
                .tabItem {
                    Label(Tab.profile.title, systemImage: selectedTab == .profile ? Tab.profile.iconFilled : Tab.profile.icon)
                }
                .tag(Tab.profile)
        }
        .tint(.primary)
        .onChange(of: selectedTab) { oldValue, newValue in
            Haptics.light()
        }
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
        addresses: [
            Address(
                id: "1",
                label: "Home",
                fullAddress: "123, MG Road, Connaught Place, New Delhi - 110001",
                city: "Delhi",
                isDefault: true
            )
        ],
        createdAt: Date(),
        updatedAt: Date()
    )
    authViewModel.isAuthenticated = true

    return MainTabView()
        .environmentObject(authViewModel)
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
        addresses: [
            Address(
                id: "1",
                label: "Home",
                fullAddress: "123, MG Road, Connaught Place, New Delhi - 110001",
                city: "Delhi",
                isDefault: true
            )
        ],
        createdAt: Date(),
        updatedAt: Date()
    )
    authViewModel.isAuthenticated = true

    return MainTabView()
        .environmentObject(authViewModel)
        .preferredColorScheme(.dark)
}
