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
    private let interactor: LoginInteractor
    
    @Published var action: Int? = 0
    
    @Published var screenState:SignInUIState = .none
    
    //estanciado o publisher
    init(interactor: LoginInteractor) {
        self.interactor = interactor
      isCancel = publisher.sink { value in
        print("usuário criado! goToHome: \(value)")
        
        if value {
            self.action = 0
        }
      }
    }
    
    
    deinit {
        isCancel?.cancel()
    }
    
    func login(email: String, password: String) {
        self.screenState = .loading

        interactor.login(loginReq: LoginRequest(email: email, password: password)) {
            (successResponse, errorResponse) in
            
            if let error = errorResponse {
                DispatchQueue.main.async {
                    // Main Thread
                    self.screenState = .error(error.detail.message)
                }
            }
            
            if let success = successResponse {
                DispatchQueue.main.async {
                    print(success)
                    self.screenState = .goToHomeScreen
                }
            }
                      
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
