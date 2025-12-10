//
//  Language.swift
//  TerraVia
//
//  Created by Meriç Keskin on 30.09.2025.
//

enum LanguageTerry: Codable, CaseIterable {
    
    case english
    case turkish
    
    var localizedCapitalizedLong: String {
        switch self {
        case .english:
            "English"
        case .turkish:
            "Türkçe"
        }
    }
    
    var capitalizedLong: String {
        switch self {
        case .english:
            "English"
        case .turkish:
            "Turkish"
        }
    }
    
    var lowercaseShort: String {
        switch self {
        case .english:
            "en"
        case .turkish:
            "tr"
        }
    }
}

enum LanguageApp: Codable {
    
    case english
    case turkish
    
    var lowercaseShort: String {
        switch self {
        case .english:
            "en"
        case .turkish:
            "tr"
        }
    }
}
