//
//  ControllableAuthenticationService.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/11/26.
//

@testable import Ganapathi_Bank

final class ControllableAuthenticationService: AuthenticationService {
    // State

    private var continuation: CheckedContinuation<User, Error>?

    // API Or Behaviour

    func login(username _: String, password _: String) async throws -> User {
        try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
        } // Suspension asynchronous object
    }

    func complete(with result: Result<User, Error>) {
        precondition(continuation != nil, "Complete() called before login() suspended.")
        switch result {
        case let .success(user):
            continuation?.resume(returning: user)
        case let .failure(error):
            continuation?.resume(throwing: error)
        }

        continuation = nil // To prevent data races or caching shared state.
    } // Expose this Public API to tests. Instead of exposing implementation detail.
} // Controllable Fake
