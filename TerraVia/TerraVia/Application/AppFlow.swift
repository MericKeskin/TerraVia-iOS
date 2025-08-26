//
//  AppFlow.swift
//  TerraVia
//
//  Created by Meriç Keskin on 14.06.2025.
//

enum AppFlow: Hashable {
    
    case onboarding(OnboardingCoordinator.Route)
    case auth(AuthCoordinator.Route)
    case dashboard(DashboardCoordinator.Route)
}
