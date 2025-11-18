import Foundation

struct Message: Identifiable, Hashable {
    let id: UUID
    let senderID: UUID
    let text: String
    let createdAt: Date

    init(id: UUID = UUID(),
         senderID: UUID,
         text: String,
         createdAt: Date = Date()) {
        self.id = id
        self.senderID = senderID
        self.text = text
        self.createdAt = createdAt
    }
}
