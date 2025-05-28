//
//  BaseCoordinator.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import Combine

protocol BaseCoordinator: ObservableObject {
    
    /// For enumerating the routes.
    /// Create a enum named 'Route' inside the coordinator, add cases for each route.
    associatedtype Route
    
    /// Active route of the flow.
    var currentRoute: Route { get set }
    
    /// Common instance for singularity.
    static var shared: Self { get }
}
