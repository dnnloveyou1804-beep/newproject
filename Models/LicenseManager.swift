import Foundation
import SwiftUI
import CryptoKit

class LicenseManager: ObservableObject {
    @AppStorage("IsAppLicensed") private(set) var isLicensed: Bool = false
    @AppStorage("SavedLicenseKey") private var savedKey: String = ""
    @AppStorage("LicenseExpiry") private(set) var expiresAt: String = ""
    
    let adminPassword = "dn1804"
    @Published var deviceID: String = ""
    
    init() {
        self.deviceID = getDeviceID()
        checkLocalExpiry()
    }
    
    func getDeviceID() -> String {
        guard let vendorID = UIDevice.current.identifierForVendor?.uuidString else {
            return "UNKNOWN-DEVICE"
        }
        // Lấy 10 ký tự đầu cho ngắn gọn
        let prefix = String(vendorID.prefix(10))
        return prefix
    }
    
    private func checkLocalExpiry() {
        if isLicensed {
            if savedKey.lowercased() == "dntweaks" { return } // Key bypass luôn đúng
            
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            let fallbackFormatter = ISO8601DateFormatter()
            
            if let expDate = formatter.date(from: expiresAt) ?? fallbackFormatter.date(from: expiresAt) {
                if expDate < Date() {
                    // Hết hạn
                    isLicensed = false
                    savedKey = ""
                    expiresAt = ""
                }
            }
        }
    }
    
    func getFormattedExpiryDate() -> String {
        if savedKey.lowercased() == "dntweaks" {
            return "Vĩnh viễn (Bypass Key)"
        }
        guard !expiresAt.isEmpty else { return "Không xác định" }
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let fallbackFormatter = ISO8601DateFormatter()
        
        if let date = formatter.date(from: expiresAt) ?? fallbackFormatter.date(from: expiresAt) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "HH:mm - dd/MM/yyyy"
            return displayFormatter.string(from: date)
        }
        return "Lỗi định dạng ngày"
    }
    
    func activate(with key: String, completion: @escaping (Bool, String?) -> Void) {
        let trimmedKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Master Bypass Key
        if trimmedKey.lowercased() == "dntweaks" {
            DispatchQueue.main.async {
                self.isLicensed = true
                self.savedKey = "dntweaks"
                self.expiresAt = "2099-12-31T23:59:59.000Z"
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                completion(true, nil)
            }
            return
        }
        
        guard let url = URL(string: "https://ddnkey.ddnstore.workers.dev/api/activate") else {
            completion(false, "Lỗi đường dẫn API")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: String] = ["key": trimmedKey, "hwid": deviceID]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(false, "Lỗi kết nối mạng, vui lòng thử lại")
                    return
                }
                
                guard let data = data else {
                    completion(false, "Không có dữ liệu phản hồi từ máy chủ")
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        let ok = json["ok"] as? Bool ?? false
                        if ok {
                            self.isLicensed = true
                            self.savedKey = trimmedKey.uppercased()
                            self.expiresAt = json["expiresAt"] as? String ?? ""
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                            completion(true, nil)
                        } else {
                            let errorMsg = json["error"] as? String ?? "Lỗi không xác định từ Server"
                            completion(false, errorMsg)
                        }
                    } else {
                        completion(false, "Dữ liệu máy chủ bị lỗi định dạng")
                    }
                } catch {
                    completion(false, "Không thể đọc dữ liệu phản hồi")
                }
            }
        }.resume()
    }
}
