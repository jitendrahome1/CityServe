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
        case bookings = 1
        case plus = 2
        case rewards = 3
        case account = 4

        var title: String {
            switch self {
            case .home: return "Home"
            case .bookings: return "Bookings"
            case .plus: return "Plus"
            case .rewards: return "Rewards"
            case .account: return "Account"
            }
        }

        var icon: String {
            switch self {
            case .home: return "house"
            case .bookings: return "clock.arrow.circlepath"
            case .plus: return "star"
            case .rewards: return "gift"
            case .account: return "person"
            }
        }

        var iconFilled: String {
            switch self {
            case .home: return "house.fill"
            case .bookings: return "clock.arrow.circlepath"
            case .plus: return "star.fill"
            case .rewards: return "gift.fill"
            case .account: return "person.fill"
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

            // Bookings Tab
            OrdersView()
                .environmentObject(authViewModel)
                .tabItem {
                    Label(Tab.bookings.title, systemImage: selectedTab == .bookings ? Tab.bookings.iconFilled : Tab.bookings.icon)
                }
                .tag(Tab.bookings)

            // Plus Tab
            PlusMembershipView()
                .environmentObject(authViewModel)
                .tabItem {
                    Label(Tab.plus.title, systemImage: selectedTab == .plus ? Tab.plus.iconFilled : Tab.plus.icon)
                }
                .tag(Tab.plus)

            // Rewards Tab
            RewardsView()
                .environmentObject(authViewModel)
                .tabItem {
                    Label(Tab.rewards.title, systemImage: selectedTab == .rewards ? Tab.rewards.iconFilled : Tab.rewards.icon)
                }
                .tag(Tab.rewards)

            // Account Tab
            ProfileView()
                .environmentObject(authViewModel)
                .tabItem {
                    Label(Tab.account.title, systemImage: selectedTab == .account ? Tab.account.iconFilled : Tab.account.icon)
                }
                .tag(Tab.account)
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
