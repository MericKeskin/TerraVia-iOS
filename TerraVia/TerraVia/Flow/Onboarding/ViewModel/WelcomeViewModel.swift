//
//  WelcomeViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import SwiftUI

final class WelcomeViewModel: BaseViewModel<OnboardingCoordinator> {}

// MARK: - View Actions

extension WelcomeViewModel {
    
    func getStartedButtonTapped() {
        routeSettle()
    }
    
    func alreadyRegisteredButtonTapped() {
        routeRegister()
    }
}

// MARK: - Navigation

private extension WelcomeViewModel {
    
    func routeRegister() {
        coordinator.navigate(to: .auth(.register))
    }
    
    func routeSettle() {
        coordinator.navigate(to: .onboarding(.settle))
    }
}
