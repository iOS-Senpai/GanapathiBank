//
//  DashboardCoordinator.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/12/26.
//

@MainActor
final class DashboardCoordinator {
    
    private let accountsRepo: AccountsRepository
    private let session: SessionManager
    
    init(accountsRepo: AccountsRepository, session: SessionManager) {
        self.accountsRepo = accountsRepo
        self.session = session
    }
    
    func start() -> DashBoardView {
        let viewModel = DashBoardViewModel(repository: accountsRepo, session: session)
        return DashBoardView(viewModel: viewModel)
    }
} // Coordinates with feature flow
