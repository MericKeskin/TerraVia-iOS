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
        case signUp
        case login
    }
    
    func makeRoute(for route: Route) -> some View {
        switch route {
        case .signUp:
            makeSignUpView()
        case .login:
            makeLoginView()
        }
    }
}

// MARK: - Make Routes

private extension AuthCoordinator {
    
    func makeLoginView() -> some View {
        let vm = LoginViewModel(coordinator: self)
        return LoginView(viewModel: vm)
    }
    
    func makeSignUpView() -> some View {
        let vm = SignUpViewModel(coordinator: self)
        return SignUpView(viewModel: vm)
    }
}
