//
//  BaseViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

import Combine

class BaseViewModel<C: BaseCoordinator>: ObservableObject {
    
    // MARK: Dependency
    
    private let dependencyProvider: DependencyProviderProtocol
    var managers: ManagerGroup { dependencyProvider.managers }
    var services: ServiceGroup { dependencyProvider.services }
    
    // MARK: Coordinator
    
    let coordinator: C
    
    // MARK: Lifecycle
    
    init(dependencyProvider: DependencyProviderProtocol = DependencyProvider.shared, coordinator: C) {
        self.dependencyProvider = dependencyProvider
        self.coordinator = coordinator
    }
    
    // MARK: Error
    
    @Published var activeError: LoggableError?
}
