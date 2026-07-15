//
//  AppConfiguration.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//

import Foundation

struct AppConfiguration {
    // State
    let environment: Environment // immutable
    
    var baseURL: URL {
        switch environment {
        case .development:
            return URL(string: "https://qa-ganapathi-bank/com/")!
        case .staging:
            return URL(string: "https://staging-ganapathi-bank/com/")!
        case .production:
            return URL(string: "https://production-ganapathi-bank/com/")!
        }
    }
    
}
