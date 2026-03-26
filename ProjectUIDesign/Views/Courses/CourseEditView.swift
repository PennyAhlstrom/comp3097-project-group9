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
                    Button("Save") {
                        let goal = Int(gradeGoalText)
                        let updated = Course(
                            id: course.id,
                            id: course.id,    // keep orijinal ID 
                            code: code,
                            title: title,
                            instructor: instructor,
                            gradeGoal: goal,
                            startWeek: startWeek
                        )

                        // Preserve the same ID for update
                        store.updateCourse(updated) // will only work after model change
                        dismiss()
                    }
                }
            }
        }
    }
}
