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
        ZStack {
            ListScreen(background: .tasksBackground) {
                Section {
                    ForEach(store.tasks) { task in
                        if let taskID = task.id {
                            CardRow {
                                NavigationLink {
                                    TaskDetailView(taskID: taskID)
                                } label: {
                                    HStack(alignment: .top, spacing: 12) {
                                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .font(.title3)

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(task.title)
                                                .font(.headline)

                                            Text("\(task.type) • Due: \(task.dueDate?.formatted(date: .abbreviated, time: .omitted) ?? "No due date")")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.vertical, 6)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("TASKS")
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
                    .environmentObject(store)
            }
            .refreshable {
                await store.loadTasks()
            }
            .task {
                await store.loadTasksIfNeeded()
            }

            LoadingErrorOverlay(
                isLoading: store.isLoading,
                errorMessage: store.errorMessage,
                onRetry: {
                    Task {
                        await store.retryLoad(.tasks)
                    }
                },
                onDemoMode: {
                    store.enterDemoMode()
                }
            )

            if let successMessage = store.successMessage {
                ToastView(message: successMessage)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskListView()
    }
    .environmentObject(AppStore())
}
