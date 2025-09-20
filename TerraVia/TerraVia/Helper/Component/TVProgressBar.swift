//
//  TVProgressBar.swift
//  TerraVia
//
//  Created by Meriç Keskin on 1.09.2025.
//

import SwiftUI

struct TVProgressBar {
    
    // MARK: Parameters
    
    @Binding var progress: Double
    var total: Double
    
    var color: Color
    var height: CGFloat
    
    // MARK: Lifecycle
    
    init(
        progress: Binding<Double>,
        total: Double,
        color: Color = .mainPrimary,
        height: CGFloat = 8
    ) {
        self._progress = progress
        self.total = total
        self.color = color
        self.height = height
    }
}

extension TVProgressBar: View {
    
    var body: some View {
        ProgressView(value: progress, total: total)
            .progressViewStyle(.TVProgress(color: color, height: height))
    }
}
