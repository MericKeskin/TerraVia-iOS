//
//  AppFlowView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import SwiftUI

struct AppFlowView: View {
   
    @ObservedObject var appCoordinator: AppCoordinator
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.makeFlow(for: appCoordinator.root)
                .navigationDestination(for: AppFlow.self) { flow in
                    appCoordinator.makeFlow(for: flow)
                        .toolbar(.hidden)
                }
                .toolbar(.hidden)
        }
    }
}
