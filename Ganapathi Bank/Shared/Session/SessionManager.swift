//
//  SessionManager.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/10/26.
//

import Observation

@MainActor @Observable
final class SessionManager {
    
    // State
    
    private(set) var currentUser: User? // for read access only not write.
    
    // Dervive isAuthenticated From Current User State
    
    var hasActiveSession: Bool {
        return currentUser != nil
    }
    
    // Life Cycle Methods
    
    func login(_ user: User) {
        currentUser = user
    }
    
    func logout() {
        currentUser = nil
    }
    
} // Manage Application wide User session state
