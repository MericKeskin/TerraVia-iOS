//
//  PreferenceObject.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.08.2025.
//

import Combine

class PreferenceObject: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bindPreferences()
    }
}

extension PreferenceObject {
    
    private func bindPreferences() {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let preference = child.value as? any PreferenceProtocol {
                preference.bind(to: objectWillChange, in: &cancellables)
            }
        }
    }
}
