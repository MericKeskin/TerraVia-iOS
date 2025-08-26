//
//  ErrorHandler.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import Combine

final class ErrorHandler: ObservableObject {
    
    /// Common instance for singularity.
    static let shared = ErrorHandler()
    
    /// A state variable of the occuring error.
    @Published private(set) var activeError: LoggableError?
    
    /// Handles the error.
    func register(_ error: Error) {
        let loggableError = error.eraseToLoggable()
        
        if loggableError.showErrorAlert {
            activeError = loggableError
        }
        
        Log.error(loggableError)
    }

    /// Resets the error.
    func clear() {
        activeError = nil
    }
}
