//
//  AccountEntity+Mapping.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/19/26.
//

import Foundation

extension AccountEntity {
    
    convenience init(account: Account) {
        self.init(
            id: account.id,
            accountNumber: account.accountNumber,
            balance: account.balance,
            currency: account.currency
        )
    }
    
    func toDomain() -> Account {
        return Account(
            id: id,
            accountNumber: accountNumber,
            balance: balance,
            currency: currency
        )
    }
    
    func update(from account: Account) {
        self.accountNumber = account.accountNumber
        self.balance = account.balance
        self.currency = account.currency
    }
}
