//
//  CourseDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct CourseDetailView: View {
    let course: Course

    var body: some View {
        List {
            Section("Course") {
                DetailRow(label: "Code", value: course.code)
                DetailRow(label: "Title", value: course.title)
                DetailRow(label: "Instructor", value: course.instructor)
            }

            Section("Goals") {
                DetailRow(label: "Grade Goal", value: course.gradeGoal.map { "\($0)%" } ?? "—")
                DetailRow(label: "Start Week", value: course.startWeek.map { $0.formatted(date: .abbreviated, time: .omitted) } ?? "—")
            }
        }
        .navigationTitle(course.code)
    }
}

#Preview {
    NavigationStack { CourseDetailView(course: Course.sampleCourses[0]) }
}
