//
//  SignInUIState.swift
//  introducao
//
//  Created by mac on 14/01/2024.
//

import Foundation

enum SignInUIState: Equatable {
    case none, loading, goToHomeScreen, error(String)
}
