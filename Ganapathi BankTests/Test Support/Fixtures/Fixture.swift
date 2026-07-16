//
//  Fixture.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/16/26.
//

import Foundation

enum Fixture {
    static func data<T: Codable>(from value: T) throws -> Data {
        return try JSONEncoder().encode(value)
    }
}
