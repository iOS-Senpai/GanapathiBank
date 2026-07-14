//
//  AuthenticationCoordinator.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/9/26.
//

import Foundation

@MainActor
final class AuthenticationCoordinator {
    
    private let authenticationService: AuthenticationService
    private let session: SessionManager
    
    public init(authenticationService: AuthenticationService, sessionManager: SessionManager) {
        self.authenticationService = authenticationService
        self.session = sessionManager
    }
    
    func start() -> LoginView {
        let viewModel = LoginViewModel(authenticationService: authenticationService,
                                       session: session)
        return LoginView(viewModel: viewModel)
    }
} // Assemble the feature and feature flow.

// There are two types of dependencies one is operational dependency and assembling dependency.
