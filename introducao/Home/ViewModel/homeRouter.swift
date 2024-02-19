//
//  homeRouter.swift
//  introducao
//
//  Created by mac on 19/02/2024.
//

import Foundation
import SwiftUI

enum homeRouter {
    static func makeHabitView () -> some View {
        let viewModel = HabitViewModel()
        return HabitView(viewModel: viewModel)
    }
}

