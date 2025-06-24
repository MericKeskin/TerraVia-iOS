//
//  WelcomeView.swift
//  TerraVia
//
//  Created by Meriç Keskin on 29.05.2025.
//

import SwiftUI

struct WelcomeView: View {
    
    @StateObject var viewModel: WelcomeViewModel
    
    var body: some View {
        BaseView(viewModel: viewModel) { _ in 
            Text("Hello, Welcome to TerraVia!")
        }
    }
}
