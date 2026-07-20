//
//  Account.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//

import Foundation

struct Account: Identifiable, Equatable {
    let id: UUID
    let accountNumber: String
    let balance: Decimal
    let currency: String
}
