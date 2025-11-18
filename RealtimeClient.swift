//
//  RealtimeClient.swift
//  SwiftChat
//
//  Created by Navyashree Byregowda on 18/11/25.
//


import Foundation

/// A very small abstraction for "something that can send data in real time".
protocol RealtimeClient {
    /// Open / ensure a WebSocket connection.
    func connect() async
    
    /// Send raw Data over the connection.
    func send(_ data: Data) async throws
}

/// Concrete implementation using URLSessionWebSocketTask.
final class URLSessionRealtimeClient: RealtimeClient {
    
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
        // If already connected, do nothing
        if task != nil { return }
        
        let task = session.webSocketTask(with: url)
        self.task = task
        task.resume()
    }
    
    func send(_ data: Data) async throws {
        // Make sure we have a WebSocket connection
        if task == nil {
            await connect()
        }
        guard let task = task else {
            throw ClientError.notConnected
        }
        
        try await task.send(.data(data))
    }
}
