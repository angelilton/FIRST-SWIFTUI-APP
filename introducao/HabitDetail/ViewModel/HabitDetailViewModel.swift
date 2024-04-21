//
//  HabitDetailViewModel.swift
//  introducao
//
//  Created by mac on 17/04/2024.
//

import Foundation
import SwiftUI
import Combine

class HabitDetailViewModel: ObservableObject {
    @Published var UiState: HabitDetailUIState = .none
    @Published var value = ""
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher: PassthroughSubject<Bool, Never>?
    
    let id: Int
    let name: String
    let label: String
    let interactor: HabitDetailInteractor
    
    init(id: Int, name: String, label: String, interactor: HabitDetailInteractor) {
        self.id = id
        self.name = name
        self.label = label
        self.interactor = interactor
    }
    
    deinit {
       cancellable?.cancel()
        //after save
        for cancellable in cancellables {
              cancellable.cancel()
            }
     }
     
    
    func save() {
        self.UiState = .loading
        
        cancellable = interactor.save(habitId: id, request: HabitValueRequest(value: value))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion) {
                case .failure(let appError):
                    self.UiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { created in
                print("Sucess \(created)")
                if created {
                    self.UiState = .success
                    self.habitPublisher?.send(created)
                    
                }
                
            }
        
    }
}
