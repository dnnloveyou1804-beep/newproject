import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: "wrench.and.screwdriver.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                Text("About DN Tweaks")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity)
                
                Text("This application is a demo/portfolio interface. It is explicitly designed to illustrate what a system tweak panel might look like on an iOS device. It does not alter system configurations.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Real in-app effects:")
                        .font(.headline)
                        .foregroundColor(.green)
                    Text("• Performance Profile (Animation speeds)\n• Touch Sensitivity (Test area threshold)\n• Haptic Feedback\n• Battery Saver (Status read)\n• App Theme Engine")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("UI Illustrations (No system effect):")
                        .font(.headline)
                        .foregroundColor(.orange)
                    Text("• Display Refresh Rate\n• Pointer Speed\n• Input Latency\n• Notification Badge")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
            }
            .padding()
        }
        .navigationTitle("About")
    }
}
