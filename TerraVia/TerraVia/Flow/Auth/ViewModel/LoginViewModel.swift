//
//  LoginViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import Combine

final class LoginViewModel: BaseViewModel<AuthCoordinator> {
    
    // MARK: Dependency
    
    private lazy var firebaseManager = managers.firebaseManager
    
    // MARK: Property
    
    @Published var email: String = ""
    @Published var password: String = ""
}

// MARK: - Navigation

extension LoginViewModel {
    
}

// MARK: - Firebase

extension LoginViewModel {
    
    func logIn() {
        firebaseManager.logIn(email: email, password: password) { _ in
            
        }
    }
}
