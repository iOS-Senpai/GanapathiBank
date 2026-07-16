//
//  DashBoardViewModel.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/12/26.
//

import Foundation
import Observation

@MainActor @Observable
final class DashBoardViewModel {
    
    // Dependencies and States
    private let repository: AccountsRepository
    private let session: SessionManager
    private(set) var accounts = [Account]()
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    init(repository: AccountsRepository, session: SessionManager) {
        self.repository = repository
        self.session = session
    }
    
    func loadAccounts() async {
        isLoading = true
        errorMessage = nil
        defer {
            isLoading = false
        }
        do {
            self.accounts = try await repository.fetchAccounts()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func logout() {
        session.logout()
    }
}
