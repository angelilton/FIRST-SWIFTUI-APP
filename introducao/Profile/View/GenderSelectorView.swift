//
//  GenderSelectorView.swift
//  introducao
//
//  Created by mac on 11/05/2024.
//

import SwiftUI

struct GenderSelectorView: View {
    let title: String
    let genders:[Gender]
    
    @Binding var selectedGender: Gender?
    
    var body: some View {
        Form {
            Section(header: Text(title)) {
                List(genders, id: \.id) { item in
                    HStack {
                        Text(item.rawValue)
                        Spacer()
                        Image(systemName:"checkmark")
                            .foregroundColor(selectedGender == item ? .orange : .white)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !(selectedGender == item) {
                            selectedGender = item
                        }
                    }
                    
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GenderSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelectorView(title: "Sexo!", genders: Gender.allCases, selectedGender: .constant(.male))
    }
}
