//
//  AppCoordinatorTests.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/12/26.
//

@testable import Ganapathi_Bank
import XCTest

@MainActor
final class AppCoordinatorTests: XCTestCase {
    // MARK: - Dependencies or Collabrators

    private var sut: AppCoordinator!
    private var session: SessionManager!
    private var authenticationService: AuthenticationService!
    private var authenticationCoordinator: AuthenticationCoordinator!
    private var dashboardCoordinator: DashboardCoordinator!

    // MARK: - Life Cycle Methods

    override func tearDown() {
        sut = nil
        session = nil
        authenticationService = nil
        authenticationCoordinator = nil
        dashboardCoordinator = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_currentFlow_whenNoActiveSession_returnsAuthentication() {
        // Arrange
        sut = makeSUT()
        // ACT
        let currentFlow = sut.currentFlow
        // Assert
        XCTAssertEqual(currentFlow, .login)
    }

    func test_currentFlow_whenActiveSession_returnsDashboard() {
        // Arrange
        sut = makeSUT()
        let user = User(username: "Pradeep Kumar")
        session.login(user)
        // Act
        let currentFlow = sut.currentFlow
        // Assert
        XCTAssertEqual(currentFlow, .dashboard)
    }

    // MARK: - Helpers

    private func makeSUT() -> AppCoordinator {
        // Assemble depency graph or compose
        session = SessionManager()
        authenticationService = MockAuthenticationService()
        authenticationCoordinator = AuthenticationCoordinator(
            authenticationService: authenticationService,
            sessionManager: session
        )
        dashboardCoordinator = DashboardCoordinator(appContainer: AppContainer())
        return AppCoordinator(
            session: session,
            authenticationCoordinator: authenticationCoordinator,
            dashboardCoordinator: dashboardCoordinator
        )
    }
}
