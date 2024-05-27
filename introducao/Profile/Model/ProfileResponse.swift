//
//  ProfileResponse.swift
//  introducao
//
//  Created by mac on 14/05/2024.
//

import Foundation

struct ProfileResponse: Codable {
    let id: Int
    let fullName: String
    let email: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "name"
        case email
        case document
        case phone
        case birthday
        case gender
    }
}
