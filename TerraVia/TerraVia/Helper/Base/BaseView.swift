//
//  BaseView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import SwiftUI

struct BaseView<Content: View, VM: BaseViewModel<C>, C: BaseCoordinator>: View {
    
    /// Namespace for animations.
    @Namespace var animationNamespace
    
    // MARK: Parameters
    
    @ObservedObject var viewModel: VM
    var navBarVisibility: Visibility
    var content: (Namespace.ID) -> Content
    
    init(viewModel: VM, navBarVisibility: Visibility = .automatic, @ViewBuilder content: @escaping (Namespace.ID) -> Content) {
        self.viewModel = viewModel
        self.navBarVisibility = navBarVisibility
        self.content = content
    }
    
    var body: some View {
        content(animationNamespace)
            .toolbar(navBarVisibility)
    }
}
