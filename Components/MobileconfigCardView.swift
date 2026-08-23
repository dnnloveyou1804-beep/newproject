import SwiftUI

struct MobileconfigCardView: View {
    @EnvironmentObject var localServer: LocalProfileServer
    @State private var showAlert = false
    
    var body: some View {
        Button(action: {
            if Bundle.main.url(forResource: "DucThinh", withExtension: "mobileconfig") != nil {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                localServer.installProfile()
            } else {
                self.showAlert = true
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }
        }) {
            HStack(spacing: 16) {
                Image(systemName: "gearbadge")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(16)
                    .shadow(color: .purple.opacity(0.5), radius: 8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Cấu Hình Hệ Thống")
                        .font(.headline.bold())
                        .foregroundColor(.white)
                    
                    Text("DucThinh.mobileconfig")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "icloud.and.arrow.down.fill")
                    .font(.title2)
                    .foregroundColor(.accentColor)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .alert("File Not Found", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("DucThinh.mobileconfig was not found in the app bundle. Please ensure it was included during compilation.")
        }
    }
}
