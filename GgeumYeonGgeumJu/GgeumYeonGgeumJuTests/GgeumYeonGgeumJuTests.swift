//
//  GgeumYeonGgeumJuTests.swift
//  GgeumYeonGgeumJuTests
//
//  Created by 남수김 on 2020/05/14.
//  Copyright © 2020 남수김. All rights reserved.
//

import XCTest
@testable import GgeumYeonGgeumJu

class GgeumYeonGgeumJuTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test측정날짜포맷() {
        let date = Date()
        let mockDate = "2020.05.14"
        let dateString = date.datePickerToString()
        
        XCTAssertEqual(mockDate, dateString)
    }

}
