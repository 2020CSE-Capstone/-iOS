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
    
    func testPickerViewData() {
        
        let sojuList = [
            Drink(title: "참이슬", price: 400),
            Drink(title: "진로", price: 350),
            Drink(title: "처음", price: 300)
        ]
        let list = GoodsList(title: "소주", list: sojuList)
            
        let resultData = ["참이슬", "진로", "처음"]
        XCTAssertEqual(list.getList(), resultData)
    }
}
