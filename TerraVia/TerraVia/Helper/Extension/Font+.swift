//
//  Font+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 2.06.2025.
//

import SwiftUI

// MARK: - Raleway

extension Font {
    
    enum RalewayWeight {
        
        case thin
        case extraLight
        case light
        case regular
        case medium
        case semiBold
        case bold
        case extraBold
        case black
    }
    
    static func raleway(weight: RalewayWeight = .regular, size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        var fontName: String {
            switch weight {
            case .thin: "Raleway-Thin"
            case .extraLight: "Raleway-ExtraLight"
            case .light: "Raleway-Light"
            case .regular: "Raleway-Regular"
            case .medium: "Raleway-Medium"
            case .semiBold: "Raleway-SemiBold"
            case .bold: "Raleway-Bold"
            case .extraBold: "Raleway-ExtraBold"
            case .black: "Raleway-Black"
            }
        }

        return .custom(fontName, size: size, relativeTo: textStyle)
    }
}

// MARK: - Cormorant Garamond

extension Font {
    
    enum CormorantGaramondWeight {
        
        case light
        case regular
        case medium
        case semiBold
        case bold
    }
    
    static func cormorantGaramond(weight: CormorantGaramondWeight = .regular, size: CGFloat, relativeTo textStyle: TextStyle = .body) -> Font {
        var fontName: String {
            switch weight {
            case .light: "CormorantGaramond-Light"
            case .regular: "CormorantGaramond-Regular"
            case .medium: "CormorantGaramond-Medium"
            case .semiBold: "CormorantGaramond-SemiBold"
            case .bold: "CormorantGaramond-Bold"
            }
        }
        
        return .custom(fontName, size: size, relativeTo: textStyle)
    }
}
