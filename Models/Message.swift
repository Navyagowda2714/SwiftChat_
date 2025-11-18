import Foundation
import SwiftUI
import UIKit
import PhotosUI

struct Message: Identifiable, Equatable {
    let id: UUID
    let senderID: UUID
    let text: String
    let date: Date
    
    /// Optional image the user attaches (photo or GIF preview as still image)
    var image: UIImage? = nil
    
    /// Optional remote GIF URL (e.g. from a CDN)
    var gifURL: URL? = nil

    init(id: UUID = UUID(),
         senderID: UUID,
         text: String,
         date: Date = Date(),
         image: UIImage? = nil,
         gifURL: URL? = nil) {
        self.id = id
        self.senderID = senderID
        self.text = text
        self.date = date
        self.image = image
        self.gifURL = gifURL
    }
}
