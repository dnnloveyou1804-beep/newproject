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
    let titleKey: String
    let icon: String
    let descKey: String
}
