//
//  HabitInteractor.swift
//  introducao
//
//  Created by mac on 10/04/2024.
//

import Foundation
import Combine

class HabitInteractor {
    private let remote: HabitRemoteDataSource = .shared
}

extension HabitInteractor {
  
  func fetchHabits() -> Future<[HabitResponse], AppError> {
    return remote.fetchHabits()
  }
  
}
