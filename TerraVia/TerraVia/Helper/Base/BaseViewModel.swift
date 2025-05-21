//
//  BaseViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

import Foundation

class BaseViewModel: ObservableObject {
    
    // MARK: Dependency
    
    private var dependencyProvider: DependencyProvider
    
    // MARK: Managers
    
    lazy var firebaseManager = dependencyProvider.firebaseManager
    
    // MARK: Lifecycle
    
    init(dependencyProvider: DependencyProvider = .common) {
        self.dependencyProvider = dependencyProvider
    }
}
