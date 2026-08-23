import SwiftUI

struct GameBoosterView: View {
    let gameName: String
    let bundleId: String
    let icon: String
    var imageName: String? = nil
    
    @EnvironmentObject var profileManager: ProfileManager
    @EnvironmentObject var lang: LanguageManager
    
    @State private var isLaunching = false
    @State private var launchStep = 0
    
    let launchSteps = ["ram_clearing", "network_tuning", "optimizing", "launching"]
    
    var body: some View {
        HStack {
            if let img = imageName, let uiImage = UIImage(named: img) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .frame(width: 50, height: 50)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(gameName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(bundleId)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                startLaunchSequence()
            }) {
                Text(lang.localizedString(for: "optimize_play"))
                    .font(.caption).bold()
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.accentColor)
                    .foregroundColor(.black)
                    .cornerRadius(20)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            Group {
                if isLaunching {
                    ZStack {
                        Color.black.opacity(0.8)
                            .cornerRadius(20)
                        
                        VStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                                .scaleEffect(1.5)
                                .padding(.bottom, 8)
                            
                            LocalizedText(key: launchSteps[launchStep])
                                .font(.caption).bold()
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
        )
    }
    
    private func startLaunchSequence() {
        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        
        // 1. Force Gaming Profile
        profileManager.applyProfile(.gaming)
        
        // 2. Start Animation
        isLaunching = true
        launchStep = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
            if launchStep < launchSteps.count - 1 {
                launchStep += 1
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } else {
                timer.invalidate()
                openGame()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isLaunching = false
                }
            }
        }
    }
    
    private func openGame() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        
        // Try opening with custom URL scheme commonly used by Free Fire
        // Since we can't use private LSApplicationWorkspace in standard SwiftUI
        let urlScheme = gameName.contains("Max") ? "freefiremax://" : "freefire://"
        if let url = URL(string: urlScheme) {
            UIApplication.shared.open(url)
        }
    }
}
