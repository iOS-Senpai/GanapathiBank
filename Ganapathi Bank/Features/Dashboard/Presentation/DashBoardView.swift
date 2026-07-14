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
        VStack(spacing: 20) {
            Image(systemName: "buildings.columns.fill")
                .font(.system(size: 64))
                .foregroundStyle(.white)
            
            Text("Welcome")
            
            Text(viewModel.name)
                .font(.title2)
                .bold()
            
            Button("Logout") {
                viewModel.logout()
            }
        }
        .navigationTitle("Dashboard")
    } // Renders
}

#Preview {
    DashBoardView(viewModel: DashBoardViewModel(sessionManager: SessionManager()))
}
