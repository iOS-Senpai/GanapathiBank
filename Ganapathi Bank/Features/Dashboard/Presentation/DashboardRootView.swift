//
//  DashboardRootView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/20/26.
//

import SwiftUI

struct DashboardRootView: View {
    @Bindable private var coordinator: DashboardCoordinator
    private let appContainer: AppContainer

    init(coordinator: DashboardCoordinator, appContainer: AppContainer) {
        self.coordinator = coordinator
        self.appContainer = appContainer
    }

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            appContainer.makeAccountsRootView()
                .tabItem {
                    Label("Accounts", systemImage: "creditcard")
                }
                .tag(DashboardTab.accounts)
            Text("Transfers")
                .tabItem {
                    Label("Transfers", systemImage: "creditcard")
                }
                .tag(DashboardTab.transfers)
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "creditcard")
                }
                .tag(DashboardTab.profile)
        }
    }
}
