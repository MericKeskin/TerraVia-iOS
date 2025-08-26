//
//  TVTextField.swift
//  TerraVia
//
//  Created by Meriç Keskin on 31.05.2025.
//

import SwiftUI

struct TVTextField<ErrorField: View> {
    
    enum Style {
        
        case regular
        case secure
    }
    
    // MARK: Dynamic
    
    @ScaledMetric var horizontalPadding: CGFloat = 12
    @ScaledMetric var verticalPadding: CGFloat = 8
    
    // MARK: Parameter
    
    var placeholder: String
    @Binding var input: String
    var style: Style
    var font: Font?
    var isError: Bool
    var errorField: ErrorField?
    var height: CGFloat?
    
    init(_ placeholder: String = "", input: Binding<String>, style: Style = .regular, font: Font? = nil, isError: Bool = false, @ViewBuilder errorField: () -> ErrorField = { EmptyView() }, height: CGFloat? = nil) {
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
            switch style {
            case .regular:
                TextField(
                    text: $input,
                    prompt: Text(placeholder).foregroundColor(.textSecondary),
                    label: {}
                )
                .foregroundStyle(.textPrimary)
                .font(font ?? .raleway(weight: .medium, size: 20, relativeTo: .body))
                .autocapitalization(.none)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
                .frame(minHeight: height)
                .overlay {
                    if isError {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.errorTint, lineWidth: 2)
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.TVStrokeGradient, lineWidth: 2)
                    }
                }
            case .secure:
                SecureField(
                    text: $input,
                    prompt: Text(placeholder).foregroundColor(.textSecondary),
                    label: {}
                )
                .autocapitalization(.none)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
                .frame(minHeight: height)
                .overlay {
                    if isError {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.errorTint, lineWidth: 2)
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.TVStrokeGradient, lineWidth: 2)
                    }
                }
            }
            
            if isError {
                errorField?
                    .foregroundStyle(.errorTint)
            }
        }
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
