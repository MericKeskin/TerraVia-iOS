//
//  TVTextField.swift
//  TerraVia
//
//  Created by Meriç Keskin on 31.05.2025.
//

import SwiftUI

struct TVTextField<ErrorField: View> {
    
    // MARK: Environment
    
    @Environment(\.sizeCategory) var sizeCategory
    
    // MARK: Dynamic
    
    var scaledHorizontalPadding: CGFloat {
        horizontalPadding * sizeCategory.scaleFactor
    }
    
    var scaledVerticalPadding: CGFloat  {
        verticalPadding * sizeCategory.scaleFactor
    }
    
    // MARK: Parameter
    
    var placeholder: String
    @Binding var input: String
    var font: Font?
    var textAlignment: TextAlignment
    var textFieldStyle: Style
    var focused: FocusState<Bool>.Binding
    var autoCapitalizationType: UITextAutocapitalizationType
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
    var width: CGFloat?
    var height: CGFloat?
    var isSecured: Bool
    var isError: Bool
    var errorField: ErrorField?
    
    init(
        _ placeholder: String = "",
        input: Binding<String>,
        font: Font = .raleway(weight: .medium, size: 20),
        textAlignment: TextAlignment = .leading,
        textFieldStyle: Style = .outlined(with: .primary),
        focused: FocusState<Bool>.Binding = FocusState().projectedValue,
        autoCapitalizationType: UITextAutocapitalizationType = .none,
        horizontalPadding: CGFloat = 20,
        verticalPadding: CGFloat = 8,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        isSecured: Bool = false,
        isError: Bool = false,
        @ViewBuilder errorField: () -> ErrorField = { EmptyView() }
    ) {
        self.placeholder = placeholder
        self._input = input
        self.font = font
        self.textAlignment = textAlignment
        self.textFieldStyle = textFieldStyle
        self.focused = focused
        self.autoCapitalizationType = autoCapitalizationType
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.width = width
        self.height = height
        self.isSecured = isSecured
        self.isError = isError
        self.errorField = errorField()
    }
}

// MARK: - View

extension TVTextField: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Group {
                if isSecured {
                    SecureField(
                        text: $input,
                        prompt: Text(placeholder).foregroundColor(textFieldStyle.placeholderTint),
                        label: {}
                    )
                } else {
                    TextField(
                        text: $input,
                        prompt: Text(placeholder).foregroundColor(textFieldStyle.placeholderTint),
                        label: {}
                    )
                }
            }
            .font(font)
            .tint(textFieldStyle.inputTint)
            .multilineTextAlignment(textAlignment)
            .focused(focused)
            .autocapitalization(autoCapitalizationType)
            .padding(.horizontal, scaledHorizontalPadding)
            .padding(.vertical, scaledVerticalPadding)
            .frame(maxWidth: width,
                   minHeight: height)
            .background {
                if isError {
                    AnyShape(.capsule)
                        .TVStroke(.negative, lineWidth: 2, forceNonGradient: true)
                } else {
                    textFieldStyle.backgroundView
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
        
        case outlined(with: ColorStyle)
        case clear
        case custom(any View,
                    placeholderTint: Color = .tintSecondary,
                    inputTint: Color = .tintPrimary)
        
        enum ColorStyle {
            
            case primary
            case secondary
            
            var color: Color {
                switch self {
                case .primary:
                    .mainPrimary
                case .secondary:
                    .mainSecondary
                }
            }
        }
        
        @ViewBuilder
        var backgroundView: some View {
            switch self {
            case .outlined(with: let colorStyle):
                AnyShape(.capsule)
                    .TVStroke(colorStyle.color, lineWidth: 2)
            case .clear:
                Color.clear
            case .custom(let background, _, _):
                AnyView(background)
            }
        }
        
        var placeholderTint: Color {
            switch self {
            case .outlined, .clear:
                .tintSecondary
            case .custom(_, let placeholderTint, _):
                placeholderTint
            }
        }
        
        var inputTint: Color {
            switch self {
            case .outlined, .clear:
                .tintPrimary
            case .custom(_, _, let inputTint):
                inputTint
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
