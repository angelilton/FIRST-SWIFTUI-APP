//
//  SignUpInteractor.swift
//  introducao
//
//  Created by mac on 11/02/2024.
//

import Foundation
import Combine

class SignUpInteractor {
    private let remoteSignUp: SignUpRemoteDataSource = .shared
    private let remoteSignIn: LoginRemoteDataSource = .shared
}

extension SignUpInteractor {
    func postUser(signUpRequest request: RegisterSubmit) -> Future<Bool, AppError> {
        return remoteSignUp.postUser(request: request)
    }
    
    func login(loginReq request: LoginRequest) -> Future<LoginResponse, AppError>  {
       return remoteSignIn.login(request: request)
    }
    
}
