//
//  DashboardCoordinator.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/12/26.
//

import Observation

@MainActor @Observable
final class DashboardCoordinator {
    // State
    var selectedTab: DashboardTab = .accounts
    
    // Dependencies
    private let appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }
    
    // Public API
    func start() -> DashboardRootView {
        return DashboardRootView(coordinator: self, appContainer: appContainer)
    }
} // Coordinates with Tab Navigation
