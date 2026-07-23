//
//  AuthViewModel.swift
//  DNTWEAKS IOS
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var rememberLogin: Bool = false
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    
    private let authService = AuthService.shared
    
    init() {
        if authService.isRemembered, let saved = authService.savedUsername {
            username = saved
            rememberLogin = true
        }
    }
    
    func login() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter username and password"
            showError = true
            HapticManager.shared.notification(.error)
            SoundManager.shared.playError()
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Simulate network delay for cyber feel
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            guard let self = self else { return }
            
            let success = self.authService.login(username: self.username, password: self.password)
            
            if success {
                self.authService.saveRemember(username: self.username, remember: self.rememberLogin)
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    self.isAuthenticated = true
                }
                HapticManager.shared.notification(.success)
                SoundManager.shared.playSuccess()
            } else {
                self.errorMessage = "Invalid credentials. Try ducnamtweaks / ducnam123"
                self.showError = true
                HapticManager.shared.notification(.error)
                SoundManager.shared.playError()
            }
            self.isLoading = false
        }
    }
    
    func logout() {
        withAnimation {
            isAuthenticated = false
            password = ""
        }
        HapticManager.shared.impact(.medium)
    }
}
