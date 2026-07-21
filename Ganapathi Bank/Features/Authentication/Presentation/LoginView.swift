//
//  LoginView.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/9/26.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State var viewModel: LoginViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Username")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("username", text: $username)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textContentType(.username)
                    Text("Password")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    SecureField("password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.password)

                    Button("Forgot Password?") {
                        // Action
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Button("Login") {
                        Task {
                            await viewModel.login(username: username, password: password)
                        }
                    }
                    .disabled(viewModel.isLoading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
                .padding(8)
            }
            .navigationTitle("Welcome Back")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(viewModel.alertState?.title ?? "", isPresented: showAlert, presenting: viewModel.alertState) { state in // Modelling the Data
            Button(state.buttonTitle, role: .cancel) {} // Gets a strongly typed data
        } message: { state in
            Text(state.message) // Gets a strongly typed data
        }
    }

    private var showAlert: Binding<Bool> {
        Binding {
            viewModel.alertState != nil
        } set: { newValue in
            if !newValue {
                viewModel.alertState = nil
            }
        }
    } // Binding acts a bridge or translator between SwiftUI and ViewModel.
}

#Preview {
    LoginView(viewModel: LoginViewModel(authenticationService: MockAuthenticationService(), session: SessionManager()))
}
