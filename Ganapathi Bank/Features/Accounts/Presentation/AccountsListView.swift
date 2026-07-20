//
//  AccountsListView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import SwiftUI

struct AccountsListView: View {
    
    let accounts: [Account]
    let accountSelected: (Account.ID) -> Void
    
    var body: some View {
        List {
            ForEach(accounts) { account in
                Button {
                    accountSelected(account.id)
                } label: {
                    AccountRowView(account: account)
                        .padding([.vertical, .horizontal], 8)
                }
            }
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}
