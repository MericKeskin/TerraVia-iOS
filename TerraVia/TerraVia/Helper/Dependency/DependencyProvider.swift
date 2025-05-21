//
//  DependencyProvider.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

final class DependencyProvider {
    
    static let common = DependencyProvider()
    
    // MARK: Manager
    
    var firebaseManager: FirebaseManagerProtocol
    
    // MARK: Service
    
    
    
    // MARK: Lifecycle
    
    init(firebaseManager: FirebaseManagerProtocol = FirebaseManager.shared) {
        self.firebaseManager = firebaseManager
    }
}
