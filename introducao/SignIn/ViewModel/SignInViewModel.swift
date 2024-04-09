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
    private var cancellableRequest: AnyCancellable?
    
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
                //                self.action = 0 // volta para a tela de login
                self.screenState = .goToHomeScreen // se loginResquest is sucess goToHome
            }
        }
    }
    
    
    deinit {
        isCancel?.cancel()
        cancellableRequest?.cancel()
    }
    
    func login(email: String, password: String) {
        self.screenState = .loading
        
        cancellableRequest = interactor.login(loginReq: LoginRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                // aqui acontece o ERRO ou FINISHED
                switch (completion) {
                case .failure(let appError):
                    self.screenState = .error(appError.message)
                    break
                default:
                    break
                }
                
            }, receiveValue: { success in
                // salva o token
                let auth = UserAuth(
                    idToken: success.accessToken,
                    refreshToken: success.refreshToken,
                    expires: Date().timeIntervalSince1970 + Double(success.expires),
                    tokenType: success.tokenType
                )
                
                self.interactor.setAuth(userAuth: auth)
                self.screenState = .goToHomeScreen
            })
        
        //  modelo antigo com callBack
        //        interactor.login(loginReq: LoginRequest(email: email, password: password)) {
        //            (successResponse, errorResponse) in
        //
        //            if let error = errorResponse {
        //                DispatchQueue.main.async {
        //                    // Main Thread
        //                    self.screenState = .error(error.detail.message)
        //                }
        //            }
        //
        //            if let success = successResponse {
        //                DispatchQueue.main.async {
        //                    print(success)
        //                    self.screenState = .goToHomeScreen
        //                }
        //            }
        //
        //        }
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
