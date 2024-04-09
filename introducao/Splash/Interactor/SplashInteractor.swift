//
//  SplashInteractor.swift
//  introducao
//
//  Created by mac on 12/02/2024.
//

import Foundation
import Combine

class SplashInteractor {
    private let local: LocalDataSource = .shared
    
    func getUserAuth () -> Future<UserAuth?, Never>  {
        return local.getUserAuth()
    }
}
