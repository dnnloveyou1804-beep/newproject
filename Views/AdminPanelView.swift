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
                Section(header: Text("Quản lý Key Server")) {
                    Text("Hệ thống License Key hiện tại đã được nâng cấp lên Backend API (ddnkey.ddnstore). Vui lòng sử dụng Web Panel để quản lý và tạo Key.")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Link(destination: URL(string: "https://ddnkey.ddnstore.workers.dev")!) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Mở Web Admin Panel")
                                .bold()
                        }
                        .foregroundColor(.accentColor)
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
