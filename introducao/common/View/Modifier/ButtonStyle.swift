//
//  ButtonStyle.swift
//  introducao
//
//  Created by mac on 24/02/2024.
//

import Foundation
import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 45)
            .background(Color.orange)
            .font(Font.system(.title3).bold())
            .foregroundColor(.white)
            .cornerRadius(7)
    }
}
