//
//  AccountsRemoteDataSource.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/17/26.
//

import Foundation

protocol AccountsRemoteDataSource {
    func fetchAccounts() async throws -> [Account]
}
