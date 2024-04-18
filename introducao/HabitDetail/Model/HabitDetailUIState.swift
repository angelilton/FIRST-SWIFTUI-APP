//
//  HabitDetailUIState.swift
//  introducao
//
//  Created by mac on 17/04/2024.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
