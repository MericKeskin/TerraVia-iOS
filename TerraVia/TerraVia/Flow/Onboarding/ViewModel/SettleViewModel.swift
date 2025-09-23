//
//  SettleViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 1.09.2025.
//

import SwiftUI
import Combine

final class SettleViewModel: BaseViewModel<OnboardingCoordinator> {
    
    @Published var scene: Scene = .language
    
    @Published var settleProgress: Double = 10
}

// MARK: - View Actions

extension SettleViewModel {
    
    func continueButtonTapped() {
        if settleProgress > 120 {
            setOnboarded()
            
            routeRegister()
        } else {
            settleForward()
        }
    }
    
    func backButtonTapped() {
        if settleProgress < 20 {
            resetOnboarded()
            
            routeBack()
        } else {
            settleBackward()
        }
    }
}

// MARK: - Navigation

extension SettleViewModel {
    
    func routeRegister() {
        coordinator.navigate(to: .auth(.register))
    }
    
    func routeBack() {
        coordinator.pop()
    }
}

// MARK: - Logic

extension SettleViewModel {
    
    func settleBackward() {
        withAnimation {
            self.settleProgress -= 40
        }
    }
    
    func settleForward() {
        withAnimation {
            self.settleProgress += 40
        }
    }
    
    func setOnboarded() {
        appPreferenceProvider.onboarded = true
    }
    
    func resetOnboarded() {
        appPreferenceProvider.onboarded = false
    }
}

// MARK: - Enums

extension SettleViewModel {
    
    enum Scene {
        
        case transition
        case language
        case personality
        case notification
    }
}
