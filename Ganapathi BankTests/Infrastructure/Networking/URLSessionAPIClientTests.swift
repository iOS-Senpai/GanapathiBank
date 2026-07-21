//
//  URLSessionAPIClientTests.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/15/26.
//

@testable import Ganapathi_Bank
import XCTest

@MainActor
final class URLSessionAPIClientTests: XCTestCase {
    /// Dependencies or Collabarators or State
    private var sut: URLSessionAPIClient!

    // MARK: - Life Cycle

    override func setUp() {
        super.setUp()
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: sessionConfiguration)
        let appConfiguration = AppConfiguration(environment: .development)
        sut = URLSessionAPIClient(session: session, configuaration: appConfiguration)
    }

    override func tearDown() {
        // Reduce test pollution
        sut = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }

    // MARK: - Test Suite

    func test_execute_success_returnsDecodedResponse() async throws {
        // Arrange
        let accountDTO = AccountResponseDTOBuilder.make(balance: 100_000)
        let data = try Fixture.data(from: [accountDTO])
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (data, response)
        }

        // Act
        let accounts = try await sut.execute(AccountsEndpoint.accounts)

        // Assert
        XCTAssertEqual(accounts.count, 1)
        XCTAssertNotNil(accounts.first)
    }

    func test_execute_WhenUnAuthorized_throwsUnAuthorizedError() async throws {
        // Arrange
        MockURLProtocol.requestHandler = { _ in
            let response = self.makeResponse(statusCode: 401)
            return (Data(), response)
        }

        do {
            // ACT + Assert
            try await executeAccountsRequest()
            XCTFail("Expected authorized error")
        } catch let error as APIError {
            // Pattern matching
            guard case .unauthorized = error else {
                return XCTFail("unauthorized error")
            }
        } catch {
            XCTFail("unknown error \(error)")
        }
    }

    func test_execute_WhenForbidden_throwsForbideenError() async throws {
        // Arrange
        MockURLProtocol.requestHandler = { _ in
            let response = self.makeResponse(statusCode: 403)
            return (Data(), response)
        }

        do {
            // ACT + Assert
            try await executeAccountsRequest()
            XCTFail("Expected authorized error")
        } catch let error as APIError {
            // Pattern matching
            guard case .forbidden = error else {
                return XCTFail("forbidden error")
            }
        } catch {
            XCTFail("unknown error \(error)")
        }
    }

    func test_execute_WhenNotFound_throwsNotFoundError() async throws {
        // Arrange
        MockURLProtocol.requestHandler = { _ in
            let response = self.makeResponse(statusCode: 404)
            return (Data(), response)
        }

        do {
            // ACT + Assert
            try await executeAccountsRequest()
            XCTFail("Expected authorized error")
        } catch let error as APIError {
            // Pattern matching
            guard case .notFound = error else {
                return XCTFail("notFound error")
            }
        } catch {
            XCTFail("unknown error \(error)")
        }
    }

    func test_execute_whenServerError_throwsServerError() async throws {
        // Arrange
        MockURLProtocol.requestHandler = { _ in
            let response = self.makeResponse(statusCode: 500)
            return (Data(), response)
        }

        do {
            // ACT + Assert
            try await executeAccountsRequest()
            XCTFail("Expected server error error")
        } catch let error as APIError {
            // Pattern matching
            guard case let .serverError(code) = error else {
                return XCTFail("server error")
            }
            XCTAssertEqual(code, 500)
        } catch {
            XCTFail("unknown error \(error)")
        }
    }

    func test_execute_whenInvalidJson_throwsDecodingFailed() async throws {
        // Arrange
        let invalidJson = Data("invalid json".utf8)
        MockURLProtocol.requestHandler = { _ in
            let response = self.makeResponse(statusCode: 200)
            return (invalidJson, response)
        }

        do {
            // ACT + Assert
            try await executeAccountsRequest()
            XCTFail("Expected decoding failed error")
        } catch let error as APIError {
            // Pattern matching
            guard case .decodingFailed = error else {
                return XCTFail("decoding failed error")
            }
        } catch {
            XCTFail("unknown error \(error)")
        }
    }

    func test_execute_whenNetworkFails_throwsNetworkError() async throws {
        MockURLProtocol.requestHandler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        do {
            // ACT + Assert
            try await executeAccountsRequest()
            XCTFail("Expected not connected to internet error")
        } catch let error as APIError {
            // Pattern matching
            guard case let .networkError(urlError) = error else {
                return XCTFail("not connected to internet")
            }
            XCTAssertEqual(urlError.code, .notConnectedToInternet)
        } catch {
            XCTFail("unknown error \(error)")
        }
    }

    func test_execute_whenReponseIsNonHTTP_throwsInvalidResponse() async throws {
        MockURLProtocol.requestHandler = { request in
            let response = URLResponse(
                url: request.url!,
                mimeType: nil,
                expectedContentLength: 0,
                textEncodingName: nil
            )
            return (Data(), response)
        }

        do {
            // ACT + Assert
            try await executeAccountsRequest()
            XCTFail("Expected invalid response")
        } catch let error as APIError {
            // Pattern matching
            guard case .invalidResponse = error else {
                return XCTFail("invalid response")
            }
        } catch {
            XCTFail("unknown error \(error)")
        }
    }

    func test_execute_buildsCorrectURLRequest() async throws {
        let dto = AccountResponseDTOBuilder.make()
        let data = try Fixture.data(from: [dto])
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertEqual(request.url?.path, "/accounts")
            XCTAssertNil(request.httpBody)
            let response = self.makeResponse(statusCode: 200)
            return (data, response)
        }
        try await executeAccountsRequest()
    }

    // MARK: - Helpers

    private func makeResponse(statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }

    @discardableResult
    private func executeAccountsRequest() async throws -> [AccountResponseDTO] {
        return try await sut.execute(AccountsEndpoint.accounts)
    }
}
