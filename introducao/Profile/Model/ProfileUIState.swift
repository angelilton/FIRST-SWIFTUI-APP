//
//  ProfileUIState.swift
//  introducao
//
//  Created by mac on 14/05/2024.
//

import Foundation

enum ProfileUIState: Equatable {
    //get
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    //put
    case updateLoading
    case updateSuccess
    case updateError(String)
}
