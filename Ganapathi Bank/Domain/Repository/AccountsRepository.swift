//
//  AccountsRepository.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//

protocol AccountsRepository {
    func fetchAccounts() async throws -> [Account]
}
