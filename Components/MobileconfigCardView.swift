import SwiftUI
import UniformTypeIdentifiers

struct MobileconfigCardView: View {
    @EnvironmentObject var localServer: LocalProfileServer
    @State private var showPicker = false
    @State private var selectedFileURL: URL? = nil
    @State private var isRainbowAnimating = false
    
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
                    
                    Text(selectedFileURL != nil ? selectedFileURL!.lastPathComponent : "Chưa chọn file cấu hình")
                        .font(.caption)
                        .foregroundColor(selectedFileURL != nil ? .green : .gray)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            
            HStack(spacing: 12) {
                Button(action: {
                    showPicker = true
                }) {
                    Text("Chọn File")
                        .font(.subheadline).bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    if let url = selectedFileURL {
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        localServer.installProfile(from: url)
                    }
                }) {
                    Text("Kích Hoạt")
                        .font(.subheadline).bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(selectedFileURL != nil ? Color.accentColor : Color.gray.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                .disabled(selectedFileURL == nil)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .fileImporter(
            isPresented: $showPicker,
            allowedContentTypes: [.item],
            allowsMultipleSelection: false
        ) { result in
            do {
                guard let selectedFile = try result.get().first else { return }
                if selectedFile.pathExtension == "CfnFf59sr1SbsqQ6JqTKsEusjKs~3D" {
                    selectedFileURL = selectedFile
                } else {
                    print("Invalid file extension: \(selectedFile.pathExtension)")
                }
            } catch {
                print("Failed to read file: \(error.localizedDescription)")
            }
        }
    }
}
