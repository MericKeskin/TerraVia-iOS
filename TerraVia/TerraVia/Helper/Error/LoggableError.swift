//
//  LoggableError.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

protocol LoggableError: Error {
    var loggableDescription: String { get }
    var underlyingError: Error? { get }
    var showErrorAlert: Bool { get }
}

fileprivate struct AnyLoggableError<E: Error>: LoggableError {
    
    let loggableDescription: String
    let underlyingError: Error?
    let showErrorAlert: Bool

    init(_ error: E) {
        self.loggableDescription = "Unexpected error"
        self.underlyingError = error
        self.showErrorAlert = false
    }
}

extension Error {
    
    func eraseToLoggable() -> LoggableError {
        if let loggableError = self as? LoggableError {
            return loggableError
        } else {
            return AnyLoggableError(self)
        }
    }
}
