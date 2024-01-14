//
//  SignInViewModel.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var screenState:SignInUIState = .none
    
    func login(email: String, password: String) {
        self.screenState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.screenState = .goToHomeScreen
        }
    }
}


extension SignInViewModel {
    func goToHomeScreen () -> some View {
        return SignInRouter.makeHomeView()
    }
}
