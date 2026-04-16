//
//  Task.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct Task: Identifiable, Codable, Hashable {
    let id: Int?
    let courseID: Int
    let title: String
    let type: String
    let dueDate: Date?
    let priorityThresholdDays: Int?
    let manualPriorityOverride: Bool?
    let weight: Double
    let scorePercent: Double
    let isPriority: Bool
    let isCompleted: Bool
    let isBonus: Bool

    init(
        id: Int? = nil,
        courseID: Int,
        title: String,
        type: String,
        dueDate: Date?,
        priorityThresholdDays: Int? = nil,
        manualPriorityOverride: Bool? = nil,
        weight: Double,
        scorePercent: Double,
        isPriority: Bool,
        isCompleted: Bool,
        isBonus: Bool
    ) {
        self.id = id
        self.courseID = courseID
        self.title = title
        self.type = type
        self.dueDate = dueDate
        self.priorityThresholdDays = priorityThresholdDays
        self.manualPriorityOverride = manualPriorityOverride
        self.weight = weight
        self.scorePercent = scorePercent
        self.isPriority = isPriority
        self.isCompleted = isCompleted
        self.isBonus = isBonus
    }

    enum CodingKeys: String, CodingKey {
        case id = "taskId"
        case courseID = "courseId"
        case title
        case type
        case dueDate
        case priorityThresholdDays
        case manualPriorityOverride
        case weight
        case scorePercent
        case isPriority = "priority"
        case isCompleted = "completed"
        case isBonus = "bonus"
    }
}
