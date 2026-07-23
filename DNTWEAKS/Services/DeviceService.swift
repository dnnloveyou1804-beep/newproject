//
//  DeviceService.swift
//  DNTWEAKS IOS
//
//  Safe device information helpers (no private APIs)
//

import Foundation
import UIKit

final class DeviceService {
    static let shared = DeviceService()
    private init() {}
    
    var deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return mapToDeviceName(identifier)
    }
    
    private func mapToDeviceName(_ identifier: String) -> String {
        // Simplified mapping – real devices will show correct model
        switch identifier {
        case "iPhone14,2": return "iPhone 13 Pro"
        case "iPhone14,3": return "iPhone 13 Pro Max"
        case "iPhone15,2": return "iPhone 14 Pro"
        case "iPhone15,3": return "iPhone 14 Pro Max"
        case "iPhone16,1": return "iPhone 15 Pro"
        case "iPhone16,2": return "iPhone 15 Pro Max"
        case "iPhone17,1": return "iPhone 16 Pro"
        case "iPhone17,2": return "iPhone 16 Pro Max"
        case "x86_64", "arm64": return "Simulator"
        default: return identifier
        }
    }
    
    var totalDiskSpace: String {
        guard let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
              let total = attrs[.systemSize] as? Int64 else { return "N/A" }
        return ByteCountFormatter.string(fromByteCount: total, countStyle: .file)
    }
    
    var freeDiskSpace: String {
        guard let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
              let free = attrs[.systemFreeSize] as? Int64 else { return "N/A" }
        return ByteCountFormatter.string(fromByteCount: free, countStyle: .file)
    }
    
    var cpuInfo: String {
        // Public info only
        ProcessInfo.processInfo.processorCount.description + " cores"
    }
    
    var ramInfo: String {
        let total = ProcessInfo.processInfo.physicalMemory
        return ByteCountFormatter.string(fromByteCount: Int64(total), countStyle: .memory)
    }
    
    var buildDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
