//
//  APIAccountsRemoteDataSource.swift
//  Ganapathi Bank
//
//  Created by xavient on 7/14/26.
//

struct APIAccountsRemoteDataSource: AccountsRemoteDataSource {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchAccounts() async throws -> [Account] {
        let response = try await apiClient.execute(AccountsEndpoint.accounts)
        return response.map { $0.toDomain() }
    }
}
