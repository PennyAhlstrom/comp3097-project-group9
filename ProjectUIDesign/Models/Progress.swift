//
//  Progress.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct Progress: Identifiable, Hashable {
    let id: UUID
    let courseID: UUID
    let accumulatedPercentPoints: Double
    let usedPercentPoints: Double
    let lostPercentPoints: Double
    let maxPossiblePercent: Double
    let currentGradePercent: Double
    let canMeetGoal: Bool
    let weekOf: Date
    let computedAt: Date

    init(
        id: UUID = UUID(),
        courseID: UUID,
        accumulatedPercentPoints: Double,
        usedPercentPoints: Double,
        lostPercentPoints: Double,
        maxPossiblePercent: Double,
        currentGradePercent: Double,
        canMeetGoal: Bool,
        weekOf: Date,
        computedAt: Date = Date()
        
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
}

extension Progress {
    static func date(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string)!
    }
    
    static let sampleProgresses: [Progress] = [
        .init(
            courseID: Course.SampleIDs.course1,
            accumulatedPercentPoints: 12,
            usedPercentPoints: 15,
            lostPercentPoints: 3,
            maxPossiblePercent: 97,
            currentGradePercent: 80,
            canMeetGoal: true,
            weekOf: date("2026-01-12"),
            computedAt: Date()
        ),
        .init(
            courseID: Course.SampleIDs.course1,
            accumulatedPercentPoints: 22,
            usedPercentPoints: 25,
            lostPercentPoints: 3,
            maxPossiblePercent: 97,
            currentGradePercent: 88,
            canMeetGoal: true,
            weekOf: date("2026-01-26"),
            computedAt: Date()
        ),
        .init(
            courseID: Course.SampleIDs.course1,
            accumulatedPercentPoints: 39,
            usedPercentPoints: 45,
            lostPercentPoints: 6,
            maxPossiblePercent: 94,
            currentGradePercent: 87,
            canMeetGoal: true,
            weekOf: date("2026-02-09"),
            computedAt: Date()
        ),
        .init(
            courseID: Course.SampleIDs.course1,
            accumulatedPercentPoints: 58,
            usedPercentPoints: 65,
            lostPercentPoints: 7,
            maxPossiblePercent: 93,
            currentGradePercent: 89,
            canMeetGoal: true,
            weekOf: date("2026-02-23"),
            computedAt: Date()
        ),
        // — COMP3132 Machine Learning progress—
        .init(
            courseID: Course.SampleIDs.course2,
            accumulatedPercentPoints: 7,
            usedPercentPoints: 7,
            lostPercentPoints: 0,
            maxPossiblePercent: 100,
            currentGradePercent: 92,
            canMeetGoal: true,
            weekOf: date("2026-02-09"),
            computedAt: Date()
        ),
        .init(
            courseID: Course.SampleIDs.course2,
            accumulatedPercentPoints: 9,
            usedPercentPoints: 9,
            lostPercentPoints: 0,
            maxPossiblePercent: 100,
            currentGradePercent: 90,
            canMeetGoal: true,
            weekOf: date("2026-02-23"),
            computedAt: Date()
        )
    ]
}