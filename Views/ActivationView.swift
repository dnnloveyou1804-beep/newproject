import SwiftUI

struct ActivationView: View {
    @EnvironmentObject var licenseManager: LicenseManager
    @EnvironmentObject var lang: LanguageManager
    
    @State private var inputKey = ""
    @State private var showError = false
    
    // Hidden admin entry
    @State private var titleTapCount = 0
    @State private var showAdminLogin = false
    @State private var adminPasswordInput = ""
    @State private var showAdminPanel = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Logo & Title (With hidden gesture)
                VStack(spacing: 8) {
                    Image(systemName: "cpu.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.accentColor)
                    
                    Text("DN TWEAKS PRO")
                        .font(.system(.title, design: .rounded).bold())
                        .foregroundColor(.white)
                        .onTapGesture {
                            titleTapCount += 1
                            if titleTapCount >= 5 {
                                showAdminLogin = true
                                titleTapCount = 0
                            }
                        }
                }
                
                VStack(spacing: 12) {
                    LocalizedText(key: "activation_required")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text(licenseManager.deviceID)
                        .font(.system(.title2, design: .monospaced).bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                    
                    Button(action: {
                        UIPasteboard.general.string = licenseManager.deviceID
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }) {
                        Label(lang.localizedString(for: "copy_device_id"), systemImage: "doc.on.doc")
                            .font(.subheadline.bold())
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.vertical, 20)
                
                VStack(spacing: 16) {
                    TextField(lang.localizedString(for: "enter_license_key"), text: $inputKey)
                        .font(.system(.body, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .autocapitalization(.allCharacters)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(showError ? Color.red : Color.clear, lineWidth: 1)
                        )
                    
                    if showError {
                        LocalizedText(key: "invalid_key")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        let success = licenseManager.activate(with: inputKey)
                        if !success {
                            showError = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showError = false
                            }
                        }
                    }) {
                        Text(lang.localizedString(for: "activate_now"))
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                LocalizedText(key: "contact_admin_desc")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
        // Admin Login Alert
        .alert("Admin Login", isPresented: $showAdminLogin) {
            SecureField("Password", text: $adminPasswordInput)
            Button("Cancel", role: .cancel) { adminPasswordInput = "" }
            Button("Login") {
                if adminPasswordInput == licenseManager.adminPassword {
                    showAdminPanel = true
                } else {
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                }
                adminPasswordInput = ""
            }
        } message: {
            Text("Enter master password to access Keygen.")
        }
        .fullScreenCover(isPresented: $showAdminPanel) {
            AdminPanelView()
        }
    }
}
