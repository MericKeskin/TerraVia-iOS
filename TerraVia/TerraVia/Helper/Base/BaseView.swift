//
//  BaseView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import SwiftUI

struct BaseView<Content: View, VM: BaseViewModel<C>, C: BaseCoordinator>: View {
    
    @ObservedObject var viewModel: VM
    @ViewBuilder var content: Content
    
    var body: some View {
        content
            .alert("",
                   isPresented:
                    Binding(get: { viewModel.activeError != nil },
                            set: { newValue in if !newValue { viewModel.activeError = nil } }),
                   presenting:
                    viewModel.activeError,
                   actions:
                    { _ in Button("OK", role: .cancel) { viewModel.activeError = nil } },
                   message:
                    { error in Text(error.localizedDescription) })
    }
}
