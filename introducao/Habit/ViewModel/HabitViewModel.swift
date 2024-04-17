//
//  HabitViewModel.swift
//  introducao
//
//  Created by mac on 19/02/2024.
//

import Foundation
import Combine
import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var screenState: HabitUIState = .loading
    
    @Published var title = ""
    @Published var headline = ""
    @Published var desc = ""
    
    @Published var opened = false
    
    private var cancellableReq: AnyCancellable?
    private let interactor: HabitInteractor
    
    init(interactor: HabitInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableReq?.cancel()
    }
    
    func onAppear() {
        self.opened = true
        self.screenState = .loading
        
        cancellableReq = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                case .failure(let appError):
                    self.screenState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                if response.isEmpty {
                    self.screenState = .emptyList
                    self.title = ""
                    self.headline = "Fique ligado!"
                    self.desc = "Você ainda não possui hábitos!"
                } else {
                    self.screenState = .fullList(
                        response.map {
                            
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Muito bom!"
                            self.headline = "Seus hábitos estão em dia"
                            self.desc = ""
                            
                            let dateToCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
                            
                            if dateToCompare < Date() {
                                state = .red
                                self.title = "Atenção"
                                self.headline = "Fique ligado!"
                                self.desc = "Você está atrasado nos hábitos"
                            }
                            
                            return HabitCardViewModel(
                                id: $0.id,
                                icon: $0.iconUrl ?? "",
                                date: lastDate,
                                name: $0.name,
                                label: $0.label,
                                value: "\($0.value ?? 0)",
                                state: state
                            )
                        }
                    )
                }
                
            })
    }
}

//    func onAppear() {
//        self.screenState = .loading
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            var habitArray: [HabitCardViewModel] = []
//
//            defer {
//                self.screenState = .fullList(habitArray)
////                self.screenState = .error("Ocorreu um erro")
//            }
//
//            habitArray.append(
//                HabitCardViewModel(
//                    id: 1,
//                    icon: "https://via.placeholder.com/150",
//                    date: "01/01/2021 00:00:00",
//                    name: "Tocar guitarra",
//                    label: "horas",
//                    value: "2",
//                    state: .green
//                )
//            )
//
//            habitArray.append(
//                HabitCardViewModel(
//                    id: 2,
//                    icon: "https://via.placeholder.com/150",
//                    date: "01/01/2021 00:00:00",
//                    name: "Fazer caminhada",
//                    label: "km",
//                    value: "5",
//                    state: .green
//                )
//            )
//
//            habitArray.append(
//                HabitCardViewModel(
//                    id: 3,
//                    icon: "https://via.placeholder.com/150",
//                    date: "01/01/2021 00:00:00",
//                    name: "Fazer caminhada",
//                    label: "km",
//                    value: "5",
//                    state: .green
//                )
//            )
//
//            habitArray.append(
//                HabitCardViewModel(
//                    id: 4,
//                    icon: "https://via.placeholder.com/150",
//                    date: "01/01/2021 00:00:00",
//                    name: "Fazer caminhada",
//                    label: "km",
//                    value: "5",
//                    state: .green
//                )
//            )
//
//            habitArray.append(
//                HabitCardViewModel(
//                    id: 5,
//                    icon: "https://via.placeholder.com/150",
//                    date: "01/01/2021 00:00:00",
//                    name: "Fazer caminhada",
//                    label: "km",
//                    value: "5",
//                    state: .green
//                )
//            )
//
//
//
//        }
//    }

