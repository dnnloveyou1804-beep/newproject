//
//  ThemeManager.swift
//  DNTWEAKS IOS
//

import SwiftUI
import Combine

final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var isDarkMode: Bool = true
    @Published var accentColor: Color = .neonPurple
    @Published var animationSpeed: Double = 1.0 // 0.5 = slow, 1.0 = normal, 1.5 = fast
    
    private let darkKey = "dntweaks_dark_mode"
    private let accentKey = "dntweaks_accent"
    private let speedKey = "dntweaks_anim_speed"
    
    private init() {
        isDarkMode = UserDefaults.standard.object(forKey: darkKey) as? Bool ?? true
        animationSpeed = UserDefaults.standard.object(forKey: speedKey) as? Double ?? 1.0
    }
    
    func toggleDarkMode() {
        isDarkMode.toggle()
        UserDefaults.standard.set(isDarkMode, forKey: darkKey)
        HapticManager.shared.selection()
    }
    
    func setAccent(_ color: Color) {
        accentColor = color
        HapticManager.shared.selection()
    }
    
    func setAnimationSpeed(_ speed: Double) {
        animationSpeed = speed
        UserDefaults.standard.set(speed, forKey: speedKey)
    }
    
    func reset() {
        isDarkMode = true
        accentColor = .neonPurple
        animationSpeed = 1.0
        UserDefaults.standard.removeObject(forKey: darkKey)
        UserDefaults.standard.removeObject(forKey: speedKey)
        HapticManager.shared.notification(.success)
    }
}
