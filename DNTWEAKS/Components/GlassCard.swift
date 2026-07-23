//
//  GlassCard.swift
//  DNTWEAKS IOS
//

import SwiftUI

struct GlassCard<Content: View>: View {
    let content: Content
    var cornerRadius: CGFloat = 22
    var padding: CGFloat = 18
    
    init(cornerRadius: CGFloat = 22, padding: CGFloat = 18, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.ultraThinMaterial)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color.white.opacity(0.06))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.35),
                                Color.neonPurple.opacity(0.4),
                                Color.neonBlue.opacity(0.3),
                                Color.white.opacity(0.15)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.2
                    )
            )
            .shadow(color: Color.neonPurple.opacity(0.25), radius: 20, x: 0, y: 10)
            .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 4)
    }
}
