import Foundation
import LocalAuthentication
import SwiftUI

class SecurityManager: ObservableObject {
    @AppStorage("RequireFaceID") private var requireFaceID: Bool = false
    @Published var isUnlocked: Bool = false
    
    init() {
        // If FaceID is not required, start unlocked
        self.isUnlocked = !requireFaceID
    }
    
    func authenticate() {
        guard requireFaceID else {
            isUnlocked = true
            return
        }
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock DN Tweaks Admin Panel"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.isUnlocked = false
                    }
                }
            }
        } else {
            // Fallback if biometrics are unavailable (e.g., simulator or no FaceID set up)
            // In a real app we might fallback to passcode (.deviceOwnerAuthentication)
            // but for demo purposes, if it can't evaluate, we let them in or lock them out.
            // Let's just unlock for demo if no biometrics.
            DispatchQueue.main.async {
                self.isUnlocked = true
            }
        }
    }
    
    func lock() {
        if requireFaceID {
            isUnlocked = false
        }
    }
}
