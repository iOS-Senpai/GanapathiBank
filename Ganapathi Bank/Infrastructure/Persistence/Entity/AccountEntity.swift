//
//  AccountEntity.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/19/26.
//

import Foundation
import SwiftData

@Model
final class AccountEntity {
    @Attribute(.unique)
    var id: UUID

    var accountNumber: String
    var balance: Decimal
    var currency: String

    init(id: UUID, accountNumber: String, balance: Decimal, currency: String) {
        self.id = id
        self.accountNumber = accountNumber
        self.balance = balance
        self.currency = currency
    }
}
