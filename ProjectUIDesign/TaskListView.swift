//
//  TaskListView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//


import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var store: AppStore
    @State private var showingAddTask = false

    var body: some View {
        List(store.tasks) { task in
            NavigationLink {
                TaskDetailView(taskID: task.id)
            } label: {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.title3)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(task.title).font(.headline)
                        Text("\(task.type) • Due: \(task.dueDate)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Tasks")
        .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingAddTask = true
                        } label: {
                            Label("Add Task", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddTask) {
                    TaskAddView()
                        .environmentObject(store) // pass the same store into the sheet
                }
    }
}
//
//#Preview {
//    NavigationStack {
//        TaskListView(tasks: Task.sampleTasks)
//    }
//}

#Preview {
    NavigationStack {
        TaskListView()
    }
    .environmentObject(AppStore())
}
