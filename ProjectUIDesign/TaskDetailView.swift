//
//  TaskDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct TaskDetailView: View {
    let task: Task

    var body: some View {
        List {
            Section("Task") {
                DetailRow(label: "Title", value: task.title)
                DetailRow(label: "Type", value: task.type)
                DetailRow(label: "Due Date", value: task.dueDate)
            }

            Section("Status") {
                DetailRow(label: "Completed", value: task.isCompleted ? "Yes" : "No")
                DetailRow(label: "Priority", value: task.isPriority ? "Yes" : "No")
                DetailRow(label: "Bonus", value: task.isBonus ? "Yes" : "No")
            }

            Section("Grading") {
                DetailRow(label: "Weight", value: "\(task.weight, default: "%.1f")%")
                DetailRow(label: "Score", value: "\(task.scorePercent, default: "%.0f")%")
            }
        }
        .navigationTitle("Task")
    }
}

#Preview {
    NavigationStack { TaskDetailView(task: Task.sampleTasks[0]) }
}
