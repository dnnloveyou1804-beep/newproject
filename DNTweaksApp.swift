import SwiftUI

@main
struct DNTweaksApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var langManager = LanguageManager()
    @StateObject private var sysStats = SystemStatsManager()
    
    @AppStorage("AppAppearance") private var appearance: String = "system"
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environmentObject(langManager)
                .environmentObject(sysStats)
                .tint(themeManager.currentTheme.color)
                .preferredColorScheme(appearance == "dark" ? .dark : (appearance == "light" ? .light : nil))
        }
    }
}
