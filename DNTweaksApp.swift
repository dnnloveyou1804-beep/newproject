import SwiftUI

@main
struct DNTweaksApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .tint(themeManager.currentTheme.color)
                .preferredColorScheme(.dark)
        }
    }
}
