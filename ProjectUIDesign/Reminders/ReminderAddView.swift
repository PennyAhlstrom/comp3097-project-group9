//
//  ReminderAddView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-04.
//

import SwiftUI

struct ReminderAddView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) var dismiss

    @State private var message = ""
    @State private var scheduledAt = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Reminder") {
                    TextField("Message", text: $message)
                    TextField("Scheduled At (YYYY-MM-DD)", text: $scheduledAt)
                }
            }
            .navigationTitle("Add Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let newReminder = Reminder(message: message, scheduledAt: scheduledAt)
                        store.reminders.append(newReminder)
                        dismiss()
                    }
                    .disabled(message.isEmpty || scheduledAt.isEmpty)
                }
            }
        }
    }
}
