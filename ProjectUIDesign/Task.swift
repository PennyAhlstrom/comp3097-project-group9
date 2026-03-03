//
//  Task.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct Task: Identifiable, Hashable {
    let id = UUID()
    // let courseID: UUID? // Tasks should be connected to a specific course
    let title: String
    let type: String // I made this string for now but should be an enum TaskType
    //let dueDate: Date?
    let dueDate: String // Making this string for now
    let isCompleted: Bool
    let isBonus: Bool
    let isPriority: Bool
    //let priorityThresholdDays: Int?
    //let manualPriorityOverride: Bool?
    let weight: Double
    let scorePercent: Double
    //let reminders: List<Reminders>?
}

extension Task {
    static let sampleTasks: [Task] = [
        .init(
            title: "LabEx1",
            type: "LAB",
            dueDate: "2026-02-23",
            isCompleted: true,
            isBonus: false,
            isPriority: false,
            weight: 1.5,
            scorePercent: 100
        ),
        .init(
            title: "Assignment 1",
            type: "ASSIGNMENT",
            dueDate: "2026-02-23",
            isCompleted: true,
            isBonus: false,
            isPriority: false,
            weight: 15,
            scorePercent: 100
        ),
        .init(
            title: "Quiz Week 1",
            type: "QUIZ",
            dueDate: "2026-02-23",
            isCompleted: false,
            isBonus: false,
            isPriority: true,
            weight: 2,
            scorePercent: 0
        )
    ]
}
