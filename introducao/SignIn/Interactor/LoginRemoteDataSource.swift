//
//  LoginRemoteDataSource.swift
//  introducao
//
//  Created by mac on 10/02/2024.
//

import Foundation
import Combine

class LoginRemoteDataSource {
    // padrao singleton
    // Temos apenas 1 unico objeto vivo dentro da aplicação
    
    static var shared: LoginRemoteDataSource = LoginRemoteDataSource()
    
    private init() {
        
    }
    
    func login(request: LoginRequest) -> Future<LoginResponse, AppError> {
        
        return Future<LoginResponse, AppError> { promise in
            
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
                            //                        callback(nil, response) não vai mais devolver a resp em uma callback
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor" )))
                        }
                        
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(LoginResponse.self, from: data)
                    //                callback(response, nil) não vai mais devolver a resp em uma callback
                    
                    guard let response = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(response))
                    
                    break
                }
            }
        }
    }
}
