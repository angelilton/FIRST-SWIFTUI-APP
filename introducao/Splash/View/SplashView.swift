//
//  SplashView.swift
//  introducao
//
//  Created by mac on 08/01/2024.
//

import SwiftUI

struct SplashView: View {
    
    @State var ScreenState: SplashUIState = .error("erro ao carregar")
    
    var body: some View {
        switch ScreenState {
        case .loading:
            loadingView
        case .goToSignInScreen:
            Text("SignIn Screen")
        case .goToHomeScreen:
            Text("Home Screen")
        case .error(let msg):
            errorView(m: msg)
        }
    }
}

// struct para reutilizar
//struct LoadingView: View {
//    var body: some View {
//        ZStack {
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.green)
//                .ignoresSafeArea()
//        }
//    }
//}

//e um extensao so e usado aqui
extension SplashView {
    var loadingView: some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)
                .ignoresSafeArea()
        }
    }
}

extension SplashView {
    func errorView (m: String) -> some View {
        ZStack {
            Text("Home Screen \(m)")
        }
    }
}



struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
