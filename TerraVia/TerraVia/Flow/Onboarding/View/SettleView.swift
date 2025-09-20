//
//  SettleView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 1.09.2025.
//

import SwiftUI

struct SettleView: View {
    
    @StateObject var viewModel: SettleViewModel
    
    var body: some View {
        BaseView(
            viewModel: viewModel,
            navigationBarConfiguration: .separated,
            backButtonConfiguration: .custom(viewModel.previousButtonTapped),
            leadingItemConfiguration: .hidden,
            trailingItemConfiguration: .custom(progressBarStack)
        ) { _ in
            VStack {
                VStack(spacing: 0) {
                    Spacer()
                    
                    TVButton(
                        title: "Continue",
                        font: .raleway(weight: .semiBold, size: 20),
                        fill: true
                    ) {
                        viewModel.continueButtonTapped()
                    }
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
        }
    }
    
    var progressBarStack: some View {
        TVProgressBar(
            progress: $viewModel.settleProgress,
            total: 140,
            color: .mainPrimary,
            height: 16
        )
    }
}
