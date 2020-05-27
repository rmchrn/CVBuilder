//
//  CVBuilderUITests.swift
//  CVBuilderUITests
//
//  Created by Ramcharan Reddy Gaddam on 20/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import XCTest

class CVBuilderUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // swiftlint:disable:next function_body_length
    func testCreateNewFlow() {
        let app = XCUIApplication()
        app.activate()
        app.buttons["create new"].tap()
        let cell = app.tables.staticTexts["Personal information"]
        cell.tap()
        let elementsQuery = app.scrollViews["scrollView"].otherElements
        let image = elementsQuery.containing(.textField, identifier: "Enter first name").children(matching: .image)
        image.element.tap()
        app.sheets["Choose Image"].scrollViews.otherElements.buttons["Gallery"].tap()
        app.tables.cells["Moments"].tap()
        app.collectionViews["PhotosGridView"].cells.element(boundBy: 0).tap()
        let firstName = elementsQuery.textFields["Enter first name"]
        firstName.tap()
        firstName.typeText("Ramcharan")
        let enterLastNameTextField = elementsQuery.textFields["Enter last name"]
        enterLastNameTextField.tap()
        enterLastNameTextField.typeText("Gaddam")
        let enterPhoneNumberTextField = elementsQuery.textFields["Enter phone number"]
        enterPhoneNumberTextField.tap()
        enterPhoneNumberTextField.typeText("9848080627")
        let enterEmailIdTextField = elementsQuery.textFields["Enter email Id"]
        enterEmailIdTextField.tap()
        enterEmailIdTextField.typeText("Ram@gmail.com")
        let enterAddressLine1TextField = elementsQuery.textFields["Enter address Line 1"]
        enterAddressLine1TextField.tap()
        enterAddressLine1TextField.typeText("Medchal")
        let enterAddressLine2TextField = elementsQuery.textFields["Enter address Line 2"]
        enterAddressLine2TextField.tap()
        enterAddressLine2TextField.typeText("Hyderabad")
        let selectDOB2TextField = elementsQuery.textFields["Select DOB"]
        selectDOB2TextField.tap()
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "August")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "27")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "1994")
        app.toolbars["Toolbar"].buttons["Done"].tap()
        elementsQuery.textFields["Enter year of experiece"].tap()
        let enterSkillSetTextField = elementsQuery.textFields["Enter skill set"]
        enterSkillSetTextField.tap()
        enterSkillSetTextField.typeText("iOS, Swift, Objective-c")
        let enterPrimaryEducationTextField = elementsQuery.textFields["Enter primary education %"]
        enterPrimaryEducationTextField.tap()
        enterPrimaryEducationTextField.typeText("90")
        let enterSecondaryEducationTextField = elementsQuery.textFields["Enter secondary education %"]
        enterSecondaryEducationTextField.tap()
        enterSecondaryEducationTextField.typeText("90")
        let enterHigherEducationTextField = elementsQuery.textFields["Enter higher education %"]
        enterHigherEducationTextField.tap()
        enterHigherEducationTextField.typeText("82")
        app.navigationBars["Personal Info"].buttons["save"].tap()
    }
    func testEditFlow() {
        let app = XCUIApplication()
        app.activate()
        let viewButton = app.buttons.element(boundBy: 2)
        viewButton.tap()
        let cell = app.tables.staticTexts["Personal information"]
        cell.tap()
        let elementsQuery = app.scrollViews["scrollView"].otherElements
        let enterEmailIdTextField = elementsQuery.textFields["Enter email Id"]
        enterEmailIdTextField.tap()
        enterEmailIdTextField.clearAndEnterText(text: "Ram@infy.com")
        app.navigationBars["Personal Info"].buttons["save"].tap()
    }
}

extension XCUIElement {
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}
