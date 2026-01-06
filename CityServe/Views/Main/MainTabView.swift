//
//  MainTabView.swift
//  CityServe
//
//  Main Tab Bar Navigation - Urban Company Style
//

import SwiftUI

struct MainTabView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedTab: Tab = .home

    enum Tab: Int, CaseIterable {
        case home = 0
        case bookings = 1
        case plus = 2
        case rewards = 3
        case account = 4

        var title: String {
            switch self {
            case .home: return "UC"
            case .bookings: return "Bookings"
            case .plus: return "UC Plus"
            case .rewards: return "Rewards"
            case .account: return "Account"
            }
        }

        var icon: String {
            switch self {
            case .home: return "house"
            case .bookings: return "calendar"
            case .plus: return "star.circle"
            case .rewards: return "gift"
            case .account: return "person.crop.circle"
            }
        }

        var iconFilled: String {
            switch self {
            case .home: return "house.fill"
            case .bookings: return "calendar.fill"
            case .plus: return "star.circle.fill"
            case .rewards: return "gift.fill"
            case .account: return "person.crop.circle.fill"
            }
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Main content
            TabView(selection: $selectedTab) {
                // Home Tab
                HomeView()
                    .environmentObject(authViewModel)
                    .tag(Tab.home)

                // Bookings Tab
                OrdersView()
                    .environmentObject(authViewModel)
                    .tag(Tab.bookings)

                // Plus Tab
                PlusMembershipView()
                    .environmentObject(authViewModel)
                    .tag(Tab.plus)

                // Rewards Tab
                RewardsView()
                    .environmentObject(authViewModel)
                    .tag(Tab.rewards)

                // Account Tab
                ProfileView()
                    .environmentObject(authViewModel)
                    .tag(Tab.account)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Custom Tab Bar

struct CustomTabBar: View {
    @Binding var selectedTab: MainTabView.Tab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTabView.Tab.allCases, id: \.self) { tab in
                TabBarItem(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedTab = tab
                            Haptics.light()
                        }
                    }
                )
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(
            Color.surface
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: -2)
        )
        .overlay(
            Rectangle()
                .fill(Color.divider)
                .frame(height: 0.5),
            alignment: .top
        )
    }
}

// MARK: - Tab Bar Item

struct TabBarItem: View {
    let tab: MainTabView.Tab
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? tab.iconFilled : tab.icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .primary : .textTertiary)
                    .frame(height: 24)

                Text(tab.title)
                    .font(.system(size: 10, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .primary : .textTertiary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
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
