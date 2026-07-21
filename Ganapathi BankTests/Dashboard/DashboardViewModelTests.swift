//
//  DashboardViewModelTests.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/15/26.
//

@testable import Ganapathi_Bank
import XCTest

@MainActor
final class DashboardViewModelTests: XCTestCase {
    // MARK: - Dependencies

    private var sut: DashBoardViewModel!
    private var repository: FakeAccountsRepository!
    private var session: SessionManager!

    // MARK: - Life Cycle Methods

    override func setUp() {
        super.setUp()
        repository = FakeAccountsRepository()
        session = SessionManager()
        sut = DashBoardViewModel(repository: repository, session: session)
    }

    override func tearDown() {
        sut = nil
        repository = nil
        super.tearDown()
    }

    // MARK: - Test Suite

    func test_initialState() {
        XCTAssertEqual(sut.accounts, [])
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_loadAccounts_success_udpateAccounts() async {
        // Arrange
        let expectedAccounts = [
            Account(id: .init(), accountNumber: "50100225596702", balance: 1_000_000_000, currency: "INR"),
        ]
        repository.result = .success(expectedAccounts)

        // ACT
        await sut.loadAccounts()

        // Assert
        XCTAssertEqual(sut.accounts, expectedAccounts)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }

    func test_loadAccounts_failure_setsError() async {
        // Arrange
        repository.result = .failure(MockError.networkError)

        // Act
        await sut.loadAccounts()

        // Assert
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(sut.accounts, [])
        XCTAssertFalse(sut.isLoading)
    }

    func test_loadAccounts_failure_preserveExistingAccounts() async {
        // Arrange
        let existingAccounts = [
            Account(id: .init(), accountNumber: "50100225596702", balance: 1_000_000_000, currency: "INR"),
        ]
        repository.result = .success(existingAccounts)

        // Act
        await sut.loadAccounts()
        repository.result = .failure(MockError.networkError)
        await sut.loadAccounts()

        // Assert
        XCTAssertEqual(sut.accounts, existingAccounts)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_loadAccounts_loadingState() async {
        // Arrange
        let sut = DashBoardViewModel(repository: DelayedAccountsRepository(), session: session)

        // Act
        let task = Task {
            await sut.loadAccounts()
        }

        await Task.yield()

        XCTAssertTrue(sut.isLoading)

        await task.value

        // Assert
        XCTAssertFalse(sut.isLoading)
    } // Loading State Transitions

    func test_loadAccounts_success_clearPreviousError() async {
        // Arrange
        repository.result = .failure(MockError.networkError)

        // Act
        await sut.loadAccounts()
        XCTAssertNotNil(sut.errorMessage)
        repository.result = .success([])
        await sut.loadAccounts()

        // Assert
        XCTAssertNil(sut.errorMessage)
    }
}
