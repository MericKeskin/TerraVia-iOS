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
        ) { namespace in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    switch viewModel.scene {
                    case .introduce:
                        introduceImageStack()
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    case .transition:
                        EmptyView()
                    case .getStarted:
                        getStartedRestartStack()
                            .transition(.asymmetric(insertion: .push(from: .trailing), removal: .move(edge: .trailing)))
                        getStartedLogoStack()
                            .transition(.asymmetric(insertion: .push(from: .top), removal: .move(edge: .top).combined(with: .opacity)))
                    }
                }
                
                VStack(spacing: 0) {
                    switch viewModel.scene {
                    case .introduce:
                        introduceTitleStack()
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    case .transition:
                        EmptyView()
                    case .getStarted:
                        getStartedTitleStack()
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    }
                }
                
                VStack(spacing: 0) {
                    switch viewModel.scene {
                    case .introduce:
                        introduceSubtitleStack()
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    case .transition:
                        EmptyView()
                    case .getStarted:
                        getStartedSubtitleStack()
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    }
                    
                    HStack(spacing: 0) {
                        switch viewModel.scene {
                        case .introduce:
                            introduceLeftButtonStack()
                                .transition(.asymmetric(insertion: .push(from: .leading), removal: .move(edge: .leading)))
                            
                            introduceSliderIndicator()
                                .transition(.asymmetric(insertion: .push(from: .bottom), removal: .move(edge: .bottom).combined(with: .opacity)))
                            
                            introduceRightButtonStack()
                                .transition(.asymmetric(insertion: .push(from: .trailing), removal: .move(edge: .trailing)))
                        case .transition:
                            EmptyView()
                        case .getStarted:
                            getStartedButtonStack()
                                .transition(.asymmetric(insertion: .push(from: .bottom), removal: .move(edge: .bottom).combined(with: .opacity)))
                        }
                    }
                    .padding(.horizontal, 32)
                }
            }
            .padding(.vertical, 16)
        }
    }
}

// MARK: - Subviews

extension WelcomeView {
    
    // MARK: Introduce
    
    func introduceImageStack() -> some View {
        VStack(spacing: 0) {
            TabView(selection: $viewModel.tab) {
                ForEach(viewModel.allTabs, id: \.self) { tab in
                    VStack {
                        Spacer()
                        
                        tab.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 160)
                            .padding(.bottom, 16)
                            .tag(tab.rawValue)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .disabled(true)
        }
    }
    
    func introduceTitleStack() -> some View {
        VStack(spacing: 0) {
            TabView(selection: $viewModel.tab) {
                ForEach(viewModel.allTabs, id: \.self) { tab in
                    Text(tab.title)
                        .font(.cormorantGaramond(weight: .semiBold, size: 28))
                        .foregroundStyle(.mainPrimary)
                        .lineSpacing(0)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .tag(tab.rawValue)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .disabled(true)
            .frame(maxHeight: 68)
        }
    }
    
    func introduceSubtitleStack() -> some View {
        VStack(spacing: 0) {
            TabView(selection: $viewModel.tab) {
                ForEach(viewModel.allTabs, id: \.self) { tab in
                    VStack(spacing: 0) {
                        Text(tab.subtitle)
                            .font(.raleway(size: 16))
                            .foregroundStyle(.tintSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .tag(tab.rawValue)
                        
                        Spacer()
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .disabled(true)
        }
    }
    
    func introduceLeftButtonStack() -> some View {
        HStack(spacing: 0) {
            TVButton(
                title: viewModel.tab.backButtonTitle,
                font: .raleway(weight: .semiBold, size: 20),
                buttonStyle: .filled(.secondary)
            ) {
                viewModel.leftButtonTapped()
            }
            
            Spacer()
        }
    }
    
    func introduceSliderIndicator() -> some View {
        HStack(spacing: 8) {
            ForEach(viewModel.allTabs, id: \.self) { tab in
                Circle()
                    .fill(viewModel.tab == tab ? .mainPrimary : .mainPrimary.opacity(0.2))
                    .frame(width: 8, height: 8)
                    .onTapGesture {
                        withAnimation {
                            viewModel.tab = tab
                        }
                    }
            }
        }
    }
    
    func introduceRightButtonStack() -> some View {
        HStack(spacing: 0) {
            Spacer()
            
            TVButton(
                title: viewModel.tab.nextButtonTitle,
                font: .raleway(weight: .semiBold, size: 20)
            ) {
                viewModel.rightButtonTapped()
            }
        }
    }
    
    // MARK: Get Started
    
    func getStartedRestartStack() -> some View {
        HStack(spacing: 0) {
            Spacer()
            
            TVButton(
                label: {
                    Image(systemName: "arrow.trianglehead.counterclockwise")
                },
                buttonStyle: .outlined(.secondary)
            ) {
                viewModel.restartButtonTapped()
            }
            .padding(.top, 16)
            .padding(.trailing, 16)
        }
    }
    
    func getStartedLogoStack() -> some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image(.app)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 240)
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 32)
    }
    
    func getStartedTitleStack() -> some View {
        VStack(spacing: 0) {
            Text("TerraVia")
                .font(.cormorantGaramond(weight: .bold, size: 48))
                .foregroundStyle(.mainPrimary)
        }
        .frame(maxHeight: 68)
        .padding(.horizontal, 32)
    }
    
    func getStartedSubtitleStack() -> some View {
        VStack(spacing: 0) {
            Text("Your travel assistant.")
                .font(.raleway(size: 16))
                .foregroundStyle(.tintSecondary)
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
    
    func getStartedButtonStack() -> some View {
        VStack(spacing: 8) {
            TVButton(
                title: "Get Started",
                font: .raleway(weight: .bold, size: 20),
                fill: true
            ) {
                viewModel.getStartedButtonTapped()
            }
            
            TVButton(
                title: "I already have an account.",
                font: .raleway(size: 18),
                buttonStyle: .clear
            ) {
                viewModel.alreadyRegisteredButtonTapped()
            }
        }
    }
}

#Preview {
    let coordinator = OnboardingCoordinator()
    let welcomeViewModel = WelcomeViewModel(coordinator: coordinator)
    WelcomeView(viewModel: welcomeViewModel)
}
