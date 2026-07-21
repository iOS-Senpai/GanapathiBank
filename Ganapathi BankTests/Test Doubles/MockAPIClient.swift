//
//  MockAPIClient.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/15/26.
//

import Foundation
@testable import Ganapathi_Bank

final class MockAPIClient: APIClient {
    // State
    var executeCalled = false
    var result: Any?
    var error: Error?

    func execute<E: EndPoint>(_: E) async throws -> E.Response {
        executeCalled = true
        if let error {
            throw error
        }
        guard let response = result as? E.Response else {
            fatalError("Mock response type mismatch")
        }
        return response
    }
}
