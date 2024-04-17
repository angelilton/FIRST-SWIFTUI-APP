//
//  HabitResponse.swift
//  introducao
//
//  Created by mac on 10/04/2024.
//

import Foundation

struct HabitResponse: Codable {
    let id: Int
    let name: String
    let label: String
    let iconUrl: String?
    let value: Int?
    let lastDate: String?
    
    enum CodingKeys: String,CodingKey {
        case id
        case name
        case label
        case iconUrl = "icon_url"
        case value
        case lastDate = "last_date"
    }
}
