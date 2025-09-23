//
//  BaseView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import SwiftUI

struct BaseView<Content: View, VM: BaseViewModel<C>, C: BaseCoordinator>: View {
    
    /// Namespace for animations.
    @Namespace var animationNamespace
    
    // MARK: Parameters
    
    @ObservedObject var viewModel: VM
    
    var navigationBarConfiguration: NavigationBarConfiguration
    var backButtonConfiguration: BackButtonConfiguration
    var leadingItemConfiguration: LeadingItemConfiguration
    var titleConfiguration: TitleConfiguration
    var trailingItemConfiguration: TrailingItemConfiguration
    var content: (Namespace.ID) -> Content
    
    init(
        viewModel: VM,
        navigationBarConfiguration: NavigationBarConfiguration = .normal,
        backButtonConfiguration: BackButtonConfiguration = .normal,
        leadingItemConfiguration: LeadingItemConfiguration = .normal,
        titleConfiguration: TitleConfiguration = .hidden,
        trailingItemConfiguration: TrailingItemConfiguration = .normal,
        @ViewBuilder content: @escaping (Namespace.ID) -> Content
    ) {
        self.viewModel = viewModel
        self.navigationBarConfiguration = navigationBarConfiguration
        self.backButtonConfiguration = backButtonConfiguration
        self.leadingItemConfiguration = leadingItemConfiguration
        self.titleConfiguration = titleConfiguration
        self.trailingItemConfiguration = trailingItemConfiguration
        self.content = content
    }
    
    var body: some View {
        ZStack {
            AnyShape(.rect)
                .TVFill(.backgroundPrimary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if navigationBarConfiguration != .hidden {
                    VStack(spacing: 0) {
                        HStack(spacing: 16) {
                            HStack(spacing: 8) {
                                if !backButtonConfiguration.isHidden {
                                    backButtonView
                                }
                                
                                leadingItemConfiguration.leadingStack
                            }
                            
                            titleConfiguration.titleStack
                            
                            HStack(spacing: 8) {
                                trailingItemConfiguration.trailingStack
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        
                        if navigationBarConfiguration != .blended {
                            AnyShape(.rect)
                                .TVFill(.borderPrimary, forceNonGradient: true)
                                .frame(height: 1)
                        }
                    }
                }
                
                content(animationNamespace)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

// MARK: - Navigation Bar Views

extension BaseView {
    
    @ViewBuilder
    var backButtonView: some View {
        HStack(spacing: 0) {
            TVButton(
                label: {
                    Image(.back)
                },
                buttonStyle: .clear,
                horizontalPadding: 0,
                verticalPadding: 0
            ) {
                if let action = backButtonConfiguration.action {
                    action()
                } else {
                    viewModel.coordinator.pop()
                }
            }
        }
    }
}

// MARK: - Navigation Bar Configuration

extension BaseView {
    
    enum NavigationBarConfiguration {
        
        case normal
        case blended
        case hidden
    }
}

// MARK: - Navigation Bar Item Configurations

extension BaseView {
    
    enum BackButtonConfiguration {
        
        case normal
        case hidden
        case custom(() -> Void)
        
        var isHidden: Bool {
            switch self {
            case .normal:
                !(AppCoordinator.shared.path.count > 0)
            case .hidden:
                true
            case .custom:
                false
            }
        }
        
        var action: (() -> Void)? {
            switch self {
            case .custom(let action):
                action
            default:
                nil
            }
        }
    }
    
    enum LeadingItemConfiguration {
        
        case normal
        case hidden
        case custom(any View)
        
        @ViewBuilder
        var leadingStack: some View {
            switch self {
            case .normal:
                Spacer()
            case .hidden:
                EmptyView()
            case .custom(let content):
                AnyView(content)
            }
        }
    }
    
    enum TitleConfiguration {
        
        case normal(String)
        case hidden
        case custom(any View)
        
        @ViewBuilder
        var titleStack: some View {
            switch self {
            case .normal(let title):
                Text(title)
                    .font(.cormorantGaramond(weight: .bold, size: 20))
                    .tint(.tintPrimary)
                    .fixedSize()
            case .hidden:
                EmptyView()
            case .custom(let content):
                AnyView(content)
            }
        }
    }
    
    enum TrailingItemConfiguration {
        
        case normal
        case hidden
        case custom(any View)
        
        @ViewBuilder
        var trailingStack: some View {
            switch self {
            case .normal:
                Spacer()
            case .hidden:
                EmptyView()
            case .custom(let content):
                AnyView(content)
            }
        }
    }
}
