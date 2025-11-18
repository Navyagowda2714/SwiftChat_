import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @FocusState private var isComposerFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.messages) { msg in
                            MessageBubble(
                                message: msg,
                                isMe: msg.senderID == User.me.id
                            )
                            .id(msg.id)
                        }

                        if viewModel.isTypingPeer {
                            HStack {
                                TypingIndicatorView()
                                Spacer()
                            }
                            .padding(.horizontal, 12)
                        }
                    }
                    .padding(.top, 12)
                }
                .onChange(of: viewModel.messages.count) { _ in
                    if let lastID = viewModel.messages.last?.id {
                        withAnimation {
                            proxy.scrollTo(lastID, anchor: .bottom)
                        }
                    }
                }
            }

            Divider()

            HStack(spacing: 8) {
                TextField("Message", text: $viewModel.composerText, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .focused($isComposerFocused)

                Button(action: {
                    viewModel.sendCurrentMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                }
                .disabled(
                    viewModel.composerText
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .isEmpty
                )
            }
            .padding(12)
        }
    }
}
