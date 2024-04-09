//
//  SignUpRemoteDataSource.swift
//  introducao
//
//  Created by mac on 11/02/2024.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init() {
        
    }
    
    func postUser(request: RegisterSubmit) -> Future<Bool, AppError> {
        return Future { promise in
            
            guard let jsonData = try? JSONEncoder().encode(request) else { return }
            
            WebService.call(body: jsonData, query: .userQuery, contentType: .json) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .badRequest {
                            print(String(data: data, encoding: .utf8) as Any)
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
//                            callback(nil, response)
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no servidor")))
                        }
                    }
                    break
                case .success(let data):
                    print(String(data: data, encoding: .utf8) as Any)
//                    callback(true, nil)
                    promise(.success(true))
                    break
                }
            }
        }
    }
}
