//
//  AccountsLocalDataSource.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/17/26.
//

import Foundation

protocol AccountsLocalDataSource {
    func fetchAccounts() throws -> [Account]
    func fetch(id: UUID) throws -> Account?
    func synchronize(with accounts: [Account]) throws
} // Contract. Synchronous API's
