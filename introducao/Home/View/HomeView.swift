//
//  HomeView.swift
//  introducao
//
//  Created by mac on 14/01/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel:HomeViewModel
    
    @State var tabState = 0
    
    var body: some View {
        TabView(selection: $tabState) {
            viewModel.habitView() // retorna uma some view
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                        Text("Hábitos")
                }.tag(0)
            
            Text("Conteudo do gráfico").bold()
                .tabItem {
                    Image(systemName: "chart.bar")
                        Text("Gráficos")
                }.tag(1)
            
            viewModel.profileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                        Text("Perfil")
                }.tag(2)
        }
        .background(Color.white)
        .accentColor(Color.orange)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(interactor: LoginInteractor()))
    }
}
