//
//  HabitViewModel.swift
//  introducao
//
//  Created by mac on 19/02/2024.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var screenState: HabitUIState = .emptyList
    
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado!"
    @Published var desc = "Você está atrasado nos hábitos"
}
