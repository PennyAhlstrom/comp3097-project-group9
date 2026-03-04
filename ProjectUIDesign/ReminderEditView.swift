//
//  ReminderEditView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-04.
//

import SwiftUI

struct ReminderEditView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) var dismiss

    let reminder: Reminder

    @State private var message: String
    @State private var scheduledAt: String

    init(reminder: Reminder) {
        self.reminder = reminder
        _message = State(initialValue: reminder.message)
        _scheduledAt = State(initialValue: reminder.scheduledAt)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Reminder") {
                    TextField("Message", text: $message)
                    TextField("Scheduled At", text: $scheduledAt)
                }
            }
            .navigationTitle("Edit Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let updated = Reminder(
                            id: reminder.id, // preserve id for the reminder
                            message: message,
                            scheduledAt: scheduledAt
                        )
                        store.updateReminder(updated)
                        dismiss()
                    }
                }
            }
        }
    }
}
