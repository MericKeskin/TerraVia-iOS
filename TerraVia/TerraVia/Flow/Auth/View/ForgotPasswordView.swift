//
//  ForgotPasswordView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.06.2025.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        BaseView(viewModel: viewModel) { _ in 
            Text("Forgot Password View")
            
            TVButton {
                Text("Test Reset Root")
            } action: {
                viewModel.coordinator.navigate(to: .dashboard(.home), resetting: true)
            }
        }
    }
}

#Preview {
    let coordinator: AuthCoordinator = .shared
    let viewModel = ForgotPasswordViewModel(coordinator: coordinator)
    ForgotPasswordView(viewModel: viewModel)
}
