//
//  Gender.swift
//  introducao
//
//  Created by mac on 14/01/2024.
//

import Foundation


enum Gender:String ,CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Feminino"
    
    var id:String {
        self.rawValue
    }
}
