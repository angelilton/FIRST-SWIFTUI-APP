//
//  HabitDetailViewModel.swift
//  introducao
//
//  Created by mac on 17/04/2024.
//

import Foundation
import SwiftUI

class HabitDetailViewModel: ObservableObject {
    @Published var UiState: HabitDetailUIState = .none
    @Published var value = ""
    
    let id: Int
    let name: String
    let label: String
    
    init(id: Int, name: String, label: String) {
        self.id = id
        self.name = name
        self.label = label
    }
}
