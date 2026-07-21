//
//  ModelContainerFactory.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/19/26.
//

import Foundation
import SwiftData

enum ModelContainerFactory {
    static func make(inMemory: Bool) -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
        do {
            return try ModelContainer(
                for: AccountEntity.self,
                configurations: configuration
            )
        } catch {
            fatalError(
                "Failed to create the model container: \(error)"
            )
        }
    }
} // Model container is a persisatnce store
