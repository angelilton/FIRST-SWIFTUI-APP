//
//  LoginErrorResponse.swift
//  introducao
//
//  Created by mac on 25/01/2024.
//

import Foundation

struct LoginErrorResponse: Decodable {
    let detail: ErrorDetail
    
}

struct ErrorDetail: Decodable {
    let message: String
}
