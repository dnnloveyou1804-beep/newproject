//
//  SettingsView.swift
//  DNTWEAKS IOS
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = SettingsViewModel()
    
    private let accentOptions: [(String, Color)] = [
        ("Purple", .neonPurple),
        ("Blue", .neonBlue),
        ("Cyan", .neonCyan),
        ("Pink", .neonPink),
        ("Green", .neonGreen)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cyberBlack.ignoresSafeArea()
                AnimatedGradientBackground()
                    .opacity(0.6)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Appearance
                        GlassCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Label("APPEARANCE", systemImage: "paintbrush.fill")
                                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                                    .foregroundColor(.neonPurple)
                                    .tracking(1)
                                
                                Toggle(isOn: Binding(
                                    get: { themeManager.isDarkMode },
                                    set: { _ in themeManager.toggleDarkMode() }
                                )) {
                                    Label("Dark Mode", systemImage: "moon.fill")
                                        .foregroundColor(.white)
                                }
                                .toggleStyle(SwitchToggleStyle(tint: .neonPurple))
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Accent Color")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    HStack(spacing: 12) {
                                        ForEach(accentOptions, id: \.0) { name, color in
                                            Circle()
                                                .fill(color)
                                                .frame(width: 32, height: 32)
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color.white, lineWidth: themeManager.accentColor == color ? 2.5 : 0)
                                                )
                                                .shadow(color: color.opacity(0.6), radius: 6)
                                                .onTapGesture {
                                                    themeManager.setAccent(color)
                                                }
                                        }
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("Animation Speed")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.white.opacity(0.8))
                                        Spacer()
                                        Text(String(format: "%.1fx", themeManager.animationSpeed))
                                            .font(.system(size: 13, weight: .semibold, design: .monospaced))
                                            .foregroundColor(.neonCyan)
                                    }
                                    Slider(value: Binding(
                                        get: { themeManager.animationSpeed },
                                        set: { themeManager.setAnimationSpeed($0) }
                                    ), in: 0.5...1.5, step: 0.1)
                                    .tint(.neonPurple)
                                }
                            }
                        }
                        
                        // About
                        GlassCard {
                            VStack(alignment: .leading, spacing: 14) {
                                Label("ABOUT", systemImage: "info.circle.fill")
                                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                                    .foregroundColor(.neonBlue)
                                    .tracking(1)
                                
                                infoLine("Version", "\(vm.version) (\(vm.build))")
                                infoLine("Bundle ID", "com.dntweaks.ios")
                                infoLine("Developer", "Dinh Duc Nam")
                                
                                Divider().background(Color.white.opacity(0.15))
                                
                                Button {
                                    vm.openTelegram()
                                } label: {
                                    Label("Telegram @dntweaks", systemImage: "paperplane.fill")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.neonBlue)
                                }
                                
                                Button {
                                    vm.openTikTok()
                                } label: {
                                    Label("TikTok @dnnnloveyou", systemImage: "play.rectangle.fill")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.neonPink)
                                }
                            }
                        }
                        
                        // Privacy
                        GlassCard {
                            VStack(alignment: .leading, spacing: 10) {
                                Label("PRIVACY", systemImage: "lock.shield.fill")
                                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                                    .foregroundColor(.neonGreen)
                                    .tracking(1)
                                
                                Text("All operations are simulated within the app sandbox. No system settings are modified. Files are only accessed with user permission via the system file picker.")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.white.opacity(0.7))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        
                        // Reset
                        NeonButton("Reset Settings", icon: "arrow.counterclockwise", color: .neonPink) {
                            themeManager.reset()
                        }
                        .padding(.horizontal, 4)
                        
                        Spacer().frame(height: 30)
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.neonPurple)
                    .fontWeight(.semibold)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func infoLine(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.5))
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
        }
    }
}
