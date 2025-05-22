//
//  DependencyProvider.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

protocol DependencyProviderProtocol {
    var managers: ManagerGroup { get }
    var services: ServiceGroup { get }
}

final class DependencyProvider: DependencyProviderProtocol {
    
    static let shared = DependencyProvider()
    
    // MARK: Group
    
    let managers: ManagerGroup
    let services: ServiceGroup
    
    // MARK: Lifecycle
    
    init(managers: ManagerGroup = ManagerGroup(), services: ServiceGroup = ServiceGroup()) {
        self.managers = managers
        self.services = services
    }
}
