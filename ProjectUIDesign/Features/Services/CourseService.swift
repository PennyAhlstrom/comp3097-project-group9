//
//  CourseService.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import Foundation

final class CourseService {
    func getAll() async throws -> [Course] {
        try await NetworkManager.shared.send(
            path: "/api/v1/courses",
            method: "GET",
            requiresAuth: true
        )
    }

    func getByID(_ id: Int) async throws -> Course {
        try await NetworkManager.shared.send(
            path: "/api/v1/courses/\(id)",
            method: "GET",
            requiresAuth: true
        )
    }

    func create(_ course: Course) async throws -> Course {
        try await NetworkManager.shared.send(
            path: "/api/v1/courses",
            method: "POST",
            body: course,
            requiresAuth: true
        )
    }

    func update(_ course: Course) async throws -> Course {
        guard let id = course.id else {
            throw APIError.invalidResponse
        }

        return try await NetworkManager.shared.send(
            path: "/api/v1/courses/\(id)",
            method: "PUT",
            body: course,
            requiresAuth: true
        )
    }

    func delete(id: Int) async throws {
        try await NetworkManager.shared.sendNoContent(
            path: "/api/v1/courses/\(id)",
            method: "DELETE",
            requiresAuth: true
        )
    }
}
