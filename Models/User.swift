//
//  User.swift
//  SwiftChat
//
//  Created by Navyashree Byregowda on 17/11/25.
//

import Foundation

struct User: Identifiable, Equatable {
    let id: UUID
    let name: String

    static let me  = User(id: UUID(), name: "Me")
    static let bot = User(id: UUID(), name: "SwiftChat Bot")
}
