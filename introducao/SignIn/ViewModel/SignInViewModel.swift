//
//  SignInViewModel.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    private var isCancel: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var screenState:SignInUIState = .none
    
    //estanciado o publisher
    init() {
      isCancel = publisher.sink { value in
        print("usuário criado! goToHome: \(value)")
        
        if value {
          self.screenState = .goToHomeScreen
        }
      }
    }
    
    
    deinit {
        isCancel?.cancel()
    }
    
    func login(email: String, password: String) {
        self.screenState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.screenState = .error("erro no login")
        }
    }
}


extension SignInViewModel {
    func goToHomeScreen () -> some View {
        return SignInRouter.makeHomeView()
    }
    
    func goToSignUpScreen () -> some View {
        return SignInRouter.makeSignUpView(publisher: publisher)
    }
}
