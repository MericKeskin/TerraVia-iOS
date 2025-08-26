//
//  TerraViaApp.swift
//  TerraVia
//
//  Created by Meriç Keskin on 12.05.2025.
//

import SwiftUI

@main
struct TerraViaApp: App {
    
    // MARK: AppDelegate
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: Error Handler
    
    @StateObject private var errorHandler = ErrorHandler.shared
    
    // MARK: App Dependency
    
    @StateObject private var appCoordinator = AppCoordinator.shared
    @StateObject private var appPreferenceProvider = AppPreferenceProvider.shared
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                AppFlowView(appCoordinator: appCoordinator)
                    .environment(\.font, .raleway(size: 22))
                
                ErrorView()
                    .environmentObject(errorHandler)
            }
            .preferredColorScheme(appPreferenceProvider.viewTheme.colorScheme)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
