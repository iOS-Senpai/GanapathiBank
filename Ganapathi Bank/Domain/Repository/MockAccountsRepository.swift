//
//  MockAccountsRepository.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//
import Foundation

final class MockAccountsRepository: AccountsRepository {

    func fetchAccounts() -> [Account] {
        let accounts: [Account] = (1...100).map { index in
            Account(
                id: .init(),
                accountNumber: "50100225596702",
                balance: index % 2 == 0 ? 500_000_000_000 : 10_000_000_000_000,
                currency: "INR"
            )
        }
        return accounts
    }
}
