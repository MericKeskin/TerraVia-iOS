//
//  ErrorView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 30.05.2025.
//

import SwiftUI

struct ErrorView: View {
    
    @EnvironmentObject var errorHandler: ErrorHandler
    
    private var errorMessage: String {
        if let loggableError = errorHandler.activeError as? LoggableError {
            loggableError.loggableDescription
        } else {
            "Unknown error"
        }
    }
    
    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
            .alert("Error",
                    isPresented: Binding<Bool>(
                        get: { errorHandler.activeError != nil },
                        set: { newValue in
                            if !newValue {
                                errorHandler.clear()
                            }
                        }
                    ),
                    presenting: errorHandler.activeError,
                    actions: { _ in
                                 Button("Dismiss") {
                                     errorHandler.clear()
                                 }
                             },
                   message: { error in
                                Text(errorMessage)
                            })
    }
}
