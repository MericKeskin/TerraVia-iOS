//
//  AppCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import Combine
import SwiftUICore

final class AppCoordinator: ObservableObject {
    
    /// Common instance for singularity.
    static var shared = AppCoordinator()
    
    /// Navigation path.
    @Published var path: [AppFlow] = []
}

// MARK: - Navigation Path Functions

extension AppCoordinator {
    
    /// Appends route to navigation path.
    func navigate(to flow: AppFlow) {
        path.append(flow)
    }
    
    /// Appends multiple routes to navigation path.
    func navigate(to flows: [AppFlow]) {
        path.append(contentsOf: flows)
    }
    
    /// Removes all previous routes.
    func setRoot() {
        path.removeSubrange(0..<path.count-1)
    }
    
    /// Pops routes from navigation path.
    func pop(_ k: Int = 1) {
        guard !path.isEmpty else { return }
        
        path.removeLast(k)
    }
    
    /// Pops routes from navigation path until given route.
    func pop(to flow: AppFlow) {
        if path.count > 1, path.contains(flow) {
            var k: Int = 0
            
            while path.last != flow {
                k += 1
            }
            
            path.removeLast(k)
        }
    }
    
    /// Pops routes from navigation path until root.
    func popToRoot() {
        path.removeSubrange(1..<path.count)
    }
}

// MARK: - Flow View Functions

extension AppCoordinator {
    
    /// View builder to arrange the flows.
    @ViewBuilder func makeFlow(for flow: AppFlow) -> some View {
        switch flow {
        case .onboarding(let route):
            OnboardingCoordinator.shared.makeRoute(for: route)
        case .auth(let route):
            AuthCoordinator.shared.makeRoute(for: route)
        }
    }
}
