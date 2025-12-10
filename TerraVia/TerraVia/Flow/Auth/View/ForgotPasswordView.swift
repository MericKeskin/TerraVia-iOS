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
        BaseView(
            viewModel: viewModel,
            titleConfiguration: .normal(title: "Forgot Password")
        ) { _ in
            VStack(spacing: 8) {
                // TODO: Forgot Password View
                
                Spacer()
                
                TVButton(
                    label: {
                        Text("Test Theme Toggle")
                    },
                    buttonStyle: .filled(with: .secondary)
                ) {
                    viewModel.appPreferenceProvider.viewTheme.toggle()
                }
                
                Spacer()
                
                TVButton(
                    label: {
                        Text("Test Route Dashboard")
                    } 
                ) {
                    viewModel.coordinator.navigate(to: .dashboard(.home), resetting: true)
                }
            }
        }
    }
}

#Preview {
    let coordinator: AuthCoordinator = .shared
    let viewModel = ForgotPasswordViewModel(coordinator: coordinator)
    ForgotPasswordView(viewModel: viewModel)
}
