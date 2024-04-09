//
//  LoginInteractor.swift
//  introducao
//
//  Created by mac on 10/02/2024.
//

import Foundation
import Combine


class LoginInteractor {
    private let remote: LoginRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension LoginInteractor {
    func login(loginReq request: LoginRequest) -> Future<LoginResponse, AppError>  {
        return remote.login(request: request)
    }
    
    func setAuth(userAuth: UserAuth) {
        local.setUserAuth(userAuth: userAuth)
    }
    
    func getUserAuth () -> Future<UserAuth?, Never>  {
       return local.getUserAuth()
    }
}
