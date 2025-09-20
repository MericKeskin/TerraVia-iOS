//
//  Color+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 19.09.2025.
//

import SwiftUI

extension Color {
    
    var TVGradient: LinearGradient {
        switch self {
        case .mainPrimary:
            .TVMainPrimaryLinearGradient
        case .mainSecondary:
            .TVMainSecondaryLinearGradient
        case .backgroundPrimary:
            .TVBackgroundPrimaryLinearGradient
        case .backgroundSecondary:
            .TVBackgroundSecondaryLinearGradient
        default:
            LinearGradient(
                stops: [
                    .init(color: self.opacity(0.8), location: 0),
                    .init(color: self.opacity(0.9), location: 0.5),
                    .init(color: self.opacity(1.0), location: 1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
