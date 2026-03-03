//
//  ReminderListView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct ReminderListView: View {
    let reminders: [Reminder]

    var body: some View {
        List(reminders) { reminder in
            VStack(alignment: .leading, spacing: 4) {
                Text(reminder.message)
                    .font(.headline)

                Text("Scheduled: \(reminder.scheduledAt)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 6)
        }
        .navigationTitle("Reminders")
    }
}

#Preview {
    NavigationStack {
        ReminderListView(reminders: Reminder.sampleReminders)
    }
}
