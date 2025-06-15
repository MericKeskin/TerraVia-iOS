//
//  RegisterViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 31.05.2025.
//

import Combine

final class RegisterViewModel: BaseViewModel<OnboardingCoordinator> {
    
    // MARK: Property
    
    @Published var email: String = ""
}

// MARK: - Navigation

extension RegisterViewModel {
    
    private func routeSignUp() {
        coordinator.navigate(to: .auth(.signUp))
    }
    
    private func routeLogin() {
        coordinator.navigate(to: .auth(.login))
    }
}

// MARK: - Firebase

extension RegisterViewModel {
    
    func checkEmailAndNavigate() {
        routeSignUp()
    }
}
