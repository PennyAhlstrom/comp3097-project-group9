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

    @State private var selectedTaskID: Int?
    @State private var message = ""
    @State private var scheduledAt = Date()
    @State private var wasSent = false
    @State private var isSubmitting = false

    var body: some View {
        NavigationStack {
            FormScreen(background: .remindersBackground) {
                Section("Task") {
                    Picker("Task", selection: $selectedTaskID) {
                        Text("Select Task").tag(Optional<Int>.none)

                        ForEach(store.tasks) { task in
                            if let id = task.id {
                                Text(task.title).tag(Optional(id))
                            }
                        }
                    }
                }

                Section("Reminder") {
                    TextField("Message", text: $message)
                    DatePicker("Scheduled At", selection: $scheduledAt)
                    Toggle("Was Sent", isOn: $wasSent)
                }
            }
            .navigationTitle("Add Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(isSubmitting ? "Adding..." : "Add") {
                        addReminder()
                    }
                    .disabled(isSubmitting || message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedTaskID == nil)
                }
            }
            .task {
                if selectedTaskID == nil {
                    selectedTaskID = store.tasks.compactMap(\.id).first
                }
            }
        }
    }

    private func addReminder() {
        guard let selectedTaskID else { return }

        let newReminder = Reminder(
            taskID: selectedTaskID,
            message: message.trimmingCharacters(in: .whitespacesAndNewlines),
            scheduledAt: scheduledAt,
            wasSent: wasSent
        )

        isSubmitting = true

        _Concurrency.Task {
            await store.addReminder(newReminder)
            isSubmitting = false

            if store.errorMessage == nil {
                dismiss()
            }
        }
    }
}
