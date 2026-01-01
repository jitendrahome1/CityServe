//
//  Haptics.swift
//  CityServe
//
//  Design System - Haptic Feedback Utilities
//

import UIKit

/// Centralized haptic feedback manager
enum Haptics {

    /// Light haptic feedback (selection, toggle)
    static func light() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    /// Medium haptic feedback (button tap, action confirmation)
    static func medium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    /// Heavy haptic feedback (important actions, alerts)
    static func heavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    /// Success haptic feedback (completed action)
    static func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    /// Warning haptic feedback (caution needed)
    static func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }

    /// Error haptic feedback (action failed)
    static func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    /// Selection changed haptic feedback (picker/segmented control)
    static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

// MARK: - Usage Documentation

/*
 Haptic Feedback Guidelines
 ===========================

 Use haptic feedback to enhance user interactions and provide tactile confirmation.

 ### Light Haptics
 - Toggle switches
 - Radio button selection
 - Checkbox toggle
 - Picker selection
 ```swift
 Haptics.light()
 ```

 ### Medium Haptics
 - Button taps
 - Primary actions
 - Navigation
 - Form submission
 ```swift
 Haptics.medium()
 ```

 ### Heavy Haptics
 - Critical actions
 - Delete/destructive actions
 - Important confirmations
 ```swift
 Haptics.heavy()
 ```

 ### Notification Haptics
 - Success: Action completed successfully
 - Warning: Caution or validation warning
 - Error: Action failed or error occurred
 ```swift
 Haptics.success()
 Haptics.warning()
 Haptics.error()
 ```

 ### Selection Haptics
 - Scrolling pickers
 - Segmented controls
 - Value changes
 ```swift
 Haptics.selection()
 ```

 ### Best Practices
 1. Don't overuse haptics - use them purposefully
 2. Match haptic intensity to action importance
 3. Always provide visual feedback alongside haptics
 4. Consider accessibility - some users may disable haptics
 5. Test on actual devices (haptics don't work in Simulator)

 ### Example Usage in Views
 ```swift
 Button("Submit") {
     Haptics.medium()
     submitForm()
 }

 Toggle("Enable Notifications", isOn: $enabled)
     .onChange(of: enabled) { _, _ in
         Haptics.light()
     }

 Button("Delete Account") {
     Haptics.heavy()
     showDeleteConfirmation()
 }
 .buttonStyle(.destructive)
 ```
 */
