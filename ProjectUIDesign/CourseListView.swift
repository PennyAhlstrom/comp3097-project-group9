//
//  CourseListView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct CourseListView: View {
    let courses: [Course]

    var body: some View {
        List(courses) { course in
            VStack(alignment: .leading, spacing: 4) {
                Text(course.code)
                    .font(.headline)

                Text(course.title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("Instructor: \(course.instructor)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                if let goal = course.gradeGoal {
                    Text("Grade Goal: \(goal)%")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 6)
        }
        .navigationTitle("Courses")
    }
}

#Preview {
    NavigationStack {
        CourseListView(courses: Course.sampleCourses)
    }
}
