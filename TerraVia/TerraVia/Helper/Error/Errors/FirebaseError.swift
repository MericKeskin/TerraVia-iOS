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
    case invalidResponse
    
    
    var loggableDescription: String {
        switch self {
        case .signUp,
             .login:
            "Auth failed"
        case .function:
            "Cloud Function failed"
        case .invalidResponse:
            "Invalid response"
        }
    }
    
    var underlyingError: (any Error)? {
        switch self {
        case .signUp(failedWith: let error),
             .login(failedWith: let error),
             .function(failedWith: let error):
            error
        default:
            nil
        }
    }
}
