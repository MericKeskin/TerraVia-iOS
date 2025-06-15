//
//  RegisterView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 31.05.2025.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel: RegisterViewModel
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Text("Login or Sign Up")
                        .font(.title3)
                        .foregroundStyle(.primary)
                    
                    Color.primary.opacity(0.2)
                        .frame(height: 1)
                        .ignoresSafeArea()
                }
                
                VStack(spacing: 16) {
                    TVTextField("Email",
                                input: $viewModel.email,
                                font: .raleway(size: 20), height: 56)
                    .keyboardType(.emailAddress)
                    
                    TVButton(title: "Continue",
                             font: .raleway(size: 22, relativeTo: .caption),
                             height: 56,
                             fill: true) {
                        viewModel.checkEmail()
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    let coordinator: OnboardingCoordinator = .shared
    let viewModel = RegisterViewModel(coordinator: coordinator)
    RegisterView(viewModel: viewModel)
}
