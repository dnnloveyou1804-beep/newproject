import SwiftUI

struct ContentView: View {
    @EnvironmentObject var securityManager: SecurityManager
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            TabView {
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "square.grid.2x2.fill")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
            .opacity(securityManager.isUnlocked ? 1 : 0.01)
            
            if !securityManager.isUnlocked {
                VStack(spacing: 20) {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.accentColor)
                    
                    LocalizedText(key: "dashboard_title")
                        .font(.largeTitle.bold())
                    
                    Button("Unlock with FaceID / TouchID") {
                        securityManager.authenticate()
                    }
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea())
                .transition(.opacity)
                .onAppear {
                    securityManager.authenticate()
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                securityManager.lock()
            } else if phase == .active {
                if !securityManager.isUnlocked {
                    securityManager.authenticate()
                }
            }
        }
    }
}
