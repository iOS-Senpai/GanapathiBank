//
//  AlertState.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/11/26.
//

import Foundation

struct AlertState: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let buttonTitle: String
}
