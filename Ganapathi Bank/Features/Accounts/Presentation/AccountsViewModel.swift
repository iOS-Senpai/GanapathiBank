//
//  AccountsViewModel.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import Foundation
import Observation

@MainActor @Observable
final class AccountsViewModel {

    //MARK: - Dependencies
    private let repository: AccountsRepository
    
    //MARK: - State
    private(set) var state: AccountsState = .idle // Read-only property // State Transitions
    
    //MARK: - Initializer
    init(repository: AccountsRepository) {
        self.repository = repository
    }
    
    //MARK: - Public API
    
    func loadAccounts() async {
        // Make this loadAccounts() as Idempotent
        guard case .idle = state else {
            return
        }
        
        state = .loading // State Transitions
        
        do {
            let accounts = try await repository.fetchAccounts()
            updateState(with: accounts)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func refresh() async {
       // check whether existing accounts loaded
        guard case let .loaded(accounts) = state else {
            return
        }
        
        state = .refreshing(accounts)
        
        do {
            let accounts = try await repository.fetchAccounts()
            updateState(with: accounts)
        } catch {
            state = .loaded(accounts)
        }
    }
    
    // MARK: - Private API
    
    private func updateState(with accounts: [Account]) {
        if accounts.isEmpty {
            state = .empty
        } else {
            state = .loaded(accounts)
        }
    }
}
