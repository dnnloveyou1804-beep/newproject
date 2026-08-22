import SwiftUI

enum AppTheme: String, CaseIterable {
    case neonBlue = "Neon Blue"
    case crimson = "Crimson"
    case emerald = "Emerald"
    case mono = "Mono"
    
    var color: Color {
        switch self {
        case .neonBlue: return Color(red: 0, green: 0.9, blue: 1.0)
        case .crimson: return Color.red
        case .emerald: return Color.green
        case .mono: return Color.white
        }
    }
}

class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme = .neonBlue
}
