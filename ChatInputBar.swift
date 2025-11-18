import SwiftUI

struct ChatInputBar: View {
    @Binding var text: String
    var onSend: () -> Void
    

    var body: some View {
            HStack(spacing: 8) {
                TextField("Message…", text: $text, axis: .vertical)
                    .lineLimit(1...4)
                    .textFieldStyle(.roundedBorder)

                Button(action: onSend) {
                    Image(systemName: "paperplane.fill")
                        .padding(8)
                }
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(8)
            .background(.ultraThinMaterial)
        }
    }
