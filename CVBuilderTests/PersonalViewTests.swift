//
//  PersonalViewTests.swift
//  CVBuilderTests
//
//  Created by Ramcharan Reddy Gaddam on 21/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import XCTest
@testable import CVBuilder

class PersonalViewTests: XCTestCase {
    
    var sut:PersonalViewModel?

    override func setUp() {
        sut = PersonalViewModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testGetDataCall() {
        let expectation = XCTestExpectation(description: "Get data call")
        sut?.getProfileData(completion: { (personalInfo, error) in
            expectation.fulfill()
            XCTAssertNil(error)
            XCTAssertTrue(personalInfo != nil)
        })
        wait(for: [expectation], timeout: 30)
    }
    
}
