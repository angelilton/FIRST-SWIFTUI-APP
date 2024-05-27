//
//  ProfileRemoteDataSource.swift
//  introducao
//
//  Created by mac on 14/05/2024.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    static var schared:ProfileRemoteDataSource = ProfileRemoteDataSource()
    
    private init() {
        
    }
    
    func fetchUser() -> Future<ProfileResponse,AppError> {
        return Future { promise in
            WebService.call(query: .fetchUser, method: .get) { result in
                switch result {
                case .success(let success):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ProfileResponse.self, from: success)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: success, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    break
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro interno no servidor")))
                    }
                    break
                }
            }
            
        }
        
        
    }
}
