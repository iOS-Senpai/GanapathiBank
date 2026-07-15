//
//  MockAccountsRepository.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//
import Foundation

final class MockAccountsRepository: AccountsRepository {

    func fetchAccounts() async throws -> [Account] {
        return [
            Account(id: .init(), accountNumber: "50100225596702", balance: 500000000000),
            Account(id: .init(), accountNumber: "50100225596702", balance: 10000000000000)
        ]
    }
}
