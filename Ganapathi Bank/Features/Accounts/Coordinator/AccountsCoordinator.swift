//
//  AccountsCoordinator.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import Foundation
import SwiftUI
import Observation

@Observable @MainActor
final class AccountsCoordinator {
    
    // Navigation State
    var path = NavigationPath()
    
    // MARK: - Public API
    
    func showAccountDetails(id: Account.ID) {
        path.append(AccountsRoute.details(id))
    }
    
    func pop() {
        guard !path.isEmpty else {
            return
        }
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
} // Navigation Decision
