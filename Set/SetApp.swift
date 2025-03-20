//
//  SetApp.swift
//  Set
//
//  Created by aruhil on 2025-03-18.
//

import SwiftUI

@main
struct SetApp: App {
    let viewModel = CardViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
