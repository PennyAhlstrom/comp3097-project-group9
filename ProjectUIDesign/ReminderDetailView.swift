//
//  ReminderDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct ReminderDetailView: View {
    @EnvironmentObject var store: AppStore
    let reminderID: UUID

    @State private var showEdit = false
    @State private var showDeleteConfirm = false

    private var reminder: Reminder? { store.reminders.first { $0.id == reminderID } }

    var body: some View {
        Group {
            if let reminder {
                List {
                    Section("Reminder") {
                        DetailRow(label: "Message", value: reminder.message)
                        DetailRow(label: "Scheduled At", value: reminder.scheduledAt)
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
                        Text("Delete Reminder").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .confirmationDialog("Delete this reminder?", isPresented: $showDeleteConfirm) {
                        Button("Delete", role: .destructive) {
                            store.deleteReminder(id: reminder.id)
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
//#Preview {
//    NavigationStack { ReminderDetailView(reminder: Reminder.sampleReminders[0]) }
//}

#Preview {
    let store = AppStore()
    return NavigationStack {
        ReminderDetailView(reminderID: store.reminders.first!.id)
    }
    .environmentObject(store)
}
