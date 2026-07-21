//
//  LoginViewModelTests.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/11/26.
//

@testable import Ganapathi_Bank // @testable Accessing the internal declarations
import XCTest

@MainActor
class LoginViewModelTests: XCTestCase {
    // State

    private var session: SessionManager! // Always describe the varibale name with its role than its concrete type

    // MARK: - Life Cycle

    override func setUp() {
        super.setUp()
        session = SessionManager()
    }

    override func tearDown() {
        session = nil // Mutable shared state need to be deallocated for every test suite.
        super.tearDown()
    }

    func test_login_success_updates_session() async {
        // Arrange
        let expectedUser = User(username: "Pradeep") // Domain Object or Data
        let authenticationService = FakeAuthenticationService(result: .success(User(username: "Pradeep"))) // Making explicit configuration for each scenario.
        let sut = makeSUT(authenticationService: authenticationService)

        // Act
        await sut.login(username: "pradeep", password: "123")

        // Assert
        XCTAssertEqual(session.currentUser, expectedUser) // Test primary behaviour first always.
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_login_failure_deliversErrorMessage() async {
        let authenticationService = FakeAuthenticationService(result: .failure(anyError())) // Making explicit configuration for each scenario.
        let sut = makeSUT(authenticationService: authenticationService)

        // Act
        await sut.login(username: "pradeep", password: "1234")

        // Assert
        XCTAssertNil(session.currentUser) // Test primary behaviour first always.
        XCTAssertNotNil(sut.errorMessage) // Secondary Behaviour
        XCTAssertFalse(sut.isLoading)
    }

    func test_login_setsLoadingWhileAuthenticating() async {
        // Arrange
        let authenticationService = ControllableAuthenticationService()
        let sut = makeSUT(authenticationService: authenticationService)

        // ACT
        let task = Task {
            await sut.login(username: "pradeep", password: "123")
        } // Using task to continue test inorder to observe the intermediate states or transient states whil still task is in suspension.

        await Task.yield()

        XCTAssertTrue(sut.isLoading) // Transient State or Intermediate State Assertion.

        authenticationService.complete(with: .success(User(username: "pradeep"))) // Encapsulating the fake implemenation details from tests.

        await task.value // Inorder to avoid race conditions or flaky tests

        // Assert(Final State)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotNil(session.currentUser)
    }

    // MARK: - Helpers

    private func makeSUT(authenticationService: AuthenticationService) -> LoginViewModel {
        return LoginViewModel(authenticationService: authenticationService, session: session)
    }

    private func anyError() -> Error {
        return NSError(domain: "\(type(of: self))", code: 1)
    }
}
