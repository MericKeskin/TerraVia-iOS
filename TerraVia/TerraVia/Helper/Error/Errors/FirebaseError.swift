//
//  FirebaseError.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

enum FirebaseError: LoggableError {
    
    case signUp(failedWith: Error?)
    case login(failedWith: Error?)
    case function(failedWith: Error?)
    case firestore(failedWith: Error?)
    
    
    var loggableDescription: String {
        switch self {
        case .signUp: 
            "Sign Up failed"
        case .login:
            "Auth failed"
        case .function:
            "Cloud Function failed"
        case .firestore:
            "Firestore failed"
        }
    }
    
    var underlyingError: (any Error)? {
        switch self {
        case .signUp(failedWith: let error),
             .login(failedWith: let error),
             .function(failedWith: let error),
             .firestore(failedWith: let error):
            error
        default:
            nil
        }
    }
    
    var showErrorAlert: Bool {
        switch self {
        case .signUp,
             .login,
             .function:
            true
        default:
            false
        }
    }
}

extension FirebaseError {
    
    enum Reason: LoggableError {
        
        case invalidResponse
        case notOnboarded
        
        var loggableDescription: String {
            switch self {
            case .invalidResponse:
                "Invalid response"
            case .notOnboarded:
                "Onboarding is not completed"
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
            default:
                false
            }
        }
    }
}
