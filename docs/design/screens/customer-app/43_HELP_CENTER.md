# Screen 43: Help Center

## Overview

- **Screen ID**: 43
- **Screen Name**: Help Center
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 21 (Profile Dashboard) → Tap "Help & Support"
  - From: Bottom navigation → "More" tab → "Help Center"
  - From: Any screen → "Help" button in navigation bar

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  Help Center                        ⚙️  │ Header
├─────────────────────────────────────────┤
│                                         │
│  ┌────────────────────────────────┐    │
│  │ 🔍 How can we help you?        │    │ Search Bar
│  └────────────────────────────────┘    │
│                                         │
│  ───── Quick Actions ─────              │
│                                         │
│  ┌──────┬──────┬──────┬──────┐         │
│  │ 📞   │ 💬   │ 📧   │ ❓   │         │ Quick Icons
│  │ Call │ Chat │ Email│ FAQ  │         │
│  └──────┴──────┴──────┴──────┘         │
│                                         │
│  ───── Popular Topics ─────             │
│                                         │
│  📖 Booking & Payments                  │ Topic Card
│     5 articles                          │
│                                      →  │
│                                         │
│  🔧 Service Issues & Complaints         │
│     8 articles                          │
│                                      →  │
│                                         │
│  👤 Account & Profile                   │
│     6 articles                          │
│                                      →  │
│                                         │
│  ⭐ Reviews & Ratings                   │
│     4 articles                          │
│                                      →  │
│                                         │
│  💰 Refunds & Cancellations             │
│     7 articles                          │
│                                      →  │
│                                         │
│  🔒 Safety & Privacy                    │
│     5 articles                          │
│                                      →  │
│                                         │
│  ───── Frequently Asked ─────           │
│                                         │
│  ❓ How do I book a service?            │ FAQ Item
│                                      ▼  │
│                                         │
│  ❓ How do I track my booking?          │
│                                      ▼  │
│                                         │
│  ❓ Can I cancel after booking?         │
│                                      ▼  │
│                                         │
│  ❓ How do I get a refund?              │
│                                      ▼  │
│                                         │
│  ❓ How do I change my address?         │
│                                      ▼  │
│                                         │
│  [View All FAQs]                        │
│                                         │
│  ───── Need More Help? ─────            │
│                                         │
│  Still can't find what you're           │
│  looking for?                           │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │     💬 Contact Support           │   │ CTA Button
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │     📞 Call: 1800-XXX-XXXX       │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ───── App Info ─────                   │
│                                         │
│  App Version: 1.2.3                     │
│  Terms of Service  |  Privacy Policy   │
│                                         │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Search Bar
- Search help articles and FAQs
- Auto-suggestions as you type
- Recent searches history
- Popular search terms

### 2. Quick Actions
- **Call Support**: Direct call to helpline (1800-XXX-XXXX)
- **Chat**: Open live chat support (Screen 45)
- **Email**: Compose email to support
- **FAQ**: Jump to FAQ section

### 3. Popular Topics (Categories)
- Booking & Payments
- Service Issues & Complaints
- Account & Profile
- Reviews & Ratings
- Refunds & Cancellations
- Safety & Privacy
- Article count per category
- Tap to view articles

### 4. Frequently Asked Questions
- Expandable/collapsible FAQ items
- Top 5 most common questions
- Clear, concise answers
- "Was this helpful?" feedback
- "View All FAQs" for complete list

### 5. Contact Support CTA
- Prominent button for direct support
- Phone number always visible
- Email support option
- Operating hours display

### 6. App Info Footer
- App version number
- Links to Terms & Privacy Policy
- Build number (for debugging)

## Component Breakdown

```swift
struct HelpCenterView: View {
    @StateObject private var viewModel = HelpCenterViewModel()
    @State private var searchText = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("TextTertiary"))

                    TextField("How can we help you?", text: $searchText)
                        .font(.custom("Inter-Regular", size: 15))
                        .foregroundColor(Color("TextPrimary"))
                        .onChange(of: searchText) { newValue in
                            viewModel.searchArticles(query: newValue)
                        }

                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color("TextTertiary"))
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color("BackgroundSecondary"))
                .cornerRadius(10)
                .padding(.horizontal, 16)

                // Quick Actions
                HStack(spacing: 16) {
                    QuickActionButton(
                        icon: "phone.fill",
                        title: "Call",
                        color: Color("SuccessGreen"),
                        action: { viewModel.callSupport() }
                    )

                    QuickActionButton(
                        icon: "message.fill",
                        title: "Chat",
                        color: Color("PrimaryTeal"),
                        action: { viewModel.openChat() }
                    )

                    QuickActionButton(
                        icon: "envelope.fill",
                        title: "Email",
                        color: Color("SecondaryOrange"),
                        action: { viewModel.emailSupport() }
                    )

                    QuickActionButton(
                        icon: "questionmark.circle.fill",
                        title: "FAQ",
                        color: Color("TextSecondary"),
                        action: { viewModel.scrollToFAQ() }
                    )
                }
                .padding(.horizontal, 16)

                Divider()
                    .padding(.horizontal, 16)

                // Popular Topics
                VStack(alignment: .leading, spacing: 12) {
                    Text("Popular Topics")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(Color("TextPrimary"))
                        .padding(.horizontal, 16)

                    ForEach(viewModel.popularTopics) { topic in
                        TopicCard(
                            topic: topic,
                            onTap: {
                                // Navigate to topic articles
                            }
                        )
                        .padding(.horizontal, 16)
                    }
                }

                Divider()
                    .padding(.horizontal, 16)

                // Frequently Asked Questions
                VStack(alignment: .leading, spacing: 12) {
                    Text("Frequently Asked")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(Color("TextPrimary"))
                        .padding(.horizontal, 16)

                    ForEach(viewModel.topFAQs) { faq in
                        FAQItem(
                            faq: faq,
                            isExpanded: viewModel.expandedFAQId == faq.id,
                            onTap: {
                                withAnimation {
                                    viewModel.toggleFAQ(faq.id)
                                }
                            },
                            onHelpful: { isHelpful in
                                viewModel.markFAQHelpful(faq.id, helpful: isHelpful)
                            }
                        )
                        .padding(.horizontal, 16)
                    }

                    Button(action: { viewModel.showAllFAQs() }) {
                        Text("View All FAQs")
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(Color("PrimaryTeal"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color("PrimaryTeal").opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 16)
                }

                Divider()
                    .padding(.horizontal, 16)

                // Need More Help Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Need More Help?")
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(Color("TextPrimary"))

                    Text("Still can't find what you're looking for?")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))

                    // Contact Support Button
                    Button(action: { viewModel.openContactSupport() }) {
                        HStack(spacing: 8) {
                            Image(systemName: "message.fill")
                                .font(.system(size: 16))
                            Text("Contact Support")
                                .font(.custom("Inter-SemiBold", size: 16))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color("PrimaryTeal"))
                        .cornerRadius(10)
                    }

                    // Call Button
                    Button(action: { viewModel.callSupport() }) {
                        HStack(spacing: 8) {
                            Image(systemName: "phone.fill")
                                .font(.system(size: 16))
                            Text("Call: 1800-XXX-XXXX")
                                .font(.custom("Inter-Medium", size: 15))
                        }
                        .foregroundColor(Color("PrimaryTeal"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("PrimaryTeal"), lineWidth: 1.5)
                        )
                    }

                    // Operating Hours
                    HStack(spacing: 6) {
                        Image(systemName: "clock")
                            .font(.system(size: 12))
                            .foregroundColor(Color("TextTertiary"))
                        Text("Mon-Sat: 9 AM - 9 PM | Sun: 10 AM - 6 PM")
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("TextTertiary"))
                    }
                }
                .padding(.horizontal, 16)

                Divider()
                    .padding(.horizontal, 16)

                // App Info
                VStack(spacing: 8) {
                    Text("App Version: \(viewModel.appVersion)")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("TextTertiary"))

                    HStack(spacing: 16) {
                        Button("Terms of Service") {
                            viewModel.openTerms()
                        }
                        .font(.custom("Inter-Medium", size: 12))
                        .foregroundColor(Color("PrimaryTeal"))

                        Text("|")
                            .foregroundColor(Color("TextTertiary"))

                        Button("Privacy Policy") {
                            viewModel.openPrivacy()
                        }
                        .font(.custom("Inter-Medium", size: 12))
                        .foregroundColor(Color("PrimaryTeal"))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
            }
            .padding(.vertical, 16)
        }
        .navigationTitle("Help Center")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.showSettings() }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color("TextPrimary"))
                }
            }
        }
        .sheet(isPresented: $viewModel.showingChat) {
            ChatInterfaceView() // Screen 45
        }
        .sheet(isPresented: $viewModel.showingContactForm) {
            ContactSupportView() // Screen 44
        }
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(color)
                    .frame(width: 56, height: 56)
                    .background(color.opacity(0.1))
                    .clipShape(Circle())

                Text(title)
                    .font(.custom("Inter-Medium", size: 12))
                    .foregroundColor(Color("TextPrimary"))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct TopicCard: View {
    let topic: HelpTopic
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Text(topic.icon)
                    .font(.system(size: 24))

                VStack(alignment: .leading, spacing: 4) {
                    Text(topic.title)
                        .font(.custom("Inter-SemiBold", size: 15))
                        .foregroundColor(Color("TextPrimary"))

                    Text("\(topic.articleCount) articles")
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color("TextSecondary"))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(Color("TextTertiary"))
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("BorderLight"), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FAQItem: View {
    let faq: FAQ
    let isExpanded: Bool
    let onTap: () -> Void
    let onHelpful: (Bool) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Question Button
            Button(action: onTap) {
                HStack(spacing: 12) {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 18))
                        .foregroundColor(Color("PrimaryTeal"))

                    Text(faq.question)
                        .font(.custom("Inter-Medium", size: 15))
                        .foregroundColor(Color("TextPrimary"))
                        .multilineTextAlignment(.leading)

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14))
                        .foregroundColor(Color("TextTertiary"))
                }
                .padding(.vertical, 14)
            }
            .buttonStyle(PlainButtonStyle())

            // Answer (Expandable)
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Text(faq.answer)
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("TextSecondary"))
                        .lineSpacing(4)
                        .padding(.bottom, 8)

                    // Was this helpful?
                    HStack(spacing: 8) {
                        Text("Was this helpful?")
                            .font(.custom("Inter-Regular", size: 13))
                            .foregroundColor(Color("TextSecondary"))

                        Button(action: { onHelpful(true) }) {
                            HStack(spacing: 4) {
                                Image(systemName: "hand.thumbsup.fill")
                                    .font(.system(size: 12))
                                Text("Yes")
                                    .font(.custom("Inter-Medium", size: 12))
                            }
                            .foregroundColor(faq.wasHelpful == true ? Color("SuccessGreen") : Color("TextTertiary"))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                faq.wasHelpful == true ?
                                    Color("SuccessGreen").opacity(0.1) :
                                    Color("BackgroundSecondary")
                            )
                            .cornerRadius(6)
                        }

                        Button(action: { onHelpful(false) }) {
                            HStack(spacing: 4) {
                                Image(systemName: "hand.thumbsdown.fill")
                                    .font(.system(size: 12))
                                Text("No")
                                    .font(.custom("Inter-Medium", size: 12))
                            }
                            .foregroundColor(faq.wasHelpful == false ? Color("ErrorRed") : Color("TextTertiary"))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(
                                faq.wasHelpful == false ?
                                    Color("ErrorRed").opacity(0.1) :
                                    Color("BackgroundSecondary")
                            )
                            .cornerRadius(6)
                        }
                    }
                }
                .padding(.bottom, 12)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }

            Divider()
        }
    }
}

struct HelpTopic: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let articleCount: Int
}

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    var wasHelpful: Bool?
}
```

## Interactions

### Search Bar
1. **Type in Search**: Auto-suggest results appear
2. **Tap Suggestion**: Navigate to article or FAQ
3. **Tap Clear (X)**: Clear search text
4. **Enter Key**: Submit search, show results page

### Quick Actions
1. **Tap Call**: Opens phone dialer with support number
2. **Tap Chat**: Opens live chat interface (Screen 45)
3. **Tap Email**: Opens email compose with support@urbannest.com
4. **Tap FAQ**: Smooth scroll to FAQ section

### Popular Topics
1. **Tap Topic Card**: Navigate to topic articles list
2. **Shows Article Count**: Display number of articles in category

### FAQ Items
1. **Tap Question**: Expands/collapses answer with animation
2. **Tap "Yes" (Helpful)**: Button highlights green, records feedback
3. **Tap "No" (Not Helpful)**: Button highlights red, shows "Contact Support" suggestion

### Contact Support
1. **Tap Contact Support Button**: Opens contact form (Screen 44)
2. **Tap Call Button**: Opens phone dialer
3. **Shows Operating Hours**: Real-time check (e.g., "Open Now" or "Closed")

### Footer Links
1. **Tap Terms of Service**: Opens web view with terms
2. **Tap Privacy Policy**: Opens web view with privacy policy

## States

### Default State
- Search bar empty
- Quick actions visible
- Popular topics loaded
- Top 5 FAQs displayed
- Contact support CTA visible

### Search Active State
```swift
struct SearchResultsView: View {
    let results: [HelpArticle]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(results.count) results found")
                .font(.custom("Inter-Medium", size: 14))
                .foregroundColor(Color("TextSecondary"))

            ForEach(results) { article in
                HelpArticleRow(article: article)
            }
        }
    }
}
```

### Empty Search State
```swift
struct NoSearchResultsView: View {
    let searchQuery: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(Color("TextTertiary"))

            Text("No results found for \"\(searchQuery)\"")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))

            Text("Try different keywords or contact support")
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextSecondary"))
                .multilineTextAlignment(.center)

            Button("Contact Support") {
                // Open contact support
            }
            .font(.custom("Inter-SemiBold", size: 14))
            .foregroundColor(Color("PrimaryTeal"))
        }
        .padding(32)
    }
}
```

### Loading State
```swift
struct HelpCenterLoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<5, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("BackgroundSecondary"))
                    .frame(height: 70)
                    .redacted(reason: .placeholder)
            }
        }
        .padding(16)
    }
}
```

### Error State
```swift
struct HelpCenterErrorView: View {
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(Color("ErrorRed"))

            Text("Failed to Load Help Center")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))

            Text("Please check your connection and try again")
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextSecondary"))
                .multilineTextAlignment(.center)

            Button("Retry") {
                onRetry()
            }
            .font(.custom("Inter-SemiBold", size: 14))
            .foregroundColor(.white)
            .frame(width: 120, height: 40)
            .background(Color("PrimaryTeal"))
            .cornerRadius(8)
        }
        .padding(48)
    }
}
```

## API Integration

### Get Help Center Data
```
GET /help/center

Response:
{
  "success": true,
  "data": {
    "popularTopics": [
      {
        "id": "topic_001",
        "title": "Booking & Payments",
        "icon": "📖",
        "articleCount": 5
      },
      {
        "id": "topic_002",
        "title": "Service Issues & Complaints",
        "icon": "🔧",
        "articleCount": 8
      }
    ],
    "topFAQs": [
      {
        "id": "faq_001",
        "question": "How do I book a service?",
        "answer": "To book a service, tap on the service you need from the home screen..."
      }
    ],
    "supportContact": {
      "phone": "1800-XXX-XXXX",
      "email": "support@urbannest.com",
      "operatingHours": "Mon-Sat: 9 AM - 9 PM | Sun: 10 AM - 6 PM",
      "isCurrentlyOpen": true
    },
    "appVersion": "1.2.3"
  }
}
```

### Search Help Articles
```
GET /help/search?q={query}

Response:
{
  "success": true,
  "data": {
    "query": "refund",
    "results": [
      {
        "id": "article_001",
        "title": "How to Request a Refund",
        "snippet": "To request a refund for a cancelled booking...",
        "category": "Refunds & Cancellations",
        "relevanceScore": 0.95
      }
    ],
    "totalResults": 3
  }
}
```

### Mark FAQ as Helpful
```
POST /help/faqs/{faqId}/feedback

Request:
{
  "customerId": "cust_123",
  "helpful": true
}

Response:
{
  "success": true,
  "message": "Thank you for your feedback!"
}
```

## Navigation

### Entry Points
- **From Screen 21** (Profile Dashboard): Tap "Help & Support"
- **From Bottom Navigation**: "More" → "Help Center"
- **From Any Screen**: Help button in nav bar
- **Deep Link**: `urbannest://help`

### Exit Points
- **Tap Topic**: Navigate to Topic Articles List
- **Tap FAQ "View All"**: Navigate to All FAQs List
- **Tap Contact Support**: Open Screen 44 (Contact Support)
- **Tap Chat**: Open Screen 45 (Chat Interface)
- **Tap Call**: Open phone dialer
- **Tap Email**: Open email compose

## Accessibility

### VoiceOver Labels
```swift
.accessibilityLabel("Help Center search")
.accessibilityHint("Search for help articles and FAQs")

.accessibilityLabel("Call support at 1800 XXX XXXX")
.accessibilityHint("Double tap to call customer support")
```

### Touch Targets
- Quick action buttons: 56x56pt (sufficient)
- Topic cards: Full width, 70pt height
- FAQ items: Full width, minimum 44pt height
- All buttons: 44x44pt minimum

### Dynamic Type
- All text scales with system font size
- Cards expand vertically with larger text
- Icons remain fixed size

### Color Contrast
- Topic card text: #1A1A1A on #FFFFFF (21:1) ✅
- FAQ text: #6B7280 on #FFFFFF (4.5:1) ✅
- Button text: meets WCAG AA standards

## Analytics Events

### Screen View
```swift
Analytics.logEvent("screen_view", parameters: [
    "screen_name": "help_center"
])
```

### Search Performed
```swift
Analytics.logEvent("help_search", parameters: [
    "search_query": searchQuery,
    "results_count": resultsCount
])
```

### Topic Tapped
```swift
Analytics.logEvent("help_topic_tapped", parameters: [
    "topic_id": topicId,
    "topic_name": topicName
])
```

### FAQ Expanded
```swift
Analytics.logEvent("faq_expanded", parameters: [
    "faq_id": faqId,
    "faq_question": faqQuestion
])
```

### FAQ Feedback
```swift
Analytics.logEvent("faq_feedback", parameters: [
    "faq_id": faqId,
    "helpful": isHelpful
])
```

### Contact Support Tapped
```swift
Analytics.logEvent("contact_support_tapped", parameters: [
    "source": "help_center",
    "method": "chat" // or "call", "email"
])
```

## Testing Checklist

- [ ] Search bar filters articles correctly
- [ ] Search suggestions appear as you type
- [ ] Clear button (X) clears search text
- [ ] Quick action buttons work (call, chat, email, FAQ)
- [ ] Call button opens phone dialer
- [ ] Chat button opens chat interface
- [ ] Email button composes email
- [ ] FAQ scroll works correctly
- [ ] Popular topics display article counts
- [ ] Tapping topic navigates to articles
- [ ] FAQ items expand/collapse with animation
- [ ] "Was this helpful?" buttons toggle correctly
- [ ] Cannot select both Yes and No simultaneously
- [ ] FAQ feedback records correctly
- [ ] "View All FAQs" navigates correctly
- [ ] Contact support button opens form
- [ ] Call support shows correct phone number
- [ ] Operating hours display correctly
- [ ] "Open Now" / "Closed" status accurate
- [ ] App version displays correctly
- [ ] Terms and Privacy links open correctly
- [ ] VoiceOver announces elements correctly
- [ ] All touch targets meet 44pt minimum
- [ ] Dynamic Type scales text properly
- [ ] Error state shows on API failure
- [ ] Loading state displays while fetching data

## Design Notes

### Platform-Specific Considerations

**iOS**:
- Native search bar with cancel button
- Native phone dialer integration
- Native mail composer
- Haptic feedback on quick action taps
- Pull-to-refresh to reload help center

**Android**:
- Material search bar
- Phone intent for dialing
- Email intent for composing
- Material ripple effects
- Swipe-to-refresh

**Web**:
- Custom search with debouncing
- Click-to-call link (tel:)
- Mailto link for email
- Keyboard navigation (Tab, Enter)
- Responsive grid for quick actions

### Search Optimization
- Debounce search input (300ms delay)
- Cache search results
- Show recent searches
- Highlight matching keywords in results
- Fuzzy matching for typos

### FAQ Behavior
- Only one FAQ expanded at a time (accordion)
- Smooth expand/collapse animation (0.3s ease-in-out)
- Auto-scroll to keep expanded FAQ visible
- Persist "helpful" feedback across sessions

### Edge Cases
- Handle empty search gracefully
- Show "No topics available" if API fails
- Handle phone number formatting (international)
- Show "Support offline" if outside operating hours
- Graceful degradation if chat is unavailable

### Future Enhancements
- Video tutorials embedded in articles
- Live status indicator for chat availability
- Community forum integration
- Chatbot for instant answers (AI-powered)
- Multi-language support
- Accessibility: Screen reader optimized articles
- Offline access to downloaded articles

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web
