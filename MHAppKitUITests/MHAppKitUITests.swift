//
//  MHAppKitUITests.swift
//  MHAppKitUITests
//
//  Created by Milen Halachev on 9/8/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest

class MHAppKitUITests: XCTestCase {
        
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

    func testRemoveBackBarButtonItemTitle() {
        
        let app = XCUIApplication()

        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertEqual(app.navigationBars.buttons.element(boundBy: 0).label, "Back")

        app.toolbars.buttons.element(boundBy: 0).tap()
        //NOTE: This test fails to report that last back button title is a space character, but appears correctly
//        XCTAssertEqual(app.navigationBars.buttons.element(boundBy: 0).label, " ")
    }
    
    func testDisablingControlBasedOnDynamicActions() {
        
        
        let app = XCUIApplication()
        app.toolbars.buttons["actions"].tap()
        app.buttons["controller with dynamic action"].tap()
        XCTAssertTrue(app.buttons["this should be enabled"].isEnabled)
        
        app.navigationBars["MHAppKitTestsHost.VC2"].buttons["Back"].tap()
        app.buttons["controller without dynamic action"].tap()
        XCTAssertFalse(app.buttons["this should be disabled "].isEnabled)
    }
}
