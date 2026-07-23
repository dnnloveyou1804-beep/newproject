//
//  DeviceInfoModel.swift
//  DNTWEAKS IOS
//
//  Model holding device & app information (sandbox-safe)
//

import Foundation
import UIKit

struct DeviceInfoModel: Identifiable {
    let id = UUID()
    
    // Device
    var model: String
    var deviceName: String
    var systemVersion: String
    var totalStorage: String
    var freeStorage: String
    var cpuInfo: String
    var ramInfo: String
    var batteryLevel: String
    var isLowPowerMode: Bool
    var isDarkMode: Bool
    
    // App
    var appVersion: String
    var buildNumber: String
    var bundleIdentifier: String
    var buildDate: String
    
    static var current: DeviceInfoModel {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        
        let totalSpace = DeviceService.shared.totalDiskSpace
        let freeSpace = DeviceService.shared.freeDiskSpace
        
        return DeviceInfoModel(
            model: DeviceService.shared.deviceModel,
            deviceName: device.name,
            systemVersion: "iOS \(device.systemVersion)",
            totalStorage: totalSpace,
            freeStorage: freeSpace,
            cpuInfo: DeviceService.shared.cpuInfo,
            ramInfo: DeviceService.shared.ramInfo,
            batteryLevel: "\(Int(device.batteryLevel * 100))%",
            isLowPowerMode: ProcessInfo.processInfo.isLowPowerModeEnabled,
            isDarkMode: true, // Forced dark
            appVersion: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0",
            buildNumber: Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1",
            bundleIdentifier: Bundle.main.bundleIdentifier ?? "com.dntweaks.ios",
            buildDate: DeviceService.shared.buildDate
        )
    }
}
