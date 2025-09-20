//
//  Shape+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 19.09.2025.
//

import SwiftUI

extension Shape {
    
    private var colorsAreGradient: Bool {
        AppPreferenceProvider.shared.colorsAreGradient
    }
    
    @ViewBuilder
    func TVFill(_ content: Color, forceNonGradient: Bool = false) -> some View {
        if colorsAreGradient && !forceNonGradient {
            self.fill(content.TVGradient)
        } else {
            self.fill(content)
        }
    }
    
    @ViewBuilder
    func TVStroke(_ content: Color, lineWidth: CGFloat = 1, forceNonGradient: Bool = false) -> some View {
        if colorsAreGradient && !forceNonGradient {
            self.stroke(content.TVGradient, lineWidth: lineWidth)
        } else {
            self.stroke(content, lineWidth: lineWidth)
        }
    }
}
