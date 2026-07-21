//
//  DefaultAccountsRepository.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/17/26.
//

import Foundation

final class DefaultAccountsRepository: AccountsRepository {
    private let remote: AccountsRemoteDataSource // Collabarating Dependencies
    private let local: AccountsLocalDataSource

    init(remote: AccountsRemoteDataSource, local: AccountsLocalDataSource) {
        self.remote = remote
        self.local = local
    }

    /// Fetches the latest accounts.
    ///
    /// Strategy:
    /// 1. Fetch from remote.
    /// 2. Synchronize local cache.
    /// 3. Return remote data.
    /// 4. If remote fails, return cached data.
    func fetchAccounts() async throws -> [Account] {
        // Caching strategy pattern which we are using here is Network-Cache-Strategy
        do {
            // We hit the remote
            let accounts = try await remote.fetchAccounts()
            // sync it with local cache
            try local.synchronize(with: accounts) // cache synchronization.
            return accounts
        } catch {
            let cachedAccounts = try local.fetchAccounts()
            if cachedAccounts.isEmpty {
                throw error
            }
            return cachedAccounts
        }
    }
}
