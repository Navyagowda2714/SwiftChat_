import SwiftUI

struct AppTheme {
    // App background gradient
    static let background = LinearGradient(
        colors: [
            Color(hue: 0.60, saturation: 0.55, brightness: 0.25),
            Color(hue: 0.68, saturation: 0.50, brightness: 0.18)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // Bubbles
    static let meBubble = LinearGradient(
        colors: [
            Color(hue: 0.56, saturation: 0.72, brightness: 0.85),
            Color(hue: 0.52, saturation: 0.70, brightness: 0.72)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let otherBubble = LinearGradient(
        colors: [
            Color(hue: 0.86, saturation: 0.56, brightness: 0.92),
            Color(hue: 0.03, saturation: 0.75, brightness: 0.96)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let accent    = Color(hue: 0.58, saturation: 0.80, brightness: 0.82)
    static let accentAlt = Color(hue: 0.86, saturation: 0.72, brightness: 0.92)

    static let barMaterial: Material = .ultraThin
}
