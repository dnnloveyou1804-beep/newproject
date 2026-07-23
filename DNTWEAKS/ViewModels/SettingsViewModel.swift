//
//  SettingsViewModel.swift
//  DNTWEAKS IOS
//

import Foundation
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var showAbout = false
    @Published var showPrivacy = false
    
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    
    func openTelegram() {
        if let url = URL(string: "https://t.me/dntweaks") {
            UIApplication.shared.open(url)
        }
        HapticManager.shared.impact(.light)
    }
    
    func openTikTok() {
        if let url = URL(string: "https://www.tiktok.com/@dnnnloveyou") {
            UIApplication.shared.open(url)
        }
        HapticManager.shared.impact(.light)
    }
    
    func copyToClipboard(_ text: String) {
        UIPasteboard.general.string = text
        HapticManager.shared.notification(.success)
        SoundManager.shared.playSuccess()
    }
}
