//
//  HabitDetailRemoteDataSource.swift
//  introducao
//
//  Created by mac on 18/04/2024.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init() {
        
    }
    
    func save(habitId:Int, request: HabitValueRequest) -> Future<Bool,AppError> {
        return Future{promise in
            let path = String(format: WebService.EndPoint.habitValues.rawValue, habitId)
            print("path" + path)
            guard let jsonData = try? JSONEncoder().encode(request) else { return }
            
            WebService.call(method: .post, body: jsonData, query: path, contentType: .json) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(LoginErrorResponse.self, from: data)
                        // completion(nil, response)
                        
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                        
                    }
                    break
                case .success(_):
                    
                    promise(.success(true))
                    
                    break
                }
            }
        }
    }
}
