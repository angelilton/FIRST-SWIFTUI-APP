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
    
    init(interactor: LoginInteractor) {
        self.interactor  = interactor
        
        isCancel = self.interactor.getUserAuth()
            .receive(on: DispatchQueue.main)
            .sink{ userAuth in
                self.screenState = userAuth?.idToken ?? "token vazio"
            }
            
    }
}
