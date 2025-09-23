//
//  ProgressViewStyle+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 9.09.2025.
//

import SwiftUI

extension ProgressViewStyle where Self == TVProgressViewStyle {
    
    static func TVProgress(
        color: Color = .mainPrimary,
        height: CGFloat = 8
    ) -> TVProgressViewStyle {
        TVProgressViewStyle(
            color: color,
            height: height
        )
    }
}

struct TVProgressViewStyle {
    
    // MARK: Parameters
    
    var color: Color
    var height: CGFloat
    
    // MARK: Lifecycle
    
    init(
        color: Color,
        height: CGFloat
    ) {
        self.color = color
        self.height = height
    }
}

extension TVProgressViewStyle: ProgressViewStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                color.opacity(0.2)
                    
                AnyShape(.capsule)
                    .fill(color)
                    .frame(width: geo.size.width * (configuration.fractionCompleted ?? 0))
            }
            .clipShape(AnyShape(.capsule))
        }
        .frame(height: height)
    }
}
