//
//  BaseFlowView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 22.05.2025.
//

import SwiftUI

protocol BaseFlowView: View {
    
    associatedtype Coordinator: BaseCoordinator
    associatedtype NavigationContent: View
    
    /// BaseCoordinator instance to own navigation actions of the flow.
    var coordinator: Coordinator { get }
    
    /// View builder to present for each route in a flow.
    /// See ``BaseCoordinator/Route`` for route definition.
    /// For possible routes, see the `Route` enum defined in the corresponding `BaseCoordinator` implementation.
    @ViewBuilder var navigationContent: NavigationContent { get }
}

extension BaseFlowView {
    
    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    navigationContent
                }
            } else {
                NavigationView {
                    navigationContent
                }
            }
        }
    }
}
