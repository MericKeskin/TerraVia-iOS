//
//  ErrorHandler.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import Combine

final class ErrorHandler: ObservableObject {
    
    static let shared = ErrorHandler()
    
    @Published var activeError: Error?
    
    func register(_ error: Error) {
            if let loggableError = error as? LoggableError, loggableError.showUser {
                activeError = loggableError
            } else {
                Log.error(error)
            }
        }

        func clear() {
            activeError = nil
        }
}
