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
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTabView.Tab.allCases, id: \.self) { tab in
                TabBarItem(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    action: {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            selectedTab = tab
                            Haptics.light()
                        }
                    }
                )
            }
        }
        .frame(height: 49)
        .background(
            ZStack {
                // Background blur effect
                (colorScheme == .dark ? Color.black : Color.white)
                    .opacity(colorScheme == .dark ? 0.9 : 0.95)

                // Subtle top border
                VStack {
                    Divider()
                    Spacer()
                }
            }
            .ignoresSafeArea(edges: .bottom)
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
            VStack(spacing: 2) {
                Image(systemName: isSelected ? tab.iconFilled : tab.icon)
                    .font(.system(size: 24, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? Color(hex: "#5F4FE0") : Color.gray.opacity(0.55))
                    .frame(height: 26)

                Text(tab.title)
                    .font(.system(size: 10, weight: isSelected ? .medium : .regular))
                    .foregroundColor(isSelected ? Color(hex: "#5F4FE0") : Color.gray.opacity(0.65))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
