//
//  AppCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import Combine
import SwiftUI

final class AppCoordinator: ObservableObject {
    
    /// Common instance for singularity.
    static var shared = AppCoordinator()
    
    /// Navigation root.
    /// The view to show when navigation path is empty.
    @Published var root: AppFlow = .onboarding(.welcome)
    
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
    
    /// Reset path with new root.
    func resetPath(with flow: AppFlow) {
        popToRoot()
        
        withAnimation {
            root = flow
        }
    }
    
    /// Pops routes from navigation path.
    func pop(_ k: Int = 1) {
        guard !path.isEmpty else { return }
        
        path.removeLast(k)
    }
    
    /// Pops routes from navigation path until given route.
    func pop(to flow: AppFlow) {
        if path.count > 1, path.contains(flow) {
            while path.last != flow {
                path.removeLast()
            }
        }
    }
    
    /// Pops routes from navigation path until root.
    func popToRoot() {
        path.removeAll()
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
        case .dashboard(let route):
            DashboardCoordinator.shared.makeRoute(for: route)
        }
    }
}
