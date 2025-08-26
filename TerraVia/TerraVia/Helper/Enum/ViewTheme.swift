//
//  ViewTheme.swift
//  TerraVia
//
//  Created by Meriç Keskin on 24.08.2025.
//

import SwiftUICore

enum ViewTheme: Codable {
    
    case light
    case dark
    
    var colorScheme: ColorScheme {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    mutating func toggle() {
        switch self {
        case .light:
            self = .dark
        case .dark:
            self = .light
        }
    }
}
