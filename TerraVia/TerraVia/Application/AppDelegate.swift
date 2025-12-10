//
//  AppDelegate.swift
//  TerraVia
//
//  Created by Meriç Keskin on 15.05.2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // MARK: Firebase
        
        FirebaseApp.configure()
        
        // TODO: Set AppCoordinator.shared.root to proper initial flow
        AppCoordinator.shared.root = .onboarding(.introduce)
        
        return true
    }
}
