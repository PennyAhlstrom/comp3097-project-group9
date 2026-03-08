//
//  TaskEditView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-04.
//

import SwiftUI

struct TaskEditView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) var dismiss

    let task: Task

    @State private var title: String
    @State private var type: String
    @State private var dueDate: Date = .now
    @State private var isCompleted: Bool
    @State private var isBonus: Bool
    @State private var isPriority: Bool
    @State private var weightText: String
    @State private var scoreText: String

    init(task: Task) {
        self.task = task
        _title = State(initialValue: task.title)
        _type = State(initialValue: task.type)
        _dueDate = State(initialValue: task.dueDate ?? .now)
        _isCompleted = State(initialValue: task.isCompleted)
        _isBonus = State(initialValue: task.isBonus)
        _isPriority = State(initialValue: task.isPriority)
        _weightText = State(initialValue: String(task.weight))
        _scoreText = State(initialValue: String(task.scorePercent))
    }

    var body: some View {
        NavigationStack {
            FormScreen(background: .tasksBackground) {
                Section("Task") {
                    TextField("Title", text: $title)
                    TextField("Type", text: $type)
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                }

                Section("Flags") {
                    Toggle("Completed", isOn: $isCompleted)
                    Toggle("Priority", isOn: $isPriority)
                    Toggle("Bonus", isOn: $isBonus)
                }

                Section("Grading") {
                    TextField("Weight (%)", text: $weightText)
                        .keyboardType(.decimalPad)
                    TextField("Score (%)", text: $scoreText)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let updated = Task(
                            id: task.id, // preserve ID
                            courseID: task.courseID,
                            title: title,
                            type: type,
                            dueDate: task.dueDate ?? dueDate,
                            isCompleted: isCompleted,
                            isBonus: isBonus,
                            isPriority: isPriority,
                            weight: Double(weightText) ?? task.weight,
                            scorePercent: Double(scoreText) ?? task.scorePercent
                        )
                        store.updateTask(updated)
                        dismiss()
                    }
                }
            }
        }
    }
}
