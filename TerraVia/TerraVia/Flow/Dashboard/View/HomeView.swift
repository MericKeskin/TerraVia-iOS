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
        BaseView(viewModel: viewModel) { _ in
            Text("Home View")
        }
    }
}

#Preview {
    let coordinator: DashboardCoordinator = .shared
    let viewModel = HomeViewModel(coordinator: coordinator)
    HomeView(viewModel: viewModel)
}
