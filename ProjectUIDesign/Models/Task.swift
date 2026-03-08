//
//  Task.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct Task: Identifiable, Hashable {
    let id: UUID
    let courseID: UUID
    
    let title: String
    let type: String // I made this string for now but should be an enum TaskType
    let dueDate: Date?
    
    let isCompleted: Bool
    let isBonus: Bool
    let isPriority: Bool
    
    //let priorityThresholdDays: Int?
    //let manualPriorityOverride: Bool?
    
    let weight: Double
    let scorePercent: Double
    //let reminders: List<Reminders>?

    init(
        id: UUID = UUID(),
        courseID: UUID,
        title: String,
        type: String,
        dueDate: Date?,
        isCompleted: Bool,
        isBonus: Bool,
        isPriority: Bool,
        weight: Double,
        scorePercent: Double
    ) {
        self.id = id
        self.courseID = courseID
        self.title = title
        self.type = type
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.isBonus = isBonus
        self.isPriority = isPriority
        self.weight = weight
        self.scorePercent = scorePercent
    }
}

extension Task {
    private static func ymd(_ year: Int, _ month: Int, _ day: Int) -> Date {
            Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
        }
    static let sampleTasks: [Task] = [
        .init(
            courseID: Course.SampleIDs.course1,
            title: "LabEx1",
            type: "LAB",
            dueDate: ymd(2026, 2, 03),
            isCompleted: true,
            isBonus: false,
            isPriority: false,
            weight: 1.5,
            scorePercent: 100
        ),
        .init(
            courseID: Course.SampleIDs.course1,
            title: "Assignment 1",
            type: "ASSIGNMENT",
            dueDate: ymd(2026, 2, 23),
            isCompleted: true,
            isBonus: false,
            isPriority: false,
            weight: 15,
            scorePercent: 100
        ),
        .init(
            courseID: Course.SampleIDs.course1,
            title: "Quiz Week 1",
            type: "QUIZ",
            dueDate: ymd(2026, 2, 08),
            isCompleted: false,
            isBonus: false,
            isPriority: true,
            weight: 2,
            scorePercent: 0
        )
    ]
}
