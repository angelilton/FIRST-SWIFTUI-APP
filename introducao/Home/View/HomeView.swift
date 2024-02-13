//
//  HomeView.swift
//  introducao
//
//  Created by mac on 14/01/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel:HomeViewModel
    
    var body: some View {
        Text($viewModel.screenState.wrappedValue).bold()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(interactor: LoginInteractor()))
    }
}
