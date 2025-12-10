//
//  IntroduceTab.swift
//  TerraVia
//
//  Created by Meriç Keskin on 9.11.2025.
//

import SwiftUI

enum IntroduceTab: Int, CaseIterable {
    
    case first = 0
    case second
    case third
    case fourth
    
    var next: IntroduceTab? {
        let all = Self.allCases
        
        guard self.rawValue < all.count-1 else { return nil }
        
        return all[self.rawValue+1]
    }

    var previous: IntroduceTab? {
        let all = Self.allCases
        
        guard self.rawValue > 0 else { return nil }
        
        return all[self.rawValue-1]
    }
    
    var item: IntroduceTabItem {
        switch self {
        case .first:
            .init(imageName: "Onboarding_0",
                  title: "Prepare for your journey",
                  subtitle: "Plan your route, book your accommodation, and more.",
                  nextText: "Next",
                  config: .init(rotation: 0,
                                scale: 1.2,
                                offset: 0,
                                zIndex: 2,
                                extraOffset: 0))
        case .second:
            .init(imageName: "Onboarding_1",
                  title: "Start traveling",
                  subtitle: "Explore the world, one step at a time.",
                  nextText: "Next",
                  config: .init(rotation: 225,
                                scale: 0.55,
                                offset: 115,
                                zIndex: 0,
                                extraOffset: 315))
        case .third:
            .init(imageName: "Onboarding_2",
                  title: "Snap your photos",
                  subtitle: "Capture photos if you wonder where you are, or what you're seeing.",
                  nextText: "Next",
                  config: .init(rotation: 135,
                                scale: 0.45,
                                offset: 115,
                                zIndex: 0,
                                extraOffset: 315))
        case .fourth:
            .init(imageName: "Onboarding_3",
                  title: "Chat with Terry",
                  subtitle: "Ask questions and share your photos with Terry.",
                  nextText: "Let's Go",
                  config: .init(rotation: 225,
                                scale: 0.6,
                                offset: -130,
                                zIndex: 0,
                                extraOffset: -330))
        }
    }
    
    static var allItems: [IntroduceTab: IntroduceTabItem] {
        Self.allCases.reduce(into: [:]) { dict, tab in
            dict[tab] = tab.item
        }
    }
}

struct IntroduceTabItem {
    
    var imageName: String
    var title: String
    var subtitle: String
    var nextText: String
    var config: IntroduceTabItemConfiguration
}

struct IntroduceTabItemConfiguration {
    
    var rotation: CGFloat
    var scale: CGFloat
    var offset: CGFloat
    var zIndex: CGFloat
    var extraOffset: CGFloat
}
