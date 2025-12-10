//
//  IntroduceViewModel.swift
//  TerraVia
//
//  Created by Meriç Keskin on 11.11.2025.
//

import SwiftUI

final class IntroduceViewModel: BaseViewModel<OnboardingCoordinator> {
    
    @Published var tab: IntroduceTab = .first
    
    let allTabs: [IntroduceTab] = IntroduceTab.allCases
    
    var allTabItems: [IntroduceTab: IntroduceTabItem] = IntroduceTab.allItems
}

// MARK: - View Actions

extension IntroduceViewModel {
    
    func nextButtonTapped() {
        guard let nextTab = tab.next else {
            routeWelcome()
            
            return
        }
        
        swapTabWithAnimation(to: nextTab)
    }
    
    func backButtonTapped() {
        guard let previousTab = tab.previous else { return }
        
        swapTabWithAnimation(to: previousTab)
    }
    
    func tabImageTapped(tab: IntroduceTab) {
        swapTabWithAnimation(to: tab)
    }
    
    func skipButtonTapped() {
        routeWelcome()
    }
}

// MARK: - Logic

private extension IntroduceViewModel {
    
    func swapTabWithAnimation(
        to swapTab: IntroduceTab,
        duration: TimeInterval = 1.2,
        delay: TimeInterval = 0.0
    ) {
        for tab in allTabs {
            allTabItems[tab]?.config.zIndex = 0
        }
        
        Task {
            withAnimation(.bouncy(duration: duration).delay(delay)) {
                guard let swapItem = allTabItems[swapTab] else { return }
                
                allTabItems[tab]?.config.rotation = swapItem.config.rotation
                allTabItems[tab]?.config.scale = swapItem.config.scale
                allTabItems[tab]?.config.offset = swapItem.config.offset
                allTabItems[tab]?.config.extraOffset = swapItem.config.extraOffset
                
                allTabItems[swapTab]?.config.offset = swapItem.config.extraOffset
            }
            
            try? await Task.sleep(for: 0.1)
            
            withAnimation(.bouncy(duration: duration-0.1).delay(delay)) {
                
                allTabItems[tab]?.config.zIndex = 1
                
                allTabItems[swapTab]?.config.rotation = .zero
                allTabItems[swapTab]?.config.scale = 1.2
                allTabItems[swapTab]?.config.offset = .zero
                allTabItems[swapTab]?.config.zIndex = 2
                
                tab = swapTab
            }
        }
    }
}

// MARK: - Navigation

private extension IntroduceViewModel {
    
    func routeWelcome() {
        coordinator.navigate(to: .onboarding(.welcome))
    }
}
