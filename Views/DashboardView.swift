import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var lang: LanguageManager
    
    let tweaks: [TweakItem] = [
        TweakItem(type: .refreshRate, titleKey: "display_refresh_rate", icon: "display.2", descKey: "refresh_rate_desc"),
        TweakItem(type: .performance, titleKey: "performance_profile", icon: "bolt.fill", descKey: "performance_desc"),
        TweakItem(type: .pointerSpeed, titleKey: "pointer_speed", icon: "cursorarrow", descKey: "pointer_desc"),
        TweakItem(type: .touchSensitivity, titleKey: "touch_sensitivity", icon: "hand.tap.fill", descKey: "touch_desc"),
        TweakItem(type: .latency, titleKey: "input_latency", icon: "timer", descKey: "latency_desc"),
        TweakItem(type: .haptic, titleKey: "haptic_intensity", icon: "iphone.radiowaves.left.and.right", descKey: "haptic_desc"),
        TweakItem(type: .battery, titleKey: "battery_saver", icon: "battery.100.bolt", descKey: "battery_saver_desc"),
        TweakItem(type: .theme, titleKey: "app_theme", icon: "paintpalette.fill", descKey: "theme_desc"),
        TweakItem(type: .badge, titleKey: "badge_style", icon: "app.badge.fill", descKey: "badge_desc")
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        HeaderView()
                        
                        // Active Profile Selector
                        VStack(alignment: .leading, spacing: 8) {
                            LocalizedText(key: "active_profile")
                                .font(.subheadline.bold())
                                .foregroundColor(.gray)
                                .padding(.horizontal, 4)
                            
                            Picker("", selection: Binding(
                                get: { profileManager.activeProfile },
                                set: { newValue in
                                    if let p = ConfigProfile(rawValue: newValue) {
                                        profileManager.applyProfile(p)
                                    }
                                }
                            )) {
                                ForEach(ConfigProfile.allCases, id: \.rawValue) { profile in
                                    Text(lang.localizedString(for: profile == .defaultProfile ? "profile_default" : (profile == .gaming ? "profile_gaming" : "profile_battery"))).tag(profile.rawValue)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                        }
                        
                        // Game Booster
                        VStack(alignment: .leading, spacing: 8) {
                            LocalizedText(key: "game_booster")
                                .font(.subheadline.bold())
                                .foregroundColor(.accentColor)
                                .padding(.horizontal, 4)
                            
                            GameBoosterView(gameName: "Free Fire", bundleId: "com.dts.freefireth", icon: "gamecontroller.fill")
                            GameBoosterView(gameName: "Free Fire Max", bundleId: "com.dts.freefiremax", icon: "flame.fill")
                        }
                        
                        // Tweaks Grid
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(tweaks) { tweak in
                                TweakCardView(tweak: tweak)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}
