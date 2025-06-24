//
//  AppFlowView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import SwiftUI

struct AppFlowView: View {
   
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        Group {
            NavigationStack(path: $coordinator.path) {
                splashContent
                    .navigationDestination(for: AppFlow.self) { flow in
                        coordinator.makeFlow(for: flow)
                    }
            }
        }
    }
    
    @ViewBuilder var splashContent: some View {
        let vm = RegisterViewModel(coordinator: AuthCoordinator.shared)
        RegisterView(viewModel: vm)
    }
}
