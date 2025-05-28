//
//  AuthCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import Combine
import SwiftUICore

final class AuthCoordinator: BaseCoordinator {
    
    enum Route {
        case login
        case signUp
    }
    
    @Published var route: Route = .login
    
    static let shared = AuthCoordinator()
}

// MARK: - Route Functions

extension AuthCoordinator {
    
    func makeLoginView() -> some View {
        let vm = LoginViewModel(coordinator: self)
        return LoginView(viewModel: vm)
    }
    
    func makeSignUpView() -> some View {
        let vm = SignUpViewModel(coordinator: self)
        return SignUpView(viewModel: vm)
    }
}
