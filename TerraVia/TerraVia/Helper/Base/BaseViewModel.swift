//
//  BaseViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

import Foundation

class BaseViewModel: ObservableObject {
    
    // MARK: Dependency
    
    private let dependencyProvider: DependencyProviderProtocol
    var managers: ManagerGroup { dependencyProvider.managers }
    var services: ServiceGroup { dependencyProvider.services }
    
    // MARK: Lifecycle
    
    init(dependencyProvider: DependencyProviderProtocol = DependencyProvider.shared) {
        self.dependencyProvider = dependencyProvider
    }
}
