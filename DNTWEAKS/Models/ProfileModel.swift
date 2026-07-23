//
//  ProfileModel.swift
//  DNTWEAKS IOS
//
//  Profile types that simulate config activation (sandbox only)
//

import Foundation
import SwiftUI

enum ProfileType: String, CaseIterable, Identifiable {
    case performance = "Performance Profile"
    case gaming = "Gaming Profile"
    case touch = "Touch Profile"
    case graphics = "Graphics Profile"
    case network = "Network Profile"
    case battery = "Battery Profile"
    case backup = "Backup Config"
    case restore = "Restore Config"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .performance: return "bolt.fill"
        case .gaming: return "gamecontroller.fill"
        case .touch: return "hand.tap.fill"
        case .graphics: return "paintbrush.fill"
        case .network: return "network"
        case .battery: return "battery.100.bolt"
        case .backup: return "arrow.up.doc.fill"
        case .restore: return "arrow.down.doc.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .performance: return .neonGreen
        case .gaming: return .neonPink
        case .touch: return .neonCyan
        case .graphics: return .neonPurple
        case .network: return .neonBlue
        case .battery: return .neonGreen
        case .backup: return .neonBlue
        case .restore: return .neonPink
        }
    }
}

struct SelectedFileInfo: Identifiable {
    let id = UUID()
    var name: String
    var size: String
    var path: String
}
