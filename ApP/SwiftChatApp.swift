import SwiftUI

@main
struct SwiftChatApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView()   // uses the default ChatViewModel()
        }
    }
}
