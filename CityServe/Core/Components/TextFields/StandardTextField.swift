//
//  StandardTextField.swift
//  CityServe
//
//  Standard Text Input Component
//  Design System Component
//

import SwiftUI

/// Standard text field with label, placeholder, error state, and icons
/// Usage: Email, name, address, general text input
struct StandardTextField: View {

    // MARK: - Properties

    let label: String
    let placeholder: String
    @Binding var text: String

    var leadingIcon: String? = nil
    var trailingIcon: String? = nil
    var trailingAction: (() -> Void)? = nil
    var errorMessage: String? = nil
    var helpText: String? = nil
    var isSecure: Bool = false
    var isDisabled: Bool = false
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var autocapitalization: TextInputAutocapitalization = .sentences
    var maxLength: Int? = nil

    @FocusState private var isFocused: Bool
    @State private var isSecureVisible: Bool = false

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.labelInputGap) {
            // Label
            if !label.isEmpty {
                Text(label)
                    .font(.label)
                    .foregroundColor(.textSecondary)
            }

            // Input Field
            HStack(spacing: Spacing.xs) {
                // Leading Icon
                if let leadingIcon = leadingIcon {
                    Image(systemName: leadingIcon)
                        .font(.system(size: Spacing.iconMD))
                        .foregroundColor(iconColor)
                }

                // Text Input
                Group {
                    if isSecure && !isSecureVisible {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .font(.input)
                .foregroundColor(.textPrimary)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .textInputAutocapitalization(autocapitalization)
                .disabled(isDisabled)
                .focused($isFocused)
                .onChange(of: text) { oldValue, newValue in
                    if let maxLength = maxLength, newValue.count > maxLength {
                        text = String(newValue.prefix(maxLength))
                    }
                }

                // Trailing Action Button or Icon
                if isSecure {
                    Button(action: {
                        isSecureVisible.toggle()
                    }) {
                        Image(systemName: isSecureVisible ? "eye.slash.fill" : "eye.fill")
                            .font(.system(size: Spacing.iconMD))
                            .foregroundColor(.textSecondary)
                    }
                } else if let trailingIcon = trailingIcon {
                    if let trailingAction = trailingAction {
                        Button(action: trailingAction) {
                            Image(systemName: trailingIcon)
                                .font(.system(size: Spacing.iconMD))
                                .foregroundColor(.textSecondary)
                        }
                    } else {
                        Image(systemName: trailingIcon)
                            .font(.system(size: Spacing.iconMD))
                            .foregroundColor(iconColor)
                    }
                }

                // Clear button when text is present
                if !text.isEmpty && !isDisabled && isFocused {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: Spacing.iconMD))
                            .foregroundColor(.textTertiary)
                    }
                }
            }
            .padding(Spacing.md)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .cornerRadius(Spacing.radiusMd)

            // Help Text or Error Message
            if let errorMessage = errorMessage, !errorMessage.isEmpty {
                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 12))
                    Text(errorMessage)
                        .font(.bodySmall)
                }
                .foregroundColor(.error)
            } else if let helpText = helpText, !helpText.isEmpty {
                Text(helpText)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
            }

            // Character count (if maxLength is set)
            if let maxLength = maxLength {
                HStack {
                    Spacer()
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }
            }
        }
    }

    // MARK: - Computed Properties

    private var borderColor: Color {
        if let errorMessage = errorMessage, !errorMessage.isEmpty {
            return .error
        }
        if isFocused {
            return .primary
        }
        return .divider
    }

    private var borderWidth: CGFloat {
        isFocused ? 2 : 1
    }

    private var backgroundColor: Color {
        isDisabled ? Color.neutralGray.opacity(0.5) : Color.surface
    }

    private var iconColor: Color {
        if let errorMessage = errorMessage, !errorMessage.isEmpty {
            return .error
        }
        if isFocused {
            return .primary
        }
        return .textSecondary
    }
}

// MARK: - Preview

#Preview("Standard Text Field States") {
    ScrollView {
        VStack(spacing: Spacing.xl) {
            // Normal
            StandardTextField(
                label: "Email Address",
                placeholder: "Enter your email",
                text: .constant("")
            )

            // With value
            StandardTextField(
                label: "Full Name",
                placeholder: "Enter your name",
                text: .constant("John Doe")
            )

            // With leading icon
            StandardTextField(
                label: "Email",
                placeholder: "you@example.com",
                text: .constant(""),
                leadingIcon: "envelope"
            )

            // With trailing icon
            StandardTextField(
                label: "Search",
                placeholder: "Search services...",
                text: .constant(""),
                trailingIcon: "magnifyingglass"
            )

            // Secure field
            StandardTextField(
                label: "Password",
                placeholder: "Enter password",
                text: .constant(""),
                isSecure: true
            )

            // With error
            StandardTextField(
                label: "Email",
                placeholder: "you@example.com",
                text: .constant("invalid"),
                leadingIcon: "envelope",
                errorMessage: "Please enter a valid email address"
            )

            // With help text
            StandardTextField(
                label: "Username",
                placeholder: "Choose a username",
                text: .constant(""),
                helpText: "Must be 3-20 characters"
            )

            // Disabled
            StandardTextField(
                label: "Account ID",
                placeholder: "Auto-generated",
                text: .constant("USR_123456"),
                isDisabled: true
            )

            // With max length
            StandardTextField(
                label: "Bio",
                placeholder: "Tell us about yourself",
                text: .constant("Hello, I'm using UrbanNest!"),
                maxLength: 150
            )

            // Phone number
            StandardTextField(
                label: "Phone Number",
                placeholder: "+91 98765 43210",
                text: .constant(""),
                leadingIcon: "phone",
                keyboardType: .phonePad
            )
        }
        .padding(Spacing.screenPadding)
    }
}

#Preview("Standard Text Field Dark Mode") {
    VStack(spacing: Spacing.lg) {
        StandardTextField(
            label: "Email Address",
            placeholder: "Enter your email",
            text: .constant(""),
            leadingIcon: "envelope"
        )

        StandardTextField(
            label: "Password",
            placeholder: "Enter password",
            text: .constant(""),
            isSecure: true
        )

        StandardTextField(
            label: "Email",
            placeholder: "you@example.com",
            text: .constant("invalid"),
            errorMessage: "Invalid email address"
        )
    }
    .padding(Spacing.screenPadding)
    .preferredColorScheme(.dark)
}
