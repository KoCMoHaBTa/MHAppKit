//
//  MHAppKitTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 3/4/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest
@testable import MHAppKit
import MessageUI

extension MHAppKitTests {
    
    class MFMailComposeViewController: MessageUI.MFMailComposeViewController {
        
        open override class func canSendMail() -> Bool {
            
            return true
        }
    }
}

class MHAppKitTests: XCTestCase {
    
    override func setUp() {
        
        super.setUp()
        
        let controller = MFMailComposeViewController()
        print(controller)
    }
    
    func testMFMailComposeViewControllerCompletionHandler() {
        
        self.performExpectation { (expectation) in
            
            let controller = MFMailComposeViewController()
            print(controller)
            controller.completionHandler = { (controller2, result, error) in
                
                XCTAssertEqual(controller, controller2)
                XCTAssertEqual(result, .cancelled)
                XCTAssertNil(error)
                expectation.fulfill()
            }
            
            controller.mailComposeDelegate?.mailComposeController?(controller, didFinishWith: .cancelled, error: nil)
            
            XCTAssertNotNil(controller.completionHandler)
            XCTAssertNotNil(controller.mailComposeDelegate)
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


