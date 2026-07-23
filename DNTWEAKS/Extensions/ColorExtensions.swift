//
//  ColorExtensions.swift
//  DNTWEAKS IOS
//
//  Cyberpunk color palette – Neon Purple, Blue Neon, Black, Glass
//

import SwiftUI

extension Color {
    // MARK: - Primary Cyberpunk Palette
    static let neonPurple = Color(red: 0.62, green: 0.20, blue: 1.00)       // #9F33FF
    static let neonBlue = Color(red: 0.00, green: 0.85, blue: 1.00)         // #00D9FF
    static let neonPink = Color(red: 1.00, green: 0.20, blue: 0.60)         // #FF3399
    static let neonGreen = Color(red: 0.20, green: 1.00, blue: 0.60)        // #33FF99
    static let neonCyan = Color(red: 0.00, green: 1.00, blue: 0.90)         // #00FFE6
    static let cyberBlack = Color(red: 0.04, green: 0.04, blue: 0.08)       // #0A0A14
    static let cyberDark = Color(red: 0.08, green: 0.08, blue: 0.14)        // #141424
    static let glassWhite = Color.white.opacity(0.12)
    static let glassBorder = Color.white.opacity(0.25)
    
    // MARK: - Gradient Helpers
    static let neonGradient = LinearGradient(
        colors: [.neonPurple, .neonBlue, .neonPink],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let cyberGradient = LinearGradient(
        colors: [.cyberBlack, .cyberDark, Color(red: 0.12, green: 0.05, blue: 0.20)],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let glowPurple = RadialGradient(
        colors: [neonPurple.opacity(0.6), .clear],
        center: .center,
        startRadius: 0,
        endRadius: 120
    )
}
