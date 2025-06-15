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
        case register
    }
    
    static let shared = OnboardingCoordinator()
    
    func makeRoute(for route: Route) -> some View {
        switch route {
        case .welcome:
            makeWelcomeView()
        case .register:
            makeRegisterView()
        }
    }
}

// MARK: - Make Routes

private extension OnboardingCoordinator {
    
    func makeWelcomeView() -> some View {
        let vm = WelcomeViewModel(coordinator: self)
        return WelcomeView(viewModel: vm)
    }
    
    func makeRegisterView() -> some View {
        let vm = RegisterViewModel(coordinator: self)
        return RegisterView(viewModel: vm)
    }
}
