//
//  TVButton.swift
//  TerraVia
//
//  Created by Meriç Keskin on 2.06.2025.
//

import SwiftUI

struct TVButton<Label: View> {
    
    // MARK: Dynamic
    
    @ScaledMetric var horizontalPadding: CGFloat = 12
    @ScaledMetric var verticalPadding: CGFloat = 8
    
    // MARK: Parameter
    
    var title: String?
    var font: Font?
    var trailingImage: ImageResource?
    var leadingImage: ImageResource?
    var topImage: ImageResource?
    var bottomImage: ImageResource?
    var background: (any View)?
    var width: CGFloat?
    var height: CGFloat?
    var fill: Bool
    var action: @MainActor () -> Void
    var label: Label?
    var isLoading: Bool
    var isDisabled: Bool
    
    // MARK: Lifecycle
    
    init(
        @ViewBuilder label: () -> Label,
        background: (any View)? = nil,
        fill: Bool = false,
        isDisabled: Bool = false,
        isLoading: Bool = false,
        action: @escaping @MainActor () -> Void
    ) {
        self.label = label()
        self.background = background
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
        background: (any View)? = nil,
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
        self.background = background
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
                        .frame(maxWidth: width.map { $0 - horizontalPadding * 2 }, maxHeight: height.map { $0 - verticalPadding * 2 })
                }
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(minWidth: width, maxWidth: fill ? .infinity : nil, minHeight: height)
        }
        .background {
            if let background {
                AnyView(background)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.TVButtonGradient)
            }
        }
        .disabled(isLoading || isDisabled)
        .grayscale(isDisabled ? 1 : 0)
        .animation(.easeInOut, value: isDisabled)
    }
    
    @ViewBuilder private var buttonContent: some View {
        if let label {
            label
        } else {
            VStack {
                if let topImage {
                    Image(topImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                HStack {
                    if let trailingImage {
                        Image(trailingImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    if let title {
                        Text(title)
                            .font(font ?? .raleway(weight: .semiBold, size: 24, relativeTo: .headline))
                            .foregroundStyle(.textPrimary)
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

#Preview {
    let title: String = "Button"
    
    VStack {
        TVButton(title: title, trailingImage: .app, width: 200, height: 90) {
            
        }
    }
    .padding(.all)
}
