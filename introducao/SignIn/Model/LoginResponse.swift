//
//  LoginResponse.swift
//  introducao
//
//  Created by mac on 24/01/2024.
//

import Foundation

struct LoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let expires: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
    
}
