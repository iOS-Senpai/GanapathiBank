//
//  SwiftDataAccountsLocalDataSource.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/17/26.
//

import Foundation
import SwiftData

final class SwiftDataAccountsLocalDataSource: AccountsLocalDataSource {
    
    private let context: ModelContext // Is an object which performs crud operations and save it.
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchAccounts() throws -> [Account] {
        return try fetchAllEntities().map { $0.toDomain() }
    }
    
    func fetch(id: UUID) throws -> Account? {
        return try fetchEntity(id: id)?.toDomain()
    }
    
    func synchronize(with accounts: [Account]) throws {
        let entities = try fetchAllEntities()
        let lookup = createEntityLookup(from: entities)
        udpateOrInsertRemoteAccounts(accounts, using: lookup)
        deleteObseleteEntities(entities, remoteAccounts: accounts)
        try context.save()
    } // One Transaction
    
    // MARK: - Helpers
    private func fetchEntity(id: UUID) throws -> AccountEntity? {
        let descriptor = FetchDescriptor<AccountEntity>.init(predicate: #Predicate<AccountEntity>{
            $0.id == id
        }) // which describe the query
        return try context.fetch(descriptor).first // It might throw error becasue of migration issues, corruption, disk full.
    }
    
    private func fetchAllEntities() throws -> [AccountEntity] {
        let descriptor = FetchDescriptor<AccountEntity>()
        let entities = try context.fetch(descriptor)
        return entities
    }
    
    private func createEntityLookup(from entities: [AccountEntity]) -> [UUID: AccountEntity] {
        // State
        var lookup = [UUID: AccountEntity]()
        // Traversal
        for entity in entities {
            lookup[entity.id] = entity
        }
        return lookup
    }
    
    private func udpateOrInsertRemoteAccounts(_ accounts: [Account], using lookup: Dictionary<UUID, AccountEntity>) {
        // Traversal
        for account in accounts {
            if let entity = lookup[account.id] {
                // Udpate
                entity.update(from: account)
            } else {
                // insert
                context.insert(AccountEntity(account: account))
            }
        }
    } // Business operations
    
    private func deleteObseleteEntities(_ entities: [AccountEntity], remoteAccounts: [Account]) {
        // Traverse through entities
        for entity in entities {
            // Check whether this entity.id exist in remote account.id
            let exists = remoteAccounts.contains {
                $0.id == entity.id
            }
            if !exists {
                context.delete(entity)
            }
        }
    }
}
