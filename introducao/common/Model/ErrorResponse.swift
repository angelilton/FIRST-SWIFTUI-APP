//
//  ErrorResponse.swift
//  introducao
//
//  Created by mac on 24/01/2024.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
