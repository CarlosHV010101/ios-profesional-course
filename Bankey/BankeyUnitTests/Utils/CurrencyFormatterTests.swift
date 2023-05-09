//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Administrador on 03/05/23.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    
    var sut: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        sut = CurrencyFormatter()
    }
    
    override class func tearDown() {
        super.tearDown()
    }

    func testBreakDollarIntoCents() {
        let result = sut.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws {
        let result = sut.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929,466.23")
    }
    
    func testZeroDollars() throws {
        let result = sut.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
    }
    
}
