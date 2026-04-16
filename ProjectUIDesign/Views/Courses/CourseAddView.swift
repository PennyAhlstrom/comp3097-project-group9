//
//  CourseAddView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-04.
//

import SwiftUI

struct CourseAddView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) var dismiss

    @State private var code = ""
    @State private var title = ""
    @State private var instructor = ""
    @State private var gradeGoalText = ""
    @State private var startWeek = Date()
    @State private var isSubmitting = false

    var body: some View {
        NavigationStack {
            FormScreen(background: .coursesBackground) {
                Section("Course") {
                    TextField("Code", text: $code)
                    TextField("Title", text: $title)
                    TextField("Instructor", text: $instructor)
                }

                Section("Goals") {
                    TextField("Grade Goal (%)", text: $gradeGoalText)
                        .keyboardType(.numberPad)
                    DatePicker("Start Week", selection: $startWeek, displayedComponents: .date)
                }
            }
            .navigationTitle("Add Course")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(isSubmitting ? "Adding..." : "Add") {
                        addCourse()
                    }
                    .disabled(isSubmitting || code.isEmpty || title.isEmpty || instructor.isEmpty)
                }
            }
        }
    }

    private func addCourse() {
        let goal = Int(gradeGoalText)
        let newCourse = Course(
            code: code,
            title: title,
            instructor: instructor,
            meetings: [],
            gradeGoal: goal,
            startWeek: startWeek
        )

        isSubmitting = true

        _Concurrency.Task {
            await store.addCourse(newCourse)
            isSubmitting = false
            if store.errorMessage == nil {
                dismiss()
            }
        }
    }
}
