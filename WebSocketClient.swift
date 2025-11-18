
import Foundation

protocol RealtimeClient {
    func connect() async throws
    func disconnect()
    func send(_ data: Data) async throws
    var incomingMessages: AsyncStream<Data> { get }
}

/// Mock client; replace with URLSessionWebSocketTask or Firebase/CloudKit subscriptions.
final class WebSocketClient: RealtimeClient {
    private let stream: AsyncStream<Data>
    private let continuation: AsyncStream<Data>.Continuation

    init() {
        var cont: AsyncStream<Data>.Continuation!
        self.stream = AsyncStream<Data> { c in cont = c }
        self.continuation = cont
    }

    var incomingMessages: AsyncStream<Data> { stream }

    func connect() async throws {
        // Simulate connection after a short delay
        try await Task.sleep(nanoseconds: 300_000_000)
    }

    func disconnect() { continuation.finish() }

    func send(_ data: Data) async throws {
        // Echo back (loopback) to simulate delivery
        continuation.yield(data)
    }
}
