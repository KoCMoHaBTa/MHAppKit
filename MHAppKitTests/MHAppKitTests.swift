//
//  MHAppKitTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 3/4/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest
@testable import MHAppKit

class MHAppKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNSTimer() {
        
        self.performExpectation("NSTimer test", timeout: 2.1) { (expectation) in
            
            NSTimer.scheduledTimerWithTimeInterval(2, repeats: false) { (timer) in
                
                expectation.fulfill()
            }
        }
    }
    
    func testUIControl() {

        self.performExpectation { (expectation) in
            
            let control = UIControl()
            
            control.addAction() { (sender, event) in
                
                expectation.fulfill()
            }
            
            XCTAssertEqual(control.actions(.TouchUpInside).count, 1)
            
            control.sendActionsForControlEvents(.AllEvents)
        }
        
        self.performExpectation { (expectation) in
            
            expectation.addConditions([String(UIControlEvents.EditingChanged.rawValue), String(UIControlEvents.TouchDragExit.rawValue)])
            
            let control = UIControl()
            
            control.addAction(.EditingChanged, action: { (sender, event) in
                
                expectation.fulfillCondition(String(UIControlEvents.EditingChanged.rawValue))
            })
            
            control.addAction(.TouchDragExit, action: { (sender, event) in
                
                expectation.fulfillCondition(String(UIControlEvents.TouchDragExit.rawValue))
            })
            
            control.addAction(.EditingDidEndOnExit, action: {_,_ in })
            control.removeActions(.EditingDidEndOnExit)
            
            XCTAssertEqual(control.actions(.EditingChanged).count, 1)
            XCTAssertEqual(control.actions(.TouchDragExit).count, 1)
            XCTAssertEqual(control.actions(.EditingDidEndOnExit).count, 0)
            
            control.sendActionsForControlEvents(.AllEvents)
        }
    }
}


