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
        
        // chamada para o servidor http
        WebService.postUser(request: introducao.RegisterSubmit(
            fullName: form.fullName,
            email: form.email,
            password: form.password,
            document: form.document,
            phone: form.phone,
            birthday: birthday,
            gender: form.gender))
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
//            self.screenState = .success
//            self.publisher.send(true)
//        }
        
    }
   
}
