//
//  SplashView.swift
//  introducao
//
//  Created by mac on 08/01/2024.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group{
            switch viewModel.ScreenState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.goToSignInScreen()
            case .goToHomeScreen:
                viewModel.goToHome()
            case .error(let msg):
                loadingView(error: msg)
            }
        }.onAppear(perform: {
            viewModel.handleStartApp()
        })
        
    }
}



//e um extensao so e usado aqui
extension SplashView {
    func loadingView (error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(
                            title: Text("Habit"),
                            message: Text(error),
                            dismissButton: .default(Text("OK"))
                        )
                    }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SplashViewModel(interactor: SplashInteractor())
        SplashView(viewModel: viewModel)
    }
}
