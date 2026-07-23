//
//  NeonButton.swift
//  DNTWEAKS IOS
//
//  Premium neon button with LED border, glow, press & ripple
//

import SwiftUI

struct NeonButton: View {
    let title: String
    let icon: String?
    let color: Color
    let action: () -> Void
    
    @State private var isPressed = false
    @State private var showRipple = false
    @State private var rippleScale: CGFloat = 0.5
    @State private var rippleOpacity: Double = 0.6
    
    init(_ title: String, icon: String? = nil, color: Color = .neonPurple, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            // Press animation
            withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) {
                isPressed = true
            }
            // Ripple
            showRipple = true
            rippleScale = 0.5
            rippleOpacity = 0.55
            withAnimation(.easeOut(duration: 0.55)) {
                rippleScale = 2.2
                rippleOpacity = 0
            }
            
            HapticManager.shared.impact(.medium)
            SoundManager.shared.playTap()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    isPressed = false
                }
                action()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                showRipple = false
            }
        }) {
            ZStack {
                // Base glass
                RoundedRectangle(cornerRadius: 18)
                    .fill(
                        LinearGradient(
                            colors: [
                                color.opacity(0.25),
                                color.opacity(0.08)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.ultraThinMaterial)
                    )
                
                // Content
                HStack(spacing: 12) {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(color)
                            .neonGlow(color: color, radius: 8)
                    }
                    Text(title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: color.opacity(0.8), radius: 6)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                
                // Ripple overlay
                if showRipple {
                    Circle()
                        .fill(color.opacity(0.4))
                        .scaleEffect(rippleScale)
                        .opacity(rippleOpacity)
                        .frame(width: 60, height: 60)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .ledBorder(cornerRadius: 18, lineWidth: 2.2)
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .shadow(color: color.opacity(isPressed ? 0.6 : 0.35), radius: isPressed ? 8 : 14, y: isPressed ? 2 : 6)
        }
        .buttonStyle(.plain)
    }
}
