import SwiftUI

class SystemStatsManager: ObservableObject {
    @Published var batteryLevel: Float = 0.0
    @Published var batteryState: UIDevice.BatteryState = .unknown
    
    private var timer: Timer?
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        updateStats()
        
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.updateStats()
        }
    }
    
    func updateStats() {
        self.batteryLevel = UIDevice.current.batteryLevel
        self.batteryState = UIDevice.current.batteryState
    }
    
    var batteryPercentageString: String {
        if batteryLevel < 0 { return "--%" }
        return "\(Int(batteryLevel * 100))%"
    }
    
    var isCharging: Bool {
        return batteryState == .charging || batteryState == .full
    }
}
