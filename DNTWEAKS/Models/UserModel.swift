//
//  UserModel.swift
//  DNTWEAKS IOS
//

import Foundation

struct UserModel: Codable, Identifiable {
    let id: UUID
    var username: String
    var isRemembered: Bool
    
    static let defaultUser = UserModel(
        id: UUID(),
        username: "ducnamtweaks",
        isRemembered: false
    )
}
