//
//  LoginViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import Combine

final class LoginViewModel: BaseViewModel<AuthCoordinator> {
    
    @Published var email: String = ""
    @Published var password: String = ""
}

// MARK: - Navigation

extension LoginViewModel {
    
    func routeSignUp() {
        coordinator.route = .signUp
    }
}
