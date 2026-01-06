//
//  ContactSupportView.swift
//  CityServe
//
//  Contact Support Form - Submit Support Tickets
//

import SwiftUI

struct ContactSupportView: View {
    @StateObject private var viewModel = ContactSupportViewModel()
    @Environment(\.dismiss) private var dismiss

    // Form state
    @State private var selectedCategory: IssueCategory = .bookingIssue
    @State private var relatedToBooking = false
    @State private var selectedBooking: Booking?
    @State private var subject = ""
    @State private var description = ""
    @State private var attachments: [UIImage] = []
    @State private var contactByEmail = true
    @State private var contactByPhone = true
    @State private var contactByNotification = false
    @State private var priority: TicketPriority = .normal
    @State private var showImagePicker = false
    @State private var showCancelConfirmation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    // Header
                    headerSection

                    // Issue Type Section
                    issueCategorySection

                    // Order Details Section
                    orderDetailsSection

                    // Message Section
                    messageSection

                    // Attachments Section
                    attachmentsSection

                    // Contact Preference Section
                    contactPreferenceSection

                    // Priority Section
                    prioritySection

                    // Submit Button
                    submitButton

                    // Info Message
                    infoMessage
                }
                .padding(.vertical, Spacing.lg)
            }
            .navigationTitle("Contact Support")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        if isFormDirty {
                            showCancelConfirmation = true
                        } else {
                            dismiss()
                        }
                    }
                    .foregroundColor(.textPrimary)
                }
            }
        }
        .alert("Ticket Submitted", isPresented: $viewModel.showSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("Your ticket #\(viewModel.ticketId) has been created. We'll get back to you soon!")
        }
        .alert("Submission Failed", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "Unable to submit your ticket. Please try again.")
        }
        .alert("Discard Changes?", isPresented: $showCancelConfirmation) {
            Button("Discard", role: .destructive) {
                dismiss()
            }
            Button("Keep Editing", role: .cancel) {}
        } message: {
            Text("Are you sure you want to discard your changes?")
        }
    }

    // MARK: - Header Section

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("We're here to help!")
                .font(.h2)
                .foregroundColor(.textPrimary)

            Text("Tell us what's going on")
                .font(.body)
                .foregroundColor(.textSecondary)
        }
        .padding(.horizontal, Spacing.md)
    }

    // MARK: - Issue Category Section

    private var issueCategorySection: some View {
        FormSectionContainer(title: "Issue Type") {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Select Issue Category *")
                    .font(.label)
                    .foregroundColor(.textSecondary)

                Menu {
                    ForEach(IssueCategory.allCases, id: \.self) { category in
                        Button(category.displayName) {
                            selectedCategory = category
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedCategory.displayName)
                            .font(.body)
                            .foregroundColor(.textPrimary)

                        Spacer()

                        Image(systemName: "chevron.down")
                            .font(.body)
                            .foregroundColor(.textTertiary)
                    }
                    .padding(Spacing.md)
                    .background(Color.surface)
                    .cornerRadius(8)
                }

                // Common Issues
                if !selectedCategory.commonIssues.isEmpty {
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Common issues:")
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)

                        ForEach(selectedCategory.commonIssues, id: \.self) { issue in
                            Button(action: {
                                subject = issue
                            }) {
                                HStack(spacing: Spacing.xs) {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: Spacing.xxs))
                                        .foregroundColor(.textTertiary)

                                    Text(issue)
                                        .font(.body)
                                        .foregroundColor(.primary)

                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.top, Spacing.xxs)
                }
            }
        }
    }

    // MARK: - Order Details Section

    private var orderDetailsSection: some View {
        FormSectionContainer(title: "Order Details") {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Related to a Booking?")
                    .font(.label)
                    .foregroundColor(.textSecondary)

                HStack(spacing: Spacing.lg) {
                    RadioButtonView(
                        title: "Yes",
                        isSelected: relatedToBooking,
                        onTap: { relatedToBooking = true }
                    )

                    RadioButtonView(
                        title: "No",
                        isSelected: !relatedToBooking,
                        onTap: { relatedToBooking = false; selectedBooking = nil }
                    )
                }

                if relatedToBooking {
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Select Booking (Optional)")
                            .font(.label)
                            .foregroundColor(.textSecondary)
                            .padding(.top, Spacing.xs)

                        ForEach(viewModel.recentBookings.prefix(3)) { booking in
                            BookingSelectionCard(
                                booking: booking,
                                isSelected: selectedBooking?.id == booking.id,
                                onSelect: { selectedBooking = booking }
                            )
                        }
                    }
                }
            }
        }
    }

    // MARK: - Message Section

    private var messageSection: some View {
        FormSectionContainer(title: "Your Message") {
            VStack(alignment: .leading, spacing: Spacing.md) {
                // Subject
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Subject *")
                        .font(.label)
                        .foregroundColor(.textSecondary)

                    TextField("Enter subject", text: $subject)
                        .font(.body)
                        .padding(Spacing.md)
                        .background(Color.surface)
                        .cornerRadius(8)
                        .onChange(of: subject) { newValue in
                            if newValue.count > 100 {
                                subject = String(newValue.prefix(100))
                            }
                        }
                }

                // Description
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Description *")
                        .font(.label)
                        .foregroundColor(.textSecondary)

                    ZStack(alignment: .topLeading) {
                        if description.isEmpty {
                            Text("Describe your issue in detail")
                                .font(.body)
                                .foregroundColor(.textTertiary)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 18)
                        }

                        TextEditor(text: $description)
                            .font(.body)
                            .foregroundColor(.textPrimary)
                            .frame(height: 120)
                            .padding(Spacing.sm)
                            .background(Color.surface)
                            .cornerRadius(8)
                            .onChange(of: description) { newValue in
                                if newValue.count > 500 {
                                    description = String(newValue.prefix(500))
                                }
                            }
                    }

                    HStack {
                        if description.count < 20 && !description.isEmpty {
                            Text("Minimum 20 characters required")
                                .font(.caption)
                                .foregroundColor(.error)
                        }

                        Spacer()

                        Text("\(description.count)/500")
                            .font(.caption)
                            .foregroundColor(.textTertiary)
                    }
                }
            }
        }
    }

    // MARK: - Attachments Section

    private var attachmentsSection: some View {
        FormSectionContainer(title: "Attachments") {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Add Photos/Screenshots (Optional)")
                    .font(.label)
                    .foregroundColor(.textSecondary)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Spacing.sm) {
                        // Existing attachments
                        ForEach(Array(attachments.enumerated()), id: \.offset) { index, image in
                            AttachmentThumbnail(
                                image: image,
                                onRemove: {
                                    attachments.remove(at: index)
                                }
                            )
                        }

                        // Add button
                        if attachments.count < 5 {
                            Button(action: { showImagePicker = true }) {
                                VStack(spacing: Spacing.xs) {
                                    Image(systemName: "plus")
                                        .font(.h3)
                                        .foregroundColor(.primary)

                                    Text("Add")
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                                .frame(width: 80, height: 80)
                                .background(Color.primary.opacity(0.1))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .foregroundColor(.primary)
                                )
                            }
                        }
                    }
                }

                Text("Max 5 files, 10MB each")
                    .font(.caption)
                    .foregroundColor(.textTertiary)
            }
        }
    }

    // MARK: - Contact Preference Section

    private var contactPreferenceSection: some View {
        FormSectionContainer(title: "Contact Preference") {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("How should we reach you?")
                    .font(.label)
                    .foregroundColor(.textSecondary)

                Toggle(isOn: $contactByEmail) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.primary)
                        Text("Email (\(viewModel.userEmail))")
                            .font(.body)
                    }
                }
                .tint(.primary)

                Toggle(isOn: $contactByPhone) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.primary)
                        Text("Phone (\(viewModel.userPhone))")
                            .font(.body)
                    }
                }
                .tint(.primary)

                Toggle(isOn: $contactByNotification) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.primary)
                        Text("In-App Notification")
                            .font(.body)
                    }
                }
                .tint(.primary)

                if !contactByEmail && !contactByPhone && !contactByNotification {
                    Text("Please select at least one contact method")
                        .font(.caption)
                        .foregroundColor(.error)
                }
            }
        }
    }

    // MARK: - Priority Section

    private var prioritySection: some View {
        FormSectionContainer(title: "Priority") {
            HStack(spacing: Spacing.md) {
                ForEach(TicketPriority.allCases, id: \.self) { priorityOption in
                    RadioButtonView(
                        title: priorityOption.displayName,
                        isSelected: priority == priorityOption,
                        onTap: { priority = priorityOption }
                    )
                }
            }
        }
    }

    // MARK: - Submit Button

    private var submitButton: some View {
        Button(action: submitTicket) {
            if viewModel.isSubmitting {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
            } else {
                Text("Submit Ticket")
                    .font(.button)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
            }
        }
        .background(isFormValid ? Color.primary : Color.textTertiary)
        .cornerRadius(Spacing.radiusLg)
        .disabled(!isFormValid || viewModel.isSubmitting)
        .padding(.horizontal, Spacing.md)
    }

    // MARK: - Info Message

    private var infoMessage: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: Spacing.iconSM))
                .foregroundColor(.secondary)

            Text("Expected response time: 2-4 hours")
                .font(.bodySmall)
                .foregroundColor(.textSecondary)
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal, Spacing.md)
    }

    // MARK: - Computed Properties

    private var isFormValid: Bool {
        !subject.isEmpty &&
        !description.isEmpty &&
        description.count >= 20 &&
        (contactByEmail || contactByPhone || contactByNotification)
    }

    private var isFormDirty: Bool {
        !subject.isEmpty || !description.isEmpty || !attachments.isEmpty
    }

    // MARK: - Actions

    private func submitTicket() {
        viewModel.submitSupportTicket(
            category: selectedCategory,
            booking: selectedBooking,
            subject: subject,
            description: description,
            attachments: attachments,
            contactEmail: contactByEmail,
            contactPhone: contactByPhone,
            contactNotification: contactByNotification,
            priority: priority
        )
    }
}

// MARK: - Form Section Container

struct FormSectionContainer<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(title)
                .font(.h5)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.md)

            content
                .padding(.horizontal, Spacing.md)

            Divider()
                .padding(.horizontal, Spacing.md)
        }
    }
}

// MARK: - Radio Button View

struct RadioButtonView: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: isSelected ? "circle.inset.filled" : "circle")
                    .font(.h4)
                    .foregroundColor(isSelected ? .primary : .textTertiary)

                Text(title)
                    .font(.body)
                    .foregroundColor(.textPrimary)
            }
        }
        .accessibilityLabel(title)
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }
}

// MARK: - Booking Selection Card

struct BookingSelectionCard: View {
    let booking: Booking
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: Spacing.sm) {
                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("#\(booking.id) - \(booking.serviceName)")
                        .font(.h5)
                        .foregroundColor(.textPrimary)

                    if let providerName = booking.providerName {
                        Text("Provider: \(providerName)")
                            .font(.bodySmall)
                            .foregroundColor(.textSecondary)
                    }

                    Text(booking.scheduledDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .foregroundColor(.textTertiary)
                }

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.h3)
                    .foregroundColor(isSelected ? .primary : .textTertiary)
            }
            .padding(Spacing.sm)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.primary : Color.divider, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Attachment Thumbnail

struct AttachmentThumbnail: View {
    let image: UIImage
    let onRemove: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .font(.h4)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .offset(x: 6, y: -6)
        }
    }
}

// MARK: - Preview

#Preview {
    ContactSupportView()
}

#Preview("Dark Mode") {
    ContactSupportView()
        .preferredColorScheme(.dark)
}
