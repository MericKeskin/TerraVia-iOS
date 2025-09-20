//
//  TVTextField.swift
//  TerraVia
//
//  Created by Meriç Keskin on 31.05.2025.
//

import SwiftUI

struct TVTextField<ErrorField: View> {
    
    // MARK: Dynamic
    
    @ScaledMetric var horizontalPadding: CGFloat = 20
    @ScaledMetric var verticalPadding: CGFloat = 8
    
    // MARK: Parameter
    
    var placeholder: String
    @Binding var input: String
    var style: Style
    var font: Font?
    var isError: Bool
    var errorField: ErrorField?
    var height: CGFloat?
    
    init(
        _ placeholder: String = "",
        input: Binding<String>,
        style: Style = .normal,
        font: Font? = nil,
        isError: Bool = false,
        @ViewBuilder errorField: () -> ErrorField = { EmptyView() },
        height: CGFloat? = nil
    ) {
        self.placeholder = placeholder
        self._input = input
        self.style = style
        self.font = font
        self.isError = isError
        self.errorField = errorField()
        self.height = height
    }
}

// MARK: - View

extension TVTextField: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Group {
                switch style {
                case .normal:
                    TextField(
                        text: $input,
                        prompt: Text(placeholder).foregroundColor(.tintSecondary),
                        label: {}
                    )
                case .secure:
                    SecureField(
                        text: $input,
                        prompt: Text(placeholder).foregroundColor(.tintSecondary),
                        label: {}
                    )
                }
            }
            .font(font ?? .raleway(weight: .medium, size: 20, relativeTo: .body))
            .tint(.tintPrimary)
            .autocapitalization(.none)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(minHeight: height)
            .background {
                if isError {
                    AnyShape(.capsule)
                        .TVStroke(.negative, lineWidth: 2, forceNonGradient: true)
                } else {
                    AnyShape(.capsule)
                        .TVStroke(.mainPrimary, lineWidth: 2)
                }
            }
            
            if isError {
                errorField?
                    .foregroundStyle(.negative)
            }
        }
    }
}

// MARK: Text Field Style

extension TVTextField {
    
    enum Style {
        
        case normal
        case secure
    }
}

#Preview {
    let input: Binding<String> = Binding(get: { "" },
                                         set: { value in })
    let placeholder: String = "Enter..."
    
    VStack {
        TVTextField(placeholder, input: input, font: .raleway(size: 20), height: 56)
    }
    .padding(.all)
}
