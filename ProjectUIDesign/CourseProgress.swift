//
//  CourseProgress.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct CourseProgress: Identifiable, Hashable {
    let id = UUID()
    //let courseId: Int // I want this to connect to an existing course
    let accumulatedPercentPoints: Double? // I want to initialize this to 0
    let usedPercentPoints: Double? // I want to initialize this to 0
    let lostPercentPoints: Double? // I want to initialize this to 0
    let maxPossiblePercent: Double? // I want to initialize this to 100
    let currentGradePercent: Double? // I want to initialize this to 0
    let canMeetGoal: Bool? // I want to initialize this to T
    let weekOf: String
    //let weekOf: Date?
    //let computedAt: Date?
}

extension CourseProgress {
    static let sampleCourseProgresses: [CourseProgress] = [
        .init(
            accumulatedPercentPoints: 12,
            usedPercentPoints: 15,
            lostPercentPoints: 3,
            maxPossiblePercent: 97,
            currentGradePercent: 80,
            canMeetGoal: true,
            weekOf: "2026-01-12"
            //weekOf: Date(), // This should be set as date of Monday for week it was calculated for
            //computedAt: Date()
        ),
        .init(
            accumulatedPercentPoints: 22,
            usedPercentPoints: 25,
            lostPercentPoints: 3,
            maxPossiblePercent: 97,
            currentGradePercent: 88,
            canMeetGoal: true,
            weekOf: "2026-01-26"
            //weekOf: Date(), // This should be set as date of Monday for week it was calculated for
            //computedAt: Date()
        ),
        .init(
            accumulatedPercentPoints: 39,
            usedPercentPoints: 45,
            lostPercentPoints: 6,
            maxPossiblePercent: 94,
            currentGradePercent: 87,
            canMeetGoal: true,
            weekOf: "2026-02-09"
            //weekOf: Date(), // This should be set as date of Monday for week it was calculated for
            //computedAt: Date()
        ),
        .init(
            accumulatedPercentPoints: 58,
            usedPercentPoints: 65,
            lostPercentPoints: 7,
            maxPossiblePercent: 93,
            currentGradePercent: 89,
            canMeetGoal: true,
            weekOf: "2026-02-23"
            //weekOf: Date(), // This should be set as date of Monday for week it was calculated for
            //computedAt: Date()
        )
    ]
}
