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
    @State private var scheduledAt: Date
    @State private var wasSent: Bool
    @State private var isSubmitting = false

    init(reminder: Reminder) {
        self.reminder = reminder
        _message = State(initialValue: reminder.message)
        _scheduledAt = State(initialValue: reminder.scheduledAt)
        _wasSent = State(initialValue: reminder.wasSent)
    }

    var body: some View {
        NavigationStack {
            FormScreen(background: .remindersBackground) {
                Section("Reminder") {
                    TextField("Message", text: $message)
                    DatePicker("Scheduled At", selection: $scheduledAt)
                    Toggle("Was Sent", isOn: $wasSent)
                }
            }
            .navigationTitle("Edit Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(isSubmitting ? "Saving..." : "Save") {
                        saveReminder()
                    }
                    .disabled(isSubmitting || message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func saveReminder() {
        let updated = Reminder(
            id: reminder.id,
            taskID: reminder.taskID,
            message: message.trimmingCharacters(in: .whitespacesAndNewlines),
            scheduledAt: scheduledAt,
            wasSent: wasSent
        )

        isSubmitting = true

        _Concurrency.Task {
            await store.updateReminder(updated)
            isSubmitting = false

            if store.errorMessage == nil {
                dismiss()
            }
        }
    }
}
