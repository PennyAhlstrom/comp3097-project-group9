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
    enum SampleIDs {
            static let course1 = UUID(uuidString: "11111111-1111-1111-1111-111111111111")!
            static let course2 = UUID(uuidString: "22222222-2222-2222-2222-222222222222")!
            static let course3 = UUID(uuidString: "33333333-3333-3333-3333-333333333333")!
            static let course4 = UUID(uuidString: "44444444-4444-4444-4444-444444444444")!
        }
    
    static let sampleCourses: [Course] = [
        .init(
            id: SampleIDs.course1,
            code: "COMP3097",
            title: "Mobile Dev II",
            instructor: "Professor Kiani",
            gradeGoal: 85,
            startWeek: Date()
        ),
        .init(
            id: SampleIDs.course2,
            code: "COMP3132",
            title: "Machine Learning",
            instructor: "Professor Ajellu",
            gradeGoal: 85,
            startWeek: Date()
        ),
        .init(
            id: SampleIDs.course3,
            code: "COMP3134",
            title: "Cyber Security",
            instructor: "Professor Blanc",
            gradeGoal: 85,
            startWeek: Date()
        ),
        .init(
            id: SampleIDs.course4,
            code: "COMP3133",
            title: "Fullstack Dev II",
            instructor: "Professor Patel",
            gradeGoal: 85,
            startWeek: Date()
        )
    ]
}
