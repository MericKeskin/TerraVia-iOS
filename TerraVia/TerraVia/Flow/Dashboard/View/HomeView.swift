//
//  HomeView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 24.06.2025.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: Owned Object
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        BaseView(
            viewModel: viewModel,
            titleConfiguration: .normal(title: "Home"),
            trailingItemConfiguration: .custom(trailingItemStack)
        ) { _ in
            Text("Home View")
        }
    }
}

extension HomeView {
    
    @ViewBuilder
    var trailingItemStack: some View {
        TVButton(
            label: {
                Image(systemName: "person.fill")
            },
            buttonStyle: .clear,
            horizontalPadding: 0,
            verticalPadding: 0
        ) {
            viewModel.profileButtonTapped()
        }
    }
}

#Preview {
    let coordinator: DashboardCoordinator = .shared
    let viewModel = HomeViewModel(coordinator: coordinator)
    HomeView(viewModel: viewModel)
}
