//
//  ChatInterfaceView.swift
//  CityServe
//
//  Real-time Support Chat Interface
//

import SwiftUI

struct ChatInterfaceView: View {
    @StateObject private var viewModel = ChatViewModel()
    @Environment(\.dismiss) private var dismiss

    @State private var messageText = ""
    @State private var showAttachmentPicker = false
    @State private var showEndChatConfirmation = false
    @FocusState private var isInputFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Chat Header
                chatHeader

                // Messages Area
                messagesArea

                // Quick Replies
                if !viewModel.quickReplies.isEmpty && !viewModel.chatEnded {
                    quickRepliesBar
                }

                // Input Bar
                if !viewModel.chatEnded {
                    messageInputBar
                }
            }
            .navigationTitle("Support Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button {
                            viewModel.emailTranscript()
                        } label: {
                            Label("Email Transcript", systemImage: "envelope")
                        }

                        Button {
                            viewModel.shareChat()
                        } label: {
                            Label("Share Chat", systemImage: "square.and.arrow.up")
                        }

                        Button(role: .destructive) {
                            showEndChatConfirmation = true
                        } label: {
                            Label("End Chat", systemImage: "xmark.circle")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.textPrimary)
                    }
                }
            }
            .onAppear {
                viewModel.connectToChat()
            }
            .onDisappear {
                if !viewModel.chatEnded {
                    viewModel.disconnectFromChat()
                }
            }
            .confirmationDialog("End Chat?", isPresented: $showEndChatConfirmation) {
                Button("End Chat", role: .destructive) {
                    viewModel.endChat()
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to end this chat session?")
            }
        }
    }

    // MARK: - Chat Header

    private var chatHeader: some View {
        VStack(spacing: 0) {
            HStack(spacing: Spacing.sm) {
                // Agent Avatar
                if let agent = viewModel.currentAgent {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.primary, Color.primaryDark],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 36, height: 36)
                        .overlay(
                            Text(agent.name.prefix(1))
                                .font(.h5)
                                .foregroundColor(.white)
                        )

                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                        Text(agent.name)
                            .font(.h5)
                            .foregroundColor(.textPrimary)

                        HStack(spacing: Spacing.xxs) {
                            Circle()
                                .fill(agent.isOnline ? Color.success : Color.textTertiary)
                                .frame(width: 8, height: 8)

                            Text(viewModel.connectionStatus.displayText)
                                .font(.caption)
                                .foregroundColor(.textSecondary)
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                        Text("Support Team")
                            .font(.h5)
                            .foregroundColor(.textPrimary)

                        Text("Connecting...")
                            .font(.caption)
                            .foregroundColor(.textSecondary)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .background(Color.white)

            Divider()
        }
    }

    // MARK: - Messages Area

    private var messagesArea: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: Spacing.sm) {
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
                        MessageBubbleView(
                            message: message,
                            isFromCurrentUser: message.senderId == viewModel.userId
                        )
                        .id(message.id)
                    }

                    // Typing Indicator
                    if viewModel.isAgentTyping {
                        TypingIndicatorView(agentName: viewModel.currentAgent?.name ?? "Agent")
                    }
                }
                .padding(Spacing.md)
            }
            .onChange(of: viewModel.messages.count) { _ in
                if let lastMessage = viewModel.messages.last {
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            .onAppear {
                if let lastMessage = viewModel.messages.last {
                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                }
            }
        }
    }

    // MARK: - Quick Replies

    private var quickRepliesBar: some View {
        VStack(spacing: 0) {
            Divider()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.xs) {
                    ForEach(viewModel.quickReplies, id: \.self) { reply in
                        Button(action: {
                            viewModel.sendMessage(text: reply)
                        }) {
                            Text(reply)
                                .font(.bodySmall)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color.primary.opacity(0.1))
                                .cornerRadius(Spacing.radiusXl)
                        }
                    }
                }
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.xs)
            }
            .background(Color.white)
        }
    }

    // MARK: - Message Input Bar

    private var messageInputBar: some View {
        VStack(spacing: 0) {
            Divider()

            HStack(spacing: Spacing.sm) {
                // Attachment Button
                Button(action: {
                    showAttachmentPicker = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.h2)
                        .foregroundColor(.primary)
                }

                // Text Input
                TextField("Type your message...", text: $messageText, axis: .vertical)
                    .font(.body)
                    .foregroundColor(.textPrimary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color.surface)
                    .cornerRadius(Spacing.radiusXl)
                    .lineLimit(1...5)
                    .focused($isInputFocused)

                // Send Button
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.h1)
                        .foregroundColor(messageText.isEmpty ? Color.textTertiary : Color.primary)
                }
                .disabled(messageText.isEmpty)
            }
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(Color.white)
        }
    }

    // MARK: - Actions

    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        viewModel.sendMessage(text: messageText)
        messageText = ""
    }
}

// MARK: - Message Bubble View

struct MessageBubbleView: View {
    let message: ChatMessage
    let isFromCurrentUser: Bool

    var body: some View {
        HStack(alignment: .bottom, spacing: Spacing.xs) {
            if isFromCurrentUser {
                Spacer(minLength: 60)
            }

            VStack(alignment: isFromCurrentUser ? .trailing : .leading, spacing: Spacing.xxs) {
                // Message Content
                Group {
                    switch message.type {
                    case .text:
                        TextMessageBubble(text: message.text, isFromCurrentUser: isFromCurrentUser)

                    case .image:
                        ImageMessageBubble(imageURL: message.imageURL)

                    case .system:
                        SystemMessageBubble(text: message.text)
                    }
                }

                // Timestamp & Status
                if message.type != .system {
                    HStack(spacing: Spacing.xxs) {
                        Text(message.timestamp.formatted(date: .omitted, time: .shortened))
                            .font(.caption)
                            .foregroundColor(.textTertiary)

                        if isFromCurrentUser {
                            Image(systemName: message.isRead ? "checkmark.circle.fill" : "checkmark.circle")
                                .font(.system(size: Spacing.iconXS))
                                .foregroundColor(message.isRead ? .primary : .textTertiary)
                        }
                    }
                }
            }

            if !isFromCurrentUser && message.type != .system {
                Spacer(minLength: 60)
            }
        }
    }
}

// MARK: - Text Message Bubble

struct TextMessageBubble: View {
    let text: String
    let isFromCurrentUser: Bool

    var body: some View {
        Text(text)
            .font(.body)
            .foregroundColor(isFromCurrentUser ? .white : .textPrimary)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(isFromCurrentUser ? Color.primary : Color.surface)
            .clipShape(ChatBubbleShape(isFromCurrentUser: isFromCurrentUser))
    }
}

// MARK: - Image Message Bubble

struct ImageMessageBubble: View {
    let imageURL: String?

    var body: some View {
        if let _ = imageURL {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.surface)
                .frame(width: 200, height: 200)
                .overlay(
                    Image(systemName: "photo")
                        .font(.h1)
                        .foregroundColor(.textTertiary)
                )
        }
    }
}

// MARK: - System Message Bubble

struct SystemMessageBubble: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.textTertiary)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, 6)
            .background(Color.surface.opacity(0.5))
            .cornerRadius(Spacing.radiusLg)
            .frame(maxWidth: .infinity)
    }
}

// MARK: - Typing Indicator

struct TypingIndicatorView: View {
    let agentName: String
    @State private var animatingDots = false

    var body: some View {
        HStack(spacing: Spacing.xs) {
            Text("\(agentName) is typing")
                .font(.bodySmall)
                .foregroundColor(.textSecondary)

            HStack(spacing: 3) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.textTertiary)
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
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.surface)
        .clipShape(ChatBubbleShape(isFromCurrentUser: false))
        .onAppear {
            animatingDots = true
        }
    }
}

// MARK: - Chat Bubble Shape

struct ChatBubbleShape: Shape {
    let isFromCurrentUser: Bool

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: isFromCurrentUser ?
                [.topLeft, .topRight, .bottomLeft] :
                [.topLeft, .topRight, .bottomRight],
            cornerRadii: CGSize(width: 16, height: 16)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview

#Preview {
    ChatInterfaceView()
}

#Preview("Dark Mode") {
    ChatInterfaceView()
        .preferredColorScheme(.dark)
}
