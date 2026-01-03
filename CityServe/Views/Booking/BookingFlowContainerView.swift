//
//  BookingFlowContainerView.swift
//  CityServe
//
//  Main Booking Flow Container
//

import SwiftUI

struct BookingFlowContainerView: View {

    let service: Service
    @StateObject private var viewModel: BookingViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var showConfirmation = false

    init(service: Service) {
        self.service = service
        _viewModel = StateObject(wrappedValue: BookingViewModel(service: service))
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Progress Bar
                progressBar

                // Step Content
                stepContent
                    .frame(maxHeight: .infinity)

                // Bottom Action Bar
                bottomActionBar
            }
        }
        .navigationTitle(viewModel.currentStep.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    if viewModel.currentStep == .address {
                        dismiss()
                    } else {
                        viewModel.goToPreviousStep()
                    }
                }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "chevron.left")
                            .font(.buttonSmall)

                        Text(viewModel.currentStep == .address ? "Cancel" : "Back")
                            .font(.body)
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .navigationDestination(isPresented: $showConfirmation) {
            if let booking = viewModel.createdBooking {
                BookingConfirmationView(booking: booking)
            }
        }
        .onAppear {
            viewModel.currentUser = authViewModel.currentUser
            viewModel.loadInitialData()
        }
    }

    // MARK: - Subviews

    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.divider)
                    .frame(height: 4)

                Rectangle()
                    .fill(Color.primary)
                    .frame(width: geometry.size.width * viewModel.progressPercentage, height: 4)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.progressPercentage)
            }
        }
        .frame(height: 4)
    }

    @ViewBuilder
    private var stepContent: some View {
        switch viewModel.currentStep {
        case .address:
            AddressSelectionView(viewModel: viewModel)
        case .dateTime:
            DateTimeSelectionView(viewModel: viewModel)
        case .summary:
            BookingSummaryView(viewModel: viewModel)
        case .payment:
            PaymentMethodView(viewModel: viewModel)
        }
    }

    private var bottomActionBar: some View {
        VStack(spacing: Spacing.sm) {
            // Error message
            if let error = viewModel.errorMessage {
                ErrorBanner(message: error)
                    .padding(.horizontal, Spacing.screenPadding)
            }

            // Action buttons
            HStack(spacing: Spacing.md) {
                // Back button (except on first step)
                if viewModel.currentStep != .address {
                    SecondaryButton(
                        "Back",
                        icon: "chevron.left",
                        size: .large,
                        action: {
                            viewModel.goToPreviousStep()
                        }
                    )
                    .frame(maxWidth: .infinity)
                }

                // Next/Confirm button
                PrimaryButton(
                    viewModel.currentStep == .payment ? "Pay ₹\(Int(viewModel.totalAmount))" : "Continue",
                    icon: viewModel.currentStep == .payment ? "lock.fill" : "arrow.right",
                    isDisabled: !viewModel.canProceedToNextStep,
                    isLoading: viewModel.isLoading,
                    size: .large,
                    action: {
                        handleContinue()
                    }
                )
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, Spacing.screenPadding)
            .padding(.vertical, Spacing.md)
            .background(Color.surface)
        }
    }

    // MARK: - Actions

    private func handleContinue() {
        if viewModel.currentStep == .payment {
            // Process payment and create booking
            Task {
                let success = await viewModel.createBooking()
                if success {
                    showConfirmation = true
                }
            }
        } else {
            // Move to next step
            viewModel.goToNextStep()
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

    return BookingFlowContainerView(service: Service.mockServices[0])
        .environmentObject(authViewModel)
}
