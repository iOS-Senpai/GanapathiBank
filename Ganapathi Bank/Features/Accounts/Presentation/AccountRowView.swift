//
//  AccountRowView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import SwiftUI

struct AccountRowView: View {
    let account: Account
    var body: some View {
        // Card
        VStack(alignment: .leading, spacing: 16) {
            header
            
            balance
            
            accountNumber
        }
        .padding()
        .background(.background)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 16
            )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.quaternary)
        }
    }
    
    private var header: some View {
        HStack {
            Image(systemName: "indianrupeesign.bank.building.fill")
            Text("Savings Account")
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
    
    private var balance: some View {
        VStack(alignment: .leading) {
            Text("Balance")
            Text(account.balance, format: .currency(code: account.currency))
                .font(.title3.bold())
        }
    }
    
    private var accountNumber: some View {
        VStack(alignment: .leading) {
            Text("Account Number")
            Text(account.maskAccountNumber)
                .font(.caption)
        }
    }
}

extension Account {
    var maskAccountNumber: String {
        return accountNumber
    }
}

#Preview {
    AccountRowView(account: MockAccountsRepository().fetchAccounts().first!)
}
