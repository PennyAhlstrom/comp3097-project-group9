//
//  LoginView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var auth = AuthManager.shared
    @EnvironmentObject var store: AppStore
    @State private var email = ""
    @State private var password = ""
    @State private var isSubmitting = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            FormScreen(background: .homeBackground) {
                Section("Welcome Back") {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)

                    SecureField("Password", text: $password)
                }

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }

                Section {
                    Button {
                        login()
                    } label: {
                        HStack {
                            if isSubmitting {
                                ProgressView()
                                    .controlSize(.small)
                            }
                            Text("Login")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(isSubmitting || email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.isEmpty)
                }

                Section {
                    NavigationLink("Create Account") {
                        RegisterView()
                    }
                }
                
                Section {
                    Button {
                        store.enterDemoMode()
                    } label: {
                        Text("Continue in Demo Mode")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Login")
        }
    }

    private func login() {
        errorMessage = nil
        isSubmitting = true

        _Concurrency.Task {
            defer { isSubmitting = false }

            do {
                try await AuthService().login(
                    email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                    password: password
                )
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
