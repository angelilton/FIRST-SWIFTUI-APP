//
//  HabitCardViewRouter.swift
//  introducao
//
//  Created by mac on 17/04/2024.
//

import Foundation
import SwiftUI

enum HabitCardViewRouter {
    static func makeHabitDetailViewModel(id: Int, name: String,label:String) -> some View {
        return HabitDetailView(viewModel: HabitDetailViewModel(id: id, name: name, label: label))
    }
}
