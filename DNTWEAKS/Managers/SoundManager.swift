//
//  SoundManager.swift
//  DNTWEAKS IOS
//
//  Lightweight system sound effects (no external audio files required)
//

import AudioToolbox
import AVFoundation

final class SoundManager {
    static let shared = SoundManager()
    private init() {}
    
    func playTap() {
        AudioServicesPlaySystemSound(1104) // Tock
    }
    
    func playSuccess() {
        AudioServicesPlaySystemSound(1025) // Success
    }
    
    func playError() {
        AudioServicesPlaySystemSound(1053) // Error
    }
    
    func playWhoosh() {
        AudioServicesPlaySystemSound(1105)
    }
}
