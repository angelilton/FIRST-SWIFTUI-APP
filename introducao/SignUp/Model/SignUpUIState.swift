//
//  SignUpUIState.swift
//  introducao
//
//  Created by mac on 15/01/2024.
//

import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
