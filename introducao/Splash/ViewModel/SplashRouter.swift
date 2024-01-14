//
//  SplashRouter.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI

enum SplashRouter {
    static func makeSignInView ( ) -> some View {
        let viewModel = SignInViewModel()
        return SignInView(viewModel: viewModel)
    }
    
    static func makeSignUpView ( ) -> some View {
        let viewModel = SignUpViewModel()
        return SignUpView(viewModel: viewModel)
    }
}
