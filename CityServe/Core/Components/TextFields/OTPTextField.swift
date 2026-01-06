//
//  OTPTextField.swift
//  CityServe
//
//  OTP (One-Time Password) Input Component
//  Design System Component
//

import SwiftUI

/// OTP input field with individual boxes for each digit
/// Usage: Phone verification, 2FA authentication
struct OTPTextField: View {

    // MARK: - Properties

    @Binding var otpCode: String

    var numberOfDigits: Int = 6
    var errorMessage: String? = nil
    var onComplete: ((String) -> Void)? = nil

    @FocusState private var isFocused: Bool
    @State private var otpDigits: [String] = []

    // MARK: - Initializer

    init(
        otpCode: Binding<String>,
        numberOfDigits: Int = 6,
        errorMessage: String? = nil,
        onComplete: ((String) -> Void)? = nil
    ) {
        self._otpCode = otpCode
        self.numberOfDigits = numberOfDigits
        self.errorMessage = errorMessage
        self.onComplete = onComplete

        // Initialize empty digits
        _otpDigits = State(initialValue: Array(repeating: "", count: numberOfDigits))
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: Spacing.md) {
            // OTP Boxes
            HStack(spacing: Spacing.sm) {
                ForEach(0..<numberOfDigits, id: \.self) { index in
                    OTPDigitBox(
                        digit: digitAt(index),
                        isActive: index == otpCode.count,
                        hasError: errorMessage != nil
                    )
                }
            }

            // Hidden TextField for input
            TextField("", text: $otpCode)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($isFocused)
                .opacity(0)
                .frame(width: 1, height: 1)
                .onChange(of: otpCode) { oldValue, newValue in
                    handleOTPChange(newValue)
                }

            // Error Message
            if let errorMessage = errorMessage, !errorMessage.isEmpty {
                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 12))
                    Text(errorMessage)
                        .font(.bodySmall)
                }
                .foregroundColor(.error)
            }
        }
        .onTapGesture {
            isFocused = true
        }
        .onAppear {
            // Auto-focus on appear
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isFocused = true
            }
        }
    }

    // MARK: - Helper Methods

    private func digitAt(_ index: Int) -> String {
        guard index < otpCode.count else { return "" }
        let stringIndex = otpCode.index(otpCode.startIndex, offsetBy: index)
        return String(otpCode[stringIndex])
    }

    private func handleOTPChange(_ newValue: String) {
        // Only allow digits
        let filtered = newValue.filter { $0.isNumber }

        // Limit to numberOfDigits
        otpCode = String(filtered.prefix(numberOfDigits))

        // Call completion handler when all digits are entered
        if otpCode.count == numberOfDigits {
            Haptics.success()
            onComplete?(otpCode)
        }
    }
}

// MARK: - OTP Digit Box

private struct OTPDigitBox: View {
    let digit: String
    let isActive: Bool
    let hasError: Bool

    var body: some View {
        ZStack {
            // Box background
            RoundedRectangle(cornerRadius: Spacing.radiusLg)
                .fill(Color.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.radiusLg)
                        .stroke(borderColor, lineWidth: borderWidth)
                )  // More rounded (12pt instead of 8pt)

            // Digit or cursor
            if !digit.isEmpty {
                Text(digit)
                    .font(.custom("Inter-SemiBold", size: 24))
                    .foregroundColor(.textPrimary)
            } else if isActive {
                // Blinking cursor
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: 24)
                    .opacity(cursorOpacity)
            }
        }
        .frame(width: 48, height: 56)
        .animation(Animations.easeInOut, value: isActive)
    }

    private var borderColor: Color {
        if hasError {
            return .error
        }
        if isActive {
            return .primary
        }
        if !digit.isEmpty {
            return .primary.opacity(0.5)
        }
        return .divider
    }

    private var borderWidth: CGFloat {
        (isActive || !digit.isEmpty) ? 2 : 1
    }

    @State private var cursorOpacity: Double = 1.0

    private var cursorAnimation: Animation {
        Animation.easeInOut(duration: 0.6)
            .repeatForever(autoreverses: true)
    }
}

// MARK: - Preview

#Preview("OTP Text Field States") {
    VStack(spacing: Spacing.xxl) {
        // Empty state
        VStack(spacing: Spacing.md) {
            Text("Enter Verification Code")
                .h3Style()

            Text("We've sent a 6-digit code to +91 98765 43210")
                .bodyStyle()
                .secondaryText()
                .multilineTextAlignment(.center)

            OTPTextField(
                otpCode: .constant(""),
                onComplete: { code in
                    print("OTP entered: \(code)")
                }
            )
        }

        Divider()

        // Partially filled
        VStack(spacing: Spacing.md) {
            Text("Partial Input")
                .h4Style()

            OTPTextField(
                otpCode: .constant("123")
            )
        }

        Divider()

        // Fully filled
        VStack(spacing: Spacing.md) {
            Text("Complete")
                .h4Style()

            OTPTextField(
                otpCode: .constant("123456")
            )
        }

        Divider()

        // Error state
        VStack(spacing: Spacing.md) {
            Text("Error State")
                .h4Style()

            OTPTextField(
                otpCode: .constant("123456"),
                errorMessage: "Invalid code. Please try again."
            )
        }

        Divider()

        // 4-digit OTP
        VStack(spacing: Spacing.md) {
            Text("4-Digit OTP")
                .h4Style()

            OTPTextField(
                otpCode: .constant("12"),
                numberOfDigits: 4
            )
        }
    }
    .padding(Spacing.screenPadding)
}

#Preview("OTP Text Field Dark Mode") {
    VStack(spacing: Spacing.xl) {
        Text("Enter Verification Code")
            .h3Style()

        Text("We've sent a 6-digit code to your phone")
            .bodyStyle()
            .secondaryText()
            .multilineTextAlignment(.center)

        OTPTextField(
            otpCode: .constant("123")
        )

        OTPTextField(
            otpCode: .constant("123456"),
            errorMessage: "Invalid code. Please try again."
        )
    }
    .padding(Spacing.screenPadding)
    .preferredColorScheme(.dark)
}
