//
//  SignInView.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        Text("Hello, World!").background(Color.green)
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel())
    }
}
