//
//  CourseEditView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-04.
//

import SwiftUI

struct CourseEditView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) var dismiss

    let course: Course

    @State private var code: String
    @State private var title: String
    @State private var instructor: String
    @State private var gradeGoalText: String
    @State private var startWeek: Date
    @State private var isSubmitting = false

    init(course: Course) {
        self.course = course
        _code = State(initialValue: course.code)
        _title = State(initialValue: course.title)
        _instructor = State(initialValue: course.instructor)
        _gradeGoalText = State(initialValue: course.gradeGoal.map(String.init) ?? "")
        _startWeek = State(initialValue: course.startWeek ?? Date())
    }

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
            .navigationTitle("Edit Course")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(isSubmitting ? "Saving..." : "Save") {
                        saveCourse()
                    }
                    .disabled(isSubmitting || code.isEmpty || title.isEmpty || instructor.isEmpty)
                }
            }
        }
    }

    private func saveCourse() {
        let goal = Int(gradeGoalText)
        let updated = Course(
            id: course.id,
            code: code,
            title: title,
            instructor: instructor,
            meetings: course.meetings,
            gradeGoal: goal,
            startWeek: startWeek
        )

        isSubmitting = true

        Task {
            await store.updateCourse(updated)
            isSubmitting = false
            if store.errorMessage == nil {
                dismiss()
            }
        }
    }
}
