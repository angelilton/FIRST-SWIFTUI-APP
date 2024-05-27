//
//  ProfileInteractor.swift
//  introducao
//
//  Created by mac on 14/05/2024.
//

import Foundation
import Combine

class ProfileInteractor {
    private let remote: ProfileRemoteDataSource = .schared
    
    func fethUser() -> Future<ProfileResponse,AppError> {
        return remote.fetchUser()
    }
}
