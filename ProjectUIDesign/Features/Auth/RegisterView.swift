//
//  RegisterView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isSubmitting = false
    @State private var errorMessage: String?

    var body: some View {
        FormScreen(background: .homeBackground) {
            Section("Account") {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
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
                    register()
                } label: {
                    HStack {
                        if isSubmitting {
                            ProgressView()
                                .controlSize(.small)
                        }
                        Text("Register")
                    }
                    .frame(maxWidth: .infinity)
                }
                .disabled(
                    isSubmitting ||
                    firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    password.isEmpty
                )
            }
        }
        .navigationTitle("Register")
    }

    private func register() {
        errorMessage = nil
        isSubmitting = true

        _Concurrency.Task {
            defer { isSubmitting = false }

            do {
                try await AuthService().register(
                    firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
                    lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines),
                    email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                    password: password
                )
                dismiss()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
