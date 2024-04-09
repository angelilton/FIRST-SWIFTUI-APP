//
//  SignUpViewModel.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var screenState: SignUpUIState = .none
    
    private let interactor: SignUpInteractor
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    init(interactor: SignUpInteractor) {
      self.interactor = interactor
    }
    
    
    deinit {
       cancellableSignUp?.cancel()
       cancellableSignIn?.cancel()
     }
    
    func RegisterSubmit(form: RegisterSubmit) {
        self.screenState = .loading
        
        // Pegar a String -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: form.birthday)
        
        // Validar a Data
        guard let dateFormatted = dateFormatted else {
            self.screenState = .error("Data inválida \(form.birthday)")
            return
        }
        
        // Date -> yyyy-MM-dd -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        let registerRequest = introducao.RegisterSubmit(
            fullName: form.fullName,
            email: form.email,
            password: form.password,
            document: form.document,
            phone: form.phone,
            birthday: birthday,
            gender: form.gender)
        
        cancellableSignUp = interactor.postUser(signUpRequest: registerRequest)
            .receive(on: DispatchQueue.main)
            .sink{ completion in
                // error | finished
                switch (completion) {
                case .failure(let appError):
                    self.screenState = .error(appError.message)
                    break
                default:
                    break
                }
            } receiveValue: {  created in
                if(created) {
                    self.cancellableSignIn = self.interactor.login(loginReq: LoginRequest(email: form.email, password: form.password))
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch (completion) {
                            case .failure(let appError):
                                self.screenState = .error(appError.message)
                                break
                            default:
                                break
                            }
                        }, receiveValue: { LoginResponse in
                            print(created)
                            self.publisher.send(created)
                            self.screenState = .success
                        })
                }
            }
        
        
        // chamada para o servidor http
//        WebService.postUser(request: introducao.RegisterSubmit(
//            fullName: form.fullName,
//            email: form.email,
//            password: form.password,
//            document: form.document,
//            phone: form.phone,
//            birthday: birthday,
//            gender: form.gender)) {
//                //função de callback
//                (successResponse, errorResponse) in
//                // Non Main Thread
//                if let error = errorResponse {
//                    DispatchQueue.main.async {
//                        // Main Thread
//                        self.screenState = .error(error.detail)
//                    }
//                }
//
//                // if register is sucessed
//                if let success = successResponse {
//                    DispatchQueue.main.async {
//                        self.publisher.send(success)
//                        if success {
//                            self.screenState = .success
//                        }
//                    }
//                }
//            }
        
        
    }
   
}
