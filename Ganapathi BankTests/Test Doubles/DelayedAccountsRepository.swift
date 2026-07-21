//
//  DelayedAccountsRepository.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/15/26.
//

import Foundation
@testable import Ganapathi_Bank

final class DelayedAccountsRepository: AccountsRepository {
    func fetchAccounts() async throws -> [Account] {
        try await Task.sleep(for: .milliseconds(300))
        return [] // Return can be empty as we are only testing the state transitions.
    }
}
