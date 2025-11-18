import SwiftUI

@main
struct SwiftChatApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView()
        }
    }
}
let socketURL = URL(string: "ws://localhost:8080")! // or your backend URL
let webSocketClient = URLSessionWebSocketClient(url: socketURL)
let repository = WebSocketMessageRepository(client: webSocketClient)
let viewModel = ChatViewModel(repository: repository)
