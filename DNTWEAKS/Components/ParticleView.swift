//
//  ParticleView.swift
//  DNTWEAKS IOS
//
//  Lightweight particle system – 60 FPS friendly
//

import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var opacity: Double
    var speed: CGFloat
    var color: Color
}

struct ParticleView: View {
    let particleCount: Int
    @State private var particles: [Particle] = []
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { p in
                    Circle()
                        .fill(p.color)
                        .frame(width: p.size, height: p.size)
                        .opacity(p.opacity)
                        .position(x: p.x, y: p.y)
                        .blur(radius: p.size > 3 ? 1.5 : 0)
                }
            }
            .onAppear {
                generateParticles(in: geo.size)
                startAnimation(in: geo.size)
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }
    
    private func generateParticles(in size: CGSize) {
        let colors: [Color] = [.neonPurple, .neonBlue, .neonCyan, .neonPink, .white]
        particles = (0..<particleCount).map { _ in
            Particle(
                x: CGFloat.random(in: 0...size.width),
                y: CGFloat.random(in: 0...size.height),
                size: CGFloat.random(in: 1.5...4.5),
                opacity: Double.random(in: 0.2...0.7),
                speed: CGFloat.random(in: 0.3...1.2),
                color: colors.randomElement()!
            )
        }
    }
    
    private func startAnimation(in size: CGSize) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { _ in
            for i in particles.indices {
                particles[i].y -= particles[i].speed
                if particles[i].y < -10 {
                    particles[i].y = size.height + 10
                    particles[i].x = CGFloat.random(in: 0...size.width)
                }
            }
        }
    }
}
