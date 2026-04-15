//
//  TaskService.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import Foundation

final class TaskService {
    func getAll() async throws -> [Task] {
        try await NetworkManager.shared.send(
            path: "/api/v1/tasks",
            method: "GET",
            requiresAuth: true
        )
    }

    func create(_ task: Task) async throws -> Task {
        try await NetworkManager.shared.send(
            path: "/api/v1/tasks",
            method: "POST",
            body: task,
            requiresAuth: true
        )
    }

    func update(_ task: Task) async throws -> Task {
        guard let id = task.id else {
            throw APIError.invalidResponse
        }

        return try await NetworkManager.shared.send(
            path: "/api/v1/tasks/\(id)",
            method: "PUT",
            body: task,
            requiresAuth: true
        )
    }

    func delete(id: Int) async throws {
        try await NetworkManager.shared.sendNoContent(
            path: "/api/v1/tasks/\(id)",
            method: "DELETE",
            requiresAuth: true
        )
    }
}
