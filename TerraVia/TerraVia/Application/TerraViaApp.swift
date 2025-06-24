//
//  TerraViaApp.swift
//  TerraVia
//
//  Created by Meriç Keskin on 12.05.2025.
//

import SwiftUI

@main
struct TerraViaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                AppFlowView()
                    .environment(\.font, .raleway(size: 16))
                    .environmentObject(AppCoordinator.shared)
                
                ErrorView()
                    .environmentObject(ErrorHandler.shared)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
