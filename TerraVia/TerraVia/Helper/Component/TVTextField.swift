//
//  TVTextField.swift
//  TerraVia
//
//  Created by Meriç Keskin on 31.05.2025.
//

import SwiftUI

struct TVTextField {
    
    // MARK: Dynamic
    
    @ScaledMetric var horizontalPadding: CGFloat = 12
    @ScaledMetric var verticalPadding: CGFloat = 8
    
    // MARK: Parameter
    
    var placeholder: String
    @Binding var input: String
    var font: Font?
    var height: CGFloat?
    
    init(_ placeholder: String = "", input: Binding<String>, font: Font? = nil, height: CGFloat? = nil) {
        self.placeholder = placeholder
        self._input = input
        self.font = font
        self.height = height
    }
}

// MARK: - View

extension TVTextField: View {
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $input)
                .font(font ?? .raleway(size: 20, relativeTo: .body))
                .autocapitalization(.none)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .frame(minHeight: height)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.TVStrokeGradient, lineWidth: 2)
        )
    }
}

#Preview {
    let placeholder: String = "Enter..."
    
    VStack {
        TVTextField(placeholder, input: Binding(get: {
            ""
        }, set: { value in
            
        }), font: .raleway(size: 20), height: 56)
    }
    .padding(.all)
}
