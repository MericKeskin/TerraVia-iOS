//
//  LoginView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            VStack {
                Text("Login")
                    .font(.headline)
                TextField("Email", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
                Button(action: {
                    viewModel.routeSignUp()
                }) {
                    Text("Sign Up")
                }
            }
        }
    }
}
