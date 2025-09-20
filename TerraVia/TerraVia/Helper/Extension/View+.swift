//
//  View+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 8.09.2025.
//

import SwiftUI

extension View {
    
    public func modifier<ModifiedContent: View>(
        @ViewBuilder _ modifier: (Self) -> ModifiedContent
    ) -> ModifiedContent {
        modifier(self)
    }
}
