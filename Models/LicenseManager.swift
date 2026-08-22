import Foundation
import SwiftUI
import CryptoKit

class LicenseManager: ObservableObject {
    @AppStorage("IsAppLicensed") private(set) var isLicensed: Bool = false
    @AppStorage("SavedLicenseKey") private var savedKey: String = ""
    
    private let secretSalt = "DNTWEAKS_PRO_VIP_2026"
    let adminPassword = "dn1804"
    
    @Published var deviceID: String = ""
    
    init() {
        self.deviceID = getDeviceID()
        
        // Double check validity on startup
        if isLicensed {
            if !validateKey(savedKey, for: deviceID) {
                isLicensed = false
                savedKey = ""
            }
        }
    }
    
    func getDeviceID() -> String {
        guard let vendorID = UIDevice.current.identifierForVendor?.uuidString else {
            return "UNKNOWN-DEVICE"
        }
        // Take first 10 characters for simpler UX
        let prefix = String(vendorID.prefix(10))
        return prefix
    }
    
    func generateKey(for targetDeviceID: String) -> String {
        let rawString = targetDeviceID + secretSalt
        let data = Data(rawString.utf8)
        let hash = SHA256.hash(data: data)
        let hashString = hash.compactMap { String(format: "%02x", $0) }.joined()
        
        // Return a formatted 12-character key (e.g., A1B2-C3D4-E5F6)
        let keyPrefix = String(hashString.prefix(12)).uppercased()
        let p1 = keyPrefix.prefix(4)
        let p2 = keyPrefix.dropFirst(4).prefix(4)
        let p3 = keyPrefix.dropFirst(8).prefix(4)
        
        return "\(p1)-\(p2)-\(p3)"
    }
    
    func validateKey(_ key: String, for targetDeviceID: String) -> Bool {
        let expectedKey = generateKey(for: targetDeviceID)
        return key.trimmingCharacters(in: .whitespacesAndNewlines).uppercased() == expectedKey
    }
    
    func activate(with key: String) -> Bool {
        if validateKey(key, for: deviceID) {
            isLicensed = true
            savedKey = key.uppercased()
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            return true
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            return false
        }
    }
}
