import SwiftUI
import Combine   // <- this fixes the @Published / ObservableObject issues

@MainActor
final class ChatViewModel: ObservableObject {

    @Published var messages: [Message] = []
    @Published var composerText: String = ""
    @Published var isTypingPeer: Bool = false

    private let me = User.me
    private let bot = User.bot

    init() {
        messages.append(
            Message(senderID: bot.id, text: "Hey 👋, this is SwiftChat.")
        )
    }

    func sendCurrentMessage() {
        let trimmed = composerText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let userMessage = Message(senderID: me.id, text: trimmed)
        messages.append(userMessage)
        composerText = ""

        respond(to: userMessage)
    }

    private func respond(to message: Message) {
        isTypingPeer = true

        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second

            let replyText = "You said: \(message.text)"
            let reply = Message(senderID: bot.id, text: replyText)
            messages.append(reply)

            isTypingPeer = false
        }
    }
}
