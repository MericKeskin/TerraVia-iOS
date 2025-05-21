//
//  FirebaseError.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

enum FirebaseError: LoggableError {
    case auth(failedWith: Error?)
    
    var loggableDescription: String {
        switch self {
        case .auth:
            "Auth failed"
        }
    }
    
    var underlyingError: (any Error)? {
        switch self {
        case .auth(failedWith: let error):
            error
        default:
            nil
        }
    }
}
