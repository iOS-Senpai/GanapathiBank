//
//  AppContainer.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/9/26.
//

final class AppContainer {
    
    private let session = SessionManager()
    lazy var authenticatioService: AuthenticationService = MockAuthenticationService()// Provide concrete implementation
    
    // Login Feature Flow Instantiation
    func makeAuthenticationCoordinator() -> AuthenticationCoordinator {
        return AuthenticationCoordinator(authenticationService: authenticatioService, sessionManager: session)
    }
    
    // Dashboard Feature Flow Instantiation
    func makeDashboardCoordinator() -> DashboardCoordinator {
        return DashboardCoordinator(sessionManager: session)
    }
    
    // Root Coordinator or App Coordinator
    func makeAppCoordinator() -> AppCoordinator {
        return AppCoordinator(session: session, authenticationCoordinator: makeAuthenticationCoordinator(), dashboardCoordinator: makeDashboardCoordinator())
    }
    
} // composition root.or Application Dependency Graph. Centralized where all the application dependencies are assembled.
