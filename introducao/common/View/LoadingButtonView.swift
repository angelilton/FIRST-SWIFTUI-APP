//
//  LoadingButtonView.swift
//  introducao
//
//  Created by mac on 20/01/2024.
//

import SwiftUI

struct LoadingButtonView: View {
    var text: String
    var loading: Bool = false
    var disabled: Bool? = false
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(loading ? " " : text)
                    .frame(maxWidth: .infinity, minHeight: 45)
                    .background(disabled! || loading ? Color("ButtonColor") : Color.orange)
                    .font(Font.system(.title3).bold())
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }).disabled(disabled! || loading)
            
            //loading que sobrepoem o btn por causa do zstack
            ProgressView()
                .opacity(loading ? 1 : 0)
                
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
            
                LoadingButtonView(
                    text:"Registar",
                    loading: false,
                    disabled: false,
                    action: { print("handle submit")}
                )
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 11")
            .preferredColorScheme($0)
        }
       
    }
}
