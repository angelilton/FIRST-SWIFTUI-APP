//
//  homeRouter.swift
//  introducao
//
//  Created by mac on 19/02/2024.
//

import Foundation
import SwiftUI

enum homeRouter {
    static func makeHabitView (viewModel: HabitViewModel) -> some View {
//        let viewModel = HabitViewModel(interactor: HabitInteractor())
        return HabitView(viewModel: viewModel)
    }
    
    static func makeProfileView (viewModel: ProfileViewModel) -> some View {
        return ProfileView(viewModel: viewModel)
    }
}

