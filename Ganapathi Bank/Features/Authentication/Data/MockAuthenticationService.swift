//
//  MockAuthenticationService.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/9/26.
//

struct MockAuthenticationService: AuthenticationService {
    func login(username: String, password: String) async throws -> User {
        try await Task.sleep(for: .seconds(2))
        if username == "pradeep" && password == "123" {
            return User(username: username)
        }
        throw LoginError.invalidCredentials
    }
}
