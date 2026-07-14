//
//  DashBoardViewModel.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/12/26.
//

import Observation

@MainActor @Observable
final class DashBoardViewModel {
    
    // Dependencies
    private let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    // Computed Var or Dervied State
    
    var name: String {
        return sessionManager.currentUser?.username ?? "Pradeep"
    }
    
    func logout() {
        sessionManager.logout()
    }
}
