//
//  HomeViewModel.swift
//  introducao
//
//  Created by mac on 14/01/2024.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var screenState = ""
    private var isCancel: AnyCancellable?
    private let interactor: LoginInteractor
    
    let viewModel = HabitViewModel(interactor: HabitInteractor())
    let ProfileviewModel = ProfileViewModel(interactor: ProfileInteractor())
    
    // desloga se nao tiver token valido
    init(interactor: LoginInteractor) {
        self.interactor  = interactor
        
        isCancel = self.interactor.getUserAuth()
            .receive(on: DispatchQueue.main)
            .sink{ userAuth in
                self.screenState = userAuth?.idToken ?? "token vazio"
            }
            
    }
}


extension HomeViewModel {
    func habitView () -> some View {
        return homeRouter.makeHabitView(viewModel: viewModel)
    }
    
    func profileView () -> some View {
        return homeRouter.makeProfileView(viewModel: ProfileviewModel)
    }
}
