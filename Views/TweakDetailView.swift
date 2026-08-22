import SwiftUI

struct TweakDetailView: View {
    let tweak: TweakItem
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var lang: LanguageManager
    
    // Persistent States using AppStorage
    @AppStorage("tweak_refreshRate") private var refreshRate = 2
    @AppStorage("tweak_performance") private var performance = 1
    @AppStorage("tweak_pointerSpeed") private var pointerSpeed = 1.0
    @AppStorage("tweak_touchSensitivity") private var touchSensitivity = 50.0
    @AppStorage("tweak_latency") private var latency = 0.0
    @AppStorage("tweak_haptic") private var haptic = 1
    @AppStorage("tweak_badgeStyle") private var badgeStyle = true
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        LocalizedText(key: tweak.descKey)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
                
                Section(header: LocalizedText(key: "control_panel")) {
                    controlForTweak()
                }
            }
            .navigationTitle(lang.localizedString(for: tweak.titleKey))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(lang.localizedString(for: "done")) {
                        dismiss()
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func triggerHaptic() {
        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
    }
    
    @ViewBuilder
    func controlForTweak() -> some View {
        switch tweak.type {
        case .refreshRate:
            Picker("", selection: $refreshRate) {
                Text("60Hz").tag(0)
                Text("90Hz").tag(1)
                Text("120Hz").tag(2)
                Text("144Hz").tag(3)
            }
            .pickerStyle(.segmented)
            .onChange(of: refreshRate) { _ in triggerHaptic() }
        case .performance:
            Picker("", selection: $performance) {
                Text("Low").tag(0)
                Text("Balanced").tag(1)
                Text("High").tag(2)
                Text("Ultra").tag(3)
            }
            .pickerStyle(.segmented)
            .onChange(of: performance) { _ in triggerHaptic() }
        case .pointerSpeed:
            VStack {
                Slider(value: Binding(
                    get: { pointerSpeed },
                    set: { pointerSpeed = $0; triggerHaptic() }
                ), in: 0.1...3.0)
                Text("\(lang.localizedString(for: "value")) \(String(format: "%.1fx", pointerSpeed))")
                    .foregroundColor(.gray)
            }
        case .touchSensitivity:
            VStack {
                Slider(value: Binding(
                    get: { touchSensitivity },
                    set: { touchSensitivity = $0; triggerHaptic() }
                ), in: 0...100)
                Text("\(lang.localizedString(for: "value")) \(Int(touchSensitivity))")
                    .foregroundColor(.gray)
            }
        case .latency:
            VStack {
                Slider(value: Binding(
                    get: { latency },
                    set: { latency = $0; triggerHaptic() }
                ), in: 0...100)
                Text("\(Int(latency)) ms")
                    .foregroundColor(.gray)
            }
        case .haptic:
            Picker("", selection: $haptic) {
                Text("Light").tag(0)
                Text("Medium").tag(1)
                Text("Heavy").tag(2)
            }
            .pickerStyle(.segmented)
            .onChange(of: haptic) { newValue in
                let style: UIImpactFeedbackGenerator.FeedbackStyle
                if newValue == 0 { style = .light }
                else if newValue == 1 { style = .medium }
                else { style = .heavy }
                UIImpactFeedbackGenerator(style: style).impactOccurred()
            }
        case .battery:
            Toggle("\(lang.localizedString(for: "battery_saver")) \(lang.localizedString(for: "read_only"))", isOn: .constant(ProcessInfo.processInfo.isLowPowerModeEnabled))
                .disabled(true)
        case .theme:
            Picker("", selection: $themeManager.currentTheme) {
                ForEach(AppTheme.allCases, id: \.self) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
            .pickerStyle(.wheel)
            .onChange(of: themeManager.currentTheme) { _ in triggerHaptic() }
        case .badge:
            Toggle(lang.localizedString(for: "badge_style"), isOn: Binding(
                get: { badgeStyle },
                set: { badgeStyle = $0; triggerHaptic() }
            ))
        case .reset:
            EmptyView()
        }
    }
}
