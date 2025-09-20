//
//  BaseViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

import Combine
import SwiftUI

class BaseViewModel<C: BaseCoordinator>: ObservableObject {
    
    // MARK: Dependency
    
    private let dependencyProvider: DependencyProviderProtocol
    
    var managers: ManagerGroup
    
    var services: ServiceGroup
    
    // MARK: Coordinator
    
    @ObservedObject var coordinator: C
    
    // MARK: Preference
    
    let appPreferenceProvider: AppPreferenceProvider = .shared
    
    // MARK: Error Handler
    
    let errorHandler: ErrorHandler = .shared
    
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
