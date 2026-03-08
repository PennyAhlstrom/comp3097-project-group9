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

    var body: some View {
        NavigationStack {
            Form {
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
                    Button("Add") {
                        let goal = Int(gradeGoalText)
                        let newCourse = Course(
                            code: code,
                            title: title,
                            instructor: instructor,
                            gradeGoal: goal,
                            startWeek: startWeek
                        )
                        store.courses.append(newCourse)
                        dismiss()
                    }
                    .disabled(code.isEmpty || title.isEmpty || instructor.isEmpty)
                }
            }
        }
    }
}
