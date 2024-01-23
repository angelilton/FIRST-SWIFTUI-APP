//
//  RegisterSubmit.swift
//  introducao
//
//  Created by mac on 23/01/2024.
//

import Foundation

struct RegisterSubmit: Encodable {
    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
       case fullName = "name"
       case email
       case password
       case document
       case phone
       case birthday
       case gender
     }
}
