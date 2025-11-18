import Foundation

@MainActor
final class WebSocketMessageRepository: MessageRepository {
    
    // MARK: - MessageRepository methods
    
    func connect() async {
        await client.connect()
    }
    
    func loadMessages(conversationID: UUID, limit: Int) async throws -> [Message] {
        // TODO: implement real loading. For now just return empty.
        return []
    }
    
    func join(conversationID: UUID) async throws {
        // TODO: send "join" event via WebSocket if your backend supports it.
    }
    
    func send(message: Message) async throws -> Message {
        // If Message has text + conversationID, you can wire it up here.
        // try await send(text: message.text, to: message.conversationID)
        return message
    }
    
    func sendTyping(conversationID: UUID, isTyping: Bool) async throws {
        try await setTyping(isTyping, in: conversationID)
    }
    
    func markRead(conversationID: UUID, messageID: UUID) async throws {
        // TODO: implement "mark as read" if your backend supports it.
    }
    
    // MARK: - Stored properties
    
    private let client: WebSocketClient
    
    private let updateStream: AsyncStream<Message>
    private let updateCont: AsyncStream<Message>.Continuation
    
    private let typingStream: AsyncStream<(UUID, UUID, Bool)>
    private let typingCont: AsyncStream<(UUID, UUID, Bool)>.Continuation
    
    var updates: AsyncStream<Message> { updateStream }
    var typingEvents: AsyncStream<(UUID, UUID, Bool)> { typingStream }
    
    // MARK: - Init
    
    init(client: WebSocketClient) {
        self.client = client
        
        var mCont: AsyncStream<Message>.Continuation!
        self.updateStream = AsyncStream { continuation in
            mCont = continuation
        }
        self.updateCont = mCont
        
        var tCont: AsyncStream<(UUID, UUID, Bool)>.Continuation!
        self.typingStream = AsyncStream { continuation in
            tCont = continuation
        }
        self.typingCont = tCont
    }
    
    // MARK: - Low-level send helpers
    
    func send(text: String, to conversationID: UUID) async throws {
        let payload: [String: Any] = [
            "type": "message",
            "conversationID": conversationID.uuidString,
            "senderID": User.me.id.uuidString,   // <- use User.me.id
            "text": text
        ]
        let data = try JSONSerialization.data(withJSONObject: payload)
        try await client.send(data)
    }
    
    func setTyping(_ isTyping: Bool,
                   in conversationID: UUID,
                   as userID: UUID = User.me.id) async throws {  // <- default is UUID
        let payload: [String: Any] = [
            "type": "typing",
            "conversationID": conversationID.uuidString,
            "senderID": userID.uuidString,
            "isTyping": isTyping
        ]
        let data = try JSONSerialization.data(withJSONObject: payload)
        try await client.send(data)
    }
}
