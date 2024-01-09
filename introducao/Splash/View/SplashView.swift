//
//  SplashView.swift
//  introducao
//
//  Created by mac on 08/01/2024.
//

import SwiftUI

struct SplashView: View {
    
    @State var ScreenState: SplashUIState = .loading
    
    var body: some View {
        switch ScreenState {
        case .loading:
            Text("Loading")
        case .goToSignInScreen:
            Text("SignIn Screen")
        case .goToHomeScreen:
            Text("Home Screen")
        case .error(let msg):
            Text("Home Screen \(msg)")
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(ScreenState: .error("desculpa deu erro"))
    }
}
