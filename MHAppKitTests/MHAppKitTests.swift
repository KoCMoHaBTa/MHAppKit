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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNSTimer() {
        
        self.performExpectation(description: "NSTimer test", timeout: 2.1) { (expectation) in
            
            let _ = Timer.scheduledTimerWithTimeInterval(2, repeats: false, handler: { (timer) in
                
                expectation.fulfill()
            })
        }
    }
    
    func testUIControlAction() {

        self.performExpectation { (expectation) in
            
            let control = UIControl()
            
            control.addAction() { (sender) in
                
                expectation.fulfill()
            }
            
            XCTAssertEqual(control.actions(forEvents: .touchUpInside).count, 1)
            
            control.sendActions(for: .allEvents)
        }
        
        self.performExpectation { (expectation) in
            
            expectation.add(conditions: [String(UIControlEvents.editingChanged.rawValue), String(UIControlEvents.touchDragExit.rawValue)])
            
            let control = UIControl()
            
            control.addAction(forEvents: .editingChanged, action: { (sender) in
                
                expectation.fulfill(condition: String(UIControlEvents.editingChanged.rawValue))
            })
            
            control.addAction(forEvents: .touchDragExit, action: { (sender) in
                
                expectation.fulfill(condition: String(UIControlEvents.touchDragExit.rawValue))
            })
            
            control.addAction(forEvents: .editingDidEndOnExit, action: {_ in })
            control.removeActions(forEvents: .editingDidEndOnExit)
            
            XCTAssertEqual(control.actions(forEvents: .editingChanged).count, 1)
            XCTAssertEqual(control.actions(forEvents: .touchDragExit).count, 1)
            XCTAssertEqual(control.actions(forEvents: .editingDidEndOnExit).count, 0)
            
            control.sendActions(for: .allEvents)
        }
    }
    
    func testUIBarButtonItemAction() {
        
        self.performExpectation { (expectation) in
            
            let item = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, action: { (sender) in
                
                expectation.fulfill()
            })
            
            UIApplication.shared.sendAction(item.action!, to: item.target, from: item, for: nil)
        }
        
        self.performExpectation { (expectation) in
            
            let item = UIBarButtonItem()
            
            item.actionHandler = { (sender) in
                
                expectation.fulfill()
            }
            
            UIApplication.shared.sendAction(item.action!, to: item.target, from: item, for: nil)
        }
    }
}


