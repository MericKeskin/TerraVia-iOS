//
//  ProfileView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 24.06.2025.
//

import SwiftUI

struct ProfileView: View {
    
    // MARK: Owned Object
    
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        BaseView(viewModel: viewModel) { _ in
            Text("Profile View")
        }
    }
}

#Preview {
    let coordinator: DashboardCoordinator = .shared
    let viewModel = ProfileViewModel(coordinator: coordinator)
    ProfileView(viewModel: viewModel)
}
