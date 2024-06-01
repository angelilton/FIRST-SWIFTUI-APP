//
//  ProfileView.swift
//  introducao
//
//  Created by mac on 11/05/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel:ProfileViewModel
    
    var desabledDone: Bool {
        viewModel.fullNameValidate.failed
        || viewModel.phoneValidate.failed
        || viewModel.birthdayValidate.failed
    }
    
    func fetchErrorView(_ value: String) -> some View {
        Text("")
            .alert(isPresented: .constant(true)) {
                Alert(title: Text("Habit"),
                      message: Text(value),
                      dismissButton: .default(Text("Ok")) {
                })
            }
    }
    
    var body: some View {
        ZStack {
            if case ProfileUIState.loading = viewModel.uiState {
                    ProgressView()
            } else {
                NavigationView {
                    VStack {
                        Form {
                            Section(header: Text("Dados cadastrais")) {
                                HStack {
                                    Text("Nome")
                                    Spacer()
                                    TextField(
                                        "Digite seu nome",
                                        text: $viewModel.fullNameValidate.value
                                    )
                                    .keyboardType(.alphabet)
                                    .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.fullNameValidate.failed {
                                    Text("Nome deve ter mais de 3 caracteres")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("E-mail")
                                    Spacer()
                                    TextField("", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("Celular")
                                    Spacer()
                                    TextField(
                                        "Digite seu numero",
                                        text: $viewModel.phoneValidate.value
                                    )
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.phoneValidate.failed {
                                    Text("Entre com o DDD + 8 ou 9 digitos")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("Data de nascimento")
                                    Spacer()
                                    TextField(
                                        "Digite seu data nasc",
                                        text: $viewModel.birthdayValidate.value
                                    )
                                    .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.birthdayValidate.failed {
                                    Text("Data incorreta dia/mes/ano")
                                        .foregroundColor(.red)
                                }
                                
                                NavigationLink (
                                    destination: GenderSelectorView(
                                        title: "Escolha o gênero",
                                        genders: Gender.allCases,
                                        selectedGender: $viewModel.gender
                                    ),
                                    label: {
                                        Text("Gênero")
                                        Spacer()
                                        Text(viewModel.gender?.rawValue ?? "")
                                    }
                                )
                            }
                        }
                    }
                    .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        
                    }, label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }).opacity(desabledDone ? 0 : 1)
                    )
                    
                }
            }
            if case ProfileUIState.fetchError(let value) = viewModel.uiState {
                fetchErrorView(value)
            }
        }.onAppear {
            viewModel.fetchUser()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
    }
}
