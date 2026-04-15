//
//  Course.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct CourseMeeting: Codable, Hashable, Identifiable {
    var id: String { "\(dayOfWeek)-\(startTime)-\(endTime)" }

    let dayOfWeek: Int
    let startTime: String
    let endTime: String
}

struct Course: Identifiable, Codable, Hashable {
    let id: Int?
    let code: String
    let title: String
    let instructor: String
    let meetings: [CourseMeeting]
    let gradeGoal: Int?
    let startWeek: Date?

    init(
        id: Int? = nil,
        code: String,
        title: String,
        instructor: String,
        meetings: [CourseMeeting] = [],
        gradeGoal: Int?,
        startWeek: Date?
    ) {
        self.id = id
        self.code = code
        self.title = title
        self.instructor = instructor
        self.meetings = meetings
        self.gradeGoal = gradeGoal
        self.startWeek = startWeek
    }

    enum CodingKeys: String, CodingKey {
        case id = "courseId"
        case code
        case title
        case instructor
        case meetings
        case gradeGoal
        case startWeek
    }
}
