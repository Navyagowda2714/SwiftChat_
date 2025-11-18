//
//  MessageRepository.swift
//  SwiftChat
//
//  Created by Navyashree Byregowda on 13/11/25.
//


import Foundation

protocol MessageRepository {
    func connect() async
    func loadMessages(conversationID: UUID, limit: Int) async throws -> [Message]
    func join(conversationID: UUID) async throws
    func send(message: Message) async throws -> Message
    func sendTyping(conversationID: UUID, isTyping: Bool) async throws
    func markRead(conversationID: UUID, messageID: UUID) async throws

    var updates: AsyncStream<Message> { get }
    var typingEvents: AsyncStream<(UUID /*conversation*/, UUID /*user*/, Bool /*isTyping*/)> { get }
}
