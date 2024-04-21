//
//  HabitDetailView.swift
//  introducao
//
//  Created by mac on 17/04/2024.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var viewModel: HabitDetailViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(Color.orange)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                
                Text("Unidade: \(viewModel.label)")
            }
            
            VStack {
                TextField("Escreva aqui o valor", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            .padding(.horizontal, 32)
            
            Text("Os registros devem ser feitos em até 24h. Hábitos se constroem todos os dias :)")
                .fixedSize( horizontal: false, vertical: true)
            
            LoadingButtonView(
                text: "Salvar",
                loading: self.viewModel.UiState == .loading,
                disabled: self.viewModel.value.isEmpty,
                action: {
                    viewModel.save()
            })
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            
            Button("Cancelar") {
                //dismiss  pop exit
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.easeIn(duration: 0.15)) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.top,50)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases,id: \.self) {
            HabitDetailView( viewModel: HabitDetailViewModel(
                id: 1,
                name: "mais 1",
                label: "horas",
                interactor: HabitDetailInteractor()
            )
            )
            .previewDevice("iPhone 11")
            .preferredColorScheme($0)
        }
        
    }
}

