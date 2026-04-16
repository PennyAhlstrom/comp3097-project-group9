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
    @StateObject private var auth = AuthManager.shared

    var body: some Scene {
        WindowGroup {
            Group {
                if auth.isLoggedIn {
                    NavigationStack {
                        HomeView()
                    }
                } else {
                    LoginView()
                }
            }
            .environmentObject(store)
            .onAppear {
                store.syncSessionMode()
            }
            .onChange(of: auth.isDemoMode) { _, _ in
                store.syncSessionMode()
            }
            .onChange(of: auth.token) { _, _ in
                store.syncSessionMode()
            }
        }
    }
}
