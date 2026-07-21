//
//  EndPoint.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//

import Foundation

protocol EndPoint {
    associatedtype Response: Decodable
    var path: String { get }
    var method: HTTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var body: Data? { get }
} // Contract Describing HTTP Request Information.

extension EndPoint {
    var queryItems: [URLQueryItem] {
        return []
    }

    var headers: [String: String] {
        return [:]
    }

    var body: Data? {
        return nil
    }
}
