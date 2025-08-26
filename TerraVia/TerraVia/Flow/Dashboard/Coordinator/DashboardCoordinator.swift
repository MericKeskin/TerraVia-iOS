//
//  DashboardCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 24.06.2025.
//

import Combine
import SwiftUICore

final class DashboardCoordinator: BaseCoordinator {
    
    static let shared = DashboardCoordinator()
    
    enum Route {
        
        case home
        case profile
    }
    
    func makeRoute(for route: Route) -> some View {
        switch route {
        case .home:
            makeHomeView()
        case .profile:
            makeProfileView()
        }
    }
}

// MARK: - Make Routes

private extension DashboardCoordinator {
    
    func makeHomeView() -> some View {
        let vm = HomeViewModel(coordinator: self)
        return HomeView(viewModel: vm)
    }
    
    func makeProfileView() -> some View {
        let vm = ProfileViewModel(coordinator: self)
        return ProfileView(viewModel: vm)
    }
}
