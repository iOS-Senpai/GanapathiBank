//
//  APIClient.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//

import Foundation

protocol APIClient {
    func execute<E: EndPoint>(_ endPoint: E) async throws -> E.Response
} // Infra Contract or API Contract
