//
//  DashboardCoordinator.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/12/26.
//

@MainActor
final class DashboardCoordinator {
    
    private let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func start() -> DashBoardView {
        let viewModel = DashBoardViewModel(sessionManager: sessionManager)
        return DashBoardView(viewModel: viewModel)
    }
} // Coordinates with feature flow
