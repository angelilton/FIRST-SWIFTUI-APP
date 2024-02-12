//
//  AppError.swift
//  introducao
//
//  Created by mac on 10/02/2024.
//

import Foundation

enum AppError: Error {
case response(message: String)
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
