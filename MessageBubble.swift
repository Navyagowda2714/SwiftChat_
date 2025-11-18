import SwiftUI

struct MessageBubble: View {
    let message: Message
    let isMe: Bool

    var body: some View {
        HStack {
            if isMe { Spacer() }

            Text(message.text)
                .padding(10)
                .background(isMe ? Color.blue : Color.gray.opacity(0.25))
                .foregroundStyle(isMe ? Color.white : Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            if !isMe { Spacer() }
        }
        .padding(.horizontal, 4)
    }
}
