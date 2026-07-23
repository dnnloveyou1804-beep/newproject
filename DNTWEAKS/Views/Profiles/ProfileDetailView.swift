//
//  ProfileDetailView.swift
//  DNTWEAKS IOS
//
//  Placeholder detail (main flow handled in HomeView)
//

import SwiftUI

struct ProfileDetailView: View {
    let profile: ProfileType
    
    var body: some View {
        Text(profile.rawValue)
            .cyberText()
    }
}
