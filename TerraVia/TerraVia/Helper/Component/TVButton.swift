//
//  TVButton.swift
//  TerraVia
//
//  Created by Meriç Keskin on 2.06.2025.
//

import SwiftUI

struct TVButton<Label: View> {
    
    // MARK: Environment
    
    @Environment(\.sizeCategory) var sizeCategory
    
    // MARK: Preference
    
    var colorsAreGradient: Bool {
        AppPreferenceProvider.shared.colorsAreGradient
    }
    
    // MARK: Dynamic
    
    var scaledHorizontalPadding: CGFloat {
        horizontalPadding * sizeCategory.scaleFactor
    }
    
    var scaledVerticalPadding: CGFloat  {
        verticalPadding * sizeCategory.scaleFactor
    }
    
    // MARK: Parameter
    
    var label: Label?
    var title: String?
    var font: Font?
    var trailingImage: ImageResource?
    var leadingImage: ImageResource?
    var topImage: ImageResource?
    var bottomImage: ImageResource?
    var buttonStyle: Style
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
    var width: CGFloat?
    var height: CGFloat?
    var fill: Bool
    var action: @MainActor () -> Void
    var isLoading: Bool
    var isDisabled: Bool
    
    // MARK: Lifecycle
    
    init(
        @ViewBuilder label: () -> Label,
        buttonStyle: Style = .filled(.primary),
        horizontalPadding: CGFloat = 14,
        verticalPadding: CGFloat = 8,
        fill: Bool = false,
        isDisabled: Bool = false,
        isLoading: Bool = false,
        action: @escaping @MainActor () -> Void
    ) {
        self.label = label()
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.buttonStyle = buttonStyle
        self.fill = fill
        self.isDisabled = isDisabled
        self.isLoading = isLoading
        self.action = action
    }
}

// MARK: - Additional Lifecycle

extension TVButton where Label == EmptyView {
    
    init(
        title: String? = nil,
        font: Font? = nil,
        trailingImage: ImageResource? = nil,
        leadingImage: ImageResource? = nil,
        topImage: ImageResource? = nil,
        bottomImage: ImageResource? = nil,
        buttonStyle: Style = .filled(.primary),
        horizontalPadding: CGFloat = 14,
        verticalPadding: CGFloat = 8,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        fill: Bool = false,
        isDisabled: Bool = false,
        isLoading: Bool = false,
        action: @escaping @MainActor () -> Void
    ) {
        self.title = title
        self.font = font
        self.trailingImage = trailingImage
        self.leadingImage = leadingImage
        self.topImage = topImage
        self.bottomImage = bottomImage
        self.buttonStyle = buttonStyle
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.width = width
        self.height = height
        self.fill = fill
        self.isDisabled = isDisabled
        self.isLoading = isLoading
        self.action = action
    }
}

// MARK: - View

extension TVButton: View {
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    buttonContent
                        .tint(buttonStyle.tintColor)
                        .frame(maxWidth: width.map { $0 - scaledHorizontalPadding * 2 },
                               maxHeight: height.map { $0 - scaledVerticalPadding * 2 })
                }
            }
            .padding(.horizontal, scaledHorizontalPadding)
            .padding(.vertical, scaledVerticalPadding)
            .frame(minWidth: width,
                   maxWidth: fill ? .infinity : nil,
                   minHeight: height)
            .background {
                buttonStyle.backgroundView
                    .opacity(isDisabled ? 0.2 : 1)
            }
        }
        .disabled(isDisabled || isLoading)
        .animation(.easeInOut, value: isDisabled)
        .animation(.easeInOut, value: isLoading)
    }
    
    @ViewBuilder private var buttonContent: some View {
        if let label {
            label
        } else {
            VStack(spacing: horizontalPadding) {
                if let topImage {
                    Image(topImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                HStack(spacing: horizontalPadding) {
                    if let trailingImage {
                        Image(trailingImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    if let title {
                        Text(title)
                            .font(font ?? .raleway(weight: .semiBold, size: 24, relativeTo: .headline))
                    }
                    
                    if let leadingImage {
                        Image(leadingImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                
                if let bottomImage {
                    Image(bottomImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

// MARK: Button Style

extension TVButton {
    
    enum Style {
        
        case filled(ColorStyle)
        case outlined(ColorStyle)
        case clear
        case custom(any View, Color = .tintPrimary)
        
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
            
            var tintColor: Color {
                switch self {
                case .primary:
                    .tintMainPrimary
                case .secondary:
                    .tintMainSecondary
                }
            }
        }
        
        @ViewBuilder var backgroundView: some View {
            switch self {
            case .filled(let colorStyle):
                AnyShape(.capsule)
                    .TVFill(colorStyle.color)
            case .outlined(let colorStyle):
                AnyShape(.capsule)
                    .TVStroke(colorStyle.color)
            case .clear:
                Color.clear
            case .custom(let background, _):
                AnyView(background)
            }
        }
        
        var tintColor: Color {
            switch self {
            case .filled(let colorStyle):
                colorStyle.tintColor
            case .outlined, .clear:
                .tintPrimary
            case .custom(_, let tintColor):
                tintColor
            }
        }
    }
}

#Preview {
    let title: String = "Button"
    
    VStack {
        TVButton(
            title: title,
            trailingImage: .app,
            width: 200,
            height: 90
        ) {
            
        }
    }
    .padding(.all)
}
