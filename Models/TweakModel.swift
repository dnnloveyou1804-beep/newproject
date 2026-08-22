import SwiftUI

enum TweakType {
    case refreshRate
    case performance
    case pointerSpeed
    case touchSensitivity
    case latency
    case haptic
    case battery
    case theme
    case badge
    case reset
}

struct TweakItem: Identifiable {
    let id = UUID()
    let type: TweakType
    let title: String
    let icon: String
    let description: String
    let isReal: Bool
}
