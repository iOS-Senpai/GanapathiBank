//
//  AppContainer.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/9/26.
//
import SwiftData

final class AppContainer {
    
    private let session = SessionManager()
    private let configuaration = AppConfiguration(environment: .development)
    lazy var authenticatioService: AuthenticationService = MockAuthenticationService()// Provide concrete implementation
    
    lazy var apiClient: APIClient = {
        return URLSessionAPIClient(configuaration: configuaration)
    }()
    
    lazy var accountsRemoteDataSource = {
        return APIAccountsRemoteDataSource(apiClient: apiClient)
    }()
    
    private lazy var modelContainer = ModelContainerFactory.make(inMemory: false)
    
    private lazy var modelContext = modelContainer.mainContext
    
    lazy var accountsLocalDataSource = {
        return SwiftDataAccountsLocalDataSource(context: modelContext)
    }()
    
    lazy var accountsRepository: AccountsRepository = {
        return DefaultAccountsRepository(remote: accountsRemoteDataSource, local: accountsLocalDataSource)
    }()
    
    // Login Feature Flow Instantiation
    func makeAuthenticationCoordinator() -> AuthenticationCoordinator {
        return AuthenticationCoordinator(authenticationService: authenticatioService, sessionManager: session)
    }
    
    // Dashboard Feature Flow Instantiation
    func makeDashboardCoordinator() -> DashboardCoordinator {
        return DashboardCoordinator(accountsRepo: accountsRepository, session: session)
    }
    
    // Root Coordinator or App Coordinator
    func makeAppCoordinator() -> AppCoordinator {
        return AppCoordinator(session: session, authenticationCoordinator: makeAuthenticationCoordinator(), dashboardCoordinator: makeDashboardCoordinator())
    }
    
} // composition root.or Application Dependency Graph. Centralized where all the application dependencies are assembled.
