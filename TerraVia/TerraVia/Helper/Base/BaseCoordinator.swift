//
//  BaseCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import Combine
import SwiftUI

protocol BaseCoordinator: ObservableObject {
    
    /// For enumerating the routes.
    /// Create a enum named 'Route' conforming to BaseRoute inside the coordinator, add cases for each route.
    associatedtype Route: BaseRoute
    
    /// Generic makeRoute(for:) return value.
    associatedtype RouteContent: View
    
    /// Common instance for singularity.
    static var shared: Self { get }
    
    /// View builder to arrange the views of the flow.
    @ViewBuilder func makeRoute(for route: Route) -> RouteContent
    
    /// Navigates to route inside a flow.
    func navigate(to flow: AppFlow, resetting: Bool)
    
    func pop(to flow: AppFlow)
    
    func pop(_ k: Int)
}

extension BaseCoordinator {
    
    func navigate(to flow: AppFlow, resetting: Bool = false) {
        if resetting {
            AppCoordinator.shared.navigate(resettingTo: flow)
        } else {
            AppCoordinator.shared.navigate(to: flow)
        }
    }
    
    func pop(to flow: AppFlow) {
        AppCoordinator.shared.pop(to: flow)
    }
    
    func pop(_ k: Int = 1) {
        AppCoordinator.shared.pop(k)
    }
}
