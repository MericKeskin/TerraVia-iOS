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
}
