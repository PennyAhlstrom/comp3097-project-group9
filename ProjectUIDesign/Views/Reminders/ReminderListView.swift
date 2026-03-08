//
//  ReminderListView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct ReminderListView: View {
    @EnvironmentObject var store: AppStore
    @State private var showingAddReminder = false
    

    var body: some View {
        List(store.reminders) { reminder in
            NavigationLink {
                ReminderDetailView(reminderID: reminder.id)
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    Text(reminder.message).font(.headline)
                    Text("Scheduled: \(reminder.scheduledAt)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Reminders")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingAddReminder = true
                        } label: {
                            Label("Add Reminder", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddReminder) {
                    ReminderAddView()
                        .environmentObject(store) // pass the same store into the sheet
                }
    }
}
//
//#Preview {
//    NavigationStack {
//        ReminderListView(reminders: Reminder.sampleReminders)
//    }
//}

#Preview {
    NavigationStack {
        ReminderListView()
    }
    .environmentObject(AppStore())
}


