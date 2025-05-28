//
//  AuthFlowView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import SwiftUI

struct AuthFlowView: BaseFlowView {
    
    @StateObject var coordinator: AuthCoordinator = .shared
    
    var navigationContent: some View {
        switch coordinator.route {
        case .login:
            coordinator.makeLoginView()
        case .signUp:
            coordinator.makeSignUpView()
        }
    }
}
