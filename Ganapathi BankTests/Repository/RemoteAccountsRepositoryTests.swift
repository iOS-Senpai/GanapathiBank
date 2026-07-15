//
//  RemoteAccountsRepository.swift
//  Ganapathi BankTests
//
//  Created by xavient on 7/15/26.
//

import XCTest
@testable import Ganapathi_Bank

@MainActor
final class RemoteAccountsRepositoryTests: XCTestCase {
    
    // Dependencies or Collbarators or State
    private var apiClient: MockAPIClient!
    private var sut: RemoteAccountsRepository!
    
    // MARK: - LifeCycle
    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        sut = RemoteAccountsRepository(apiClient: apiClient)
    }
    
    override func tearDown() {
        apiClient = nil
        sut = nil
        super.tearDown()
    }
    
    //MARk: - Test suite
    func test_fetchAccounts_success_returnsMappedDomainModels() async throws {
        //Arrange
        let dto = AccountResponseDTO(id: .init(), accountNumber: "501002256702", balance: 10000000, currency: "$")
        apiClient.result = [dto]
        
        //Act
        let accounts = try await sut.fetchAccounts()
        
        //Assert
        XCTAssertEqual(accounts.count, 1)
        XCTAssertEqual(accounts.first?.accountNumber, dto.accountNumber)
        XCTAssertEqual(accounts.first?.balance, dto.balance)
    }
    
    func test_fetchAccounts_failure_propagatesError() async {
        //Arrange
        apiClient.error = MockError.networkError
        
        //Act + Assert
        do {
            _ = try await sut.fetchAccounts()
            XCTFail("Expected fetchAccounts() to return error")
        } catch {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_fecthAccounts_callsAPIClient() async throws {
        //Arrange
        apiClient.result = [AccountResponseDTO]()
        
        //Act
        _ = try await sut.fetchAccounts()
        
        //Assert
        XCTAssertTrue(apiClient.executeCalled)
    }
}
