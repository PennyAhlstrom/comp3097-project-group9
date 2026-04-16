//
//  NetworkManager.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import Foundation

struct EmptyBody: Encodable {}

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func send<Request: Encodable, Response: Decodable>(
        path: String,
        method: String,
        body: Request?,
        requiresAuth: Bool
    ) async throws -> Response {
        guard let url = URL(string: APIConfig.baseURL + path) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if requiresAuth {
            guard let token = await AuthManager.shared.token, !token.isEmpty else {
                throw APIError.missingToken
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            do {
                request.httpBody = try encoder.encode(body)
            } catch {
                throw APIError.encodingFailed
            }
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response, data: data)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let raw = try container.decode(String.self)

            if let date = APIConfig.apiDateFormatter.date(from: raw) {
                return date
            }
            if let date = APIConfig.fallbackISOFormatter.date(from: raw) {
                return date
            }

            let plain = DateFormatter()
            plain.dateFormat = "yyyy-MM-dd"
            plain.locale = Locale(identifier: "en_US_POSIX")
            if let date = plain.date(from: raw) {
                return date
            }

            throw APIError.decodingFailed
        }

        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }

    func send<Response: Decodable>(
        path: String,
        method: String,
        requiresAuth: Bool
    ) async throws -> Response {
    
        return try await send(path: path, method: method, body: Optional<EmptyBody>.none, requiresAuth: requiresAuth)
    }

    func sendNoContent<Request: Encodable>(
        path: String,
        method: String,
        body: Request?,
        requiresAuth: Bool
    ) async throws {
        guard let url = URL(string: APIConfig.baseURL + path) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if requiresAuth {
            guard let token = await AuthManager.shared.token, !token.isEmpty else {
                throw APIError.missingToken
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            do {
                request.httpBody = try encoder.encode(body)
            } catch {
                throw APIError.encodingFailed
            }
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response, data: data)
    }

    func sendNoContent(
        path: String,
        method: String,
        requiresAuth: Bool
    ) async throws {
        try await sendNoContent(path: path, method: method, body: Optional<EmptyBody>.none, requiresAuth: requiresAuth)
    }

    private func validate(response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            return
        case 401:
            _Concurrency.Task { @MainActor in
                AuthManager.shared.logout()
            }
            throw APIError.unauthorized
        default:
            let message = String(data: data, encoding: .utf8)
            throw APIError.serverError(statusCode: httpResponse.statusCode, message: message)
        }
    }
}
