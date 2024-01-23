//
//  SignUpView.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    @State var name = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    
    @State var gender = Gender.male
    
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(.black)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        nameField
                        
                        lastNameField
                        
                        emailField
                        
                        passwordField
                        
                        documentField
                        
                        phoneField
                        
                        birthdayField
                        
                        genderField
                        
                        SubmitButton
                        
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                
            }
            .padding()
            
            if case SignUpUIState.error(let value) = viewModel.screenState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                            // faz algo quando some o alerta
                        })
                    }

            }
        }
        
    }
}


extension SignUpView {
    var genderField: some View {
        Picker("Sexo", selection: $gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
}

extension SignUpView {
    var SubmitButton: some View {
        LoadingButtonView(
            text: "Registrar",
            loading: viewModel.screenState == SignUpUIState.loading,
            action: {
                viewModel.RegisterSubmit(
                    user: UserProps(
                        fullName: "\(name) \(lastName)",
                        email: email,
                        password: password,
                        document: document,
                        phone: phone,
                        birthday: birthday,
                        gender: gender.index
                    )
                )
            })
    }
}

extension SignUpView {
    var nameField: some View {
        EditTextView(
            text: $name,
            placeholder: "Nome",
            isError: name.count < 3,
            error: "que tem que maior que 3 caracter",
            keyboard: .alphabet
        )
    }
}

extension SignUpView {
    var lastNameField: some View {
        EditTextView(
            text: $lastName,
            placeholder: "Sobrenome",
            isError: lastName.count < 3,
            error: "que tem que maior que 3 caracter",
            keyboard: .alphabet
        )
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(
            text: $email,
            placeholder: "E-mail",
            isError: !email.emailValidated(),
            error: "e-mail é obrigatorio",
            keyboard: .emailAddress
        ).autocapitalization(.none)
    }
}

extension SignUpView {
  var passwordField: some View {
      EditTextView(
          text: $password,
          isSecureField: true,
          placeholder: "Senha",
          isError: password.count < 8,
          error: "senha deve ter ao menos 8 caracteres"
      )
  }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(
            text: $document,
            placeholder: "CPF",
            isError: document.count != 11,
            error: "CPF inválido"
        )
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(
            text: $phone,
            placeholder: "Telefone",
            isError: phone.count < 10 || phone.count >= 12,
            error: "Entre com o DDD + 8 ou 9 digitos",
            keyboard: .numberPad
        )
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(
            text: $birthday,
            placeholder: "Data Nascimento",
            isError: birthday.count != 10,
            error: "Data deve ser dd/MM/yyyy"
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView(viewModel: SignUpViewModel())
                .previewDevice("iPhone 11 Pro")
                        .preferredColorScheme($0)
        }
    }
}
