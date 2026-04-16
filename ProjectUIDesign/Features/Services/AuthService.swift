//
//  AuthService.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct RegisterRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let role: String
}

// TODO: Assumption based on collection; patch later if backend wraps this differently
struct AuthResponse: Codable {
    let token: String
}

final class AuthService {
    func login(email: String, password: String) async throws {
        let response: AuthResponse = try await NetworkManager.shared.send(
            path: "/api/v1/auth/login",
            method: "POST",
            body: LoginRequest(email: email, password: password),
            requiresAuth: false
        )

        await AuthManager.shared.setSession(token: response.token, email: email)
    }

    func register(firstName: String, lastName: String, email: String, password: String) async throws {
        let _: AuthResponse = try await NetworkManager.shared.send(
            path: "/api/v1/auth/register",
            method: "POST",
            body: RegisterRequest(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                role: "USER"
            ),
            requiresAuth: false
        )
    }
}
