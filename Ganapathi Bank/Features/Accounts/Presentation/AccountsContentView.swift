//
//  AccountsContentView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import SwiftUI

struct AccountsContentView: View {
    let state: AccountsState
    let onRefresh: () async -> Void
    let accountSelected: (Account.ID) -> Void

    var body: some View {
        content
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .idle:
            ProgressView()
        case .loading:
            AccountsLoadingView()
        case let .loaded(accounts):
            accountsList(accounts)
        case let .refreshing(accounts):
            accountsList(accounts)
        case .empty:
            AccountsEmptyView()
        case let .error(message):
            AccountsErrorView(message: message)
        }
    } // Rendering Based on State

    private func accountsList(_ accounts: [Account]) -> some View {
        AccountsListView(accounts: accounts, accountSelected: accountSelected)
            .refreshable {
                await onRefresh()
            }
    }
}
