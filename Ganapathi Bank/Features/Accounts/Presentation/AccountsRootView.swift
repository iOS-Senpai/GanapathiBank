//
//  AccountsRootView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import SwiftUI

struct AccountsRootView: View {
    
    @Bindable private var coordinator: AccountsCoordinator
    private let appContainer: AppContainer
    
    init(coordinator: AccountsCoordinator, appContainer: AppContainer) {
        self.coordinator = coordinator
        self.appContainer = appContainer
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            appContainer.makeAccountsView(coordinator: coordinator)
                .navigationDestination(for: AccountsRoute.self, destination: destination(for:))
        }
    }
    
    // MAKR: - Helpers
    
    @ViewBuilder
    private func destination(for route: AccountsRoute) -> some View {
        switch route {
        case let .details(id):
            // Accounts details view
            EmptyView()
        }
    }
}
