import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var lang: LanguageManager
    @State private var showResetAlert = false
    
    @AppStorage("AppAppearance") private var appearance: String = "system"
    @AppStorage("RequireFaceID") private var requireFaceID: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: LocalizedText(key: "ui_settings")) {
                    Picker(lang.localizedString(for: "language"), selection: $lang.currentLanguage) {
                        ForEach(AppLanguage.allCases, id: \.self) { language in
                            Text(language.displayName).tag(language)
                        }
                    }
                    
                    Picker(lang.localizedString(for: "appearance"), selection: $appearance) {
                        Text(lang.localizedString(for: "system_default")).tag("system")
                        Text(lang.localizedString(for: "light")).tag("light")
                        Text(lang.localizedString(for: "dark")).tag("dark")
                    }
                }
                
                Section(header: LocalizedText(key: "security")) {
                    Toggle(lang.localizedString(for: "require_faceid"), isOn: $requireFaceID)
                }
                
                Section {
                    NavigationLink(destination: AboutView()) {
                        Label(lang.localizedString(for: "about"), systemImage: "info.circle")
                    }
                    
                    Button(role: .destructive) {
                        showResetAlert = true
                    } label: {
                        Label(lang.localizedString(for: "reset_all"), systemImage: "arrow.counterclockwise")
                    }
                    .alert(lang.localizedString(for: "reset_confirm_title"), isPresented: $showResetAlert) {
                        Button(lang.localizedString(for: "cancel"), role: .cancel) { }
                        Button(lang.localizedString(for: "reset"), role: .destructive) {
                            resetAllTweaks()
                        }
                    } message: {
                        Text(lang.localizedString(for: "reset_confirm_msg"))
                    }
                }
            }
            .navigationTitle(lang.localizedString(for: "settings_title"))
        }
    }
    
    private func resetAllTweaks() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
    }
}
