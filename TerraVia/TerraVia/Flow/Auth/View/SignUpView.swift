//
//  SignUpView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 24.05.2025.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel: SignUpViewModel
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            Text("Sign Up")
        }
    }
}

#Preview {
    let mockSignUpViewModel = SignUpViewModel(coordinator: AuthCoordinator.shared)
    SignUpView(viewModel: mockSignUpViewModel)
}
