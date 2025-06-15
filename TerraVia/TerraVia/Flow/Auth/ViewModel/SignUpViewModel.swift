//
//  SignUpViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 24.05.2025.
//

import Combine

final class SignUpViewModel: BaseViewModel<AuthCoordinator> {
    
    // MARK: Dependency
    
    private lazy var firebaseManager = managers.firebaseManager
    
    // MARK: Property
    
    @Published var email: String = ""
    @Published var password: String = ""
}

// MARK: - Navigation

extension SignUpViewModel {
    
}

// MARK: - Firebase

extension SignUpViewModel {
    
    func signUp() {
        firebaseManager.signUp(email: email, password: password) { _ in
            
        }
    }
}
