import SwiftUI

struct TweakDetailView: View {
    let tweak: TweakItem
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var themeManager: ThemeManager
    
    // States for controls
    @State private var refreshRate = 2 // 120Hz
    @State private var performance = 1 // Balanced
    @State private var pointerSpeed = 1.0
    @State private var touchSensitivity = 50.0
    @State private var latency = 0.0
    @State private var haptic = 1 // Medium
    @State private var batterySaver = ProcessInfo.processInfo.isLowPowerModeEnabled
    @State private var badgeStyle = true
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        if !tweak.isReal {
                            Label("UI Illustration Only", systemImage: "info.circle.fill")
                                .foregroundColor(.orange)
                                .font(.caption.bold())
                        } else {
                            Label("App-level Effect", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.caption.bold())
                        }
                        Text(tweak.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("Control Panel")) {
                    controlForTweak()
                }
            }
            .navigationTitle(tweak.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func controlForTweak() -> some View {
        switch tweak.type {
        case .refreshRate:
            Picker("Refresh Rate", selection: $refreshRate) {
                Text("60Hz").tag(0)
                Text("90Hz").tag(1)
                Text("120Hz").tag(2)
                Text("144Hz").tag(3)
            }
            .pickerStyle(.segmented)
        case .performance:
            Picker("Performance", selection: $performance) {
                Text("Low").tag(0)
                Text("Balanced").tag(1)
                Text("High").tag(2)
                Text("Ultra").tag(3)
            }
            .pickerStyle(.segmented)
        case .pointerSpeed:
            VStack {
                Slider(value: $pointerSpeed, in: 0.1...3.0)
                Text(String(format: "%.1fx", pointerSpeed))
                    .foregroundColor(.gray)
            }
        case .touchSensitivity:
            VStack {
                Slider(value: $touchSensitivity, in: 0...100)
                Text("Value: \(Int(touchSensitivity))")
                    .foregroundColor(.gray)
            }
        case .latency:
            VStack {
                Slider(value: $latency, in: 0...100)
                Text("\(Int(latency)) ms")
                    .foregroundColor(.gray)
            }
        case .haptic:
            Picker("Haptic", selection: $haptic) {
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
            Toggle("Battery Saver (Read-only)", isOn: .constant(ProcessInfo.processInfo.isLowPowerModeEnabled))
                .disabled(true)
        case .theme:
            Picker("Theme", selection: $themeManager.currentTheme) {
                ForEach(AppTheme.allCases, id: \.self) { theme in
                    Text(theme.rawValue).tag(theme)
                }
            }
            .pickerStyle(.wheel)
        case .badge:
            Toggle("Notification Badge", isOn: $badgeStyle)
        case .reset:
            EmptyView()
        }
    }
}
