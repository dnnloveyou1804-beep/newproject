import Foundation
import SwiftUI

enum ConfigProfile: String, CaseIterable {
    case defaultProfile = "Default"
    case gaming = "Gaming Mode"
    case batterySaver = "Battery Saver"
}

class ProfileManager: ObservableObject {
    @AppStorage("ActiveProfile") var activeProfile: String = ConfigProfile.defaultProfile.rawValue
    
    func applyProfile(_ profile: ConfigProfile) {
        self.activeProfile = profile.rawValue
        
        // Trigger haptic
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        
        switch profile {
        case .defaultProfile:
            UserDefaults.standard.set(2, forKey: "tweak_refreshRate") // 120Hz
            UserDefaults.standard.set(1, forKey: "tweak_performance") // Balanced
            UserDefaults.standard.set(1.0, forKey: "tweak_pointerSpeed")
            UserDefaults.standard.set(50.0, forKey: "tweak_touchSensitivity")
            UserDefaults.standard.set(0.0, forKey: "tweak_latency")
            UserDefaults.standard.set(1, forKey: "tweak_haptic") // Medium
            
        case .gaming:
            UserDefaults.standard.set(3, forKey: "tweak_refreshRate") // 144Hz
            UserDefaults.standard.set(3, forKey: "tweak_performance") // Ultra
            UserDefaults.standard.set(2.0, forKey: "tweak_pointerSpeed")
            UserDefaults.standard.set(100.0, forKey: "tweak_touchSensitivity")
            UserDefaults.standard.set(0.0, forKey: "tweak_latency")
            UserDefaults.standard.set(2, forKey: "tweak_haptic") // Heavy
            
        case .batterySaver:
            UserDefaults.standard.set(0, forKey: "tweak_refreshRate") // 60Hz
            UserDefaults.standard.set(0, forKey: "tweak_performance") // Low
            UserDefaults.standard.set(0.5, forKey: "tweak_pointerSpeed")
            UserDefaults.standard.set(30.0, forKey: "tweak_touchSensitivity")
            UserDefaults.standard.set(10.0, forKey: "tweak_latency")
            UserDefaults.standard.set(0, forKey: "tweak_haptic") // Light
        }
    }
}
