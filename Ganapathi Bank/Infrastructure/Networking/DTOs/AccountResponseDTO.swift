//
//  AccountResponseDTO.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//

import Foundation

struct AccountResponseDTO: Codable {
    let id: UUID
    let accountNumber: String
    let balance: Decimal
    let currency: String

    private enum CodingKeys: String, CodingKey {
        case id
        case accountNumber = "account_number"
        case balance
        case currency
    }
} // API Shape or API Contract.

extension AccountResponseDTO {
    func toDomain() -> Account {
        return Account(id: id, accountNumber: accountNumber, balance: balance, currency: currency)
    }
}
