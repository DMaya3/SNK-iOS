//
//  Errors.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import Foundation

enum CoreDataErrors: Error {
    case entityNotFound
    case errorSavingContext(_ error: String)
    case errorFetchingDataByContext
}

enum APIError: Swift.Error, Codable {
    case invalidUrl
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl: return "Invalid URL"
        case .httpCode(let code): return "Unexpected HTTP Code \(code)"
        case .unexpectedResponse: return "Unexpected response"
        }
    }
}
