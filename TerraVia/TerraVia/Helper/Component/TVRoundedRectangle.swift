//
//  TVRoundedRectangle.swift
//  TerraVia
//
//  Created by Meriç Keskin on 18.09.2025.
//

import SwiftUI
import UIKit

struct TVRoundedRectangle: Shape {
    
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    init(
        cornerRadius: CGFloat = 8,
        corners: UIRectCorner = [.allCorners]
    ) {
        self.cornerRadius = cornerRadius
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        return Path(path.cgPath)
    }
}
