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
    //let type: String // I made this string for now but should be an enum TaskType
    enum TaskType: String {
        case assignment = "ASSIGNMENT"
        case quiz = "QUIZ"
        case exam = "EXAM"
        case project = "PROJECT"
        case lab = "LAB"
    }
    let type: TaskType
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
        type: TaskType,
        //type: String,
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
        // — COMP3097 Mobile Dev II tasks —
        .init(
            courseID: Course.SampleIDs.course1,
            title: "LabEx1",
            type: .lab,
            //type: "LAB",
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
            type: .assignment,
            //type: "ASSIGNMENT",
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
            type: .quiz,
            //type: "QUIZ",
            dueDate: ymd(2026, 2, 08),
            isCompleted: false,
            isBonus: false,
            isPriority: true,
            weight: 2,
            scorePercent: 0
        ),
        .init(
            courseID: Course.SampleIDs.course2,
            title: "ML Project Proposal",
            type: .project,
            //type: "PROJECT",
            dueDate: ymd(2026, 3, 1),
            isCompleted: false,
            isBonus: false,
            isPriority: true,
            weight: 5,
            scorePercent: 0
        ),
        .init(
            courseID: Course.SampleIDs.course2,
            title: "Quiz 1",
            type: .quiz,
            //type: "QUIZ",
            dueDate: ymd(2026, 3, 5),
            isCompleted: false,
            isBonus: false,
            isPriority: true,
            weight: 2,
            scorePercent: 0
        ),
        .init(
            courseID: Course.SampleIDs.course2,
            title: "Assignment 2",
            type: .assignment,
            //type: "ASSIGNMENT",
            dueDate: ymd(2026, 3, 12),
            isCompleted: false,
            isBonus: false,
            isPriority: false,
            weight: 10,
            scorePercent: 0
        ),
        .init(
            courseID: Course.SampleIDs.course3,
            title: "Cyber Sec Lab 1",
            type: .lab,
            //type: "LAB",
            dueDate: ymd(2026, 2, 10),
            isCompleted: true,
            isBonus: false,
            isPriority: false,
            weight: 5,
            scorePercent: 92
        ),
        .init(
            courseID: Course.SampleIDs.course2,
            title: "Midterm Exam",
            type: .exam,
            //type: "EXAM",
            dueDate: ymd(2026, 3, 5),
            isCompleted: false,
            isBonus: false,
            isPriority: true,
            weight: 25,
            scorePercent: 0
        ),
        .init(
            courseID: Course.SampleIDs.course2,
            title: "Quiz Week 2",
            type: .quiz,
            //type: "QUIZ",
            dueDate: ymd(2026, 2, 15),
            isCompleted: true,
            isBonus: false,
            isPriority: false,
            weight: 2,
            scorePercent: 88
        ),
        // — COMP3134 Cyber Security tasks (Nezihe) —
        .init(
            courseID: Course.SampleIDs.course3,
            title: "Security Audit Report",
            type: .assignment,
            //type: "ASSIGNMENT",
            dueDate: ymd(2026, 2, 20),
            isCompleted: true,
            isBonus: false,
            isPriority: false,
            weight: 20,
            scorePercent: 95
        ),
        .init(
            courseID: Course.SampleIDs.course3,
            title: "Bonus: CTF Challenge",
            type: .lab,
            //type: "LAB",
            dueDate: ymd(2026, 3, 1),
            isCompleted: false,
            isBonus: true,
            isPriority: false,
            weight: 5,
            scorePercent: 0
        ),
        // — COMP3133 Fullstack Dev II tasks (Nezihe) —
        .init(
            courseID: Course.SampleIDs.course4,
            title: "React CRUD App",
            type: .assignment,
            //type: "ASSIGNMENT",
            dueDate: ymd(2026, 2, 28),
            isCompleted: true,
            isBonus: false,
            isPriority: false,
            weight: 15,
            scorePercent: 90
        ),
        .init(
            courseID: Course.SampleIDs.course4,
            title: "GraphQL Quiz",
            type: .quiz,
            //type: "QUIZ",
            dueDate: ymd(2026, 2, 12),
            isCompleted: true,
            isBonus: false,
            isPriority: false,
            weight: 3,
            scorePercent: 85,
        ),
        .init(
            courseID: Course.SampleIDs.course3,
            title: "Midterm Exam",
            type: .exam,
            //type: "EXAM",
            dueDate: ymd(2026, 3, 1),
            isCompleted: false,
            isBonus: false,
            isPriority: true,
            weight: 20,
            scorePercent: 0
        )
    ]
}
