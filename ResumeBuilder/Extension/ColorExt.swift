

import SwiftUI

extension Color {
    init(hex: String) {
        // Remove any non-hex characters, like `#`
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        // Convert the hex string into an integer
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        // Extract red, green, and blue components
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        // Initialize the color
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}
