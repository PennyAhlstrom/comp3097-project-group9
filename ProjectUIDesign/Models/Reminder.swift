//
//  Reminder.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation

struct Reminder: Identifiable, Codable, Hashable {
    let id: Int?
    let taskID: Int
    let message: String
    let scheduledAt: Date
    let wasSent: Bool

    init(
        id: Int? = nil,
        taskID: Int,
        message: String,
        scheduledAt: Date,
        wasSent: Bool = false
    ) {
        self.id = id
        self.taskID = taskID
        self.message = message
        self.scheduledAt = scheduledAt
        self.wasSent = wasSent
    }

    enum CodingKeys: String, CodingKey {
        case id = "reminderId"
        case taskID = "taskId"
        case message
        case scheduledAt
        case wasSent
    }
}
