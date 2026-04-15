//
//  ReminderService.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import Foundation

final class ReminderService {
    func getAll() async throws -> [Reminder] {
        try await NetworkManager.shared.send(
            path: "/api/v1/reminders",
            method: "GET",
            requiresAuth: true
        )
    }

    func create(_ reminder: Reminder) async throws -> Reminder {
        try await NetworkManager.shared.send(
            path: "/api/v1/reminders",
            method: "POST",
            body: reminder,
            requiresAuth: true
        )
    }

    func update(_ reminder: Reminder) async throws -> Reminder {
        guard let id = reminder.id else {
            throw APIError.invalidResponse
        }

        return try await NetworkManager.shared.send(
            path: "/api/v1/reminders/\(id)",
            method: "PUT",
            body: reminder,
            requiresAuth: true
        )
    }

    func delete(id: Int) async throws {
        try await NetworkManager.shared.sendNoContent(
            path: "/api/v1/reminders/\(id)",
            method: "DELETE",
            requiresAuth: true
        )
    }
}
