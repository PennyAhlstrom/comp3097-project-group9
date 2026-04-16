//
//  AuthManager.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AuthManager: ObservableObject {
    static let shared = AuthManager()

    @Published var token: String? = UserDefaults.standard.string(forKey: Keys.token)
    @Published var email: String? = UserDefaults.standard.string(forKey: Keys.email)
    @Published var isDemoMode: Bool = UserDefaults.standard.bool(forKey: Keys.isDemoMode)

    private enum Keys {
        static let token = "auth_token"
        static let email = "auth_email"
        static let isDemoMode = "auth_is_demo_mode"
    }

    private init() {}

    var isLoggedIn: Bool {
        isDemoMode || (token?.isEmpty == false)
    }

    func setSession(token: String, email: String?) {
        self.token = token
        self.email = email
        self.isDemoMode = false

        UserDefaults.standard.set(token, forKey: Keys.token)
        UserDefaults.standard.set(email, forKey: Keys.email)
        UserDefaults.standard.set(false, forKey: Keys.isDemoMode)
    }

    func enterDemoMode() {
        isDemoMode = true
        UserDefaults.standard.set(true, forKey: Keys.isDemoMode)
    }

    func exitDemoMode() {
        isDemoMode = false
        UserDefaults.standard.set(false, forKey: Keys.isDemoMode)
    }

    func logout() {
        token = nil
        email = nil
        isDemoMode = false

        UserDefaults.standard.removeObject(forKey: Keys.token)
        UserDefaults.standard.removeObject(forKey: Keys.email)
        UserDefaults.standard.set(false, forKey: Keys.isDemoMode)
    }
}
