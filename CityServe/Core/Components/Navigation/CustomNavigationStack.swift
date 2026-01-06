//
//  CustomNavigationStack.swift
//  CityServe
//
//  Custom Navigation Stack with Animated Transitions
//

import SwiftUI
import Combine

/// Custom navigation stack with animated transitions and gesture support
struct CustomNavigationStack<Content: View>: View {
    @StateObject private var navigator = NavigationStackCoordinator()
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            content
                .environmentObject(navigator)

            // Overlay stack of views
            ForEach(navigator.viewStack.indices, id: \.self) { index in
                navigator.viewStack[index].view
                    .navigationTransition(
                        navigator.viewStack[index].transition,
                        isPresented: true,
                        isForward: true
                    )
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
                    .zIndex(Double(index + 1))
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                handleSwipeGesture(gesture, at: index)
                            }
                    )
            }
        }
    }

    private func handleSwipeGesture(_ gesture: DragGesture.Value, at index: Int) {
        // Swipe right to go back
        if gesture.translation.width > 100 && gesture.translation.height < 50 {
            Haptics.light()
            navigator.pop()
        }
    }
}

// MARK: - Navigation Stack Coordinator

class NavigationStackCoordinator: ObservableObject {
    @Published var viewStack: [NavigationItem] = []

    /// Push a new view onto the stack
    func push<V: View>(
        _ view: V,
        transition: NavigationTransition = .slide
    ) {
        withAnimation(transition.pushAnimation) {
            viewStack.append(NavigationItem(
                view: AnyView(view),
                transition: transition
            ))
        }
        Haptics.light()
    }

    /// Pop the top view from the stack
    func pop() {
        guard !viewStack.isEmpty else { return }
        let transition = viewStack.last?.transition ?? .slide

        withAnimation(transition.popAnimation) {
            _ = viewStack.popLast()
        }
        Haptics.light()
    }

    /// Pop to a specific index in the stack
    func popTo(index: Int) {
        guard index < viewStack.count else { return }
        let transition = viewStack.last?.transition ?? .slide

        withAnimation(transition.popAnimation) {
            viewStack.removeSubrange(index..<viewStack.count)
        }
        Haptics.medium()
    }

    /// Pop to root (remove all views)
    func popToRoot() {
        guard !viewStack.isEmpty else { return }
        let transition = viewStack.last?.transition ?? .slide

        withAnimation(transition.popAnimation) {
            viewStack.removeAll()
        }
        Haptics.medium()
    }

    /// Check if can go back
    var canGoBack: Bool {
        !viewStack.isEmpty
    }
}

// MARK: - Navigation Item

struct NavigationItem: Identifiable {
    let id = UUID()
    let view: AnyView
    let transition: NavigationTransition
}

// MARK: - View Extension for Easy Navigation

extension View {
    /// Push a new view with custom navigation
    func customNavigationPush<Destination: View>(
        isActive: Binding<Bool>,
        transition: NavigationTransition = .slide,
        @ViewBuilder destination: @escaping () -> Destination
    ) -> some View {
        self.background(
            CustomNavigationHelper(
                isActive: isActive,
                transition: transition,
                destination: destination
            )
        )
    }
}

// MARK: - Navigation Helper

private struct CustomNavigationHelper<Destination: View>: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    @Binding var isActive: Bool
    let transition: NavigationTransition
    let destination: () -> Destination

    var body: some View {
        Color.clear
            .onChange(of: isActive) { oldValue, newValue in
                if newValue {
                    navigator.push(destination(), transition: transition)
                    // Reset binding after push
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isActive = false
                    }
                }
            }
    }
}

// MARK: - Custom Navigation Container with Bar

/// Container that combines CustomNavigationBar with content
struct CustomNavigationContainer<Content: View>: View {
    let title: String
    let showBackButton: Bool
    let backAction: (() -> Void)?
    let trailingActions: [NavigationAction]
    let barStyle: NavigationBarStyle
    let content: Content

    @Environment(\.dismiss) private var dismiss

    init(
        title: String,
        showBackButton: Bool = true,
        backAction: (() -> Void)? = nil,
        trailingActions: [NavigationAction] = [],
        barStyle: NavigationBarStyle = .gradient,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.showBackButton = showBackButton
        self.backAction = backAction
        self.trailingActions = trailingActions
        self.barStyle = barStyle
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                title: title,
                showBackButton: showBackButton,
                backAction: backAction ?? { dismiss() },
                trailingActions: trailingActions,
                style: barStyle
            )

            content
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Preview

#Preview {
    CustomNavigationStack {
        ExampleRootView()
    }
}

// Example Views for Preview
private struct ExampleRootView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator

    var body: some View {
        VStack(spacing: Spacing.lg) {
            Text("Root View")
                .font(.h2)
                .foregroundColor(.textPrimary)

            Button("Push Slide Transition") {
                navigator.push(ExampleDetailView(title: "Slide", color: .blue), transition: .slide)
            }

            Button("Push Fade Transition") {
                navigator.push(ExampleDetailView(title: "Fade", color: .purple), transition: .fade)
            }

            Button("Push Scale Transition") {
                navigator.push(ExampleDetailView(title: "Scale", color: .green), transition: .scale)
            }

            Button("Push Slide Up") {
                navigator.push(ExampleDetailView(title: "Slide Up", color: .orange), transition: .slideUp)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

private struct ExampleDetailView: View {
    @EnvironmentObject var navigator: NavigationStackCoordinator
    let title: String
    let color: Color

    var body: some View {
        CustomNavigationContainer(
            title: title,
            showBackButton: true,
            backAction: { navigator.pop() },
            trailingActions: [
                NavigationAction(icon: "heart", action: {}),
                NavigationAction(icon: "square.and.arrow.up", action: {})
            ],
            barStyle: .gradient
        ) {
            VStack(spacing: Spacing.lg) {
                Circle()
                    .fill(color)
                    .frame(width: 100, height: 100)

                Text("Detail View - \(title)")
                    .font(.h3)
                    .foregroundColor(.textPrimary)

                Button("Push Another") {
                    navigator.push(ExampleDetailView(title: "Nested", color: .red), transition: .slide)
                }

                Button("Pop") {
                    navigator.pop()
                }

                Button("Pop to Root") {
                    navigator.popToRoot()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}
