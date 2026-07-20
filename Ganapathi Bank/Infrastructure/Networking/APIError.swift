//
//  APIError.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case unauthorized
    case notFound
    case forbidden
    case serverError(Int)
    case unKnownStatusCode(Int)
    case decodingFailed(Error)
    case networkError(URLError)
    case unknown(Error)
} // Domain Error
