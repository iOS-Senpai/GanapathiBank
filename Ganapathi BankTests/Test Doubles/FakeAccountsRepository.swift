//
//  FakeAccountsRepository.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/15/26.
//

import Foundation
@testable import Ganapathi_Bank

final class FakeAccountsRepository: AccountsRepository {
    
    var result: Result<[Account], Error>!
    
    func fetchAccounts() async throws -> [Account] {
        return try result.get()
    }
}
