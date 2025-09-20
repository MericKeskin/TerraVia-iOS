//
//  SettleViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 1.09.2025.
//

import SwiftUI
import Combine

final class SettleViewModel: BaseViewModel<OnboardingCoordinator> {
    
    @Published var settleProgress: Double = 10
}

// MARK: - View Actions

extension SettleViewModel {
    
    func continueButtonTapped() {
        if settleProgress > 120 {
            routeRegister()
        } else {
            stepForward()
        }
    }
    
    func previousButtonTapped() {
        if settleProgress < 20 {
            routeWelcome()
        } else {
            stepBackward()
        }
    }
}

// MARK: - Navigation

extension SettleViewModel {
    
    func routeWelcome() {
        coordinator.navigate(to: .onboarding(.welcome), resetting: true)
    }
    
    func routeRegister() {
        coordinator.navigate(to: .auth(.register))
    }
}

// MARK: - Logic

extension SettleViewModel {
    
    func stepBackward() {
        withAnimation {
            self.settleProgress -= 40
        }
    }
    
    func stepForward() {
        withAnimation {
            self.settleProgress += 40
        }
    }
    
    func setOnboarded() {
        appPreferenceProvider.onboarded = true
    }
}
