//
//  TaskDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject var store: AppStore
    let taskID: Int

    @State private var showEdit = false
    @State private var showDeleteConfirm = false

    private var task: Task? { store.tasks.first { $0.id == taskID } }

    var body: some View {
        DetailScreen(background: .tasksBackground) {
            if let task {
                List {
                    Section("Task") {
                        DetailRow(label: "Title", value: task.title)
                        DetailRow(label: "Type", value: task.type)
                        DetailRow(
                            label: "Due Date",
                            value: task.dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "No due date"
                        )
                    }

                    Section("Status") {
                        DetailRow(label: "Completed", value: task.isCompleted ? "Yes" : "No")
                        DetailRow(label: "Priority", value: task.isPriority ? "Yes" : "No")
                        DetailRow(label: "Bonus", value: task.isBonus ? "Yes" : "No")
                    }

                    Section("Grading") {
                        DetailRow(label: "Weight", value: String(format: "%.1f%%", task.weight))
                        DetailRow(label: "Score", value: String(format: "%.0f%%", task.scorePercent))
                    }
                }
                .navigationTitle("Task")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Edit") { showEdit = true }
                }
                .sheet(isPresented: $showEdit) {
                    TaskEditView(task: task)
                        .environmentObject(store)
                }
                .safeAreaInset(edge: .bottom) {
                    Button(role: .destructive) {
                        showDeleteConfirm = true
                    } label: {
                        Text("Delete Task")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .confirmationDialog("Delete this task?", isPresented: $showDeleteConfirm) {
                        Button("Delete", role: .destructive) {
                            _Concurrency.Task {
                                await store.deleteTask(id: taskID)
                            }
                        }
                    }
                }
            } else {
                Text("Task not found.")
                    .foregroundColor(.secondary)
                    .navigationTitle("Task")
            }
        }
    }
}

#Preview {
    let store = AppStore()
    return NavigationStack {
        if let firstTaskID = store.tasks.first?.id {
            TaskDetailView(taskID: firstTaskID)
        } else {
            Text("No task preview data")
        }
    }
    .environmentObject(store)
}
