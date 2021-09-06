//
//  TestKumparanTests.swift
//  TestKumparanTests
//
//  Created by Linando Saputra on 06/09/21.
//
@testable import TestKumparan
import XCTest

class TestKumparanTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetUsername(){
        
        let userNamePlusCompany = "Leanne Graham, Romaguera-Crona"
        let newUserNamePlusCompany = String(userNamePlusCompany.reversed())
        
        if let range = newUserNamePlusCompany.range(of: ",") {
            let userName = newUserNamePlusCompany[range.upperBound...].trimmingCharacters(in: .whitespaces)
            XCTAssertEqual(String(userName.reversed()), "Leanne Graham")
        }
    }
    
}
