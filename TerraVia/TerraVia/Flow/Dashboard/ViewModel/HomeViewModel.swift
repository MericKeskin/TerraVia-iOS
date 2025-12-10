//
//  HomeViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 24.06.2025.
//

final class HomeViewModel: BaseViewModel<DashboardCoordinator> {
    
}

// MARK: - View Actions

extension HomeViewModel {
    
    func profileButtonTapped() {
        routeProfile()
    }
}

// MARK: - Navigation

private extension HomeViewModel {
    
    func routeProfile() {
        coordinator.navigate(to: .dashboard(.profile))
    }
}
