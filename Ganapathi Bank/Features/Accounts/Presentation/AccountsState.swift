//
//  AccountsState.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import Foundation

//MARK: - Presentation State or View Satet
enum AccountsState {
    case idle
    case loading
    case loaded([Account])
    case refreshing([Account])
    case empty
    case error(String)
}
