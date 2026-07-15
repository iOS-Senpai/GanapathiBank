//
//  DashboardCoordinator.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/12/26.
//

@MainActor
final class DashboardCoordinator {
    
    private let accountsRepo: AccountsRepository
    
    init(accountsRepo: AccountsRepository) {
        self.accountsRepo = accountsRepo
    }
    
    func start() -> DashBoardView {
        let viewModel = DashBoardViewModel(repository: accountsRepo)
        return DashBoardView(viewModel: viewModel)
    }
} // Coordinates with feature flow
