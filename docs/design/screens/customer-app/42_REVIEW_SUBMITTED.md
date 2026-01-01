# Screen 42: Review Submitted

## Overview

- **Screen ID**: 42
- **Screen Name**: Review Submitted
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 40 (Write Review) → After successful submission
  - Auto-dismisses after 3 seconds OR user taps action button

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│                                         │
│                                         │
│                                         │
│              ┌───────────┐              │
│              │           │              │
│              │     ✓     │              │ Success Animation
│              │           │              │
│              └───────────┘              │
│                                         │
│          Thank You!                     │ Heading
│                                         │
│     Your review has been                │ Subheading
│        submitted successfully           │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │                                 │   │ Review Summary Card
│  │    ⭐⭐⭐⭐⭐                    │   │
│  │    5.0 Overall Rating           │   │
│  │                                 │   │
│  │    Reviewed:                    │   │
│  │    👤 John Doe (Electrician)    │   │
│  │    📅 December 31, 2025         │   │
│  │                                 │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │     📱 Share Your Review         │   │ Share Button
│  └─────────────────────────────────┘   │
│                                         │
│  ───────────────────────────────────   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │       View My Review             │   │ Primary CTA
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │       Book Again                 │   │ Secondary CTA
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │       Return to Home             │   │ Tertiary CTA
│  └─────────────────────────────────┘   │
│                                         │
│                                         │
│  💡 Your review helps others make       │ Tip
│     informed decisions!                 │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Success Animation
- Animated checkmark in circle
- Scale + fade-in animation (0.5s)
- Green accent color
- Optional confetti effect (for high ratings 4+)

### 2. Confirmation Message
- "Thank You!" heading
- Success message
- Positive, appreciative tone

### 3. Review Summary Card
- Star rating displayed (non-interactive)
- Provider name and service
- Submission date
- Compact summary view

### 4. Share Review
- Share to social media
- Copy link to clipboard
- Pre-filled share text

### 5. Action Buttons
- **View My Review**: Navigate to provider reviews list with user's review highlighted
- **Book Again**: Navigate to service detail to rebook same provider
- **Return to Home**: Navigate to home screen

### 6. Helpful Tip
- Educational message
- Encourages community contribution

### 7. Auto-Dismiss Option
- 3-second countdown (optional, configurable)
- Skip button to dismiss immediately

## Component Breakdown

```swift
struct ReviewSubmittedView: View {
    let review: SubmittedReview
    @Environment(\.dismiss) var dismiss
    @State private var showConfetti = false
    @State private var animateCheckmark = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Success Animation
            ZStack {
                // Checkmark Circle
                Circle()
                    .fill(Color("SuccessGreen"))
                    .frame(width: 100, height: 100)
                    .scaleEffect(animateCheckmark ? 1.0 : 0.5)
                    .opacity(animateCheckmark ? 1.0 : 0.0)

                Image(systemName: "checkmark")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                    .scaleEffect(animateCheckmark ? 1.0 : 0.5)
                    .opacity(animateCheckmark ? 1.0 : 0.0)
            }
            .padding(.bottom, 24)

            // Confetti Overlay (for high ratings)
            if showConfetti {
                ConfettiView()
                    .allowsHitTesting(false)
            }

            // Heading
            Text("Thank You!")
                .font(.custom("Inter-Bold", size: 28))
                .foregroundColor(Color("TextPrimary"))
                .padding(.bottom, 8)

            // Subheading
            Text("Your review has been\nsubmitted successfully")
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Color("TextSecondary"))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.bottom, 32)

            // Review Summary Card
            ReviewSummaryCard(review: review)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)

            // Share Button
            Button(action: shareReview) {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 16))
                    Text("Share Your Review")
                        .font(.custom("Inter-SemiBold", size: 15))
                }
                .foregroundColor(Color("PrimaryTeal"))
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Color("PrimaryTeal").opacity(0.1))
                .cornerRadius(10)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)

            Divider()
                .padding(.horizontal, 24)
                .padding(.bottom, 16)

            // Action Buttons
            VStack(spacing: 12) {
                // View My Review
                Button(action: viewReview) {
                    Text("View My Review")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color("PrimaryTeal"))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 24)

                // Book Again
                Button(action: bookAgain) {
                    Text("Book Again")
                        .font(.custom("Inter-SemiBold", size: 16))
                        .foregroundColor(Color("PrimaryTeal"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("PrimaryTeal"), lineWidth: 1.5)
                        )
                }
                .padding(.horizontal, 24)

                // Return to Home
                Button(action: returnHome) {
                    Text("Return to Home")
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(Color("TextSecondary"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                }
                .padding(.horizontal, 24)
            }
            .padding(.bottom, 16)

            // Helpful Tip
            HStack(spacing: 8) {
                Image(systemName: "lightbulb.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color("SecondaryOrange"))

                Text("Your review helps others make informed decisions!")
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color("TextSecondary"))
                    .lineSpacing(3)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Color("SecondaryOrange").opacity(0.1))
            .cornerRadius(8)
            .padding(.horizontal, 24)

            Spacer()
        }
        .background(Color("BackgroundPrimary"))
        .onAppear {
            // Animate checkmark
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                animateCheckmark = true
            }

            // Show confetti for high ratings (4+)
            if review.overallRating >= 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showConfetti = true
                }
            }

            // Haptic feedback
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        .navigationBarHidden(true)
    }

    func shareReview() {
        let shareText = "I just reviewed \(review.providerName) on UrbanNest! ⭐ \(review.overallRating)/5"
        let activityVC = UIActivityViewController(
            activityItems: [shareText, review.reviewURL],
            applicationActivities: nil
        )
        // Present activity view controller
        // (requires UIViewControllerRepresentable wrapper)
    }

    func viewReview() {
        // Navigate to provider reviews list with user's review highlighted
        // Pass reviewId for scrolling/highlighting
    }

    func bookAgain() {
        // Navigate to service detail for same provider/service
    }

    func returnHome() {
        // Navigate to home screen (root)
        dismiss()
    }
}

struct ReviewSummaryCard: View {
    let review: SubmittedReview

    var body: some View {
        VStack(spacing: 16) {
            // Star Rating
            HStack(spacing: 4) {
                ForEach(0..<review.overallRating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color("SecondaryOrange"))
                }
                ForEach(0..<(5 - review.overallRating), id: \.self) { _ in
                    Image(systemName: "star")
                        .font(.system(size: 24))
                        .foregroundColor(Color("TextTertiary"))
                }
            }
            .padding(.top, 4)

            Text("\(String(format: "%.1f", Double(review.overallRating))) Overall Rating")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))

            Divider()

            // Review Details
            VStack(spacing: 10) {
                HStack(spacing: 8) {
                    Text("Reviewed:")
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                    Spacer()
                }

                HStack(spacing: 8) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color("PrimaryTeal"))

                    Text("\(review.providerName) (\(review.serviceName))")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextPrimary"))

                    Spacer()
                }

                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                        .font(.system(size: 16))
                        .foregroundColor(Color("PrimaryTeal"))

                    Text(review.submittedDate.formatted(date: .long, time: .omitted))
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextPrimary"))

                    Spacer()
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("BorderLight"), lineWidth: 1)
        )
    }
}

struct ConfettiView: View {
    @State private var confettiPieces: [ConfettiPiece] = []

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(confettiPieces) { piece in
                    ConfettiShape(piece: piece)
                }
            }
            .onAppear {
                generateConfetti(in: geometry.size)
            }
        }
    }

    func generateConfetti(in size: CGSize) {
        let colors: [Color] = [
            Color("PrimaryTeal"),
            Color("SecondaryOrange"),
            Color("SuccessGreen"),
            Color("WarningYellow")
        ]

        for i in 0..<50 {
            let piece = ConfettiPiece(
                id: i,
                color: colors.randomElement()!,
                x: CGFloat.random(in: 0...size.width),
                y: -20,
                rotation: Double.random(in: 0...360),
                speed: CGFloat.random(in: 2...5)
            )
            confettiPieces.append(piece)
        }

        // Animate falling
        withAnimation(.linear(duration: 3.0)) {
            for i in 0..<confettiPieces.count {
                confettiPieces[i].y = size.height + 20
                confettiPieces[i].rotation += Double.random(in: 360...720)
            }
        }
    }
}

struct ConfettiPiece: Identifiable {
    let id: Int
    let color: Color
    var x: CGFloat
    var y: CGFloat
    var rotation: Double
    let speed: CGFloat
}

struct ConfettiShape: View {
    let piece: ConfettiPiece

    var body: some View {
        Rectangle()
            .fill(piece.color)
            .frame(width: 10, height: 10)
            .rotationEffect(.degrees(piece.rotation))
            .position(x: piece.x, y: piece.y)
    }
}

struct SubmittedReview {
    let reviewId: String
    let bookingId: String
    let providerId: String
    let providerName: String
    let serviceName: String
    let overallRating: Int
    let submittedDate: Date
    let reviewURL: URL
}
```

## Interactions

### On Load
1. **Success Animation**:
   - Checkmark scales from 0.5 to 1.0 with spring animation (0.6s)
   - Fade-in from 0 to 1.0 opacity
   - Haptic success feedback

2. **Confetti** (for ratings 4+):
   - 50 confetti pieces fall from top (3s animation)
   - Random colors (Teal, Orange, Green, Yellow)
   - Random rotation and speeds

3. **Auto-Dismiss** (optional):
   - 3-second countdown timer
   - Small countdown indicator (top-right)
   - "Tap anywhere to stay" hint
   - Cancels on any user interaction

### Button Actions
1. **Share Review**:
   - Opens native share sheet
   - Pre-filled text: "I just reviewed [Provider] on UrbanNest! ⭐ [Rating]/5"
   - Includes review URL for web viewing
   - Options: Messages, Twitter, Facebook, Copy Link

2. **View My Review**:
   - Navigates to Screen 41 (Provider Reviews List)
   - Scrolls to user's review
   - Highlights review with subtle background color (3s)
   - Dismisses current sheet

3. **Book Again**:
   - Navigates to service detail for same provider
   - Pre-fills form with previous booking data
   - Dismisses current sheet

4. **Return to Home**:
   - Dismisses review submitted screen
   - Navigates to home screen (root)
   - Clears navigation stack

### Gestures
- **Swipe Down**: Dismiss sheet (iOS only)
- **Tap Outside**: No action (modal)

## States

### Default State
```swift
// Standard success display
ReviewSubmittedView(review: submittedReview)
```

### High Rating State (4-5 stars)
```swift
// With confetti animation
ReviewSubmittedView(review: highRatingReview)
    .onAppear {
        showConfetti = true
    }
```

### Low Rating State (1-3 stars)
```swift
// No confetti, different messaging
ReviewSubmittedView(review: lowRatingReview)
    .onAppear {
        // Could show "Thank you for your feedback" instead
    }
```

## API Integration

### Review Submission Confirmation
```
GET /reviews/{reviewId}/confirmation

Response:
{
  "success": true,
  "data": {
    "reviewId": "rev_123",
    "bookingId": "bkg_456",
    "providerId": "prv_789",
    "providerName": "John Doe",
    "serviceName": "Electrician",
    "overallRating": 5,
    "submittedDate": "2025-12-31T10:30:00Z",
    "reviewURL": "https://urbannest.com/reviews/rev_123",
    "earnedRewardPoints": 50
  }
}
```

### Share Review Link
```
POST /reviews/{reviewId}/share-link

Response:
{
  "success": true,
  "data": {
    "shareURL": "https://urbannest.com/share/review/rev_123",
    "shareText": "I just reviewed John Doe on UrbanNest! ⭐ 5/5",
    "ogImage": "https://cdn.urbannest.com/og/rev_123.jpg"
  }
}
```

## Navigation

### Entry Point
- **From Screen 40** (Write Review): After successful review submission
- Presented as full-screen modal

### Exit Points
- **View My Review**: Navigate to Screen 41 (Provider Reviews List) with highlight
- **Book Again**: Navigate to Screen 07 (Service Detail) for same provider
- **Return to Home**: Navigate to Screen 03 (Home)
- **Swipe Down**: Dismiss sheet (returns to previous screen)

### Navigation Flow
```
Screen 40 (Write Review)
    ↓ [Submit Review]
Screen 42 (Review Submitted) ← YOU ARE HERE
    ↓ [View My Review]
Screen 41 (Provider Reviews List)

OR

Screen 42
    ↓ [Book Again]
Screen 07 (Service Detail)

OR

Screen 42
    ↓ [Return to Home]
Screen 03 (Home)
```

## Accessibility

### VoiceOver Labels
```swift
.accessibilityLabel("Review submitted successfully")
.accessibilityHint("Your \(review.overallRating) star review for \(review.providerName) has been posted")
```

### Reduced Motion
```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

// Skip confetti if reduce motion enabled
if !reduceMotion && review.overallRating >= 4 {
    showConfetti = true
}
```

### Focus Management
- Focus moves to "Thank You!" heading on appear
- Logical tab order: Heading → Summary → Share → View → Book → Home

### Color Contrast
- Success green checkmark: #10B981 on white background (4.5:1) ✅
- Button text: meets WCAG AA standards

## Analytics Events

### Screen View
```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "review_submitted",
    "review_id": reviewId,
    "provider_id": providerId,
    "rating": overallRating
])
```

### Share Review
```swift
Analytics.logEvent("review_shared", parameters: [
    "review_id": reviewId,
    "provider_id": providerId,
    "rating": overallRating,
    "share_method": shareMethod // "messages", "twitter", etc.
])
```

### View Review Tapped
```swift
Analytics.logEvent("review_view_tapped", parameters: [
    "review_id": reviewId,
    "provider_id": providerId
])
```

### Book Again Tapped
```swift
Analytics.logEvent("review_rebook_tapped", parameters: [
    "review_id": reviewId,
    "provider_id": providerId,
    "service_id": serviceId
])
```

### Return Home Tapped
```swift
Analytics.logEvent("review_return_home", parameters: [
    "review_id": reviewId,
    "time_spent": timeSpentOnScreen
])
```

## Testing Checklist

- [ ] Success animation plays smoothly
- [ ] Checkmark scales and fades in correctly
- [ ] Confetti appears for ratings 4-5 only
- [ ] Confetti does not appear for ratings 1-3
- [ ] Haptic feedback triggers on appear
- [ ] Review summary displays correct data
- [ ] Star rating matches submitted rating
- [ ] Share button opens native share sheet
- [ ] Share text pre-fills correctly
- [ ] View My Review navigates to reviews list
- [ ] User's review is highlighted in list
- [ ] Book Again navigates to service detail
- [ ] Return Home navigates to home screen
- [ ] Swipe down gesture dismisses (iOS)
- [ ] Auto-dismiss timer works (if enabled)
- [ ] Reduced motion skips animations
- [ ] VoiceOver announces success correctly
- [ ] All buttons have proper touch targets (44pt)
- [ ] Screen works in portrait and landscape
- [ ] Deep linking handles review URL correctly

## Design Notes

### Platform-Specific Considerations

**iOS**:
- Native share sheet (`UIActivityViewController`)
- Swipe-down gesture to dismiss
- Haptic success feedback (`UINotificationFeedbackGenerator`)
- Confetti with SF Symbols or custom shapes
- Use `.interactiveDismissDisabled(false)` for sheet

**Android**:
- Share Intent for sharing
- Back button dismisses
- Material ripple effects on buttons
- Confetti with Canvas drawing
- Use Material Motion for animations

**Web**:
- Web Share API (if available) or custom modal
- Browser-native share on mobile
- CSS animations for confetti
- Keyboard navigation (Tab, Enter)
- Close button in header

### Animation Specifications
- **Checkmark Scale**: 0.5 → 1.0, spring (response: 0.6, damping: 0.7)
- **Checkmark Fade**: 0.0 → 1.0, ease-in-out (0.4s)
- **Confetti Duration**: 3.0s linear fall
- **Confetti Count**: 50 pieces
- **Confetti Colors**: Teal, Orange, Green, Yellow (random)

### Copy Variations by Rating

**5 Stars**:
- Heading: "Thank You!"
- Message: "Your review has been submitted successfully"
- Tip: "Your review helps others make informed decisions!"

**4 Stars**:
- Same as 5 stars

**3 Stars or Below**:
- Heading: "Thank You for Your Feedback"
- Message: "We appreciate your honest review"
- Tip: "Your feedback helps providers improve their service"

### Reward Points (Future)
If gamification is added:
```swift
HStack(spacing: 6) {
    Image(systemName: "star.circle.fill")
        .foregroundColor(Color("SecondaryOrange"))
    Text("You earned 50 reward points!")
        .font(.custom("Inter-Medium", size: 13))
}
.padding(.horizontal, 16)
.padding(.vertical, 8)
.background(Color("SecondaryOrange").opacity(0.1))
.cornerRadius(8)
```

### Edge Cases
- Handle network failure gracefully (retry option)
- Show skeleton if review data not loaded
- Handle dismissed provider account (show generic message)
- Prevent double-submission if user navigates back

### Future Enhancements
- Reward points display (+50 points for review)
- Achievement unlocked (e.g., "First Review!")
- Social media auto-post option (with permission)
- Review streak tracking ("5 reviews this month!")
- Provider response notification setup

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web

---

**🎉 Customer App - Group 2 Complete! (Screens 40-42)**
