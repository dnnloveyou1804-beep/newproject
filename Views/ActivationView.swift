import SwiftUI

struct ActivationView: View {
    @EnvironmentObject var licenseManager: LicenseManager
    @EnvironmentObject var lang: LanguageManager
    
    @State private var inputKey = ""
    @State private var showError = false
    @State private var isActivating = false
    
    // Hidden admin entry
    @State private var titleTapCount = 0
    @State private var showAdminLogin = false
    @State private var adminPasswordInput = ""
    @State private var showAdminPanel = false
    
    var body: some View {
        ZStack {
            // Animated Background Gradient
            LinearGradient(colors: [Color.black, Color.accentColor.opacity(0.2), Color.black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            // Floating geometric shapes
            Circle()
                .fill(Color.accentColor.opacity(0.3))
                .frame(width: 200, height: 200)
                .blur(radius: 60)
                .offset(x: -100, y: -200)
            
            Circle()
                .fill(Color.blue.opacity(0.3))
                .frame(width: 250, height: 250)
                .blur(radius: 80)
                .offset(x: 150, y: 250)
            
            VStack(spacing: 30) {
                Spacer()
                
                // Logo & Title
                VStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.accentColor)
                        .shadow(color: .accentColor.opacity(0.5), radius: 10)
                    
                    Text("PRO EDITION")
                        .font(.system(size: 28, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .white.opacity(0.5), radius: 5)
                        .onTapGesture {
                            titleTapCount += 1
                            if titleTapCount >= 5 {
                                showAdminLogin = true
                                titleTapCount = 0
                            }
                        }
                }
                
                // Device ID Card (Glassmorphism)
                VStack(spacing: 12) {
                    LocalizedText(key: "activation_required")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text(licenseManager.deviceID)
                        .font(.system(.title2, design: .monospaced).bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                    
                    Button(action: {
                        UIPasteboard.general.string = licenseManager.deviceID
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }) {
                        Label(lang.localizedString(for: "copy_device_id"), systemImage: "doc.on.doc.fill")
                            .font(.subheadline.bold())
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.vertical, 10)
                
                // Input Field
                VStack(spacing: 16) {
                    TextField(lang.localizedString(for: "enter_license_key"), text: $inputKey)
                        .font(.system(.body, design: .monospaced).bold())
                        .multilineTextAlignment(.center)
                        .autocapitalization(.allCharacters)
                        .disableAutocorrection(true)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(showError ? Color.red : (inputKey.isEmpty ? Color.white.opacity(0.2) : Color.accentColor), lineWidth: 2)
                        )
                        .shadow(color: showError ? .red.opacity(0.5) : (inputKey.isEmpty ? .clear : .accentColor.opacity(0.5)), radius: 5)
                        .animation(.easeInOut, value: inputKey)
                    
                    if showError {
                        LocalizedText(key: "invalid_key")
                            .font(.caption.bold())
                            .foregroundColor(.red)
                            .transition(.opacity)
                    }
                    
                    Button(action: {
                        handleActivation()
                    }) {
                        HStack {
                            if isActivating {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            } else {
                                Text(lang.localizedString(for: "activate_now"))
                                    .font(.headline.bold())
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.black)
                        .cornerRadius(16)
                        .shadow(color: .accentColor.opacity(0.5), radius: 10)
                    }
                    .disabled(inputKey.isEmpty || isActivating)
                    .opacity(inputKey.isEmpty ? 0.5 : 1.0)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                LocalizedText(key: "contact_admin_desc")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
            }
        }
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
        }
        .fullScreenCover(isPresented: $showAdminPanel) {
            AdminPanelView()
        }
    }
    
    private func handleActivation() {
        isActivating = true
        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        
        // Simulate a slight network delay for dramatic effect
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let success = licenseManager.activate(with: inputKey)
            if success {
                // The ContentView will automatically transition because isLicensed changed!
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            } else {
                showError = true
                isActivating = false
                UINotificationFeedbackGenerator().notificationOccurred(.error)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showError = false
                }
            }
        }
    }
}
