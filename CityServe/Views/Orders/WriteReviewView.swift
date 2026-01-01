//
//  WriteReviewView.swift
//  CityServe
//
//  Rate and review completed service bookings
//  Design Spec: 40_WRITE_REVIEW.md
//

import SwiftUI
import PhotosUI
import Combine

struct WriteReviewView: View {

    let booking: Booking
    @StateObject private var viewModel: WriteReviewViewModel
    @Environment(\.dismiss) var dismiss

    init(booking: Booking) {
        self.booking = booking
        self._viewModel = StateObject(wrappedValue: WriteReviewViewModel(booking: booking))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: Spacing.lg) {
                        // Provider Info Card
                        providerInfoCard

                        // Title
                        Text("How was your experience?")
                            .font(.h4)
                            .fontWeight(.semibold)
                            .foregroundColor(.textPrimary)

                        // Overall Rating (Required)
                        StarRatingSelector(
                            title: "Overall Rating",
                            rating: $viewModel.overallRating,
                            isRequired: true,
                            size: 44
                        )

                        Divider()
                            .padding(.vertical, Spacing.xs)

                        // Category Ratings
                        VStack(alignment: .leading, spacing: Spacing.md) {
                            Text("Rate Specific Aspects")
                                .font(.h5)
                                .fontWeight(.semibold)
                                .foregroundColor(.textPrimary)

                            StarRatingSelector(
                                title: "Quality of Work",
                                rating: $viewModel.qualityRating,
                                size: 28
                            )

                            StarRatingSelector(
                                title: "Punctuality",
                                rating: $viewModel.punctualityRating,
                                size: 28
                            )

                            StarRatingSelector(
                                title: "Professionalism",
                                rating: $viewModel.professionalismRating,
                                size: 28
                            )

                            StarRatingSelector(
                                title: "Communication",
                                rating: $viewModel.communicationRating,
                                size: 28
                            )

                            StarRatingSelector(
                                title: "Value for Money",
                                rating: $viewModel.valueRating,
                                size: 28
                            )
                        }

                        Divider()
                            .padding(.vertical, Spacing.xs)

                        // Written Review
                        reviewTextSection

                        // Quick Tags
                        QuickTagsSelector(selectedTags: $viewModel.selectedTags)

                        // Photo Upload
                        ReviewPhotoUpload(selectedImages: $viewModel.selectedPhotos)

                        // Anonymous Option
                        Toggle(isOn: $viewModel.isAnonymous) {
                            Text("Post review anonymously")
                                .font(.body)
                                .foregroundColor(.textPrimary)
                        }
                        .tint(Color.primary)

                        // Submit Button
                        PrimaryButton(
                            viewModel.isSubmitting ? "Submitting..." : "Submit Review",
                            isDisabled: !viewModel.isValid || viewModel.isSubmitting,
                            isLoading: viewModel.isSubmitting,
                            size: .large
                        ) {
                            submitReview()
                        }

                        // Skip Button
                        Button(action: {
                            skipReview()
                        }) {
                            Text("Skip for Now")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.textSecondary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                        }
                    }
                    .padding(Spacing.screenPadding)
                }
            }
            .navigationTitle("Rate Your Experience")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: Spacing.iconMD))
                            .foregroundColor(.textPrimary)
                    }
                }
            }
            .onChange(of: viewModel.overallRating) { oldValue, newValue in
                // Auto-populate category ratings if not set
                if oldValue == 0 && newValue > 0 {
                    if viewModel.qualityRating == 0 { viewModel.qualityRating = newValue }
                    if viewModel.punctualityRating == 0 { viewModel.punctualityRating = newValue }
                    if viewModel.professionalismRating == 0 { viewModel.professionalismRating = newValue }
                    if viewModel.communicationRating == 0 { viewModel.communicationRating = newValue }
                    if viewModel.valueRating == 0 { viewModel.valueRating = newValue }
                }
            }
            .alert("Review Submitted", isPresented: $viewModel.showSuccessAlert) {
                Button("OK") {
                    dismiss()
                }
            } message: {
                Text("Thank you for your review! Your feedback helps improve our service quality.")
            }
            .alert("Error", isPresented: $viewModel.showErrorAlert) {
                Button("OK") {}
            } message: {
                Text(viewModel.errorMessage ?? "Failed to submit review. Please try again.")
            }
        }
    }

    // MARK: - Subviews

    private var providerInfoCard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.md) {
                // Provider Photo
                ZStack {
                    Circle()
                        .fill(Color.surface)
                        .frame(width: 48, height: 48)

                    Image(systemName: "person.fill")
                        .font(.system(size: Spacing.iconMD))
                        .foregroundColor(.textTertiary)
                }

                VStack(alignment: .leading, spacing: Spacing.xxs) {
                    Text("Service Provider")
                        .font(.h5)
                        .fontWeight(.semibold)
                        .foregroundColor(.textPrimary)

                    Text(booking.serviceName)
                        .font(.caption)
                        .foregroundColor(.textSecondary)
                }

                Spacer()
            }

            Divider()

            // Booking Details
            VStack(alignment: .leading, spacing: Spacing.xs) {
                HStack {
                    Text("Booking ID:")
                        .font(.caption)
                        .foregroundColor(.textSecondary)

                    Text("#\(booking.id.prefix(8))")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimary)
                }

                HStack {
                    Text("Service:")
                        .font(.caption)
                        .foregroundColor(.textSecondary)

                    Text(booking.serviceName)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimary)
                }

                HStack {
                    Text("Completed:")
                        .font(.caption)
                        .foregroundColor(.textSecondary)

                    Text(booking.scheduledDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimary)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusMd)
    }

    private var reviewTextSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text("Tell us more (Optional)")
                .font(.label)
                .foregroundColor(.textPrimary)

            ZStack(alignment: .topLeading) {
                if viewModel.reviewText.isEmpty {
                    Text("Share your experience to help others...")
                        .font(.body)
                        .foregroundColor(.textTertiary)
                        .padding(.horizontal, Spacing.sm)
                        .padding(.top, Spacing.xs + 2)
                }

                TextEditor(text: $viewModel.reviewText)
                    .font(.body)
                    .foregroundColor(.textPrimary)
                    .frame(minHeight: 100)
                    .padding(Spacing.xs)
                    .scrollContentBackground(.hidden)
            }
            .background(Color.surface)
            .cornerRadius(Spacing.radiusMd)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusMd)
                    .stroke(
                        viewModel.reviewText.count > 500 ? Color.error : Color.divider,
                        lineWidth: 1
                    )
            )

            HStack {
                Spacer()
                Text("\(viewModel.reviewText.count) / 500 characters")
                    .font(.caption)
                    .foregroundColor(viewModel.reviewText.count > 500 ? Color.error : Color.textTertiary)
            }
        }
    }

    // MARK: - Actions

    private func submitReview() {
        Task {
            await viewModel.submitReview()
        }
    }

    private func skipReview() {
        if viewModel.overallRating > 0 {
            // Show confirmation if user has started rating
            // TODO: Add confirmation alert
        }
        dismiss()
    }
}

// MARK: - Star Rating Selector

struct StarRatingSelector: View {
    let title: String
    @Binding var rating: Int
    var isRequired: Bool = false
    var size: CGFloat = 32

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            HStack(spacing: Spacing.xxs) {
                Text(title)
                    .font(.label)
                    .foregroundColor(.textPrimary)

                if isRequired {
                    Text("*")
                        .font(.label)
                        .foregroundColor(.error)
                }
            }

            HStack(spacing: Spacing.xs) {
                ForEach(1...5, id: \.self) { index in
                    Button(action: {
                        Haptics.light()
                        rating = index
                    }) {
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .font(.system(size: size))
                            .foregroundColor(index <= rating ? Color.secondary : Color.textTertiary)
                    }
                }

                if rating > 0 {
                    Text(ratingText)
                        .font(.bodySmall)
                        .fontWeight(.medium)
                        .foregroundColor(.textSecondary)
                        .padding(.leading, Spacing.xs)
                }
            }
        }
    }

    private var ratingText: String {
        switch rating {
        case 1: return "Very Poor"
        case 2: return "Poor"
        case 3: return "Average"
        case 4: return "Good"
        case 5: return "Excellent"
        default: return ""
        }
    }
}

// MARK: - Quick Tags Selector

struct QuickTagsSelector: View {
    @Binding var selectedTags: Set<String>

    private let availableTags = [
        "Professional", "Punctual", "Quality Work", "Friendly",
        "Fast Service", "Fair Price", "Clean", "Skilled"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Quick Tags (Optional)")
                .font(.label)
                .foregroundColor(.textPrimary)

            FlowLayout(spacing: Spacing.xs) {
                ForEach(availableTags, id: \.self) { tag in
                    TagChip(
                        tag: tag,
                        isSelected: selectedTags.contains(tag),
                        onTap: {
                            Haptics.light()
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }
                    )
                }
            }
        }
    }
}

// MARK: - Tag Chip

struct TagChip: View {
    let tag: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Spacing.xxs) {
                Text(tag)
                    .font(.tag)

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: Spacing.iconXS))
                }
            }
            .foregroundColor(isSelected ? Color.primary : Color.textSecondary)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(isSelected ? Color.primary.opacity(0.1) : Color.surface)
            .cornerRadius(Spacing.radiusPill)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusPill)
                    .stroke(isSelected ? Color.primary : Color.divider, lineWidth: 1)
            )
        }
    }
}

// MARK: - Review Photo Upload

struct ReviewPhotoUpload: View {
    @Binding var selectedImages: [PhotosPickerItem]
    @State private var loadedImages: [UIImage] = []
    @State private var showingPicker = false

    private let maxPhotos = 6

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Upload Photos (Optional)")
                .font(.label)
                .foregroundColor(.textPrimary)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: Spacing.md), count: 4),
                spacing: Spacing.md
            ) {
                // Loaded photos
                ForEach(loadedImages.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: loadedImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: Spacing.radiusMd))

                        // Remove button
                        Button(action: {
                            Haptics.light()
                            loadedImages.remove(at: index)
                            selectedImages.remove(at: index)
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: Spacing.iconSM))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.black.opacity(0.6))
                                        .frame(width: 20, height: 20)
                                )
                        }
                        .offset(x: -4, y: 4)
                    }
                }

                // Add photo button
                if selectedImages.count < maxPhotos {
                    PhotosPicker(selection: Binding(
                        get: { [] },
                        set: { newItems in
                            selectedImages.append(contentsOf: newItems)
                            loadImages()
                        }
                    ), maxSelectionCount: maxPhotos - selectedImages.count, matching: .images) {
                        VStack(spacing: Spacing.xxs) {
                            Image(systemName: "plus")
                                .font(.system(size: Spacing.iconMD))
                                .foregroundColor(.primary)

                            Text("Add")
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(Spacing.radiusMd)
                        .overlay(
                            RoundedRectangle(cornerRadius: Spacing.radiusMd)
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                .foregroundColor(.primary)
                        )
                    }
                }
            }

            Text("Add before/after photos (max \(maxPhotos))")
                .font(.caption)
                .foregroundColor(.textTertiary)
        }
        .onChange(of: selectedImages) { _, _ in
            loadImages()
        }
    }

    private func loadImages() {
        Task {
            var images: [UIImage] = []
            for item in selectedImages {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    images.append(image)
                }
            }
            await MainActor.run {
                loadedImages = images
            }
        }
    }
}

// MARK: - Flow Layout (for tags)

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX, y: bounds.minY + result.frames[index].minY), proposal: .unspecified)
        }
    }

    struct FlowResult {
        var size: CGSize = .zero
        var frames: [CGRect] = []

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)

                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }

                frames.append(CGRect(origin: CGPoint(x: currentX, y: currentY), size: size))
                currentX += size.width + spacing
                lineHeight = max(lineHeight, size.height)
            }

            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

// MARK: - Write Review ViewModel

class WriteReviewViewModel: ObservableObject {
    let booking: Booking

    @Published var overallRating: Int = 0
    @Published var qualityRating: Int = 0
    @Published var punctualityRating: Int = 0
    @Published var professionalismRating: Int = 0
    @Published var communicationRating: Int = 0
    @Published var valueRating: Int = 0

    @Published var reviewText: String = ""
    @Published var selectedTags: Set<String> = []
    @Published var selectedPhotos: [PhotosPickerItem] = []

    @Published var isAnonymous: Bool = false
    @Published var isSubmitting: Bool = false
    @Published var showSuccessAlert: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String?

    init(booking: Booking) {
        self.booking = booking
    }

    var isValid: Bool {
        // Overall rating is required
        return overallRating > 0 &&
               reviewText.count <= 500
    }

    func submitReview() async {
        guard isValid else { return }

        isSubmitting = true

        // TODO: Implement actual API call to submit review
        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_500_000_000)

        await MainActor.run {
            isSubmitting = false
            showSuccessAlert = true
            Haptics.success()
        }
    }
}

// MARK: - Preview

#Preview("Write Review - Light") {
    WriteReviewView(booking: Booking.mockBookings[0])
}

#Preview("Write Review - Dark") {
    WriteReviewView(booking: Booking.mockBookings[0])
        .preferredColorScheme(.dark)
}

#Preview("Write Review - With Ratings") {
    WriteReviewView(booking: Booking.mockBookings[0])
}
