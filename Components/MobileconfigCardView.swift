import SwiftUI

struct MobileconfigCardView: View {
    @State private var showShareSheet = false
    @State private var fileURL: URL?
    @State private var showAlert = false
    
    var body: some View {
        Button(action: {
            // Attempt to find the file in the main bundle
            if let url = Bundle.main.url(forResource: "DucThinh", withExtension: "mobileconfig") {
                self.fileURL = url
                self.showShareSheet = true
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
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
                    Text("System Profile")
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
        .sheet(isPresented: $showShareSheet) {
            if let url = fileURL {
                ShareSheet(activityItems: [url])
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
