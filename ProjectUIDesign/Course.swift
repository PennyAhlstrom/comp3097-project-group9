//
//  Course.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct Course: Identifiable, Hashable {
    let id: UUID
    let code: String
    let title: String
    let instructor: String
    //let schedule: List<ScheduleItem>
    let gradeGoal: Int?
    let startWeek: Date?
    //let tasks: List<Task>?

    init(
        id: UUID = UUID(),
        code: String,
        title: String,
        instructor: String,
        gradeGoal: Int?,
        startWeek: Date?
    ) {
        self.id = id
        self.code = code
        self.title = title
        self.instructor = instructor
        self.gradeGoal = gradeGoal
        self.startWeek = startWeek
    }
}

extension Course {
    static let sampleCourses: [Course] = [
        .init(
            code: "COMP3097",
            title: "Mobile Dev II",
            instructor: "Professor Kiani",
            gradeGoal: 85,
            startWeek: Date()
        ),
        .init(
            code: "COMP3132",
            title: "Machine Learning",
            instructor: "Professor Ajellu",
            gradeGoal: 85,
            startWeek: Date()
        ),
        .init(
            code: "COMP3134",
            title: "Cyber Security",
            instructor: "Professor Blanc",
            gradeGoal: 85,
            startWeek: Date()
        ),
        .init(
            code: "COMP3133",
            title: "Fullstack Dev II",
            instructor: "Professor Patel",
            gradeGoal: 85,
            startWeek: Date()
        )
    ]
}
