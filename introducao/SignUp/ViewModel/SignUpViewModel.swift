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
    
    func RegisterSubmit(user: UserProps) {
        self.screenState = .loading
        
        WebService.postUser(user: user)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
////            self.screenState = .error("vamos trabalhar")
//            self.screenState = .success
//            self.publisher.send(true)
//        }
    }
   
}
