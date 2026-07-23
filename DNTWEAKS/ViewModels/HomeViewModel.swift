//
//  HomeViewModel.swift
//  DNTWEAKS IOS
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var deviceInfo: DeviceInfoModel = .current
    @Published var selectedProfile: ProfileType? = nil
    @Published var selectedFile: SelectedFileInfo? = nil
    @Published var isProcessing: Bool = false
    @Published var progress: Double = 0.0
    @Published var statusMessage: String = ""
    @Published var showFilePicker: Bool = false
    @Published var showActiveCode: Bool = false
    @Published var isCompleted: Bool = false
    
    func refreshDeviceInfo() {
        deviceInfo = .current
        HapticManager.shared.selection()
    }
    
    func selectProfile(_ profile: ProfileType) {
        selectedProfile = profile
        selectedFile = nil
        showActiveCode = false
        isCompleted = false
        progress = 0
        statusMessage = ""
        showFilePicker = true
        HapticManager.shared.impact(.medium)
        SoundManager.shared.playTap()
    }
    
    func fileSelected(name: String, size: Int64, path: String) {
        let sizeStr = ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
        selectedFile = SelectedFileInfo(name: name, size: sizeStr, path: path)
        showFilePicker = false
        showActiveCode = true
        HapticManager.shared.notification(.success)
        SoundManager.shared.playSuccess()
    }
    
    func activateCode() {
        guard selectedFile != nil else { return }
        
        isProcessing = true
        isCompleted = false
        progress = 0
        statusMessage = "Processing..."
        
        HapticManager.shared.impact(.heavy)
        SoundManager.shared.playWhoosh()
        
        // Simulated processing animation (sandbox only – no real system changes)
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self = self else { timer.invalidate(); return }
            
            Task { @MainActor in
                self.progress += 0.02
                if self.progress >= 1.0 {
                    timer.invalidate()
                    self.progress = 1.0
                    self.statusMessage = "Completed."
                    self.isProcessing = false
                    self.isCompleted = true
                    HapticManager.shared.notification(.success)
                    SoundManager.shared.playSuccess()
                }
            }
        }
    }
    
    func resetSelection() {
        selectedProfile = nil
        selectedFile = nil
        showActiveCode = false
        isCompleted = false
        progress = 0
        statusMessage = ""
    }
}
