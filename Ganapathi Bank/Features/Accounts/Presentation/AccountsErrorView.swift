//
//  AccountsErrorView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import SwiftUI

struct AccountsErrorView: View {
    let message: String

    var body: some View {
        ContentUnavailableView(
            "Something went wrong",
            image: "exclamationmark.triangle",
            description: Text(
                message
            )
        )
    }
}
