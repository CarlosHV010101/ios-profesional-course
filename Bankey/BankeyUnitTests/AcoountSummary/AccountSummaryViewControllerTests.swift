//
//  AccountSummaryViewControllerTests.swift
//  BankeyUnitTests
//
//  Created by Administrador on 01/06/23.
//

import Foundation
import XCTest

@testable import Bankey

class AccountSummaryViewControllerTests: XCTestCase {
    
    var sut: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        sut = AccountSummaryViewController()
        mockManager = MockProfileManager()
        sut.profileManager = mockManager
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleMessage = sut.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleMessage.1)
    }
    
    func testTitleAndMessageForDecondingError() throws {
        let titleMessage = sut.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Network Error", titleMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleMessage.1)
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        sut.forceFetchProfile()
        
        XCTAssertEqual("Server Error", sut.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", sut.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        sut.forceFetchProfile()
        
        XCTAssertEqual("Network Error", sut.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", sut.errorAlert.message)
    }
}
