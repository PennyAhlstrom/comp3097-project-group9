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
    @State private var scheduledAt: Date // Changed from String to Date for DatePicker

    init(reminder: Reminder) {
        self.reminder = reminder
        _message = State(initialValue: reminder.message)
        // Parse "yyyy-MM-dd" string to Date, fallback to today
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        _scheduledAt = State(initialValue: formatter.date(from: reminder.scheduledAt) ?? Date())
    }

    var body: some View {
        NavigationStack {
            FormScreen(background: .remindersBackground) {
                Section("Reminder") {
                    TextField("Message", text: $message)
                    DatePicker("Scheduled At", selection: $scheduledAt, displayedComponents: .date) // Replaced TextField with DatePicker
                }
            }
            .navigationTitle("Edit Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Convert Date back to "yyyy-MM-dd" String to match Reminder model
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let dateString = formatter.string(from: scheduledAt)
                        let updated = Reminder(
                            id: reminder.id,
                            message: message,
                            scheduledAt: dateString
                        )
                        store.updateReminder(updated)
                        dismiss()
                    }
                }
            }
        }
    }
}