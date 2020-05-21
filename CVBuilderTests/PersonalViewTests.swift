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
    var sut: PersonalViewModel?

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
            XCTAssertTrue(error == nil, "error while fetching CV data")
            XCTAssertTrue(personalInfo != nil, "error while fetching CV data")
        })
        wait(for: [expectation], timeout: 30)
    }
}
