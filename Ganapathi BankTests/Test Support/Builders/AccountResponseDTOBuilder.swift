//
//  AccountResponseDTOBuilder.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/16/26.
//

import Foundation
@testable import Ganapathi_Bank

enum AccountResponseDTOBuilder {
    static func make(id: UUID = .init(), accountNumber: String = "501002296702", balance: Decimal = 1_000_000_000, currency: String = "INR") -> AccountResponseDTO {
        return .init(id: id, accountNumber: accountNumber, balance: balance, currency: currency)
    }
}
