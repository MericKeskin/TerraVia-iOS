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
            if #available(iOS 16.0, *) {
                NavigationStack(path: $coordinator.path) {
                    splashContent
                        .navigationDestination(for: AppFlow.self) { flow in
                            coordinator.makeFlow(for: flow)
                        }
                }
            } else {
                NavigationView {
                    splashContent
                    
                    NavigationLink(
                        destination: coordinator.path.last.map(coordinator.makeFlow),
                        isActive: Binding(
                            get: { coordinator.path.last != nil },
                            set: { if !$0 { coordinator.pop() } }
                        ),
                        label: { EmptyView() }
                    )
                }
                .animation(.easeInOut, value: coordinator.path)
            }
        }
    }
    
    @ViewBuilder var splashContent: some View {
        let vm = RegisterViewModel(coordinator: OnboardingCoordinator.shared)
        RegisterView(viewModel: vm)
    }
}
