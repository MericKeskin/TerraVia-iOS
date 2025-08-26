//
//  AuthCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import Combine
import SwiftUICore

final class AuthCoordinator: BaseCoordinator {
    
    static let shared = AuthCoordinator()
    
    enum Route {
        
        case register
        case forgotPassword
    }
    
    func makeRoute(for route: Route) -> some View {
        switch route {
        case .register:
            makeRegisterView()
        case .forgotPassword:
            makeForgotPasswordView()
        }
    }
}

// MARK: - Make Routes

private extension AuthCoordinator {
    
    func makeRegisterView() -> some View {
        let vm = RegisterViewModel(coordinator: self)
        return RegisterView(viewModel: vm)
    }
    
    func makeForgotPasswordView() -> some View {
        let vm = ForgotPasswordViewModel(coordinator: self)
        return ForgotPasswordView(viewModel: vm)
    }
}
