//
//  ShapeStyle+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 30.05.2025.
//

import SwiftUI

// MARK: - Color

extension ShapeStyle where Self == Color {
    
    static var TVDebug: Color {
        Color(red: .random(in: 0...1),
              green: .random(in: 0...1),
              blue: .random(in: 0...1))
    }
}

// MARK: - Linear Gradient

extension ShapeStyle where Self == LinearGradient {
    
    static var TVBackgroundPrimaryLinearGradient: LinearGradient {
        LinearGradient(
            stops: [
                .init(color: Color.backgroundPrimary.opacity(1.0), location: 0),
                .init(color: Color.backgroundPrimary.opacity(0.95), location: 0.5),
                .init(color: Color.backgroundPrimary.opacity(0.9), location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    static var TVBackgroundSecondaryLinearGradient: LinearGradient {
        LinearGradient(
            stops: [
                .init(color: Color.backgroundSecondary.opacity(1.0), location: 0),
                .init(color: Color.backgroundSecondary.opacity(0.95), location: 0.5),
                .init(color: Color.backgroundSecondary.opacity(0.9), location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    static var TVMainPrimaryLinearGradient: LinearGradient {
        LinearGradient(
            stops: [
                .init(color: Color.mainPrimary.opacity(0.7), location: 0),
                .init(color: Color.mainPrimary.opacity(0.85), location: 0.3),
                .init(color: Color.mainPrimary.opacity(1.0), location: 1)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static var TVMainSecondaryLinearGradient: LinearGradient {
        LinearGradient(
            stops: [
                .init(color: Color.mainSecondary.opacity(0.7), location: 0),
                .init(color: Color.mainSecondary.opacity(0.85), location: 0.3),
                .init(color: Color.mainSecondary.opacity(1.0), location: 1)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
