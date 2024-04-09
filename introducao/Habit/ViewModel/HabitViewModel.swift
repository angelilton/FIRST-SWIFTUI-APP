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
    
    func onAppear() {
        self.screenState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var habitArray: [HabitCardViewModel] = []
            
            defer {
                self.screenState = .fullList(habitArray)
//                self.screenState = .error("Ocorreu um erro")
            }
            
            habitArray.append(
                HabitCardViewModel(
                    id: 1,
                    icon: "https://via.placeholder.com/150",
                    date: "01/01/2021 00:00:00",
                    name: "Tocar guitarra",
                    label: "horas",
                    value: "2",
                    state: .green
                )
            )
            
            habitArray.append(
                HabitCardViewModel(
                    id: 2,
                    icon: "https://via.placeholder.com/150",
                    date: "01/01/2021 00:00:00",
                    name: "Fazer caminhada",
                    label: "km",
                    value: "5",
                    state: .green
                )
            )
            
            habitArray.append(
                HabitCardViewModel(
                    id: 3,
                    icon: "https://via.placeholder.com/150",
                    date: "01/01/2021 00:00:00",
                    name: "Fazer caminhada",
                    label: "km",
                    value: "5",
                    state: .green
                )
            )
            
            habitArray.append(
                HabitCardViewModel(
                    id: 4,
                    icon: "https://via.placeholder.com/150",
                    date: "01/01/2021 00:00:00",
                    name: "Fazer caminhada",
                    label: "km",
                    value: "5",
                    state: .green
                )
            )
            
            habitArray.append(
                HabitCardViewModel(
                    id: 5,
                    icon: "https://via.placeholder.com/150",
                    date: "01/01/2021 00:00:00",
                    name: "Fazer caminhada",
                    label: "km",
                    value: "5",
                    state: .green
                )
            )
            
           
            
        }
    }
}
