//
//  ProgressRing.swift
//  DNTWEAKS IOS
//

import SwiftUI

struct ProgressRing: View {
    var progress: Double
    var lineWidth: CGFloat = 10
    var size: CGFloat = 120
    
    @State private var animatedProgress: Double = 0
    
    var body: some View {
        ZStack {
            // Track
            Circle()
                .stroke(Color.white.opacity(0.1), lineWidth: lineWidth)
            
            // Progress
            Circle()
                .trim(from: 0, to: animatedProgress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            .neonPurple,
                            .neonBlue,
                            .neonCyan,
                            .neonPurple
                        ]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .shadow(color: .neonPurple.opacity(0.7), radius: 8)
            
            // Center text
            VStack(spacing: 2) {
                Text("\(Int(animatedProgress * 100))%")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(colors: [.neonBlue, .neonPurple], startPoint: .leading, endPoint: .trailing)
                    )
                Text("PROCESSING")
                    .font(.system(size: 10, weight: .semibold, design: .monospaced))
                    .foregroundColor(.white.opacity(0.6))
                    .tracking(1.5)
            }
        }
        .frame(width: size, height: size)
        .onChange(of: progress) { newValue in
            withAnimation(.easeInOut(duration: 0.15)) {
                animatedProgress = newValue
            }
        }
        .onAppear {
            animatedProgress = progress
        }
    }
}
