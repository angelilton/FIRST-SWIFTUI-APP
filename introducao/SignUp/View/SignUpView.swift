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
        HStack {
            Spacer()
            Button("registrar") {
                
            }
            Spacer()
        }
        
    }
}

extension SignUpView {
    var nameField: some View {
        TextField("", text: $name)
            .border(Color.black)
    }
}

extension SignUpView {
    var lastNameField: some View {
        TextField("", text: $lastName)
            .border(Color.black)
    }
}

extension SignUpView {
    var emailField: some View {
        TextField("", text: $email)
            .border(Color.black)
    }
}

extension SignUpView {
  var passwordField: some View {
    SecureField("", text: $password)
      .border(Color.orange)
  }
}

extension SignUpView {
    var documentField: some View {
        TextField("", text: $document)
            .border(Color.black)
    }
}

extension SignUpView {
    var phoneField: some View {
        TextField("", text: $phone)
            .border(Color.black)
    }
}

extension SignUpView {
    var birthdayField: some View {
        TextField("", text: $birthday)
            .border(Color.black)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}
