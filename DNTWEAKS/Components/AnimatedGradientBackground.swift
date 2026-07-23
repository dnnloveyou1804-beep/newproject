//
//  AnimatedGradientBackground.swift
//  DNTWEAKS IOS
//
//  Smooth animated cyber gradient + particle ready background
//

import SwiftUI

struct AnimatedGradientBackground: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            // Base dark
            Color.cyberBlack
                .ignoresSafeArea()
            
            // Animated mesh gradient layers
            GeometryReader { geo in
                ZStack {
                    // Purple blob
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.neonPurple.opacity(0.45), .clear],
                                center: .center,
                                startRadius: 20,
                                endRadius: 280
                            )
                        )
                        .frame(width: 420, height: 420)
                        .offset(
                            x: animate ? geo.size.width * 0.25 : -geo.size.width * 0.2,
                            y: animate ? -geo.size.height * 0.15 : geo.size.height * 0.2
                        )
                        .blur(radius: 60)
                    
                    // Blue blob
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.neonBlue.opacity(0.35), .clear],
                                center: .center,
                                startRadius: 10,
                                endRadius: 250
                            )
                        )
                        .frame(width: 380, height: 380)
                        .offset(
                            x: animate ? -geo.size.width * 0.3 : geo.size.width * 0.25,
                            y: animate ? geo.size.height * 0.25 : -geo.size.height * 0.1
                        )
                        .blur(radius: 70)
                    
                    // Pink accent
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.neonPink.opacity(0.25), .clear],
                                center: .center,
                                startRadius: 5,
                                endRadius: 180
                            )
                        )
                        .frame(width: 280, height: 280)
                        .offset(
                            x: animate ? geo.size.width * 0.1 : -geo.size.width * 0.15,
                            y: animate ? geo.size.height * 0.35 : geo.size.height * 0.05
                        )
                        .blur(radius: 50)
                }
            }
            .ignoresSafeArea()
            
            // Cyber grid overlay
            CyberGridView()
                .opacity(0.35)
                .ignoresSafeArea()
            
            // Floating particles
            ParticleView(particleCount: 45)
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
                animate = true
            }
        }
    }
}
