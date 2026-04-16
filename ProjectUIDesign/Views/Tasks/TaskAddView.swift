//
//  TaskAddView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-04.
//

import SwiftUI

struct TaskAddView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) var dismiss

    @State private var selectedCourseID: Int?
    @State private var title = ""
    @State private var type = "LAB"
    @State private var hasDueDate = true
    @State private var dueDate = Date.now
    @State private var isCompleted = false
    @State private var isBonus = false
    @State private var isPriority = false
    @State private var weight: Double = 0
    @State private var score: Double = 0
    @State private var isSubmitting = false

    var body: some View {
        NavigationStack {
            FormScreen(background: .tasksBackground) {
                Section("Course") {
                    Picker("Course", selection: $selectedCourseID) {
                        Text("Select Course").tag(Optional<Int>.none)

                        ForEach(store.courses) { course in
                            if let id = course.id {
                                Text("\(course.code) — \(course.title)")
                                    .tag(Optional(id))
                            }
                        }
                    }
                }

                Section("Task") {
                    TextField("Title", text: $title)
                    TextField("Type (e.g., LAB)", text: $type)

                    Toggle("Has Due Date", isOn: $hasDueDate)

                    if hasDueDate {
                        DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    }
                }

                Section("Flags") {
                    Toggle("Completed", isOn: $isCompleted)
                    Toggle("Priority", isOn: $isPriority)
                    Toggle("Bonus", isOn: $isBonus)
                }

                Section("Grading") {
                    Stepper("Weight: \(weight, specifier: "%.1f")%", value: $weight, in: 0...100, step: 0.5)
                    Stepper("Score: \(score, specifier: "%.0f")%", value: $score, in: 0...100, step: 1)
                }
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(isSubmitting ? "Adding..." : "Add") {
                        addTask()
                    }
                    .disabled(isSubmitting || title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedCourseID == nil)
                }
            }
            .task {
                if selectedCourseID == nil {
                    selectedCourseID = store.courses.compactMap(\.id).first
                }
            }
        }
    }

    private func addTask() {
        guard let selectedCourseID else { return }

        let newTask = Task(
            courseID: selectedCourseID,
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            type: type.trimmingCharacters(in: .whitespacesAndNewlines),
            dueDate: hasDueDate ? dueDate : nil,
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: weight,
            scorePercent: score,
            isPriority: isPriority,
            isCompleted: isCompleted,
            isBonus: isBonus
        )

        isSubmitting = true

        _Concurrency.Task {
            await store.addTask(newTask)
            isSubmitting = false

            if store.errorMessage == nil {
                dismiss()
            }
        }
    }
}
