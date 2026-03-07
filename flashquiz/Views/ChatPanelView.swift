//
//  ChatPanelView.swift
//  flashquiz
//

import SwiftUI

struct ChatPanelView: View {
    @ObservedObject var session: AppSession
    var title: String = "Sohbet"
    var height: CGFloat = 160

    @State private var messageText: String = ""
    @State private var sendingErrorMessage: String?
    @FocusState private var isMessageFieldFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.appTextPrimary)

            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        if session.chatMessages.isEmpty {
                            Text("Henüz mesaj yok.")
                                .font(.footnote)
                                .foregroundStyle(.appTextSecondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 4)
                        }

                        ForEach(session.chatMessages) { message in
                            messageRow(message)
                                .id(message.id)
                        }
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                }
                .frame(height: height)
                .background(Color.appSurface)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.appBorder, lineWidth: 1)
                )
                .onAppear {
                    scrollToBottom(with: proxy, animated: false)
                }
                .onChange(of: session.chatMessages.count) { _, _ in
                    scrollToBottom(with: proxy, animated: true)
                }
                .onTapGesture {
                    isMessageFieldFocused = false
                }
            }

            HStack(spacing: 8) {
                TextField("Mesaj yaz...", text: $messageText, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(1...3)
                    .focused($isMessageFieldFocused)

                Button("Gönder") {
                    sendMessage()
                }
                .buttonStyle(.borderedProminent)
                .disabled(trimmedMessage.isEmpty)
            }

            if let sendingErrorMessage {
                Text(sendingErrorMessage)
                    .font(.caption)
                    .foregroundStyle(.appDanger)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Bitti") {
                    isMessageFieldFocused = false
                }
            }
        }
    }

    private var trimmedMessage: String {
        messageText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func sendMessage() {
        let outgoingMessage = trimmedMessage
        guard !outgoingMessage.isEmpty else { return }

        sendingErrorMessage = nil
        session.sendChatMessage(outgoingMessage) { error in
            if let error {
                sendingErrorMessage = error.localizedDescription
                return
            }
            messageText = ""
            isMessageFieldFocused = false
        }
    }

    private func scrollToBottom(with proxy: ScrollViewProxy, animated: Bool) {
        guard let lastMessageId = session.chatMessages.last?.id else { return }
        if animated {
            withAnimation {
                proxy.scrollTo(lastMessageId, anchor: .bottom)
            }
        } else {
            proxy.scrollTo(lastMessageId, anchor: .bottom)
        }
    }

    @ViewBuilder
    private func messageRow(_ message: ChatMessage) -> some View {
        let isCurrentUser = message.playerId == session.currentPlayer?.id
        let rowAlignment: Alignment = isCurrentUser ? .trailing : .leading
        let bubbleColor = isCurrentUser ? Color.appAccent.opacity(0.22) : Color.appSurfaceAlt

        VStack(alignment: .leading, spacing: 3) {
            Text("\(message.playerName) • \(Self.timeFormatter.string(from: message.sentAt))")
                .font(.caption2)
                .foregroundStyle(.appTextSecondary)
            Text(message.text)
                .font(.footnote)
                .foregroundStyle(.appTextPrimary)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: rowAlignment)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(bubbleColor)
        )
    }

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
