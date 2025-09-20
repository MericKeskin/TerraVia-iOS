//
//  Font+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 2.06.2025.
//

import SwiftUI

// MARK: - Raleway

extension Font {
    
    enum RalewayWeight: String {
        
        case thin = "Raleway-Thin"
        case extraLight = "Raleway-ExtraLight"
        case light = "Raleway-Light"
        case regular = "Raleway-Regular"
        case medium = "Raleway-Medium"
        case semiBold = "Raleway-SemiBold"
        case bold = "Raleway-Bold"
        case extraBold = "Raleway-ExtraBold"
        case black = "Raleway-Black"
    }
    
    static func raleway(
        weight: RalewayWeight = .regular,
        size: CGFloat,
        relativeTo textStyle: TextStyle = .body
    ) -> Font {
        .custom(weight.rawValue, size: size, relativeTo: textStyle)
    }
}

// MARK: - Cormorant Garamond

extension Font {
    
    enum CormorantGaramondWeight: String {
        
        case light = "CormorantGaramond-Light"
        case regular = "CormorantGaramond-Regular"
        case medium = "CormorantGaramond-Medium"
        case semiBold = "CormorantGaramond-SemiBold"
        case bold = "CormorantGaramond-Bold"
    }
    
    static func cormorantGaramond(
        weight: CormorantGaramondWeight = .regular,
        size: CGFloat,
        relativeTo textStyle: TextStyle = .body
    ) -> Font {
        .custom(weight.rawValue, size: size, relativeTo: textStyle)
    }
}
