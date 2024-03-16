//
//  currencyFormmatterUnitTest.swift
//  BankeyUnityTests
//
//  Created by Baran Baran on 13.03.2024.
//


import XCTest
import Foundation

@testable import Bankey


final class Test: XCTestCase {
    
    
    var formatter : CurrencyFormatter!
    
    
    override func setUp() {
        formatter = CurrencyFormatter()
        
    }
   
    func testBreakZeroDollarsIntoCents() throws {
       
        
        let result = formatter.breakIntoDollarsAndCents(0.00)
        XCTAssertEqual(result.0, "0")
        XCTAssertEqual(result.1, "00")
    }
    
    
    func testDollarsFormatted() throws {
        // mevcut para biri sembolüm
        let currencySymbol = Locale.current.currencySymbol
        let result1 = formatter.dollarsFormatted(99.99)
        let result2 = formatter.dollarsFormatted(0.00)
        
        XCTAssertEqual(result1, "\(currencySymbol!)99,99")
        XCTAssertEqual(result2, "\(currencySymbol!)0,00")
    }
    
    
 
}


