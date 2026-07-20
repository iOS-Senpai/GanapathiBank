//
//  AppCoordinator.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/10/26.
//

import SwiftUI

@MainActor @Observable
final class AppCoordinator {
    
    private let session: SessionManager
    private let authenticationCoordinator: AuthenticationCoordinator // dependencies
    private let dashboardCoordinator: DashboardCoordinator
    
    var currentFlow: AppFlow {
        return session.hasActiveSession ? .dashboard : .login
    } // Always try to dervie from the state.
    
    init(session: SessionManager, authenticationCoordinator: AuthenticationCoordinator, dashboardCoordinator: DashboardCoordinator) {
        self.session = session
        self.authenticationCoordinator = authenticationCoordinator
        self.dashboardCoordinator = dashboardCoordinator
    }
    
    @ViewBuilder
    func start() -> some View {
        if session.hasActiveSession {
            dashboardCoordinator.start()
        } else {
            authenticationCoordinator.start()
        }
    } // API or Behaviour exposing
    
} // Root Of Application Flow
