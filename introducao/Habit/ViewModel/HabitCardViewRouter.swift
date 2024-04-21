//
//  HabitCardViewRouter.swift
//  introducao
//
//  Created by mac on 17/04/2024.
//

import Foundation
import SwiftUI
import Combine

enum HabitCardViewRouter {
    static func makeHabitDetailViewModel(id: Int, name: String,label:String, habitPublisher:PassthroughSubject<Bool, Never> ) -> some View {
        let viewModel = HabitDetailViewModel(
            id: id,
            name: name,
            label: label,
            interactor: HabitDetailInteractor()
        )
        
        viewModel.habitPublisher = habitPublisher
        return HabitDetailView(viewModel:viewModel)
    }
}
