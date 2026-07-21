//
//  APIAccountsRemoteDataSourceTests.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/15/26.
//

@testable import Ganapathi_Bank
import XCTest

@MainActor
final class APIAccountsRemoteDataSourceTests: XCTestCase {
    // Dependencies or Collbarators or State
    private var apiClient: MockAPIClient!
    private var sut: APIAccountsRemoteDataSource!

    // MARK: - LifeCycle

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        sut = APIAccountsRemoteDataSource(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Test suite

    func test_fetchAccounts_success_returnsMappedDomainModels() async throws {
        // Arrange
        let dto = AccountResponseDTO(id: .init(), accountNumber: "501002256702", balance: 10_000_000, currency: "$")
        apiClient.result = [dto]

        // Act
        let accounts = try await sut.fetchAccounts()

        // Assert
        XCTAssertEqual(accounts.count, 1)
        XCTAssertEqual(accounts.first?.accountNumber, dto.accountNumber)
        XCTAssertEqual(accounts.first?.balance, dto.balance)
    }

    func test_fetchAccounts_failure_propagatesError() async {
        // Arrange
        apiClient.error = MockError.networkError

        // Act + Assert
        do {
            _ = try await sut.fetchAccounts()
            XCTFail("Expected fetchAccounts() to return error")
        } catch {
            XCTAssertTrue(error is MockError)
        }
    }

    func test_fecthAccounts_callsAPIClient() async throws {
        // Arrange
        apiClient.result = [AccountResponseDTO]()

        // Act
        _ = try await sut.fetchAccounts()

        // Assert
        XCTAssertTrue(apiClient.executeCalled)
    }
}
