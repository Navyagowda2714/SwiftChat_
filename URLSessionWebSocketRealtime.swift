import Foundation

/// Simple abstraction for something that can send WebSocket data.
protocol WebSocketClient {
    func connect() async
    func send(_ data: Data) async throws
}

final class URLSessionWebSocketClient: WebSocketClient {
    
    enum ClientError: Error {
        case notConnected
    }
    
    private let url: URL
    private let session: URLSession
    private var task: URLSessionWebSocketTask?
    
    init(url: URL) {
        self.url = url
        self.session = URLSession(configuration: .default)
    }
    
    func connect() async {
        if task != nil { return }   // already connected
        let task = session.webSocketTask(with: url)
        self.task = task
        task.resume()
    }
    
    func send(_ data: Data) async throws {
        if task == nil {
            await connect()
        }
        guard let task = task else {
            throw ClientError.notConnected
        }
        try await task.send(.data(data))
    }
}
