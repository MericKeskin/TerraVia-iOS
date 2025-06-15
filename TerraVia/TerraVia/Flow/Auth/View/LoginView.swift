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
            Text("Login View")
        }
    }
}

#Preview {
    let mockLoginViewModel = LoginViewModel(coordinator: AuthCoordinator.shared)
    LoginView(viewModel: mockLoginViewModel)
}
