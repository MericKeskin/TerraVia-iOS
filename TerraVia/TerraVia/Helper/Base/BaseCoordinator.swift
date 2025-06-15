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
    
    associatedtype RouteContent: View
    
    /// Common instance for singularity.
    static var shared: Self { get }
    
    @ViewBuilder func makeRoute(for route: Route) -> RouteContent
    
    func navigate(to flow: AppFlow)
}

extension BaseCoordinator {
    
    func navigate(to flow: AppFlow) {
        AppCoordinator.shared.navigate(to: flow)
    }
}
