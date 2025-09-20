//
//  WelcomeViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import SwiftUI

final class WelcomeViewModel: BaseViewModel<OnboardingCoordinator> {
    
    enum Scene {
        
        case introduce
        case transition
        case getStarted
    }
    
    enum Tab: Int, CaseIterable {
        
        case first = 1
        case second
        case third
        case fourth
        
        var next: Tab? {
            let all = Self.allCases
            
            guard self.rawValue < all.count else { return nil }
            
            return all[self.rawValue]
        }

        var previous: Tab? {
            let all = Self.allCases
            
            guard self.rawValue > 1 else { return nil }
            
            return all[self.rawValue - 2]
        }
        
        var image: Image {
            Image("Onboarding_\(rawValue)")
        }
        
        var title: String {
            switch self {
            case .first:
                "Prepare for Your Journey"
            case .second:
                "Start Traveling"
            case .third:
                "Snap Your Photos"
            case .fourth:
                "Chat with Terry"
            }
        }
        
        var subtitle: String {
            switch self {
            case .first:
                "Plan your route, book your accommodation, and more."
            case .second:
                "Explore the world, one step at a time."
            case .third:
                "Capture photos if you wonder where you are, or what you're seeing."
            case .fourth:
                "Ask questions and share your photos with Terry."
            }
        }
        
        var backButtonTitle: String {
            switch self {
            case .first:
                "Skip"
            default:
                "Back"
            }
        }
        
        var nextButtonTitle: String {
            switch self {
            case .fourth:
                "Let's Go"
            default:
                "Next"
            }
        }
    }
    
    @Published var scene: Scene = .introduce
    
    @Published var tab: Tab = .first
    
    let allTabs: [Tab] = Tab.allCases
}

// MARK: - View Actions

extension WelcomeViewModel {
    
    func rightButtonTapped() {
        if tab == .fourth {
            showGetStarted()
        } else {
            nextTab()
        }
    }
    
    func leftButtonTapped() {
        if tab == .first {
            showGetStarted()
        } else {
            previousTab()
        }
    }
    
    func goButtonTapped() {
        showGetStarted()
    }
    
    func skipButtonTapped() {
        showGetStarted()
    }
    
    func restartButtonTapped() {
        showIntroduce()
    }
    
    func getStartedButtonTapped() {
        routeSettle()
    }
    
    func alreadyRegisteredButtonTapped() {
        routeRegister()
    }
}

// MARK: - Navigation

private extension WelcomeViewModel {
    
    func showGetStarted() {
        withAnimation(.easeIn(duration: 0.8)) {
            scene = .transition
        }
            
        withAnimation(.easeOut(duration: 1.2).delay(0.8)) {
            scene = .getStarted
        }
    }
    
    func showIntroduce() {
        tab = .first
        
        withAnimation(.easeIn(duration: 0.8)) {
            scene = .transition
        }
        
        withAnimation(.easeOut(duration: 1.2).delay(0.8)) {
            scene = .introduce
        }
    }
    
    func routeRegister() {
        coordinator.navigate(to: .auth(.register))
    }
    
    func routeSettle() {
        coordinator.navigate(to: .onboarding(.settle))
    }
}

// MARK: - Logic

private extension WelcomeViewModel {
    
    func nextTab() {
        guard let next = tab.next else { return }
        
        withAnimation {
            tab = next
        }
    }
    
    func previousTab() {
        guard let previous = tab.previous else { return }
        
        withAnimation {
            tab = previous
        }
    }
}
