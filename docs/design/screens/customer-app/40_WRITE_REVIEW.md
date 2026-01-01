# Screen 40: Write Review

## Overview

- **Screen ID**: 40
- **Screen Name**: Write Review
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 14 (Order Detail) → Tap "Write Review" button (after service completed)
  - From: Screen 15 (Active Booking) → Post-completion prompt
  - From: Push Notification → "Rate your recent service"

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│ ✕  Rate Your Experience                │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────────────────────────┐    │
│  │    👤  John Doe                 │    │ Provider Card
│  │    Electrician                  │    │
│  │                                 │    │
│  │    Booking ID: #BK123456        │    │
│  │    Service: Electrical Repair   │    │
│  │    Completed: Dec 30, 2025      │    │
│  └────────────────────────────────┘    │
│                                         │
│  How was your experience?               │
│                                         │
│  Overall Rating *                       │
│  ┌────────────────────────────────┐    │
│  │    ⭐ ⭐ ⭐ ⭐ ⭐               │    │ Star Rating
│  │   Tap to rate                   │    │
│  └────────────────────────────────┘    │
│                                         │
│  Rate Specific Aspects                  │
│                                         │
│  Quality of Work                        │
│  ⭐ ⭐ ⭐ ⭐ ⭐                         │ 5-Star Rating
│                                         │
│  Punctuality                            │
│  ⭐ ⭐ ⭐ ⭐ ☆                         │ 4-Star Rating
│                                         │
│  Professionalism                        │
│  ⭐ ⭐ ⭐ ⭐ ⭐                         │ 5-Star Rating
│                                         │
│  Communication                          │
│  ⭐ ⭐ ⭐ ⭐ ☆                         │ 4-Star Rating
│                                         │
│  Value for Money                        │
│  ⭐ ⭐ ⭐ ⭐ ⭐                         │ 5-Star Rating
│                                         │
│  ─────────────────────────────────      │
│                                         │
│  Tell us more (Optional)                │
│  ┌────────────────────────────────┐    │
│  │ John was very professional and  │    │ Text Area
│  │ completed the work efficiently. │    │
│  │ Highly recommend!               │    │
│  │                                 │    │
│  │                                 │    │
│  └────────────────────────────────┘    │
│  85 / 500 characters                    │
│                                         │
│  Quick Tags (Optional)                  │
│  ┌────────────────────────────────┐    │
│  │ [Professional ✓] [Punctual ✓]  │    │ Tag Chips
│  │ [Quality Work ✓] [Friendly]    │    │
│  │ [Fast Service] [Fair Price ✓]  │    │
│  │ [Clean] [Skilled ✓]             │    │
│  └────────────────────────────────┘    │
│                                         │
│  Upload Photos (Optional)               │
│  ┌────┬────┬────┬────┐                 │
│  │ 📷 │ 📷 │ +  │    │                 │ Photo Grid
│  └────┴────┴────┴────┘                 │
│  Add before/after photos (max 6)        │
│                                         │
│  ☐ Post review anonymously              │ Checkbox
│                                         │
│  ┌─────────────────────────────────┐   │
│  │      Submit Review               │   │ Primary CTA
│  └─────────────────────────────────┘   │
│                                         │
│  [Skip for Now]                         │ Secondary Action
│                                         │
└─────────────────────────────────────────┘

RATING TOOLTIP:

┌─────────────────────────────────────────┐
│  Your rating helps others find great    │
│  service providers!                     │
│                                         │
│  ⭐ 1 star - Very Poor                  │
│  ⭐⭐ 2 stars - Poor                     │
│  ⭐⭐⭐ 3 stars - Average                │
│  ⭐⭐⭐⭐ 4 stars - Good                 │
│  ⭐⭐⭐⭐⭐ 5 stars - Excellent          │
└─────────────────────────────────────────┘

THANK YOU ANIMATION:

┌─────────────────────────────────────────┐
│                                         │
│          ✨ (Success Animation)         │
│                                         │
│      Thank You for Your Review!         │
│                                         │
│   Your feedback helps improve our       │
│   service quality                       │
│                                         │
│   ┌─────────────────────────────────┐  │
│   │      View Your Review            │  │
│   └─────────────────────────────────┘  │
│                                         │
│   [Back to Home]                        │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Provider Info Card
- Provider photo, name, specialization
- Booking details (ID, service, date)
- Service completion verification

### 2. Overall Rating
- Large 5-star selector
- Required field
- Visual feedback on selection
- Rating guide tooltip

### 3. Category Ratings
- 5 specific aspects:
  - Quality of Work
  - Punctuality
  - Professionalism
  - Communication
  - Value for Money
- Individual 5-star ratings
- Auto-populated from overall rating (can be adjusted)

### 4. Written Review
- Text area (max 500 characters)
- Optional but encouraged
- Character counter
- Placeholder with example

### 5. Quick Tags
- Pre-defined positive tags
- Multi-select chips
- Common keywords: Professional, Punctual, Quality Work, Friendly, Fast Service, Fair Price, Clean, Skilled
- Visual selection state

### 6. Photo Upload
- Before/after photos
- Max 6 photos
- Camera or gallery
- Preview thumbnails
- Remove uploaded photos

### 7. Anonymous Option
- Post review without name
- Shows as "Anonymous Customer"
- Verified booking badge still shown

### 8. Validation
- Overall rating required
- Category ratings optional (default to overall)
- Written review optional
- Min 10 characters if review text provided

## Component Breakdown

### 1. Header
```swift
struct WriteReviewHeader: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("TextPrimary"))
            }

            Spacer()

            Text("Rate Your Experience")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(Color("TextPrimary"))

            Spacer()

            // Placeholder for symmetry
            Color.clear
                .frame(width: 18)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
```

### 2. Provider Info Card
```swift
struct ReviewProviderCard: View {
    let booking: Booking

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                // Provider Photo
                AsyncImage(url: URL(string: booking.provider.photoURL ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Circle()
                        .fill(Color("BackgroundSecondary"))
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("TextTertiary"))
                        )
                }
                .frame(width: 48, height: 48)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(booking.provider.name)
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(Color("TextPrimary"))

                    Text(booking.provider.specialization)
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color("TextSecondary"))
                }

                Spacer()
            }

            Divider()

            // Booking Details
            VStack(alignment: .leading, spacing: 6) {
                DetailRow(label: "Booking ID:", value: booking.id)
                DetailRow(label: "Service:", value: booking.serviceName)
                DetailRow(label: "Completed:", value: booking.completedAt.formatted(date: .abbreviated, time: .omitted))
            }
        }
        .padding(16)
        .background(Color("BackgroundSecondary"))
        .cornerRadius(12)
    }
}

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color("TextSecondary"))

            Text(value)
                .font(.custom("Inter-Medium", size: 12))
                .foregroundColor(Color("TextPrimary"))
        }
    }
}
```

### 3. Star Rating Selector
```swift
struct StarRatingSelector: View {
    let title: String
    @Binding var rating: Int
    var isRequired: Bool = false
    var size: CGFloat = 40

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.custom("Inter-Medium", size: 15))
                    .foregroundColor(Color("TextPrimary"))

                if isRequired {
                    Text("*")
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(Color("ErrorRed"))
                }
            }

            HStack(spacing: 8) {
                ForEach(1...5, id: \.self) { index in
                    Button(action: {
                        rating = index
                        // Haptic feedback
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }) {
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .font(.system(size: size))
                            .foregroundColor(index <= rating ? Color("SecondaryOrange") : Color("TextTertiary"))
                            .animation(.spring(response: 0.2), value: rating)
                    }
                }

                if rating > 0 {
                    Text(ratingText)
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                        .padding(.leading, 8)
                }
            }
        }
    }

    var ratingText: String {
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
```

### 4. Quick Tags Selector
```swift
struct QuickTagsSelector: View {
    @Binding var selectedTags: Set<String>
    let availableTags = [
        "Professional", "Punctual", "Quality Work", "Friendly",
        "Fast Service", "Fair Price", "Clean", "Skilled"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Tags (Optional)")
                .font(.custom("Inter-Medium", size: 15))
                .foregroundColor(Color("TextPrimary"))

            FlowLayout(spacing: 10) {
                ForEach(availableTags, id: \.self) { tag in
                    TagChip(
                        tag: tag,
                        isSelected: selectedTags.contains(tag),
                        onTap: {
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

struct TagChip: View {
    let tag: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Text(tag)
                    .font(.custom("Inter-Medium", size: 13))

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10))
                }
            }
            .foregroundColor(isSelected ? Color("PrimaryTeal") : Color("TextSecondary"))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? Color("PrimaryTeal").opacity(0.1) : Color("BackgroundSecondary"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color("PrimaryTeal") : Color.clear, lineWidth: 1)
            )
        }
    }
}
```

### 5. Photo Upload Grid
```swift
struct ReviewPhotoUpload: View {
    @Binding var photos: [UIImage]
    @State private var showingImagePicker = false
    let maxPhotos = 6

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upload Photos (Optional)")
                .font(.custom("Inter-Medium", size: 15))
                .foregroundColor(Color("TextPrimary"))

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                ForEach(photos.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: photos[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        // Remove Button
                        Button(action: { photos.remove(at: index) }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .background(Circle().fill(Color.black.opacity(0.6)))
                        }
                        .offset(x: -4, y: 4)
                    }
                }

                // Add Photo Button
                if photos.count < maxPhotos {
                    Button(action: { showingImagePicker = true }) {
                        VStack(spacing: 6) {
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .foregroundColor(Color("PrimaryTeal"))

                            Text("Add")
                                .font(.custom("Inter-Regular", size: 11))
                                .foregroundColor(Color("PrimaryTeal"))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(Color("PrimaryTeal").opacity(0.1))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("PrimaryTeal"), lineWidth: 1, dash: [4])
                        )
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePickerView(image: Binding(
                            get: { nil },
                            set: { if let image = $0 { photos.append(image) } }
                        ))
                    }
                }
            }

            Text("Add before/after photos (max \(maxPhotos))")
                .font(.custom("Inter-Regular", size: 11))
                .foregroundColor(Color("TextTertiary"))
        }
    }
}
```

### 6. Submit Review Form
```swift
struct WriteReviewView: View {
    let booking: Booking
    @StateObject private var viewModel = WriteReviewViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Provider Info
                ReviewProviderCard(booking: booking)

                Text("How was your experience?")
                    .font(.custom("Inter-SemiBold", size: 18))
                    .foregroundColor(Color("TextPrimary"))

                // Overall Rating
                StarRatingSelector(
                    title: "Overall Rating",
                    rating: $viewModel.overallRating,
                    isRequired: true,
                    size: 44
                )

                Divider()

                // Category Ratings
                VStack(alignment: .leading, spacing: 16) {
                    Text("Rate Specific Aspects")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(Color("TextPrimary"))

                    StarRatingSelector(title: "Quality of Work", rating: $viewModel.qualityRating)
                    StarRatingSelector(title: "Punctuality", rating: $viewModel.punctualityRating)
                    StarRatingSelector(title: "Professionalism", rating: $viewModel.professionalismRating)
                    StarRatingSelector(title: "Communication", rating: $viewModel.communicationRating)
                    StarRatingSelector(title: "Value for Money", rating: $viewModel.valueRating)
                }

                Divider()

                // Written Review
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tell us more (Optional)")
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(Color("TextPrimary"))

                    ZStack(alignment: .topLeading) {
                        if viewModel.reviewText.isEmpty {
                            Text("Share your experience to help others...")
                                .font(.custom("Inter-Regular", size: 15))
                                .foregroundColor(Color("TextTertiary"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                        }

                        TextEditor(text: $viewModel.reviewText)
                            .font(.custom("Inter-Regular", size: 15))
                            .foregroundColor(Color("TextPrimary"))
                            .frame(minHeight: 100)
                            .padding(8)
                    }
                    .background(Color("BackgroundSecondary"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("BorderLight"), lineWidth: 1)
                    )

                    HStack {
                        Spacer()
                        Text("\(viewModel.reviewText.count) / 500 characters")
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(viewModel.reviewText.count > 500 ? Color("ErrorRed") : Color("TextTertiary"))
                    }
                }

                // Quick Tags
                QuickTagsSelector(selectedTags: $viewModel.selectedTags)

                // Photo Upload
                ReviewPhotoUpload(photos: $viewModel.photos)

                // Anonymous Option
                Toggle(isOn: $viewModel.isAnonymous) {
                    Text("Post review anonymously")
                        .font(.custom("Inter-Regular", size: 15))
                        .foregroundColor(Color("TextPrimary"))
                }
                .tint(Color("PrimaryTeal"))

                // Submit Button
                Button(action: { viewModel.submitReview() }) {
                    HStack {
                        if viewModel.isSubmitting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        Text(viewModel.isSubmitting ? "Submitting..." : "Submit Review")
                    }
                    .font(.custom("Inter-SemiBold", size: 16))
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .foregroundColor(.white)
                    .background(viewModel.isValid ? Color("PrimaryTeal") : Color("DisabledGray"))
                    .cornerRadius(8)
                }
                .disabled(!viewModel.isValid || viewModel.isSubmitting)

                // Skip Button
                Button("Skip for Now") {
                    dismiss()
                }
                .font(.custom("Inter-Medium", size: 15))
                .foregroundColor(Color("TextSecondary"))
                .frame(maxWidth: .infinity)
            }
            .padding(16)
        }
        .navigationBarHidden(true)
        .onChange(of: viewModel.overallRating) { newValue in
            // Auto-populate category ratings if not set
            if viewModel.qualityRating == 0 { viewModel.qualityRating = newValue }
            if viewModel.punctualityRating == 0 { viewModel.punctualityRating = newValue }
            if viewModel.professionalismRating == 0 { viewModel.professionalismRating = newValue }
            if viewModel.communicationRating == 0 { viewModel.communicationRating = newValue }
            if viewModel.valueRating == 0 { viewModel.valueRating = newValue }
        }
    }
}
```

## API Integration

```
POST /bookings/{bookingId}/reviews

Request (multipart/form-data):
- overallRating: 5
- qualityRating: 5
- punctualityRating: 4
- professionalismRating: 5
- communicationRating: 4
- valueRating: 5
- reviewText: "John was very professional..."
- tags: ["Professional", "Punctual", "Quality Work", "Fair Price"]
- photos: [file1, file2]
- isAnonymous: false

Response:
{
  "success": true,
  "data": {
    "reviewId": "rev_abc123",
    "status": "published"
  },
  "message": "Thank you for your review!"
}
```

## Navigation

- From Order Detail/Active Booking → Write Review
- Submit Success → Review Submitted (Screen 42)
- Skip → Return to previous screen

## Testing Checklist

- [ ] Overall rating required validation
- [ ] Category ratings auto-populate from overall
- [ ] Text area character limit (500)
- [ ] Quick tags multi-select works
- [ ] Photo upload (max 6)
- [ ] Photo removal works
- [ ] Anonymous toggle works
- [ ] Submit button enables when valid
- [ ] Success animation plays
- [ ] Skip confirmation if ratings entered

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
