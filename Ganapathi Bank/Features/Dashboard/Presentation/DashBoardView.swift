//
//  DashBoardView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/12/26.
//

import SwiftUI

struct DashBoardView: View {
    
    @Bindable var viewModel: DashBoardViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.accounts) { account in
                    VStack(alignment: .leading) {
                        Text(account.accountNumber)
                        Text(account.balance.formatted())
                    }
                }
            }
            .navigationTitle("DashBoard")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Logout") {
                        viewModel.logout()
                    }
                }
            }
        }
        .task {
            await viewModel.loadAccounts()
        }
    } // Renders
}

#Preview {
    DashBoardView(viewModel: DashBoardViewModel(repository: MockAccountsRepository(), session: SessionManager()))
}
