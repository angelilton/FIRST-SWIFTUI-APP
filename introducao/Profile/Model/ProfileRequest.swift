//
//  ProfileRequest.swift
//  introducao
//
//  Created by mac on 01/06/2024.
//

import Foundation

struct ProfileRequest: Encodable {
    let fullName: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case phone
        case birthday
        case gender
    }
    
}