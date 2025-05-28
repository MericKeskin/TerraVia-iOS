//
//  AuthFlowView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import SwiftUI

struct AuthFlowView: BaseFlowView {
    
    @ObservedObject var coordinator: AuthCoordinator = .shared
    
    var navigationContent: some View {
        switch coordinator.currentRoute {
        case .login:
            coordinator.makeLoginView()
        case .signUp:
            coordinator.makeSignUpView()
        }
    }
}
