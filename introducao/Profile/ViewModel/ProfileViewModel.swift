//
//  ProfileViewModel.swift
//  introducao
//
//  Created by mac on 12/05/2024.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var uiState: ProfileUIState = .none
    
    @Published var fullNameValidate = ValidFullName()
    @Published var phoneValidate = ValidPhone()
    @Published var birthdayValidate = ValidBirthday()
    
    var userId: Int?
    @Published var email = ""
    @Published var document = ""
    @Published var gender: Gender?
    
    private var cancellable: AnyCancellable?
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func fetchUser () {
        self.uiState = .loading
        cancellable = interactor.fethUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .fetchError(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.userId = response.id
                self.email = response.email
                self.document = response.document
                self.gender = Gender.allCases[response.gender]
                self.fullNameValidate.value = response.fullName
                self.phoneValidate.value = response.phone
                
                // Pegar a String -> dd/MM/yyyy -> Date
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyy-MM-dd"
                let dateFormatted = formatter.date(from: response.birthday)
                
                //validar a data
                guard let dateFormatted = dateFormatted else {
                    self.uiState = .fetchError("Data inválida \(response.birthday)")
                    return
                }
                
                formatter.dateFormat = "dd/MM/yyyy"
                let birthday = formatter.string(from:  dateFormatted)
                self.birthdayValidate.value = birthday
                
                self.uiState = .fetchSuccess
            })
    }
}

class ValidFullName:ObservableObject {
    @Published var failed = false
   
    var value:String = "angelilton" {
        didSet {
            failed = value.count < 3
            print("valor \(failed)")
        }
    }
}

class ValidPhone:ObservableObject {
    @Published var failed = false
    
    var value:String = "" {
        didSet {
            failed = value.count < 10 || value.count >= 12
        }
    }
}

class ValidBirthday:ObservableObject {
    @Published var failed = false
    
    var value:String = "" {
        didSet {
            failed = value.count != 10
        }
    }
}
