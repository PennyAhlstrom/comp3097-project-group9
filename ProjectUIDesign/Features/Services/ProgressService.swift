//
//  ProgressService.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import Foundation

final class ProgressService {
    func getAll() async throws -> [Progress] {
        try await NetworkManager.shared.send(
            path: "/api/v1/course-progress",
            method: "GET",
            requiresAuth: true
        )
    }

    func create(_ progress: Progress) async throws -> Progress {
        try await NetworkManager.shared.send(
            path: "/api/v1/course-progress",
            method: "POST",
            body: progress,
            requiresAuth: true
        )
    }

    func update(_ progress: Progress) async throws -> Progress {
        guard let id = progress.id else {
            throw APIError.invalidResponse
        }

        return try await NetworkManager.shared.send(
            path: "/api/v1/course-progress/\(id)",
            method: "PUT",
            body: progress,
            requiresAuth: true
        )
    }

    func delete(id: Int) async throws {
        try await NetworkManager.shared.sendNoContent(
            path: "/api/v1/course-progress/\(id)",
            method: "DELETE",
            requiresAuth: true
        )
    }
}
