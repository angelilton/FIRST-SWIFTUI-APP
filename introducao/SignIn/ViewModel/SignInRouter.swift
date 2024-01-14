//
//  SignInRouter.swift
//  introducao
//
//  Created by mac on 14/01/2024.
//

import SwiftUI

enum SignInRouter {
    static func makeHomeView () -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
