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
    @State private var scheduledAt = Date() // Changed from String to Date to support DatePicker

    var body: some View {
        NavigationStack {
            FormScreen(background: .remindersBackground) {
                Section("Reminder") {
                    TextField("Message", text: $message)
                    DatePicker("Scheduled At", selection: $scheduledAt, displayedComponents: .date) // Replaced TextField with DatePicker for calendar selection
                }
            }
            .navigationTitle("Add Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        // Convert Date to "yyyy-MM-dd" String to match Reminder model
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        let dateString = formatter.string(from: scheduledAt)
                        let newReminder = Reminder(message: message, scheduledAt: dateString)
                        store.reminders.append(newReminder)
                        dismiss()
                    }
                    .disabled(message.isEmpty) // Removed scheduledAt.isEmpty since DatePicker always has a value
                }
            }
        }
    }
}
