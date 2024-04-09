//
//  LocalDataSource.swift
//  introducao
//
//  Created by mac on 12/02/2024.
//

import Foundation
import Combine

class LocalDataSource {
    static var shared: LocalDataSource = LocalDataSource()
    // salva em JOSN os dados
    private func saveValue(value: UserAuth) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "USER_KEY")
    }
    
    private func readValue(forKey key: String) -> UserAuth? {
        var userAuth: UserAuth?
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        
        return userAuth
    }
}

extension LocalDataSource {
    func setUserAuth(userAuth: UserAuth) {
        saveValue(value: userAuth)
    }
    
    func getUserAuth () -> Future<UserAuth?, Never> {
        let userAuth = readValue(forKey: "USER_KEY")
        return Future { promise in
            promise(.success(userAuth))
        }
    }
}
