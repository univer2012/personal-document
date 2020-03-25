//
//  UITestDemoUITests.swift
//  UITestDemoUITests
//
//  Created by WANG WEI on 2015/09/09.
//  Copyright © 2015年 OneV's Den. All rights reserved.
//

import XCTest
@testable import UITestDemo

class UITestDemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyUserNameAndPassword() {
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        
        let alerts = app.alerts
        let label = app.alerts.staticTexts["Empty username/password"]
        
        let alertCount = NSPredicate(format: "count == 1")
        let labelExist = NSPredicate(format: "exists == 1")
        
        expectation(for: alertCount, evaluatedWith: alerts, handler: nil)
        expectation(for: labelExist, evaluatedWith: label, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLoginSuccessfully() {
        
        #if false
        let app = XCUIApplication()
        let element = app.otherElements.containingType(.NavigationBar, identifier:"Login").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1)
        let textField = element.childrenMatchingType(.Other).elementBoundByIndex(0).childrenMatchingType(.TextField).element
        textField.tap()
        textField.typeText("onevcat")
        element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.SecureTextField).element.typeText("123")
        
        // Other more test code
        #elseif false
        
        let userName = "onevcat"
        let password = "123"
        
        let app = XCUIApplication()
        
        let userNameTextField = app.textFields["username"]
        userNameTextField.tap()
        userNameTextField.typeText(userName)
        
        let passwordTextField = app.secureTextFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText(password)

        app.buttons["Login"].tap()

        let navTitle = app.navigationBars[userName].staticTexts[userName]
        expectationForPredicate(NSPredicate(format: "exists == 1"), evaluatedWithObject: navTitle, handler: nil)

        waitForExpectationsWithTimeout(5, handler: nil)
        #endif
        
        
        
    }
    
    func testSwitchAndCount() {
        let userName = "onevcat"
        let password = "123"
        
        let app = XCUIApplication()
        
        let userNameTextField = app.textFields["username"]
        userNameTextField.tap()
        userNameTextField.typeText(userName)
        
        let passwordTextField = app.secureTextFields["password"]
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        app.buttons["Login"].tap()

        sleep(3)
        
        let switcher = app.switches["checkin"]
        let l = app.staticTexts["countLabel"]

        switcher.tap()
        XCTAssertEqual(l.label, "1", "Count label should be 1 after clicking check in.")
        
        switcher.tap()
        XCTAssertEqual(l.label, "0", "And 0 after clicking again.")
        
    }
    
}
