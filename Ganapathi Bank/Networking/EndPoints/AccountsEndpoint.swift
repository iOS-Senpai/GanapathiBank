//
//  AccountsEndpoint.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//
import Foundation

enum AccountsEndpoint: EndPoint {
    typealias Response = [AccountResponseDTO]
    
    case accounts
    
    var path: String {
        switch self {
        case .accounts: return "/accounts"
        }
    }
    
    var method: HTTTPMethod {
        switch self {
        case .accounts: return .get
        }
    }
}
