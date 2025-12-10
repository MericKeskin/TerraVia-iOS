//
//  SettleView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 1.09.2025.
//

import SwiftUI

struct SettleView: View {
    
    // MARK: Owned Object
    
    @StateObject var viewModel: SettleViewModel
    
    // MARK: Focus State
    
    @FocusState private var greetingNameFocusState: Bool
    
    var body: some View {
        BaseView(
            viewModel: viewModel,
            navigationBarConfiguration: .blended,
            backButtonConfiguration: .custom(action: viewModel.backButtonTapped),
            leadingItemConfiguration: .hidden,
            titleConfiguration: .hidden,
            trailingItemConfiguration: .custom(trailingItemStack, spaced: false)
        ) { _ in
            VStack(spacing: 16) {
                Group {
                    switch viewModel.scene {
                    case .language, .personality, .notification, .finalize:
                        terryStack()
                            .transition(.asymmetric(insertion: .slide, removal: .move(edge: .leading).combined(with: .opacity)))
                    case .initialize, .greeting:
                        EmptyView()
                    }
                }
                
                Group {
                    switch viewModel.scene {
                    case .initialize:
                        Spacer()
                    case .greeting:
                        greetingStack()
                            .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading).combined(with: .opacity)))
                            .onAppear {
                                viewModel.greetingAppeared()
                            }
                    case .language:
                        languageStack()
                            .transition(.asymmetric(insertion: .slide.combined(with: .opacity), removal: .move(edge: .leading).combined(with: .opacity)))
                            .onAppear {
                                viewModel.languageAppeared()
                            }
                    case .personality:
                        personalityStack()
                    case .notification:
                        notificationStack()
                    case .finalize:
                        finalizeStack()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.middleViewTapped()
                }
                
                continueButtonStack()
                    .padding(.horizontal, 32)
            }
            .padding(.vertical, 16)
        }
        .onAppear {
            bindStates()
            
            viewModel.viewAppeared()
        }
    }
}

// MARK: - Binding

extension SettleView {
    
    func bindStates() {
        viewModel.greetingNameFocusState = $greetingNameFocusState
    }
}

// MARK: - Subviews

private extension SettleView {
    
    @ViewBuilder
    func terryStack() -> some View {
        HStack(alignment: .top, spacing: 16) {
            Image(viewModel.terryHeadImage)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .fixedSize()
            
            Group {
                Text(viewModel.terryDisplayedText)
                    .font(.cormorantGaramond(weight: .regular, size: 24))
                    .foregroundColor(.tintPrimary)
                + Text(viewModel.terryRestText)
                    .font(.cormorantGaramond(weight: .regular, size: 24))
                    .foregroundColor(.backgroundPrimary)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.top, 16)
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    func greetingStack() -> some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image(.terryGreeting)
                .resizable()
                .scaledToFit()
                .frame(height: 180)
            
            Spacer()
            
            Group {
                Text(viewModel.greetingDisplayedText)
                    .font(.cormorantGaramond(weight: .regular, size: 32))
                    .foregroundColor(.tintPrimary)
                + Text(viewModel.greetingRestText)
                    .font(.cormorantGaramond(weight: .regular, size: 32))
                    .foregroundColor(.backgroundPrimary)
            }
            .frame(height: 40)
        }
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TVTextField(
                    input: $viewModel.greetingName,
                    font: .raleway(weight: .regular, size: 36),
                    textAlignment: .center,
                    textFieldStyle: .clear,
                    focused: $greetingNameFocusState,
                    autoCapitalizationType: .words,
                    horizontalPadding: 0,
                    verticalPadding: 0,
                )
            }
            .padding(.horizontal, 64)
            
            Spacer()
        }
        .padding(.top, 16)
    }
    
    @ViewBuilder
    func languageStack() -> some View {
        Group {
            if !viewModel.isLanguageListHidden {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.allLanguages, id: \.self) { language in
                            HStack(spacing: 0) {
                                Text(language.capitalizedLong)
                                    .font(.raleway(weight: .regular, size: 24))
                                    .foregroundStyle(.tintSecondary)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 32)
                            .padding(.vertical, 8)
                            .frame(height: 80)
                            .background {
                                if viewModel.selectedLanguage == language {
                                    AnyShape(.capsule)
                                        .TVStroke(.accentColor, lineWidth: 4)
                                        .background {
                                            AnyShape(.capsule)
                                                .TVFill(.backgroundSecondary)
                                        }
                                } else {
                                    AnyShape(.capsule)
                                        .TVFill(.backgroundSecondary)
                                }
                            }
                            .onTapGesture {
                                viewModel.languageListItemTapped(for: language)
                            }
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 4)
                }
                .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            } else {
                Spacer()
            }
        }
    }
    
    func personalityStack() -> some View {
        VStack(spacing: 16) {
            
        }
    }
    
    func notificationStack() -> some View {
        VStack(spacing: 16) {
            
        }
    }
    
    func finalizeStack() -> some View {
        VStack(spacing: 16) {
            
        }
    }
    
    @ViewBuilder
    func continueButtonStack() -> some View {
        TVButton(
            title: "Continue",
            font: .raleway(weight: .bold, size: 22),
            height: 48,
            fill: true,
            isDisabled: viewModel.isContinueButtonDisabled,
        ) {
            viewModel.continueButtonTapped()
        }
    }
}

// MARK: - Navigation Bar Views

extension SettleView {
    
    @ViewBuilder
    var trailingItemStack: some View {
        TVProgressBar(
            progress: $viewModel.settleProgress,
            total: viewModel.totalSettleProgress,
            color: .mainPrimary,
            height: 16
        )
    }
}

#Preview {
    let c = OnboardingCoordinator()
    let vm = SettleViewModel(coordinator: c)
    SettleView(viewModel: vm)
}
