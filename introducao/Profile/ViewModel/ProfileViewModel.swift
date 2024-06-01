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
    
    private var cancellableFetch: AnyCancellable?
    private var cancellableUpdate: AnyCancellable?
    
    private let interactor: ProfileInteractor
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableFetch?.cancel()
        cancellableUpdate?.cancel()
    }
    
    func fetchUser () {
        self.uiState = .loading
        cancellableFetch = interactor.fethUser()
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
    
    func updateUser () {
        self.uiState = .updateLoading
        
        guard let userId = userId,
              let gender = gender else { return }
        
        // Pegar a String -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthdayValidate.value)
        
        guard let dateFormatted = dateFormatted else {
              self.uiState = .updateError("Data inválida \(birthdayValidate.value)")
              return
            }
        
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        cancellableUpdate = interactor.updateUser(
            userId: userId,
            data: ProfileRequest(
                fullName: fullNameValidate.value,
                phone: phoneValidate.value,
                birthday: birthday,
                gender: gender.index
            ))
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch(completion) {
            case .failure(let appError):
                self.uiState = .updateError(appError.message)
                break
            case .finished:
                break
            }
        }, receiveValue: { resp in
            self.uiState = .updateSuccess
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
