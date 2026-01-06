//
//  NavigationTransition.swift
//  CityServe
//
//  Custom Navigation Transition Styles
//

import SwiftUI

/// Defines the type of transition animation for custom navigation
enum NavigationTransition {
    case slide       // Standard slide from right (iOS default)
    case fade        // Fade in/out
    case scale       // Scale up from center
    case slideUp     // Slide up from bottom (modal style)
    case hero        // Hero animation with shared element
    case none        // No animation

    /// Animation configuration for push transition
    var pushAnimation: Animation {
        switch self {
        case .slide:
            return .spring(response: 0.35, dampingFraction: 0.85)
        case .fade:
            return .easeInOut(duration: 0.25)
        case .scale:
            return .spring(response: 0.4, dampingFraction: 0.8)
        case .slideUp:
            return .spring(response: 0.4, dampingFraction: 0.85)
        case .hero:
            return .spring(response: 0.5, dampingFraction: 0.8)
        case .none:
            return .linear(duration: 0)
        }
    }

    /// Animation configuration for pop transition
    var popAnimation: Animation {
        switch self {
        case .slide:
            return .spring(response: 0.3, dampingFraction: 0.85)
        case .fade:
            return .easeInOut(duration: 0.2)
        case .scale:
            return .spring(response: 0.35, dampingFraction: 0.8)
        case .slideUp:
            return .spring(response: 0.35, dampingFraction: 0.85)
        case .hero:
            return .spring(response: 0.45, dampingFraction: 0.8)
        case .none:
            return .linear(duration: 0)
        }
    }
}

/// Transition effect for presenting/dismissing views
struct NavigationTransitionModifier: ViewModifier {
    let isPresented: Bool
    let transition: NavigationTransition
    let isForward: Bool // true for push, false for pop

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(x: offsetX, y: offsetY)
            .scaleEffect(scale)
    }

    private var opacity: Double {
        switch transition {
        case .fade:
            return isPresented ? 1 : 0
        case .hero, .slide, .slideUp, .scale:
            return isPresented ? 1 : (isForward ? 1 : 0.95)
        case .none:
            return 1
        }
    }

    private var offsetX: CGFloat {
        switch transition {
        case .slide:
            if isPresented {
                return 0
            } else {
                return isForward ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width * 0.3
            }
        default:
            return 0
        }
    }

    private var offsetY: CGFloat {
        switch transition {
        case .slideUp:
            return isPresented ? 0 : UIScreen.main.bounds.height
        default:
            return 0
        }
    }

    private var scale: CGFloat {
        switch transition {
        case .scale:
            return isPresented ? 1 : 0.85
        case .hero:
            return isPresented ? 1 : 0.95
        default:
            return 1
        }
    }
}

extension View {
    /// Apply custom navigation transition
    func navigationTransition(
        _ transition: NavigationTransition,
        isPresented: Bool,
        isForward: Bool = true
    ) -> some View {
        self.modifier(NavigationTransitionModifier(
            isPresented: isPresented,
            transition: transition,
            isForward: isForward
        ))
    }
}
