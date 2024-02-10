//
//  LoginInteractor.swift
//  introducao
//
//  Created by mac on 10/02/2024.
//

import Foundation


class LoginInteractor {
    private let remote: LoginRemoteDataSource = .shared

}

extension LoginInteractor {
    func login(loginReq request: LoginRequest, callback: @escaping (LoginResponse?, LoginErrorResponse?) -> Void) {
        remote.login(request: request, callback: callback)
    }
}
