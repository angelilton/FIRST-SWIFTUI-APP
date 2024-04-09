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
    @State var showNangationTitle = true
    
    var body: some View {
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.screenState {
                viewModel.goToHomeScreen()
            } else {
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
                        .padding(.vertical, 100)
                        
                        if case SignInUIState.error(let msg) = viewModel.screenState {
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text("login error"), message: Text(msg), dismissButton: .default(Text("OK")) {
                                        viewModel.screenState = .none
                                        })
                                }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .navigationBarTitle("Login", displayMode: .inline)
                    .navigationBarHidden(showNangationTitle)
                }
            }
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
                    destination: viewModel.goToSignUpScreen(),
                    tag: 1,
                    selection: $viewModel.action,
                    label: { EmptyView()}
                )
                
                Button("cadastrar"){
                    viewModel.action = 1
                }
            }
        }
    }
}

extension SignInView {
    var submitButton: some View {
        LoadingButtonView(
            text: "Entrar",
            loading: viewModel.screenState == SignInUIState.loading,
            action: {
                viewModel.login(email: email, password: password)
        })
    }
}

extension SignInView {
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

extension SignInView {
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


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignInView(viewModel: SignInViewModel(interactor: LoginInteractor()))
                .previewDevice("iPhone 11 Pro")
                .preferredColorScheme($0)
        }
       
    }
}
