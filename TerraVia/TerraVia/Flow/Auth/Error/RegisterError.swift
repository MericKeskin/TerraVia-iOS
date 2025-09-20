//
//  RegisterError.swift
//  TerraVia
//
//  Created by Meriç Keskin on 1.09.2025.
//

enum RegisterError: LoggableError {
    
    case notOnboarded
    
    var loggableDescription: String {
        switch self {
        case .notOnboarded:
            return "Can't sign up, onboarding is not completed yet."
        }
    }
    
    var underlyingError: (any Error)? {
        switch self {
        default:
            nil
        }
    }
    
    var showErrorAlert: Bool {
        switch self {
        case .notOnboarded:
            true
        default:
            false
        }
    }
}
