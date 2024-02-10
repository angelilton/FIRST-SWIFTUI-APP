//
//  LoginRemoteDataSource.swift
//  introducao
//
//  Created by mac on 10/02/2024.
//

import Foundation

class LoginRemoteDataSource {
    // padrao singleton
    // Temos apenas 1 unico objeto vivo dentro da aplicação
    
    static var shared: LoginRemoteDataSource = LoginRemoteDataSource()
    
    private init() {
        
    }
    
    func login(request: LoginRequest, callback: @escaping (LoginResponse?, LoginErrorResponse?) -> Void) {
        
        guard let urlRequest = WebService.urlCreate(path: .login) else { return }
        guard let absoluteURL = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteURL)
        
        components?.queryItems = [
            URLQueryItem(name: "username", value: request.email),
            URLQueryItem(name: "password", value: request.password)
        ]
        
        WebService.call(
            body: components?.query?.data(using: .utf8),
            query: .login,
            contentType: .formUrl
        ) { result in
            //return
            switch result {
            case .failure(let error, let data):
                if let data = data {
                    if error == .unauthorized {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(LoginErrorResponse.self, from: data)
                        callback(nil, response)
                    }
                    
                }
                break
            case .success(let data):
                let decoder = JSONDecoder()
                let response = try? decoder.decode(LoginResponse.self, from: data)
                callback(response, nil)
            }
        }
    }
}
