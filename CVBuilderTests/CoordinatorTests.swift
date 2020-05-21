//
//  CoordinatorTests.swift
//  CVBuilderTests
//
//  Created by Ramcharan Reddy Gaddam on 21/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import XCTest
@testable import CVBuilder

class CoordinatorTests: XCTestCase {
    var sut: MainCoordinator?
    let navigationController = UINavigationController()
    override func setUp() {
        sut = MainCoordinator(navigationController: navigationController)
    }

    override func tearDown() {
        sut = nil
    }

    func testShouldNavigateCreateCVVCOnGotoCreatCVCall() {
        sut?.gotoCreateVC(true)
        XCTAssert(navigationController.topViewController is CreateCVViewController)
    }
    func testShouldNavigateCreateCVVCOnGotoPersonalInfo() {
        sut?.gotoPersonalInfo(true)
        XCTAssert(navigationController.topViewController is PersonalViewController)
    }
}
