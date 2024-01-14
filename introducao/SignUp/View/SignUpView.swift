//
//  SignUpView.swift
//  introducao
//
//  Created by mac on 10/01/2024.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        Text("Sign-Up").background(Color.blue)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel())
    }
}
