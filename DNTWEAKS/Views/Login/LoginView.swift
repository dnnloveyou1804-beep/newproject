//
//  LoginView.swift
//  DNTWEAKS IOS
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var appear = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                Spacer().frame(height: 40)
                
                // Logo + Brand
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(Color.neonPurple.opacity(0.25))
                            .frame(width: 110, height: 110)
                            .blur(radius: 25)
                        
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 90, height: 90)
                            .overlay(
                                Circle()
                                    .stroke(
                                        LinearGradient(colors: [.neonPurple, .neonBlue], startPoint: .topLeading, endPoint: .bottomTrailing),
                                        lineWidth: 2.5
                                    )
                            )
                            .ledBorder(cornerRadius: 45, lineWidth: 2)
                        
                        Text("DN")
                            .font(.system(size: 34, weight: .black, design: .rounded))
                            .foregroundStyle(LinearGradient(colors: [.white, .neonBlue], startPoint: .top, endPoint: .bottom))
                    }
                    .scaleEffect(appear ? 1 : 0.6)
                    .opacity(appear ? 1 : 0)
                    
                    Text("DUCNAMTWEAKS")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(colors: [.neonPurple, .neonBlue, .neonCyan], startPoint: .leading, endPoint: .trailing)
                        )
                        .neonGlow(color: .neonPurple, radius: 6)
                        .opacity(appear ? 1 : 0)
                        .offset(y: appear ? 0 : 20)
                }
                
                // Form Card
                GlassCard {
                    VStack(spacing: 20) {
                        // Username
                        VStack(alignment: .leading, spacing: 8) {
                            Label("USERNAME", systemImage: "person.fill")
                                .font(.system(size: 12, weight: .semibold, design: .monospaced))
                                .foregroundColor(.neonCyan)
                                .tracking(1)
                            
                            TextField("", text: $authViewModel.username)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .padding(14)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.white.opacity(0.07))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(Color.neonPurple.opacity(0.4), lineWidth: 1)
                                        )
                                )
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                        }
                        
                        // Password
                        VStack(alignment: .leading, spacing: 8) {
                            Label("PASSWORD", systemImage: "lock.fill")
                                .font(.system(size: 12, weight: .semibold, design: .monospaced))
                                .foregroundColor(.neonCyan)
                                .tracking(1)
                            
                            SecureField("", text: $authViewModel.password)
                                .padding(14)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.white.opacity(0.07))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(Color.neonBlue.opacity(0.4), lineWidth: 1)
                                        )
                                )
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                        }
                        
                        // Remember
                        Toggle(isOn: $authViewModel.rememberLogin) {
                            Text("Remember Login")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.85))
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .neonPurple))
                        .padding(.top, 4)
                        
                        // Error
                        if authViewModel.showError, let msg = authViewModel.errorMessage {
                            Text(msg)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.neonPink)
                                .multilineTextAlignment(.center)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                        
                        // Login Button
                        NeonButton(
                            authViewModel.isLoading ? "AUTHENTICATING..." : "LOGIN",
                            icon: authViewModel.isLoading ? "hourglass" : "arrow.right.circle.fill",
                            color: .neonPurple
                        ) {
                            authViewModel.login()
                        }
                        .disabled(authViewModel.isLoading)
                        .opacity(authViewModel.isLoading ? 0.7 : 1)
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal, 24)
                .opacity(appear ? 1 : 0)
                .offset(y: appear ? 0 : 40)
                
                // Hint
                Text("Default: ducnamtweaks / ducnam123")
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(.white.opacity(0.4))
                    .opacity(appear ? 1 : 0)
                
                Spacer().frame(height: 60)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.1)) {
                appear = true
            }
        }
    }
}
