//
//  LoginViewModel.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/9/26.
//

import Observation

@Observable @MainActor
final class LoginViewModel {
    // State
    var isLoading = false
    var errorMessage: String?
    var successMessage: String? // Intent Based or Dervie the state from Intent.
    var alertState: AlertState?

    private let authenticationService: AuthenticationService
    private let session: SessionManager

    init(authenticationService: AuthenticationService, session: SessionManager) {
        self.authenticationService = authenticationService
        self.session = session
    }

    // Behaviour

    func login(username: String, password: String) async {
        guard !username.isEmpty else {
            errorMessage = "Username is empty"
            return
        }
        guard !password.isEmpty else {
            errorMessage = "passowrd is empty"
            return
        }
        errorMessage = nil
        isLoading = true
        defer {
            isLoading = false
        } // clean up
        do {
            let user = try await authenticationService.login(username: username, password: password)
            session.login(user)
            successMessage = "Welcome, \(user.username)" // Update it
            alertState = AlertState(title: "Login", message: "Successfully Authenticated", buttonTitle: "OK")
        } catch LoginError.invalidCredentials {
            errorMessage = "Invalid credentials" // Translating domain errors to presentation state
        } catch {
            errorMessage = "Something went worng"
        }
    }
} // Presentation Behaviour
