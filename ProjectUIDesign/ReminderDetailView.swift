//
//  ReminderDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct ReminderDetailView: View {
    let reminder: Reminder

    var body: some View {
        List {
            Section("Reminder") {
                DetailRow(label: "Message", value: reminder.message)
                DetailRow(label: "Scheduled At", value: reminder.scheduledAt)
            }
        }
        .navigationTitle("Reminder")
    }
}

#Preview {
    NavigationStack { ReminderDetailView(reminder: Reminder.sampleReminders[0]) }
}
