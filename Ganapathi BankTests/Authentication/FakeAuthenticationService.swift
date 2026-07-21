//
//  FakeAuthenticationService.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/11/26.
//

@testable import Ganapathi_Bank

final class FakeAuthenticationService: AuthenticationService {
    private let result: Result<User, Error>

    init(result: Result<User, Error>) {
        self.result = result
    }

    func login(username _: String, password _: String) async throws -> User {
        return try result.get()
    }
} // Configurable Fake
