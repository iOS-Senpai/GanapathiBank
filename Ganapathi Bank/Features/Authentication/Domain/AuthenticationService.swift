//
//  AuthenticationService.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/9/26.
//

import Foundation

protocol AuthenticationService {
    func login(username: String, password: String) async throws -> User
}
