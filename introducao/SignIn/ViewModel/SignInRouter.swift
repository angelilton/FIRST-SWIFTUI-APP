//
//  SignInRouter.swift
//  introducao
//
//  Created by mac on 14/01/2024.
//

import SwiftUI
import Combine

enum SignInRouter {
    static func makeHomeView () -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
    static func makeSignUpView (publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = SignUpViewModel(interactor: SignUpInteractor())
        viewModel.publisher = publisher
        return SignUpView(viewModel: viewModel)
      }
}
