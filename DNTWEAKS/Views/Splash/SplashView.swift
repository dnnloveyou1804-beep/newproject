//
//  SplashView.swift
//  DNTWEAKS IOS
//
//  Logo appear → Glow → Scale → Particle → 3s → Login
//

import SwiftUI

struct SplashView: View {
    var onFinish: () -> Void
    
    @State private var logoScale: CGFloat = 0.3
    @State private var logoOpacity: Double = 0
    @State private var glowOpacity: Double = 0
    @State private var titleOpacity: Double = 0
    @State private var particleOpacity: Double = 0
    @State private var ringScale: CGFloat = 0.5
    @State private var ringOpacity: Double = 0
    
    var body: some View {
        ZStack {
            // Background already provided by ContentView
            
            // Expanding neon rings
            ForEach(0..<3) { i in
                Circle()
                    .stroke(
                        AngularGradient(
                            colors: [.neonPurple, .neonBlue, .neonPink, .neonPurple],
                            center: .center
                        ),
                        lineWidth: 2
                    )
                    .frame(width: 180 + CGFloat(i) * 50, height: 180 + CGFloat(i) * 50)
                    .scaleEffect(ringScale)
                    .opacity(ringOpacity * (1.0 - Double(i) * 0.25))
                    .blur(radius: 1)
            }
            
            VStack(spacing: 24) {
                // Logo circle
                ZStack {
                    // Outer glow
                    Circle()
                        .fill(Color.neonPurple.opacity(glowOpacity * 0.4))
                        .frame(width: 160, height: 160)
                        .blur(radius: 30)
                    
                    // Glass circle
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 130, height: 130)
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: [.neonPurple, .neonBlue],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                        )
                        .shadow(color: .neonPurple.opacity(0.6), radius: 20)
                    
                    // Logo text
                    Text("DN")
                        .font(.system(size: 48, weight: .black, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, .neonBlue],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .neonGlow(color: .neonPurple, radius: 10)
                }
                .scaleEffect(logoScale)
                .opacity(logoOpacity)
                
                // Title
                VStack(spacing: 6) {
                    Text("DNTWEAKS")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.neonPurple, .neonBlue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .neonGlow(color: .neonPurple, radius: 8)
                    
                    Text("IOS")
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundColor(.neonCyan)
                        .tracking(8)
                }
                .opacity(titleOpacity)
            }
            
            // Particles overlay
            ParticleView(particleCount: 30)
                .opacity(particleOpacity)
                .allowsHitTesting(false)
        }
        .onAppear {
            // Sequence animation
            withAnimation(.spring(response: 0.8, dampingFraction: 0.65)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            
            withAnimation(.easeIn(duration: 0.6).delay(0.3)) {
                glowOpacity = 1.0
            }
            
            withAnimation(.easeOut(duration: 0.9).delay(0.2)) {
                ringScale = 1.3
                ringOpacity = 0.7
            }
            
            withAnimation(.easeIn(duration: 0.5).delay(0.5)) {
                titleOpacity = 1.0
            }
            
            withAnimation(.easeIn(duration: 0.8).delay(0.4)) {
                particleOpacity = 1.0
            }
            
            // Auto transition after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    logoOpacity = 0
                    titleOpacity = 0
                    ringOpacity = 0
                    particleOpacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    onFinish()
                }
            }
            
            HapticManager.shared.impact(.light)
        }
    }
}
