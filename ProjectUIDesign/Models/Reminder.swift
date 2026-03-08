//
//  Reminder.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct Reminder: Identifiable, Hashable {
    let id: UUID
    let message: String
    let scheduledAt: String // String for now, should be LocalDateTime
    //let wasSent: Bool

    init(id: UUID = UUID(), message: String, scheduledAt: String) {
        self.id = id
        self.message = message
        self.scheduledAt = scheduledAt
    }
}

extension Reminder {
    static let sampleReminders: [Reminder] = [
        .init(
            message: "Complete Quiz 1",
            scheduledAt: "2026-03-06"
        ),
        .init(
            message: "Study for Midterm",
            scheduledAt: "2026-02-08"
        ),
        .init(
            message: "Submit Lab 3",
            scheduledAt: "2026-03-12"
        ),
        .init(
            message: "Midterm Exam",
            scheduledAt: "2026-02-18"
        )
    ]
}
