import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
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
                    HeaderView()
                        .padding(.horizontal)
                        .padding(.top)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(tweaks) { tweak in
                            TweakCardView(tweak: tweak)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}
