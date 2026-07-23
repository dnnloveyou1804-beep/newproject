//
//  ContentView.swift
//  DNTWEAKS IOS
//
//  Root navigation controller – handles Splash → Login → Home flow
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            // Always present animated cyber background
            AnimatedGradientBackground()
                .ignoresSafeArea()
            
            if showSplash {
                SplashView {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        showSplash = false
                    }
                }
                .transition(.opacity)
            } else {
                if authViewModel.isAuthenticated {
                    HomeView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                } else {
                    LoginView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                }
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showSplash)
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: authViewModel.isAuthenticated)
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager.shared)
        .environmentObject(AuthViewModel())
}
