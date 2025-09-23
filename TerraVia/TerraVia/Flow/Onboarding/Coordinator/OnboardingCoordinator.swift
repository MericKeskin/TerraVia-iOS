//
//  OnboardingCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import Combine
import SwiftUI

final class OnboardingCoordinator: BaseCoordinator {
    
    enum Route: BaseRoute {
        
        case welcome
        case settle
    }
    
    static let shared = OnboardingCoordinator()
    
    func makeRoute(for route: Route) -> some View {
        switch route {
        case .welcome:
            makeWelcomeView()
        case .settle:
            makeSettleView()
        }
    }
}

// MARK: - Make Routes

private extension OnboardingCoordinator {
    
    func makeWelcomeView() -> some View {
        let vm = WelcomeViewModel(coordinator: self)
        return WelcomeView(viewModel: vm)
    }
    
    func makeSettleView() -> some View {
        let vm = SettleViewModel(coordinator: self)
        return SettleView(viewModel: vm)
    }
}
