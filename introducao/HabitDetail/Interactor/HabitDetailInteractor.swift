//
//  HabitDetailInteractor.swift
//  introducao
//
//  Created by mac on 18/04/2024.
//

import Foundation
import Combine

class HabitDetailInteractor {
    private let remote: HabitDetailRemoteDataSource = .shared
    
    func save(habitId:Int, request: HabitValueRequest) -> Future<Bool,AppError> {
        return remote.save(habitId: habitId, request: request)
    }
}
