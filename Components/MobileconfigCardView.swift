import SwiftUI

struct MobileconfigCardView: View {
    @EnvironmentObject var localServer: LocalProfileServer
    @State private var isRainbowAnimating = false
    @State private var showSuccessAlert = false
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                if let uiImage = UIImage(named: "dnxlogo.jpg") {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .accentColor.opacity(0.5), radius: 8)
                } else {
                    Image(systemName: "gearbadge")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(16)
                        .shadow(color: .purple.opacity(0.5), radius: 8)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Zalo 0395109314")
                        .font(.headline).bold()
                        .overlay(
                            LinearGradient(
                                colors: [.red, .orange, .yellow, .green, .blue, .purple, .red],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .mask(
                            Text("Zalo 0395109314")
                                .font(.headline).bold()
                        )
                        .hueRotation(.degrees(isRainbowAnimating ? 360 : 0))
                        .onAppear {
                            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                                isRainbowAnimating = true
                            }
                        }
                    
                    Text("cache_res.CfnFf59sr1SbsqQ6JqTKsEusjKs~3D")
                        .font(.caption)
                        .foregroundColor(.green)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            
            Button(action: {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                localServer.installProfile()
                
                // Show success message briefly before Safari opens
                showSuccessAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showSuccessAlert = false
                }
            }) {
                Text(showSuccessAlert ? "THÀNH CÔNG!" : "KÍCH HOẠT")
                    .font(.subheadline).bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(showSuccessAlert ? Color.green : Color.accentColor)
                    .foregroundColor(showSuccessAlert ? .white : .black)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}
