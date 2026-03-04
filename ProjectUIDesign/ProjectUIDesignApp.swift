//
//  ProjectUIDesignApp.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

@main
struct ProjectUIDesignApp: App {
    @StateObject private var store = AppStore()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(store)
        }
    }
}
