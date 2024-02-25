//
//  HabitUIState.swift
//  introducao
//
//  Created by mac on 19/02/2024.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList
    case error(String)
}
