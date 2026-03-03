//
//  TaskListView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct TaskListView: View {
    let tasks: [Task]

    var body: some View {
        List(tasks) { task in
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title3)

                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.headline)

                    Text("\(task.type) • Due: \(task.dueDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("Weight: \(task.weight, specifier: "%.1f")% • Score: \(task.scorePercent, specifier: "%.0f")%")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if task.isPriority || task.isBonus {
                        HStack(spacing: 8) {
                            if task.isPriority {
                                Text("PRIORITY")
                                    .font(.caption2)
                                    .bold()
                            }
                            if task.isBonus {
                                Text("BONUS")
                                    .font(.caption2)
                                    .bold()
                            }
                        }
                        .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.vertical, 6)
        }
        .navigationTitle("Tasks")
    }
}

#Preview {
    NavigationStack {
        TaskListView(tasks: Task.sampleTasks)
    }
}
