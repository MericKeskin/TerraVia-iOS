//
//  BaseCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import Combine
import SwiftUICore

protocol BaseCoordinator: ObservableObject {
    
    /// For enumerating the routes.
    /// Create a enum named 'Route' inside the coordinator, add cases for each route.
    associatedtype Route
    
    /// For generic makeRoute(for:) return value.
    associatedtype RouteContent: View
    
    /// Common instance for singularity.
    static var shared: Self { get }
    
    /// View builder to arrange the views of the flow.
    @ViewBuilder func makeRoute(for route: Route) -> RouteContent
    
    /// Navigates to route inside a flow.
    func navigate(to flow: AppFlow, resetting: Bool)
}

extension BaseCoordinator {
    
    func navigate(to flow: AppFlow, resetting: Bool = false) {
        if resetting {
            AppCoordinator.shared.resetPath(with: flow)
        } else {
            AppCoordinator.shared.navigate(to: flow)
        }
    }
}
