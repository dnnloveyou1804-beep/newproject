//
//  DNTWEAKSApp.swift
//  DNTWEAKS IOS
//
//  Created by Dinh Duc Nam
//  Cyberpunk / Sci-Fi UI Toolkit
//

import SwiftUI

@main
struct DNTWEAKSApp: App {
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .environmentObject(authViewModel)
                .preferredColorScheme(.dark) // Force Dark Mode by default
                .onAppear {
                    // Configure global appearance
                    configureAppearance()
                }
        }
    }
    
    private func configureAppearance() {
        // Global UIKit appearance overrides for cyberpunk look
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.cyberBlack)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.neonPurple),
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        UITableView.appearance().backgroundColor = .clear
        UIScrollView.appearance().backgroundColor = .clear
    }
}
