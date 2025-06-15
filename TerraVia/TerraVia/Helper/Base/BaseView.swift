//
//  BaseView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import SwiftUI

struct BaseView<Content: View, VM: BaseViewModel<C>, C: BaseCoordinator>: View {
    
    // MARK: Parameters
    
    @ObservedObject var viewModel: VM
    var navBarVisibility: Visibility
    var navBarHidden: Bool { navBarVisibility == .hidden }
    @ViewBuilder var content: () -> Content
    
    init(viewModel: VM, navBarVisibility: Visibility = .automatic, content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.navBarVisibility = navBarVisibility
        self.content = content
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            content()
                .toolbar(navBarVisibility)
        } else {
            content()
                .navigationBarHidden(navBarHidden)
        }
        
    }
}
