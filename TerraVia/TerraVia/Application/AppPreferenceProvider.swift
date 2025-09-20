//
//  AppPreference.swift
//  TerraVia
//
//  Created by Meriç Keskin on 23.08.2025.
//

final class AppPreferenceProvider: PreferenceObject {
    
    static let shared = AppPreferenceProvider()
    
    // MARK: Preference
    
    @Preference(key: .viewTheme, defaultValue: .light)
    var viewTheme: ViewTheme
    
    @Preference(key: .colorsAreGradient, defaultValue: false)
    var colorsAreGradient: Bool
    
    @Preference(key: .onboarded, defaultValue: false)
    var onboarded: Bool
}

// MARK: - Keys

extension Preference {
    
    enum PreferenceKey: String {
        
        case viewTheme = "view_theme"
        case onboarded = "onboarded"
        case colorsAreGradient = "colors_are_gradient"
    }
}
