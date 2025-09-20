//
//  DebugViewModifier.swift
//  TerraVia
//
//  Created by Meriç Keskin on 31.05.2025.
//

import SwiftUI

struct DebugViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        switch AppConfig.current {
        case .development:
            content
                .border(.TVDebug, width: 2.0)
        default:
            content
        }
    }
}

extension View {
    public func debug() -> some View {
        modifier(DebugViewModifier())
    }
}
