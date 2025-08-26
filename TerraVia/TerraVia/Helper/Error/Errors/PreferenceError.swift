//
//  PreferenceError.swift
//  TerraVia
//
//  Created by Meriç Keskin on 1.07.2025.
//

enum PreferenceError: LoggableError {
    
    case read(from: String)
    case decode
    case encode
    
    var loggableDescription: String {
        switch self {
        case .read(from: let key):
            "Failed reading preference for: \(key)"
        case .decode:
            "Failed decoding preference"
        case .encode:
            "Failed encoding preference"
        }
    }
    
    var underlyingError: Error? {
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
