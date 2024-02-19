//
//  HabitViewModel.swift
//  introducao
//
//  Created by mac on 19/02/2024.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var screenState: HabitUIState = .emptyList
}
