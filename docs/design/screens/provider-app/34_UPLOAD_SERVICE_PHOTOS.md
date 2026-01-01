# Upload Service Photos

## Overview
- **Screen ID**: 34
- **Screen Name**: Upload Service Photos
- **User Role**: Service Provider
- **Platform**: iOS, Android
- **Navigation**: From Job In Progress (Screen 29) → Tap "Add Photo" or from Mark Complete (Screen 33) → Tap "Add More"

## ASCII Wireframe

```
┌──────────────────────────────────────────┐
│  ✕  Service Photos              Done     │
├──────────────────────────────────────────┤
│                                          │
│  📸 Upload Photos (4/6)                  │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ Before                    After    │ │  ← Tab selector
│  └────────────────────────────────────┘ │
│                                          │
│  Before Photos (2)                       │
│  ┌──────────┐ ┌──────────┐ ┌─────────┐│
│  │ [Photo1] │ │ [Photo2] │ │  [+]    ││  ← Photo grid
│  │          │ │          │ │         ││
│  │ ✓ Primary│ │          │ │  Add    ││
│  └──────────┘ └──────────┘ └─────────┘│
│                                          │
│  After Photos (2)                        │
│  ┌──────────┐ ┌──────────┐ ┌─────────┐│
│  │ [Photo3] │ │ [Photo4] │ │  [+]    ││
│  │          │ │          │ │         ││
│  │ ✓ Primary│ │          │ │  Add    ││
│  └──────────┘ └──────────┘ └─────────┘│
│                                          │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                          │
│  📝 Add Captions (Optional)              │
│  ┌────────────────────────────────────┐ │
│  │ [Selected: Photo1]                 │ │
│  │                                    │ │
│  │ Caption:                           │ │
│  │ ┌────────────────────────────────┐│ │
│  │ │ Before starting repair...      ││ │
│  │ └────────────────────────────────┘│ │
│  │                                    │ │
│  │ (50/100 characters)                │ │
│  └────────────────────────────────────┘ │
│                                          │
│  💡 Tips for Better Photos               │
│  ┌────────────────────────────────────┐ │
│  │ • Take clear, well-lit photos      │ │
│  │ • Show problem area and solution   │ │
│  │ • Use before/after comparison      │ │
│  │ • Include close-up details         │ │
│  └────────────────────────────────────┘ │
│                                          │
│  Photo Settings                          │
│  ┌────────────────────────────────────┐ │
│  │ ☑ Auto-compress for faster upload │ │
│  │ ☑ Add timestamp watermark          │ │
│  │ ☑ Include GPS location             │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │        Upload Photos (4)           │ │  ← Primary button
│  └────────────────────────────────────┘ │
│                                          │
│              Cancel                      │
│                                          │
└──────────────────────────────────────────┘
```

## Key Features

### Before/After Organization

**Before Photos:**
- Show initial problem/condition
- Mandatory for documentation
- Minimum 1 required
- Set one as primary for thumbnail

**After Photos:**
- Show completed work/solution
- Proves service quality
- Minimum 1 required
- Set one as primary for thumbnail

**Comparison View:**
- Side-by-side before/after
- Swipe to compare
- Helps demonstrate value

### Photo Capture Options

**Camera:**
- Direct capture from device camera
- Front/rear camera switch
- Flash control
- Grid overlay for alignment

**Gallery:**
- Select from photo library
- Multiple selection (up to 6 total)
- Recent photos first
- Album browsing

**Quality Settings:**
- Original quality (larger file)
- High quality (recommended)
- Medium quality (faster upload)
- Auto-select based on connection

### Photo Management

**Actions per Photo:**
- View full size
- Delete
- Set as primary
- Add/edit caption
- Rotate/crop (basic editing)
- Reorder photos

**Validation:**
- Maximum 6 photos total
- Minimum 2 photos (1 before, 1 after)
- Maximum file size: 5MB per photo
- Supported formats: JPG, PNG, HEIC
- Auto-compression if needed

### Captions & Annotations

**Caption Features:**
- Optional text description (100 chars max)
- Helps explain the photo
- Useful for complex repairs
- Searchable in records

**Auto-Generated Info:**
- Timestamp
- GPS coordinates (with permission)
- Camera/device info
- File size

### Photo Settings

**Auto-Compress:**
- Reduces file size for faster upload
- Maintains visual quality
- Recommended for slow connections
- Toggle on/off

**Timestamp Watermark:**
- Adds date/time to photo corner
- Proves when photo was taken
- Cannot be removed later
- Useful for disputes

**GPS Location:**
- Embeds GPS coordinates
- Verifies service location
- Requires location permission
- Toggle on/off for privacy

## Component Breakdown

### Before/After Tab Selector

```swift
struct BeforeAfterTabSelector: View {
    @Binding var selectedTab: PhotoCategory
    let beforeCount: Int
    let afterCount: Int

    var body: some View {
        HStack(spacing: 0) {
            TabButton(
                title: "Before",
                count: beforeCount,
                isSelected: selectedTab == .before,
                onTap: { selectedTab = .before }
            )

            TabButton(
                title: "After",
                count: afterCount,
                isSelected: selectedTab == .after,
                onTap: { selectedTab = .after }
            )
        }
        .background(Color.gray100)
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

struct TabButton: View {
    let title: String
    let count: Int
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: isSelected ? .semibold : .regular))

                Text("(\(count))")
                    .font(.system(size: 12))
            }
            .foregroundColor(isSelected ? .white : .gray600)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(isSelected ? Color.brandPrimary : Color.clear)
            .cornerRadius(6)
        }
    }
}

enum PhotoCategory {
    case before
    case after
}
```

### Photo Grid

```swift
struct PhotoGrid: View {
    let category: PhotoCategory
    @Binding var photos: [ServicePhoto]
    let maxPhotos: Int = 6
    let onAddPhoto: () -> Void
    let onPhotoTap: (ServicePhoto) -> Void
    let onDelete: (ServicePhoto) -> Void
    let onSetPrimary: (ServicePhoto) -> Void

    var categoryPhotos: [ServicePhoto] {
        photos.filter { $0.category == category }
    }

    var canAddMore: Bool {
        photos.count < maxPhotos
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("\(category == .before ? "Before" : "After") Photos (\(categoryPhotos.count))")
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(.gray700)

                Spacer()

                if categoryPhotos.isEmpty {
                    Text("Minimum 1 required")
                        .font(.system(size: 12))
                        .foregroundColor(.error)
                }
            }

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(categoryPhotos) { photo in
                    PhotoThumbnailCard(
                        photo: photo,
                        onTap: { onPhotoTap(photo) },
                        onDelete: { onDelete(photo) },
                        onSetPrimary: { onSetPrimary(photo) }
                    )
                }

                if canAddMore {
                    AddPhotoCard(action: onAddPhoto)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct PhotoThumbnailCard: View {
    let photo: ServicePhoto
    let onTap: () -> Void
    let onDelete: () -> Void
    let onSetPrimary: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Photo
            Button(action: onTap) {
                Image(uiImage: photo.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            // Delete button
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.black.opacity(0.6)))
            }
            .offset(x: 8, y: -8)

            // Primary badge
            if photo.isPrimary {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("✓ Primary")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.success)
                            .cornerRadius(4)
                    }
                    .padding(6)
                }
            }
        }
        .frame(width: 110, height: 110)
        .contextMenu {
            Button(action: onSetPrimary) {
                Label("Set as Primary", systemImage: "star.fill")
            }
            .disabled(photo.isPrimary)

            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

struct AddPhotoCard: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .foregroundColor(.brandPrimary)

                Text("Add")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.brandPrimary)
            }
            .frame(width: 110, height: 110)
            .background(Color.brandPrimary.opacity(0.1))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.brandPrimary, style: StrokeStyle(lineWidth: 2, dash: [5]))
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
```

### Caption Editor

```swift
struct CaptionEditor: View {
    @Binding var selectedPhoto: ServicePhoto?
    @Binding var caption: String
    let maxLength: Int = 100

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📝 Add Captions (Optional)")
                .font(.custom("Inter-Medium", size: 16))
                .foregroundColor(.gray800)

            if let photo = selectedPhoto {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(uiImage: photo.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 6))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Selected: \(photo.category == .before ? "Before" : "After") Photo")
                                .font(.system(size: 12))
                                .foregroundColor(.gray600)

                            if photo.isPrimary {
                                Text("✓ Primary photo")
                                    .font(.system(size: 11))
                                    .foregroundColor(.success)
                            }
                        }

                        Spacer()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Caption:")
                            .font(.system(size: 12))
                            .foregroundColor(.gray600)

                        TextField("Describe what's shown in this photo", text: $caption)
                            .font(.system(size: 14))
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray200, lineWidth: 1)
                            )

                        HStack {
                            Text("Helps explain the photo")
                                .font(.system(size: 11))
                                .foregroundColor(.gray500)

                            Spacer()

                            Text("\(caption.count)/\(maxLength)")
                                .font(.system(size: 11))
                                .foregroundColor(caption.count > maxLength ? .error : .gray500)
                        }
                    }
                }
            } else {
                Text("Select a photo to add caption")
                    .font(.system(size: 14))
                    .foregroundColor(.gray500)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(Color.gray50)
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}
```

### Photo Tips

```swift
struct PhotoTips: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.warning)

                Text("Tips for Better Photos")
                    .font(.custom("Inter-Medium", size: 14))
                    .foregroundColor(.gray800)
            }

            VStack(alignment: .leading, spacing: 8) {
                TipRow(text: "Take clear, well-lit photos")
                TipRow(text: "Show problem area and solution")
                TipRow(text: "Use before/after comparison")
                TipRow(text: "Include close-up details")
            }
        }
        .padding(16)
        .background(Color.warning.opacity(0.1))
        .cornerRadius(12)
    }
}

struct TipRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .foregroundColor(.warning)

            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.gray700)
        }
    }
}
```

### Photo Settings

```swift
struct PhotoSettings: View {
    @Binding var autoCompress: Bool
    @Binding var addTimestamp: Bool
    @Binding var includeGPS: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Photo Settings")
                .font(.custom("Inter-Medium", size: 14))
                .foregroundColor(.gray700)

            VStack(spacing: 12) {
                SettingToggle(
                    icon: "arrow.down.circle",
                    title: "Auto-compress for faster upload",
                    subtitle: "Reduces file size while maintaining quality",
                    isOn: $autoCompress
                )

                SettingToggle(
                    icon: "clock",
                    title: "Add timestamp watermark",
                    subtitle: "Shows when photo was taken",
                    isOn: $addTimestamp
                )

                SettingToggle(
                    icon: "location",
                    title: "Include GPS location",
                    subtitle: "Verifies service location",
                    isOn: $includeGPS
                )
            }
        }
        .padding(16)
        .background(Color.gray50)
        .cornerRadius(12)
    }
}

struct SettingToggle: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(.brandPrimary)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.gray800)

                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray500)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.brandPrimary)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(8)
    }
}
```

## Interactions

### Add Photo

```swift
func addPhoto() {
    guard photos.count < 6 else {
        ToastManager.show("Maximum 6 photos allowed")
        return
    }

    // Show action sheet for camera or gallery
    presentActionSheet(
        title: "Add Photo",
        actions: [
            .init(title: "Take Photo", icon: "camera") {
                openCamera()
            },
            .init(title: "Choose from Gallery", icon: "photo.on.rectangle") {
                openGallery()
            }
        ]
    )
}

func openCamera() {
    presentCamera { image in
        processAndUploadPhoto(image, category: selectedTab)
    }
}

func openGallery() {
    let maxSelection = 6 - photos.count
    presentPhotoLibrary(maxSelection: maxSelection) { images in
        for image in images {
            processAndUploadPhoto(image, category: selectedTab)
        }
    }
}

func processAndUploadPhoto(_ image: UIImage, category: PhotoCategory) {
    var processedImage = image

    // Auto-compress if enabled
    if autoCompress {
        processedImage = compressImage(image, maxSizeKB: 500)
    }

    // Add timestamp watermark if enabled
    if addTimestamp {
        processedImage = addTimestampWatermark(to: processedImage)
    }

    // Create photo object
    let photo = ServicePhoto(
        image: processedImage,
        category: category,
        isPrimary: photos.filter { $0.category == category }.isEmpty, // First photo of category is primary
        timestamp: Date(),
        location: includeGPS ? getCurrentLocation() : nil
    )

    // Upload
    Task {
        await viewModel.uploadPhoto(photo)
        photos.append(photo)
    }
}
```

### Upload Photos

```swift
func uploadPhotos() {
    // Validate
    guard validatePhotos() else { return }

    isLoading = true

    Task {
        do {
            let uploadedUrls = await viewModel.uploadAllPhotos(photos)

            isLoading = false

            if uploadedUrls.count == photos.count {
                ToastManager.show("\(photos.count) photos uploaded successfully")
                HapticManager.notification(.success)

                // Track analytics
                analytics.track("service_photos_uploaded", [
                    "count": photos.count,
                    "before_count": photos.filter { $0.category == .before }.count,
                    "after_count": photos.filter { $0.category == .after }.count,
                    "has_captions": photos.contains { !$0.caption.isEmpty }
                ])

                // Dismiss
                dismiss()
            } else {
                AlertManager.showError("Some photos failed to upload. Please try again.")
            }
        } catch {
            isLoading = false
            AlertManager.showError(error.localizedDescription)
        }
    }
}

func validatePhotos() -> Bool {
    let beforePhotos = photos.filter { $0.category == .before }
    let afterPhotos = photos.filter { $0.category == .after }

    // Check minimum photos
    guard beforePhotos.count >= 1 && afterPhotos.count >= 1 else {
        AlertManager.showError("Please add at least 1 before and 1 after photo")
        return false
    }

    // Check total
    guard photos.count >= 2 else {
        AlertManager.showError("Minimum 2 photos required")
        return false
    }

    // Check captions length
    for photo in photos where !photo.caption.isEmpty {
        guard photo.caption.count <= 100 else {
            AlertManager.showError("Caption too long (max 100 characters)")
            return false
        }
    }

    return true
}
```

## States

### Empty State
- No photos uploaded
- Show prompt to add first photo
- Tips visible
- Upload button disabled

### Uploading State
- Progress indicator per photo
- Cancel option
- Disable interactions

### Error State
- Show failed uploads
- Retry option
- Error message

## API Integration

### Upload Photo
```typescript
POST /bookings/{bookingId}/photos
Body: FormData {
  photo: File,
  category: "before" | "after",
  isPrimary: boolean,
  caption: string?,
  timestamp: string,
  location: { lat: number, lng: number }?
}

Response:
{
  "success": true,
  "photoUrl": "https://storage.../photo.jpg",
  "thumbnailUrl": "https://storage.../photo_thumb.jpg"
}
```

## Navigation

### Entry Points
- Screen 29 (Job In Progress) → "Add Photo"
- Screen 33 (Mark Complete) → "Add More"

### Exit Points
- Tap "Done" → Return with uploaded photos
- Tap Close → Confirm discard → Return

## Accessibility

### VoiceOver
- Photos: "Before photo 1 of 2, Primary, Double tap to view"
- Add button: "Add photo, Button"

## Analytics

```typescript
analytics.track('photo_upload_opened', {
  from_screen: 'job_in_progress',
  existing_photos: 2
})

analytics.track('photo_added', {
  category: 'before',
  source: 'camera',
  compressed: true,
  has_timestamp: true
})
```

## Testing Checklist

- [ ] Camera capture works
- [ ] Gallery selection works
- [ ] Photo compression works
- [ ] Timestamp watermark adds correctly
- [ ] GPS location embeds
- [ ] Caption saves
- [ ] Primary photo indicator shows
- [ ] Delete confirmation
- [ ] Upload progress displays
- [ ] Validation messages correct

## Design Notes

- Intuitive before/after organization
- Easy photo management
- Clear quality settings
- Helpful tips prominent
- Fast upload with compression
