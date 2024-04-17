//
//  HabitRemoteDataSource.swift
//  introducao
//
//  Created by mac on 10/04/2024.
//

import Foundation
import Combine

class HabitRemoteDataSource {
    static var shared: HabitRemoteDataSource = HabitRemoteDataSource()
    
    private init() {
        
    }
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return Future<[HabitResponse], AppError>{ promise in
            WebService.call(query: .habits, method: .get) { result in
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode([HabitResponse].self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    
                    break
                    
                case .failure(_,let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(LoginErrorResponse.self, from: data)
                        
                        promise(.failure(AppError.response(
                            message: response?.detail.message
                            ?? "Erro desconhecido no servidor")
                        ))
                        
                    }
                    
                    break
                }
                
            }
        }
    }
}
