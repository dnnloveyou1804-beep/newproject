//
//  ViewExtensions.swift
//  DNTWEAKS IOS
//
//  Custom view modifiers for glassmorphism, neon glow, LED borders
//

import SwiftUI

extension View {
    /// Glassmorphism card style
    func glassStyle(cornerRadius: CGFloat = 20) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color.glassWhite)
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.glassBorder, lineWidth: 1)
            )
            .shadow(color: Color.neonPurple.opacity(0.3), radius: 15, x: 0, y: 8)
    }
    
    /// Neon glow effect
    func neonGlow(color: Color = .neonPurple, radius: CGFloat = 12) -> some View {
        self
            .shadow(color: color.opacity(0.8), radius: radius / 2)
            .shadow(color: color.opacity(0.5), radius: radius)
            .shadow(color: color.opacity(0.3), radius: radius * 1.5)
    }
    
    /// Cyberpunk text style
    func cyberText(size: CGFloat = 16, weight: Font.Weight = .semibold) -> some View {
        self
            .font(.system(size: size, weight: weight, design: .rounded))
            .foregroundStyle(
                LinearGradient(
                    colors: [.neonBlue, .neonPurple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
    
    /// Conditional modifier helper
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
