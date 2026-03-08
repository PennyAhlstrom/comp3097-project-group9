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

    @State private var courseID = Course.sampleCourses.first!.id
    @State private var title = ""
    @State private var type = "LAB"
    @State var hasDueDate = false
    @State private var dueDate = Date.now
    @State private var isCompleted = false
    @State private var isBonus = false
    @State private var isPriority = false
    @State private var weight: Double = 0
    @State private var score: Double = 0

    var body: some View {
        NavigationStack {
            Form {
                Section("Task") {
                    TextField("Title", text: $title)
                    TextField("Type (e.g., LAB)", text: $type)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
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
                    Button("Add") {
                        let newTask = Task(
                            courseID: courseID,
                            title: title,
                            type: type,
                            dueDate: hasDueDate ? dueDate : nil, // dueDate is optional
                            isCompleted: isCompleted,
                            isBonus: isBonus,
                            isPriority: isPriority,
                            weight: weight,
                            scorePercent: score
                        )
                        store.tasks.append(newTask)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
