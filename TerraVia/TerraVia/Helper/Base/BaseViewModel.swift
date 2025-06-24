//
//  BaseViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

import Combine
import SwiftUICore

class BaseViewModel<C: BaseCoordinator>: ObservableObject {
    
    // MARK: Dependency
    
    private let dependencyProvider: DependencyProviderProtocol
    var managers: ManagerGroup
    var services: ServiceGroup
    
    // MARK: Coordinator
    
    @ObservedObject var coordinator: C
    
    // MARK: Error
    
    let errorHandler: ErrorHandler = .shared
    
    // MARK: Hud
    
    @Published var isShowingHud: Bool = false
    
    // MARK: Loading
    
    @Published var isLoading: Bool = false
    
    // MARK: Lifecycle
    
    init(dependencyProvider: DependencyProviderProtocol = DependencyProvider.shared, coordinator: C) {
        self.dependencyProvider = dependencyProvider
        self.managers = dependencyProvider.managers
        self.services = dependencyProvider.services
        self.coordinator = coordinator
    }
}
