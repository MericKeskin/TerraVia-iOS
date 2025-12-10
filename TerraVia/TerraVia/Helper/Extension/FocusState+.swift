//
//  FocusState+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 27.10.2025.
//

import SwiftUI

extension FocusState.Binding where Value == Bool {
    
    func focus() {
        if self.wrappedValue != true {
            self.wrappedValue = true
        }
    }
    
    func defocus() {
        if self.wrappedValue != false {
            self.wrappedValue = false
        }
    }
}
