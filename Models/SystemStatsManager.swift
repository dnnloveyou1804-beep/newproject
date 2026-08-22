import SwiftUI

class SystemStatsManager: ObservableObject {
    @Published var batteryLevel: Float = 0.0
    @Published var batteryState: UIDevice.BatteryState = .unknown
    @Published var deviceName: String = UIDevice.current.name
    @Published var osVersion: String = UIDevice.current.systemVersion
    @Published var freeStorage: String = "Unknown"
    @Published var totalStorage: String = "Unknown"
    @Published var ramUsage: String = "Unknown"
    
    private var timer: Timer?
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        updateStats()
        updateHardwareInfo()
        
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.updateStats()
        }
    }
    
    private func updateHardwareInfo() {
        // Disk Space
        if let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last,
           let dictionary = try? FileManager.default.attributesOfFileSystem(forPath: paths) {
            
            let freeSpace = dictionary[.systemFreeSize] as? Int64 ?? 0
            let totalSpace = dictionary[.systemSize] as? Int64 ?? 0
            
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = [.useGB]
            formatter.countStyle = .file
            
            self.freeStorage = formatter.string(fromByteCount: freeSpace)
            self.totalStorage = formatter.string(fromByteCount: totalSpace)
        }
        
        // RAM usage (approximate using ProcessInfo physicalMemory for total)
        let totalRAM = ProcessInfo.processInfo.physicalMemory
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB]
        formatter.countStyle = .memory
        self.ramUsage = formatter.string(fromByteCount: Int64(totalRAM))
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
