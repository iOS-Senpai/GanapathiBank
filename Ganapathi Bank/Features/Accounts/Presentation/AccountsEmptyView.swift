//
//  AccountsEmptyView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import SwiftUI

struct AccountsEmptyView: View {
    var body: some View {
        ContentUnavailableView(
            "No Accounts",
            image: "creditcard"
        )
    }
}
