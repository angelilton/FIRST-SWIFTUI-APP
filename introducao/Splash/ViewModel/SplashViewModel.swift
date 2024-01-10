//
//  SplashViewModel.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var ScreenState: SplashUIState = .loading
    
    func handleStartApp() {
        //ligar com um login ou req para o servidor
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            //executa depois de 3seg
            self.ScreenState = .goToHomeScreen
        }
    }
}
