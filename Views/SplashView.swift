import SwiftUI

struct SplashView: View {
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var glowOffset: CGFloat = 0.0
    @State private var isFinished = false
    
    // Router bindings
    @Binding var showSplash: Bool
    
    var body: some View {
        if isFinished {
            ContentView()
        } else {
            ZStack {
                Color.black.ignoresSafeArea()
                
                // Background subtle glow
                Circle()
                    .fill(Color.accentColor.opacity(0.15))
                    .frame(width: 300, height: 300)
                    .blur(radius: 50)
                    .scaleEffect(size)
                    .opacity(opacity)
                
                VStack(spacing: 20) {
                    Image(systemName: "cpu.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.accentColor)
                        .shadow(color: .accentColor, radius: 10 + glowOffset)
                    
                    Text("DN TWEAKS")
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .white.opacity(0.5), radius: 5 + glowOffset)
                    
                    Text("Admin: DucThinh")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .tracking(2.0)
                        .opacity(opacity)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    // Animation sequence
                    withAnimation(.easeIn(duration: 1.0)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                    
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        self.glowOffset = 15.0
                    }
                    
                    // Transition to main app after 3 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.opacity = 0.0
                            self.size = 1.2
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.showSplash = false
                        }
                    }
                }
            }
        }
    }
}
