//
//  IntroduceView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 11.11.2025.
//

import SwiftUI

struct IntroduceView: View {
    
    @StateObject var viewModel: IntroduceViewModel
    
    var body: some View {
        BaseView(
            viewModel: viewModel,
            navigationBarConfiguration: .blended,
            backButtonConfiguration: viewModel.tab.previous == nil ? .hidden : .custom(action: viewModel.backButtonTapped),
            trailingItemConfiguration: .custom(trailingItemStack)
        ) { _ in
            VStack(spacing: 0) {
                ZStack {
                    ForEach(viewModel.allTabs, id: \.self) { tab in
                        if let item = viewModel.allTabItems[tab] {
                            Image(item.imageName)
                                .resizable()
                                .shadow(radius: 12)
                                .frame(width: 160, height: 160)
                                .padding(-12)
                                .background(.accent, in: .rect(cornerRadius: 32))
                                .background {
                                    RoundedRectangle(cornerRadius: 35)
                                        .fill(.backgroundPrimary)
                                        .padding(-3)
                                        .opacity(tab == viewModel.tab ? 1 : 0)
                                }
                                .rotationEffect(.degrees(-item.config.rotation))
                                .scaleEffect(item.config.scale)
                                .offset(x: item.config.offset)
                                .rotationEffect(.degrees(item.config.rotation))
                                .zIndex(item.config.zIndex)
                                .onTapGesture {
                                    if tab != viewModel.tab {
                                        viewModel.tabImageTapped(tab: tab)
                                    }
                                }
                        }
                    }
                }
                .frame(height: 360)
                .frame(maxHeight: .infinity)
                
                VStack(spacing: 6) {
                    HStack(spacing: 6) {
                        ForEach(viewModel.allTabs, id: \.self) { tab in
                            AnyShape(.capsule)
                                .fill(tab == viewModel.tab ? .accent : .accent.opacity(0.6))
                                .frame(width: tab == viewModel.tab ? 36 : 6, height: 6)
                        }
                    }
                    
                    VStack(spacing: 0) {
                        Text(viewModel.tab.item.title)
                            .font(.raleway(weight: .bold, size: 32))
                            .foregroundStyle(.tintPrimary)
                            .multilineTextAlignment(.center)
                            .contentTransition(.numericText())
                    }
                    .frame(height: 80, alignment: .bottom)
                    
                    Text(viewModel.tab.item.subtitle)
                        .font(.raleway(weight: .regular, size: 18))
                        .foregroundStyle(.tintSecondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(4, reservesSpace: true)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.horizontal, 64)
                .padding(.bottom, 48)
                
                TVButton(
                    title: viewModel.tab.item.nextText,
                    font: .raleway(weight: .bold, size: 22),
                    height: 48,
                    fill: true
                ) {
                    viewModel.nextButtonTapped()
                }
                .padding(.horizontal, 64)
            }
        }
    }
}

// MARK: - Navigation Bar Views

extension IntroduceView {
    
    @ViewBuilder
    var trailingItemStack: some View {
        TVButton(
            title: "Skip",
            font: .raleway(weight: .medium, size: 18),
            buttonStyle: .clear,
            horizontalPadding: 0,
            verticalPadding: 0
        ) {
            viewModel.skipButtonTapped()
        }
    }
}

#Preview {
    let coordinator = OnboardingCoordinator()
    let introduceViewModel = IntroduceViewModel(coordinator: coordinator)
    IntroduceView(viewModel: introduceViewModel)
}
