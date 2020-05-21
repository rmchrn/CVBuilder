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

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateNewFlow() {
        
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["create new"]/*[[".buttons[\"Create New\"]",".buttons[\"create new\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Personal information"]/*[[".cells.staticTexts[\"Personal information\"]",".staticTexts[\"Personal information\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let elementsQuery = app.scrollViews["scrollView"].otherElements
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
        elementsQuery.textFields["Select DOB."].tap()
        
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "August")
        datePickersQuery.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "27")
        datePickersQuery.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "1994")

        app.toolbars["Toolbar"].buttons["Done"].tap()
        elementsQuery.textFields["Enter year of experiece."].tap()
        
        let enterSkillSetTextField = elementsQuery.textFields["Enter skill set."]
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
        app.alerts["CVBuilder"].scrollViews.otherElements.buttons["Ok"].tap()
        
                
    }

    func testViewOrEditFlow() {
        
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["view or edit"]/*[[".buttons[\"View\/Edit\"]",".buttons[\"view or edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Personal information"]/*[[".cells.staticTexts[\"Personal information\"]",".staticTexts[\"Personal information\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews["scrollView"].otherElements.textFields["Enter email Id"].tap()
        app.navigationBars["Personal Info"].buttons["save"].tap()
        app.alerts["CVBuilder"].scrollViews.otherElements.buttons["Ok"].tap()
        
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
