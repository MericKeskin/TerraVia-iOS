//
//  SettleError.swift
//  TerraVia
//
//  Created by Meriç Keskin on 4.11.2025.
//

enum SettleError: LoggableError {
    
    case typeTaskFastForward
    
    var loggableDescription: String {
        switch self {
        case .typeTaskFastForward: "Fast-forwarded typing."
        }
    }
    
    var underlyingError: (any Error)? {
        switch self {
        default: nil
        }
    }
    
    var showErrorAlert: Bool {
        switch self {
        default: false
        }
    }
}
