//
//  EditTextView.swift
//  introducao
//
//  Created by mac on 19/01/2024.
//

import SwiftUI

struct EditTextView: View {
    @Binding var text: String
    
    var isSecureField: Bool = false
    var placeholder: String = ""
    var isError: Bool = false
    var error: String? = nil
    var keyboard: UIKeyboardType = .default
    
    var body: some View {
        VStack(spacing: 10){
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(CustomTextField())
                    .keyboardType(keyboard)
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(CustomTextField())
                    .keyboardType(keyboard)
            }
            
            if let error = error, isError == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
        .padding(.bottom, 10)
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                EditTextView(
                    text: .constant("texto"),
                    isError: true,
                    error: "email e obrigatorio"
                )
                    .padding()
            }
            .previewDevice("iPhone 11 Pro")
            .preferredColorScheme($0)
           
        }
        
    }
}
