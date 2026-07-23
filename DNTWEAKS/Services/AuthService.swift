//
//  AuthService.swift
//  DNTWEAKS IOS
//
//  Simple local authentication (default credentials)
//

import Foundation

final class AuthService {
    static let shared = AuthService()
    private init() {}
    
    private let defaultUsername = "ducnamtweaks"
    private let defaultPassword = "ducnam123"
    
    private let rememberKey = "dntweaks_remember_login"
    private let usernameKey = "dntweaks_saved_username"
    
    func login(username: String, password: String) -> Bool {
        let success = username.lowercased() == defaultUsername && password == defaultPassword
        return success
    }
    
    func saveRemember(username: String, remember: Bool) {
        UserDefaults.standard.set(remember, forKey: rememberKey)
        if remember {
            UserDefaults.standard.set(username, forKey: usernameKey)
        } else {
            UserDefaults.standard.removeObject(forKey: usernameKey)
        }
    }
    
    var isRemembered: Bool {
        UserDefaults.standard.bool(forKey: rememberKey)
    }
    
    var savedUsername: String? {
        UserDefaults.standard.string(forKey: usernameKey)
    }
}
