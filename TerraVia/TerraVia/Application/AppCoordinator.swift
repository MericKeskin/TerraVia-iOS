//
//  AppCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import Combine
import SwiftUICore

final class AppCoordinator: ObservableObject {
    
    static var shared = AppCoordinator()
    
    @Published var path: [AppFlow] = []
    
    func navigate(to flow: AppFlow) {
        path.append(flow)
    }
    
    func pop(_ k: Int = 1) {
        guard !path.isEmpty else { return }
        
        path.removeLast(k)
    }
    
    @ViewBuilder func makeFlow(for flow: AppFlow) -> some View {
        switch flow {
        case .onboarding(let route):
            OnboardingCoordinator.shared.makeRoute(for: route)
        case .auth(let route):
            AuthCoordinator.shared.makeRoute(for: route)
        }
    }
}
