import SwiftUI

struct TypingIndicatorView: View {
    var body: some View {
        Label("Typing…", systemImage: "ellipsis.message.fill")
            .labelStyle(.titleAndIcon)
            .foregroundStyle(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(Color.gray.opacity(0.5), in: Capsule())
    }
}
