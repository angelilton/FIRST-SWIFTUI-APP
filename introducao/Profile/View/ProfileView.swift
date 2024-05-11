//
//  ProfileView.swift
//  introducao
//
//  Created by mac on 11/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @State var fullName = ""
      @State var email = "tiago.aguiar@teste.com.br"
      @State var cpf = "111.222.333-11"
      @State var phone = "(11) 1234-1234"
      @State var birthday = "20/02/1990"
      @State var selectedGender: Gender? = .male
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Dados cadastrais")) {
                        HStack {
                            Text("Nome")
                            Spacer()
                            TextField("Digite seu nome", text: $fullName)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("E-mail")
                            Spacer()
                            TextField("", text: $email)
                                .disabled(true)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
                                .disabled(true)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Celular")
                            Spacer()
                            TextField("Digite seu numero", text: $phone)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Data de nascimento")
                            Spacer()
                            TextField("Digite seu data nasc", text: $birthday)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        NavigationLink (
                            destination: GenderSelectorView(
                                    title: "Escolha o gênero",
                                    genders: Gender.allCases,
                                    selectedGender: $selectedGender
                                ),
                            label: {
                                Text("Gênero")
                                Spacer()
                                Text(selectedGender?.rawValue ?? "")
                            }
                       )
                    }
                }
            }
            .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
