//
//  HabitView.swift
//  introducao
//
//  Created by mac on 19/02/2024.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        Text("habit screen").bold()
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(viewModel: HabitViewModel())
    }
}
