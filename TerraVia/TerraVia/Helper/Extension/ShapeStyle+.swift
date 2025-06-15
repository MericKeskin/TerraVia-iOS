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
    
    static var TVBackgroundGradient: LinearGradient {
        LinearGradient(stops: [.init(color: .backgroundBase, location: 0),
                               .init(color: .shineTint, location: 0.7),
                               .init(color: .mainTint, location: 1)],
                       startPoint: .top,
                       endPoint: .bottom)
    }
    
    static var TVButtonGradient: LinearGradient {
        LinearGradient(stops: [.init(color: .shineTint, location: 0),
                               .init(color: .mainTint, location: 1)],
                             startPoint: .topLeading,
                             endPoint: .bottom)
    }
    
    static var TVStrokeGradient: LinearGradient {
        LinearGradient(stops: [.init(color: .shineTint, location: 0),
                               .init(color: .mainTint, location: 1)],
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
    }
}
