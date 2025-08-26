//
//  BaseManager.swift
//  TerraVia
//
//  Created by Meriç Keskin on 24.08.2025.
//

protocol BaseManager: AnyObject {
    
    /// Common instance for singularity.
    static var shared: Self { get }
    
    /// Handler for TerraVia errors.
    /// Use .register(_ error:_) function to register errors.
    var errorHandler: ErrorHandler { get }
}

extension BaseManager {
    
    var errorHandler: ErrorHandler {
        .shared
    }
}
