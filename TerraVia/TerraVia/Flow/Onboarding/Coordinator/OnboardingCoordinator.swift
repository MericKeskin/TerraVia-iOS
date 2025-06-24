//
//  OnboardingCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import Combine
import SwiftUICore

final class OnboardingCoordinator: BaseCoordinator {
    
    enum Route {
        case welcome
    }
    
    static let shared = OnboardingCoordinator()
    
    func makeRoute(for route: Route) -> some View {
        switch route {
        case .welcome:
            makeWelcomeView()
        }
    }
}

// MARK: - Make Routes

private extension OnboardingCoordinator {
    
    func makeWelcomeView() -> some View {
        let vm = WelcomeViewModel(coordinator: self)
        return WelcomeView(viewModel: vm)
    }
}
