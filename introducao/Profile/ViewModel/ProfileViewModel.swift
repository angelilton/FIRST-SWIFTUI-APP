//
//  ProfileViewModel.swift
//  introducao
//
//  Created by mac on 12/05/2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var fullNameValidate = ValidFullName()
    @Published var phoneValidate = ValidPhone()
    @Published var birthdayValidate = ValidBirthday()
}

class ValidFullName:ObservableObject {
    @Published var failed = false
   
    var value:String = "" {
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
