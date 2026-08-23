import SwiftUI

@main
struct DNTweaksApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var langManager = LanguageManager()
    @StateObject private var sysStats = SystemStatsManager()
    @StateObject private var securityManager = SecurityManager()
    @StateObject private var profileManager = ProfileManager()
    @StateObject private var licenseManager = LicenseManager()
    @StateObject private var localServer = LocalProfileServer()
    
    @AppStorage("AppAppearance") private var appearance: String = "system"
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showSplash {
                    SplashView(showSplash: $showSplash)
                } else {
                    ContentView()
                }
            }
            .environmentObject(themeManager)
            .environmentObject(langManager)
            .environmentObject(sysStats)
            .environmentObject(securityManager)
            .environmentObject(profileManager)
            .environmentObject(licenseManager)
            .environmentObject(localServer)
            .tint(themeManager.currentTheme.color)
            .preferredColorScheme(appearance == "dark" ? .dark : (appearance == "light" ? .light : nil))
        }
    }
}
