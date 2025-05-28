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
    
    func routeSignUp() {
        coordinator.flow = .signUp
    }
}
