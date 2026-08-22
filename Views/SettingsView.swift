import SwiftUI

struct SettingsView: View {
    @State private var showResetAlert = false
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: AboutView()) {
                    Label("About DN Tweaks", systemImage: "info.circle")
                }
                
                Button(role: .destructive) {
                    showResetAlert = true
                } label: {
                    Label("Reset All Tweaks", systemImage: "arrow.counterclockwise")
                }
                .alert("Reset All Tweaks", isPresented: $showResetAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Reset", role: .destructive) {
                        // Handle reset
                    }
                } message: {
                    Text("Are you sure you want to reset all tweak preferences to default?")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
