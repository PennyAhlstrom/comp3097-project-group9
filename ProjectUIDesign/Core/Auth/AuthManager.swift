//
//  AuthManager.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import Foundation
import SwiftUI

@MainActor
final class AuthManager: ObservableObject {
    static let shared = AuthManager()

    @Published var token: String? = UserDefaults.standard.string(forKey: Keys.token)
    @Published var email: String? = UserDefaults.standard.string(forKey: Keys.email)

    private enum Keys {
        static let token = "auth_token"
        static let email = "auth_email"
    }

    private init() {}

    var isLoggedIn: Bool {
        token?.isEmpty == false
    }

    func setSession(token: String, email: String?) {
        self.token = token
        self.email = email

        UserDefaults.standard.set(token, forKey: Keys.token)
        UserDefaults.standard.set(email, forKey: Keys.email)
    }

    func logout() {
        token = nil
        email = nil

        UserDefaults.standard.removeObject(forKey: Keys.token)
        UserDefaults.standard.removeObject(forKey: Keys.email)
    }
}
