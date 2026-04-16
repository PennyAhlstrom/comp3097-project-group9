//
//  APIError.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case unauthorized
    case serverError(statusCode: Int, message: String?)
    case decodingFailed
    case encodingFailed
    case missingToken

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid server URL."
        case .invalidResponse:
            return "Invalid server response."
        case .unauthorized:
            return "Your session has expired. Please log in again."
        case .serverError(let statusCode, let message):
            return message ?? "Server error (\(statusCode))."
        case .decodingFailed:
            return "Failed to decode server response."
        case .encodingFailed:
            return "Failed to encode request body."
        case .missingToken:
            return "You must be logged in to perform this action."
        }
    }
}
