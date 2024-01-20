//
//  String+Extension.swift
//  introducao
//
//  Created by mac on 20/01/2024.
//

import Foundation

extension String {
    func emailValidated() -> Bool {
        let regEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regEX).evaluate(with: self)
    }
}
