//
//  WelcomeView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import SwiftUI

struct WelcomeView: View {
    
    @StateObject var viewModel: WelcomeViewModel
    
    var body: some View {
        BaseView(
            viewModel: viewModel,
            navigationBarConfiguration: .hidden
        ) { _ in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Spacer()
                    
                    Image(.app)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 240)
                        .padding(.bottom, 16)
                }
                
                Text("TerraVia")
                    .font(.cormorantGaramond(weight: .bold, size: 56))
                    .foregroundStyle(.mainPrimary)
                
                VStack(spacing: 16) {
                    Text("Your travel assistant.")
                        .font(.raleway(size: 18))
                        .foregroundStyle(.tintSecondary)
                    
                    Spacer()
                    
                    TVButton(
                        title: "Get Started",
                        font: .raleway(weight: .bold, size: 22),
                        height: 48,
                        fill: true
                    ) {
                        viewModel.getStartedButtonTapped()
                    }
                    
                    TVButton(
                        title: "I already have an account.",
                        font: .raleway(size: 18),
                        buttonStyle: .clear,
                        horizontalPadding: 0,
                        verticalPadding: 0
                    ) {
                        viewModel.alreadyRegisteredButtonTapped()
                    }
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    let coordinator = OnboardingCoordinator()
    let welcomeViewModel = WelcomeViewModel(coordinator: coordinator)
    WelcomeView(viewModel: welcomeViewModel)
}
