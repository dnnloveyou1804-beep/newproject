import SwiftUI

struct AdminPanelView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var lang: LanguageManager
    @EnvironmentObject var licenseManager: LicenseManager
    
    @State private var inputDeviceID = ""
    @State private var generatedKey = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Key Generator")) {
                    TextField("Enter Client Device ID (e.g. ABC-123)", text: $inputDeviceID)
                        .autocapitalization(.allCharacters)
                        .disableAutocorrection(true)
                    
                    Button("Generate License Key") {
                        if !inputDeviceID.isEmpty {
                            generatedKey = licenseManager.generateKey(for: inputDeviceID.uppercased())
                            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                        }
                    }
                    .foregroundColor(.accentColor)
                }
                
                if !generatedKey.isEmpty {
                    Section(header: Text("Generated Key")) {
                        HStack {
                            Text(generatedKey)
                                .font(.system(.body, design: .monospaced).bold())
                                .foregroundColor(.green)
                            
                            Spacer()
                            
                            Button(action: {
                                UIPasteboard.general.string = generatedKey
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }) {
                                Image(systemName: "doc.on.doc")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Admin Panel")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
