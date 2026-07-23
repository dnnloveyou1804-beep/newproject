//
//  LEDBorder.swift
//  DNTWEAKS IOS
//
//  Continuous RGB LED running border animation
//

import SwiftUI

struct LEDBorder: View {
    let cornerRadius: CGFloat
    let lineWidth: CGFloat
    @State private var phase: CGFloat = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(
                AngularGradient(
                    gradient: Gradient(colors: [
                        .neonPurple,
                        .neonBlue,
                        .neonCyan,
                        .neonGreen,
                        .neonPink,
                        .neonPurple
                    ]),
                    center: .center,
                    angle: .degrees(phase)
                ),
                lineWidth: lineWidth
            )
            .blur(radius: 1.5)
            .onAppear {
                withAnimation(.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                    phase = 360
                }
            }
    }
}

struct LEDBorderModifier: ViewModifier {
    let cornerRadius: CGFloat
    let lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LEDBorder(cornerRadius: cornerRadius, lineWidth: lineWidth)
            )
    }
}

extension View {
    func ledBorder(cornerRadius: CGFloat = 18, lineWidth: CGFloat = 2.5) -> some View {
        modifier(LEDBorderModifier(cornerRadius: cornerRadius, lineWidth: lineWidth))
    }
}
