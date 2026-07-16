//
//  MockURLProtocol.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/15/26.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    
    // Behaviour
    typealias RequestHandler = (URLRequest) throws -> (Data, URLResponse)
    static var requestHandler: RequestHandler?
    
    // Life Cycle Methods
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // Lets check handler
        guard let handler = Self.requestHandler else {
            fatalError("Handler not set")
        }
        
        do {
            let (data, response) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() { }
}
