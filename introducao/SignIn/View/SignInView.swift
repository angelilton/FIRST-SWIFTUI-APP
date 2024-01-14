//
//  SignInView.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    // um variavel com statado igual state do rn
    @State  var email = ""
    @State var password = ""
    @State var action: Int? = 0
    @State var showNangationTitle = true
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing:20) {
                    
                    Spacer(minLength: 40)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                        
                        Text("Login")
                            .foregroundColor(.orange)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        emailField
                        passwordField
                        submitButton
                        registerLink
                    }
                }
                .background(Color.white)
                .padding(.vertical, 100)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 32)
            .background(Color.white)
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationBarHidden(showNangationTitle)
        }
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui cadastro?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack{
                NavigationLink(
                    destination: SignUpView(viewModel: SignUpViewModel()),
                    tag: 1,
                    selection: $action,
                    label: { EmptyView()}
                )
                
                Button("cadastrar"){
                    self.action = 1
                }
            }
        }
    }
}

extension SignInView {
    var submitButton: some View {
        Button("Entrar") {
            //evento de submit
        }
    }
}

extension SignInView {
    var emailField: some View {
        TextField("",text: $email)
            .border(Color.black)
    }
}

extension SignInView {
    var passwordField: some View {
        SecureField("",text: $password)
            .border(Color.black)
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel())
    }
}
