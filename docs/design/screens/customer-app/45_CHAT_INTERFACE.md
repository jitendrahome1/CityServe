# Screen 45: Chat Interface

## Overview

- **Screen ID**: 45
- **Screen Name**: Chat Interface
- **User Role**: Customer
- **Platform**: iOS, Android, Web
- **Navigation**:
  - From: Screen 43 (Help Center) → Tap "Chat" quick action
  - From: Screen 44 (Contact Support) → Escalate to live chat
  - From: Any screen → Floating chat button (if available)

## ASCII Wireframe

```
┌─────────────────────────────────────────┐
│  ← Support Chat              ⋮          │ Header
│     🟢 Online • Avg wait: 2 mins        │ Status
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │  Support Team                   │   │ Agent Card
│  │  👤 Sarah from Support          │   │
│  │  🟢 Active now                  │   │
│  └─────────────────────────────────┘   │
│                                         │
│                                         │ Chat Area
│  ┌────────────────────────────┐        │
│  │ Hi! How can I help you?    │        │ Agent Message
│  │ 10:30 AM                   │        │
│  └────────────────────────────┘        │
│                                         │
│              ┌─────────────────────┐   │
│              │ I need help with    │   │ User Message
│              │ my booking          │   │
│              │ 10:31 AM         ✓✓ │   │
│              └─────────────────────┘   │
│                                         │
│  ┌────────────────────────────┐        │
│  │ Sure! Can you share your   │        │
│  │ booking ID?                │        │
│  │ 10:31 AM                   │        │
│  └────────────────────────────┘        │
│                                         │
│              ┌─────────────────────┐   │
│              │ #BKG123             │   │
│              │ 10:32 AM         ✓✓ │   │
│              └─────────────────────┘   │
│                                         │
│  ┌────────────────────────────┐        │
│  │ 👍 Got it! Let me check... │        │
│  │ ⏳ Sarah is typing...       │        │ Typing Indicator
│  └────────────────────────────┘        │
│                                         │
│                                         │
│  ───── Quick Replies ─────              │
│  [My booking]  [Refund]  [Help]         │ Suggestions
│                                         │
├─────────────────────────────────────────┤
│  ┌───┬─────────────────────────┬───┐   │ Input Bar
│  │ + │ Type your message...    │ →  │   │
│  └───┴─────────────────────────┴───┘   │
└─────────────────────────────────────────┘
```

## Key Features

### 1. Chat Header
- Agent name and photo
- Online/offline status indicator (🟢 Online / 🔴 Offline)
- Average wait time
- Menu (⋮) for options:
  - Email transcript
  - End chat
  - Report issue

### 2. Message Display
- **Agent Messages**: Left-aligned, gray background
- **User Messages**: Right-aligned, teal background
- Timestamp for each message
- Read receipts (✓ Sent, ✓✓ Read)
- Message grouping by sender
- Auto-scroll to latest message

### 3. Typing Indicator
- "Sarah is typing..." with animated dots
- Shows when agent is composing message
- Real-time WebSocket update

### 4. Quick Replies (Suggested Actions)
- Context-aware suggestions
- Common responses: "My booking", "Refund", "Cancel", "Payment issue"
- Tap to send instantly
- Dynamic based on conversation

### 5. Message Input
- **Attachment Button (+)**: Upload photos, documents
- **Text Input**: Multi-line support, auto-expand
- **Send Button (→)**: Enabled when text entered
- Character limit: 2000 chars

### 6. Rich Message Types
- Text messages
- Images (with preview)
- Documents (PDF, etc.)
- Links (auto-detected, clickable)
- System messages (Chat started, Agent joined, Chat ended)

### 7. Chat History
- Load previous messages on scroll up
- Date separators (e.g., "Today", "Yesterday", "Dec 30")
- Infinite scroll pagination

### 8. Connection Status
- Auto-reconnect on network loss
- "Reconnecting..." banner
- "Connected" confirmation

## Component Breakdown

```swift
struct ChatInterfaceView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var messageText = ""
    @State private var showAttachmentPicker = false
    @FocusState private var isInputFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            // Header
            ChatHeader(
                agent: viewModel.currentAgent,
                status: viewModel.connectionStatus,
                onMenuTap: { viewModel.showMenu.toggle() }
            )

            // Messages List
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        // Load More Indicator
                        if viewModel.hasMoreMessages {
                            ProgressView()
                                .padding()
                                .onAppear {
                                    viewModel.loadMoreMessages()
                                }
                        }

                        // Messages
                        ForEach(viewModel.messages) { message in
                            MessageBubble(
                                message: message,
                                isFromCurrentUser: message.senderId == viewModel.userId
                            )
                            .id(message.id)
                        }

                        // Typing Indicator
                        if viewModel.isAgentTyping {
                            TypingIndicator(agentName: viewModel.currentAgent.name)
                        }
                    }
                    .padding(16)
                }
                .onChange(of: viewModel.messages.count) { _ in
                    if let lastMessage = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }

            // Quick Replies
            if !viewModel.quickReplies.isEmpty {
                QuickRepliesBar(
                    replies: viewModel.quickReplies,
                    onSelect: { reply in
                        viewModel.sendMessage(text: reply)
                    }
                )
            }

            // Input Bar
            MessageInputBar(
                text: $messageText,
                isFocused: $isInputFocused,
                onAttachment: {
                    showAttachmentPicker = true
                },
                onSend: {
                    if !messageText.isEmpty {
                        viewModel.sendMessage(text: messageText)
                        messageText = ""
                    }
                }
            )
        }
        .navigationTitle("Support Chat")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.showMenu.toggle() }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(Color("TextPrimary"))
                }
            }
        }
        .actionSheet(isPresented: $viewModel.showMenu) {
            ActionSheet(
                title: Text("Chat Options"),
                buttons: [
                    .default(Text("Email Transcript")) {
                        viewModel.emailTranscript()
                    },
                    .default(Text("Share Chat")) {
                        viewModel.shareChat()
                    },
                    .destructive(Text("End Chat")) {
                        viewModel.endChat()
                    },
                    .cancel()
                ]
            )
        }
        .sheet(isPresented: $showAttachmentPicker) {
            ImagePicker(selectedImages: $viewModel.attachmentsToSend, maxSelection: 5)
        }
        .onAppear {
            viewModel.connectToChat()
        }
        .onDisappear {
            viewModel.disconnectFromChat()
        }
    }
}

struct ChatHeader: View {
    let agent: Agent?
    let status: ConnectionStatus
    let onMenuTap: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                // Agent Avatar
                if let agent = agent {
                    AsyncImage(url: URL(string: agent.photoURL ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Circle()
                            .fill(Color("BackgroundSecondary"))
                            .overlay(
                                Image(systemName: "person.fill")
                                    .foregroundColor(Color("TextTertiary"))
                            )
                    }
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        Text(agent.name)
                            .font(.custom("Inter-SemiBold", size: 15))
                            .foregroundColor(Color("TextPrimary"))

                        HStack(spacing: 4) {
                            Circle()
                                .fill(agent.isOnline ? Color("SuccessGreen") : Color("TextTertiary"))
                                .frame(width: 8, height: 8)

                            Text(status.displayText)
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("TextSecondary"))
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Support Team")
                            .font(.custom("Inter-SemiBold", size: 15))
                            .foregroundColor(Color("TextPrimary"))

                        Text("Connecting...")
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("TextSecondary"))
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)

            Divider()
        }
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    let isFromCurrentUser: Bool

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if isFromCurrentUser {
                Spacer(minLength: 60)
            }

            VStack(alignment: isFromCurrentUser ? .trailing : .leading, spacing: 4) {
                // Message Content
                Group {
                    switch message.type {
                    case .text:
                        TextMessageContent(text: message.text, isFromCurrentUser: isFromCurrentUser)

                    case .image:
                        ImageMessageContent(imageURL: message.imageURL)

                    case .system:
                        SystemMessageContent(text: message.text)
                    }
                }

                // Timestamp & Status
                HStack(spacing: 4) {
                    Text(message.timestamp.formatted(date: .omitted, time: .shortened))
                        .font(.custom("Inter-Regular", size: 11))
                        .foregroundColor(Color("TextTertiary"))

                    if isFromCurrentUser {
                        Image(systemName: message.isRead ? "checkmark.circle.fill" : "checkmark.circle")
                            .font(.system(size: 10))
                            .foregroundColor(message.isRead ? Color("PrimaryTeal") : Color("TextTertiary"))
                    }
                }
            }

            if !isFromCurrentUser {
                Spacer(minLength: 60)
            }
        }
    }
}

struct TextMessageContent: View {
    let text: String
    let isFromCurrentUser: Bool

    var body: some View {
        Text(text)
            .font(.custom("Inter-Regular", size: 15))
            .foregroundColor(isFromCurrentUser ? .white : Color("TextPrimary"))
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(isFromCurrentUser ? Color("PrimaryTeal") : Color("BackgroundSecondary"))
            .cornerRadius(16, corners: isFromCurrentUser ?
                [.topLeft, .topRight, .bottomLeft] :
                [.topLeft, .topRight, .bottomRight])
    }
}

struct ImageMessageContent: View {
    let imageURL: String?

    var body: some View {
        if let url = imageURL {
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color("BackgroundSecondary"))
                    .overlay(
                        ProgressView()
                    )
            }
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct SystemMessageContent: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.custom("Inter-Regular", size: 12))
            .foregroundColor(Color("TextTertiary"))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color("BackgroundSecondary").opacity(0.5))
            .cornerRadius(12)
            .frame(maxWidth: .infinity)
    }
}

struct TypingIndicator: View {
    let agentName: String
    @State private var animatingDots = false

    var body: some View {
        HStack(spacing: 8) {
            Text("\(agentName) is typing")
                .font(.custom("Inter-Regular", size: 13))
                .foregroundColor(Color("TextSecondary"))

            HStack(spacing: 3) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color("TextTertiary"))
                        .frame(width: 6, height: 6)
                        .opacity(animatingDots ? 1.0 : 0.3)
                        .animation(
                            Animation.easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                            value: animatingDots
                        )
                }
            }
        }
        .onAppear {
            animatingDots = true
        }
    }
}

struct QuickRepliesBar: View {
    let replies: [String]
    let onSelect: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(replies, id: \.self) { reply in
                    Button(action: { onSelect(reply) }) {
                        Text(reply)
                            .font(.custom("Inter-Medium", size: 13))
                            .foregroundColor(Color("PrimaryTeal"))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color("PrimaryTeal").opacity(0.1))
                            .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .background(Color.white)
        .overlay(
            Divider(),
            alignment: .top
        )
    }
}

struct MessageInputBar: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    let onAttachment: () -> Void
    let onSend: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            // Attachment Button
            Button(action: onAttachment) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(Color("PrimaryTeal"))
            }

            // Text Input
            TextField("Type your message...", text: $text, axis: .vertical)
                .font(.custom("Inter-Regular", size: 15))
                .foregroundColor(Color("TextPrimary"))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color("BackgroundSecondary"))
                .cornerRadius(20)
                .lineLimit(1...5)
                .focused(isFocused)

            // Send Button
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(text.isEmpty ? Color("TextTertiary") : Color("PrimaryTeal"))
            }
            .disabled(text.isEmpty)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white)
        .overlay(
            Divider(),
            alignment: .top
        )
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let senderId: String
    let text: String
    let timestamp: Date
    let type: MessageType
    var isRead: Bool
    let imageURL: String?

    enum MessageType {
        case text
        case image
        case system
    }
}

struct Agent: Identifiable {
    let id = UUID()
    let name: String
    let photoURL: String?
    let isOnline: Bool
}

enum ConnectionStatus {
    case connecting
    case connected
    case disconnected
    case reconnecting

    var displayText: String {
        switch self {
        case .connecting: return "Connecting..."
        case .connected: return "Online • Avg wait: 2 mins"
        case .disconnected: return "Offline"
        case .reconnecting: return "Reconnecting..."
        }
    }
}

// Custom corner radius modifier
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
```

## Interactions

### Sending Messages
1. **Type Message**: Input expands up to 5 lines
2. **Tap Send**: Message sent, appears in chat with "Sent" checkmark
3. **Delivery**: Checkmark updates to "Read" when agent reads
4. **Quick Reply**: Tap suggestion chip to send instantly

### Attachments
1. **Tap + Button**: Opens image/file picker
2. **Select Image**: Shows thumbnail in chat
3. **Send**: Image uploaded and sent

### Scrolling
1. **Scroll Up**: Load more history (pagination)
2. **Auto-scroll**: Jumps to latest message on new message received
3. **Manual Scroll**: Doesn't auto-scroll if user is reading history

### Connection Handling
1. **Network Loss**: Shows "Reconnecting..." banner
2. **Reconnected**: Banner disappears, shows "Connected"
3. **Failed to Reconnect**: Shows retry button

### Chat Options (Menu)
1. **Email Transcript**: Sends chat history to user's email
2. **Share Chat**: Native share sheet with chat text
3. **End Chat**: Confirmation dialog, then closes chat

## States

### Connecting State
```swift
struct ConnectingChatView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)

            Text("Connecting to support...")
                .font(.custom("Inter-Medium", size: 15))
                .foregroundColor(Color("TextSecondary"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
```

### Empty State (No Messages)
```swift
struct EmptyChatView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "message.fill")
                .font(.system(size: 60))
                .foregroundColor(Color("TextTertiary"))

            Text("Chat with Support")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(Color("TextPrimary"))

            Text("We're here to help! Send a message to get started.")
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextSecondary"))
                .multilineTextAlignment(.center)
        }
        .padding(48)
    }
}
```

### Disconnected State
```swift
struct DisconnectedChatView: View {
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 50))
                .foregroundColor(Color("ErrorRed"))

            Text("Connection Lost")
                .font(.custom("Inter-SemiBold", size: 16))
                .foregroundColor(Color("TextPrimary"))

            Text("Check your internet connection and try again")
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

### Chat Ended State
```swift
struct ChatEndedView: View {
    let onNewChat: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(Color("SuccessGreen"))

            Text("Chat Ended")
                .font(.custom("Inter-SemiBold", size: 18))
                .foregroundColor(Color("TextPrimary"))

            Text("Thank you for contacting support. We hope we resolved your issue!")
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Color("TextSecondary"))
                .multilineTextAlignment(.center)

            Button("Start New Chat") {
                onNewChat()
            }
            .font(.custom("Inter-SemiBold", size: 14))
            .foregroundColor(Color("PrimaryTeal"))
        }
        .padding(48)
    }
}
```

## API Integration

### WebSocket Connection
```
WS: wss://api.urbannest.com/chat

// Connect
{
  "action": "connect",
  "customerId": "cust_123",
  "sessionToken": "token_abc"
}

// Send Message
{
  "action": "sendMessage",
  "chatId": "chat_456",
  "text": "I need help with my booking",
  "timestamp": "2025-12-31T10:30:00Z"
}

// Receive Message
{
  "action": "receiveMessage",
  "messageId": "msg_789",
  "senderId": "agent_012",
  "senderName": "Sarah",
  "text": "Sure! Can you share your booking ID?",
  "timestamp": "2025-12-31T10:31:00Z"
}

// Typing Indicator
{
  "action": "typing",
  "chatId": "chat_456",
  "isTyping": true,
  "userId": "agent_012"
}

// Read Receipt
{
  "action": "markRead",
  "messageId": "msg_789"
}
```

### HTTP Endpoints (Fallback)

#### Start Chat Session
```
POST /chat/sessions

Request:
{
  "customerId": "cust_123",
  "initialMessage": "I need help"
}

Response:
{
  "success": true,
  "data": {
    "chatId": "chat_456",
    "sessionToken": "token_abc",
    "agent": {
      "id": "agent_012",
      "name": "Sarah",
      "photoURL": "https://...",
      "isOnline": true
    },
    "estimatedWaitTime": "2 mins"
  }
}
```

#### Get Chat History
```
GET /chat/sessions/{chatId}/messages?limit=50&before={messageId}

Response:
{
  "success": true,
  "data": {
    "messages": [
      {
        "id": "msg_001",
        "senderId": "agent_012",
        "text": "Hi! How can I help you?",
        "timestamp": "2025-12-31T10:30:00Z",
        "isRead": true
      }
    ],
    "hasMore": true
  }
}
```

#### End Chat Session
```
POST /chat/sessions/{chatId}/end

Response:
{
  "success": true,
  "data": {
    "transcript": "https://storage.../transcript_chat456.txt",
    "duration": 900, // seconds
    "messagesCount": 15
  }
}
```

## Navigation

### Entry Points
- **From Screen 43** (Help Center): Tap "Chat" button
- **From Screen 44** (Contact Support): Escalate to live chat
- **Floating Chat Button**: Global accessibility (if available)
- **Deep Link**: `urbannest://chat`

### Exit Points
- **Back Button**: Minimizes chat (continues in background)
- **End Chat**: Confirmation → Close chat session
- **Swipe Down**: Minimize (iOS)

## Accessibility

### VoiceOver
```swift
.accessibilityLabel("Message from \(message.senderName)")
.accessibilityValue(message.text)
.accessibilityHint("Double tap to copy message")

.accessibilityLabel("Send message button")
.accessibilityHint(text.isEmpty ? "Enter a message first" : "Double tap to send message")
```

### Touch Targets
- Send button: 44x44pt
- Attachment button: 44x44pt
- Quick reply chips: 32pt height (acceptable for secondary action)

### Dynamic Type
- All message text scales
- Bubbles expand vertically
- Input field adjusts height

## Analytics Events

### Chat Started
```swift
Analytics.logEvent("chat_started", parameters: [
    "source": "help_center",
    "initial_message": initialMessage
])
```

### Message Sent
```swift
Analytics.logEvent("chat_message_sent", parameters: [
    "chat_id": chatId,
    "message_length": messageText.count,
    "has_attachment": !attachments.isEmpty
])
```

### Chat Ended
```swift
Analytics.logEvent("chat_ended", parameters: [
    "chat_id": chatId,
    "duration": sessionDuration,
    "messages_count": messagesCount,
    "ended_by": "customer" // or "agent"
])
```

## Testing Checklist

- [ ] WebSocket connects successfully
- [ ] Messages send and receive in real-time
- [ ] Typing indicator appears when agent types
- [ ] Read receipts update correctly
- [ ] Auto-scroll to latest message works
- [ ] Manual scroll stops auto-scroll
- [ ] Load more messages on scroll up
- [ ] Quick replies send messages instantly
- [ ] Attachment picker opens
- [ ] Images display in chat
- [ ] Connection lost banner appears on network loss
- [ ] Auto-reconnect works after network restored
- [ ] End chat confirmation works
- [ ] Chat transcript emails correctly
- [ ] VoiceOver announces messages
- [ ] Keyboard doesn't cover input field
- [ ] Multi-line input expands correctly
- [ ] Send button disabled when empty

## Design Notes

### Platform-Specific Considerations

**iOS**:
- Native WebSocket (URLSessionWebSocketTask)
- Keyboard avoidance with `.ignoresSafeArea(.keyboard)`
- Haptic feedback on message sent
- Native share sheet for transcript

**Android**:
- OkHttp WebSocket
- Keyboard handling with manifest
- Material ripples on bubbles
- Share Intent for transcript

**Web**:
- Browser WebSocket API
- Auto-scroll with smooth behavior
- Copy message on right-click
- Desktop notification for new messages

### Real-Time Updates
- WebSocket for instant messaging
- Fallback to long-polling if WebSocket fails
- Local message queue (retry failed sends)
- Optimistic UI updates (show message immediately, update on confirmation)

### Performance
- Virtualized list for large chat histories
- Image compression before upload
- Lazy load old messages (pagination)
- Cache messages locally (offline access)

### Edge Cases
- Handle agent reassignment mid-chat
- Show "Agent left, new agent joined" system message
- Handle duplicate messages (deduplication by message ID)
- Queue messages during disconnection, send when reconnected

### Future Enhancements
- Voice messages
- Video calls
- File attachments (PDF, docs)
- Chatbot (AI-powered) before human handoff
- Canned responses for common questions
- Rich cards (booking summary, payment link)
- Multi-language support
- Emoji picker

---

**Design Status**: ✅ Complete
**Last Updated**: December 31, 2025
**Version**: 1.0
**Platforms**: iOS, Android, Web

---

**🎉 Customer App - Group 3 Complete! (Screens 43-45)**
