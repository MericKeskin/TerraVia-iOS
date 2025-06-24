//
//  ErrorView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 30.05.2025.
//

import SwiftUI

struct ErrorView: View {
    
    @EnvironmentObject var errorHandler: ErrorHandler
    
    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
            .alert("Error",
                   isPresented: Binding<Bool>(
                        get: {
                            errorHandler.activeError != nil
                        },
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
                                Text(error.loggableDescription)
                            })
    }
}
