//
//  AccountsView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import SwiftUI

struct AccountsView: View {
    @State private var viewModel: AccountsViewModel
    private let coordinator: AccountsCoordinator

    init(viewModel: AccountsViewModel, coordinator: AccountsCoordinator) {
        _viewModel = State(initialValue: viewModel)
        self.coordinator = coordinator
    }

    var body: some View {
        AccountsContentView(
            state: viewModel.state,
            onRefresh: viewModel.refresh,
            accountSelected: coordinator.showAccountDetails
        )
        .navigationTitle("Accounts")
        .navigationBarTitleDisplayMode(.large)
        .task {
            print("Accounts view executed")
            await viewModel.loadAccounts()
        }
    }
} // Life cycle management
