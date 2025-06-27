//
//  ContentSizeCategory+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 27.06.2025.
//

import SwiftUICore

extension ContentSizeCategory {
    
    var scaleFactor: CGFloat {
        switch self {
        case .extraSmall: return 0.8
        case .small: return 0.9
        case .medium: return 1.0
        case .large: return 1.0
        case .extraLarge: return 1.1
        case .extraExtraLarge: return 1.2
        case .extraExtraExtraLarge: return 1.3
        case .accessibilityMedium: return 1.4
        case .accessibilityLarge: return 1.5
        case .accessibilityExtraLarge: return 1.6
        case .accessibilityExtraExtraLarge: return 1.7
        case .accessibilityExtraExtraExtraLarge: return 1.8
        @unknown default: return 1.0
        }
    }
}
