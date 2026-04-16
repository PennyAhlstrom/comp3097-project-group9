//
//  Progress.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct Progress: Identifiable, Codable, Hashable {
    let id: Int?
    let courseID: Int
    let accumulatedPercentPoints: Double
    let usedPercentPoints: Double
    let lostPercentPoints: Double
    let maxPossiblePercent: Double
    let currentGradePercent: Double
    let canMeetGoal: Bool
    let weekOf: Date
    let computedAt: Date

    init(
        id: Int? = nil,
        courseID: Int,
        accumulatedPercentPoints: Double,
        usedPercentPoints: Double,
        lostPercentPoints: Double,
        maxPossiblePercent: Double,
        currentGradePercent: Double,
        canMeetGoal: Bool,
        weekOf: Date,
        computedAt: Date
    ) {
        self.id = id
        self.courseID = courseID
        self.accumulatedPercentPoints = accumulatedPercentPoints
        self.usedPercentPoints = usedPercentPoints
        self.lostPercentPoints = lostPercentPoints
        self.maxPossiblePercent = maxPossiblePercent
        self.currentGradePercent = currentGradePercent
        self.canMeetGoal = canMeetGoal
        self.weekOf = weekOf
        self.computedAt = computedAt
    }

    enum CodingKeys: String, CodingKey {
        case id = "progressId"
        case courseID = "courseId"
        case accumulatedPercentPoints
        case usedPercentPoints
        case lostPercentPoints
        case maxPossiblePercent
        case currentGradePercent
        case canMeetGoal
        case weekOf
        case computedAt
    }
}
