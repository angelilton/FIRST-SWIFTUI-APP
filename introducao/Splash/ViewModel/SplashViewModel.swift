//
//  SplashViewModel.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    @Published var ScreenState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private let interactor: SplashInteractor
    
    init( interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
    }
    
    func handleStartApp() {
        //ligar com um login ou req para o servidor
        cancellableAuth = interactor.getUserAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                // se userAuth == nulo -> Login
                if userAuth == nil {
                    self.ScreenState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                    // senao se userAuth != null && expirou
                    print("token expirou")
                    self.ScreenState = .goToSignInScreen
                } else {
                    // senao -> Tela princial
                    self.ScreenState = .goToHomeScreen
                }
            }
        
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
        //            //executa depois de 3seg
        //            self.ScreenState = .goToSignInScreen
        //        }
        
    }
    
}


extension SplashViewModel {
    func goToSignInScreen () -> some View {
        return SplashRouter.makeSignInView()
    }
    
    func goToHome () -> some View {
        return SplashRouter.makeHomeView()
    }
}













































