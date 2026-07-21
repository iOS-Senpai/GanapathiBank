//
//  Ganapathi_BankApp.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/9/26.
//

import SwiftUI

@main
struct Ganapathi_BankApp: App {
    @State private var appContainer = AppContainer() // Composition Root or Assembler or Top Level Object or Dependency Graph.
    var body: some Scene {
        WindowGroup {
            appContainer.makeAppCoordinator().start()
        }
    }
} // State driven Architecture

/*
 Mutiple Driven Architecture Exists

 Test Driven Architecture
 Behvioural Driven Architecture
 State Driven Architecture
 Event Driven Arhitecture
 Data Driven Architecture

 */
