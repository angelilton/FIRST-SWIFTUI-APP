//
//  TextFieldStyle.swift
//  introducao
//
//  Created by mac on 19/01/2024.
//

import SwiftUI

struct CustomTextField: TextFieldStyle {
    public func _body (configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(Color("TextColor"))
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.orange, lineWidth: 0.8)
            )
    }
}
