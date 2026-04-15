//
//  ReminderDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct ReminderDetailView: View {
    @EnvironmentObject var store: AppStore
    let reminderID: Int

    @State private var showEdit = false
    @State private var showDeleteConfirm = false

    private var reminder: Reminder? { store.reminders.first { $0.id == reminderID } }

    var body: some View {
        DetailScreen(background: .remindersBackground) {
            if let reminder {
                List {
                    Section("Reminder") {
                        DetailRow(label: "Message", value: reminder.message)
                        DetailRow(
                            label: "Scheduled At",
                            value: reminder.scheduledAt.formatted(date: .abbreviated, time: .shortened)
                        )
                        DetailRow(label: "Was Sent", value: reminder.wasSent ? "Yes" : "No")
                    }
                }
                .navigationTitle("Reminder")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Edit") { showEdit = true }
                }
                .sheet(isPresented: $showEdit) {
                    ReminderEditView(reminder: reminder)
                        .environmentObject(store)
                }
                .safeAreaInset(edge: .bottom) {
                    Button(role: .destructive) {
                        showDeleteConfirm = true
                    } label: {
                        Text("Delete Reminder")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .confirmationDialog("Delete this reminder?", isPresented: $showDeleteConfirm) {
                        Button("Delete", role: .destructive) {
                            Task {
                                await store.deleteReminder(id: reminderID)
                            }
                        }
                    }
                }
            } else {
                Text("Reminder not found.")
                    .foregroundColor(.secondary)
                    .navigationTitle("Reminder")
            }
        }
    }
}

#Preview {
    let store = AppStore()
    return NavigationStack {
        if let firstReminderID = store.reminders.first?.id {
            ReminderDetailView(reminderID: firstReminderID)
        } else {
            Text("No reminder preview data")
        }
    }
    .environmentObject(store)
}
