//
//  URLSessionAPIClient.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//

import Foundation

final class URLSessionAPIClient: APIClient {
    // State
    private let session: URLSession
    private let jsonDecoder: JSONDecoder // Dependecies or Collabarators
    private let configuration: AppConfiguration

    init(session: URLSession = .shared, configuaration: AppConfiguration) { // .shared for convenience
        self.session = session
        jsonDecoder = JSONDecoder()
        configuration = configuaration
    }

    func execute<E: EndPoint>(_ endPoint: E) async throws -> E.Response {
        // Build Request From Endpoint
        let request = try makeRequest(from: endPoint) // each one has its own resposibility

        // Execute Request
        let (data, response) = try await perform(request)

        // Validate Response
        try validate(response)

        // Decode the data

        return try decode(of: E.Response.self, data: data)
    }

    // MARK: - Behaviours

    private func makeRequest(from endpoint: any EndPoint) throws -> URLRequest {
        var urlComponents = URLComponents(url: configuration.baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems
        guard let url = urlComponents?.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        for (field, value) in endpoint.headers {
            request.setValue(value, forHTTPHeaderField: field)
        }
        request.httpBody = endpoint.body
        return request
    }

    private func perform(_ request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: request)
        } catch let error as URLError {
            throw APIError.networkError(error)
        } catch {
            throw APIError.unknown(error)
        }
    }

    @discardableResult
    private func validate(_ response: URLResponse) throws -> HTTPURLResponse {
        guard let response = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        switch response.statusCode {
        case 200 ... 299:
            return response
        case 401:
            throw APIError.unauthorized
        case 403:
            throw APIError.forbidden
        case 404:
            throw APIError.notFound
        case 500 ... 599:
            throw APIError.serverError(response.statusCode)
        default:
            throw APIError.unKnownStatusCode(response.statusCode)
        }
    }

    private func decode<T: Decodable>(of type: T.Type, data: Data) throws -> T {
        do {
            return try jsonDecoder.decode(type, from: data)
        } catch {
            throw APIError.decodingFailed(error)
        }
    }
}
