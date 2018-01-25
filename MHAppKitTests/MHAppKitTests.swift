//
//  MHAppKitTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 3/4/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import XCTest
@testable import MHAppKit
@testable import MHAppKitTestsHost
import MessageUI

class MHAppKitTests: XCTestCase {
    
    func testNSTimer() {
        
        self.performExpectation(description: "NSTimer test", timeout: 2.1) { (expectation) in
            
            let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, handler: { (timer) in
                
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
    
    func testNibLoadable() {
        
        XCTAssertNotNil(TestNibView.loadFromNib())
    }
    
    func testCollectionConvenienceMutation() {
        
        XCTAssertEqual(["2", "1"] + "3", ["2", "1", "3"])
        XCTAssertEqual(Set(["2", "1"]) + "3", Set(["2", "1", "3"]))
    }
    
    func testResponderChainSequence() {
        
        self.performExpectation { (e) in
            
            e.expectedFulfillmentCount = 3
            
            let v1 = UIView()
            let v2 = UIView()
            let v3 = UIView()
            
            v1.addSubview(v2)
            v2.addSubview(v3)
            
            for _ in v3.responderChain {
                
                e.fulfill()
            }
        }
    }
    
    func testResponderChainActions() {
        
        class ResponderWithAction: UIControl {
            
            var handler: () -> Void
            
            init(handler: @escaping () -> Void) {
                
                self.handler = handler
                
                super.init(frame: .zero)
            }
            
            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            @IBAction func testingAction() {
                
                self.handler()
            }
        }
        
        self.performExpectation { (e) in
            
            let v1 = UIView()
            let v2 = UIView()
            let v3 = UIControl()
            
            v1.addSubview(v2)
            v2.addSubview(v3)
            
            let chain = v3.responderChain
            XCTAssertFalse(chain.canPerformAction(#selector(ResponderWithAction.testingAction), withSender: nil))
            v3.sendAction(#selector(ResponderWithAction.testingAction), to: nil, for: nil)
            
            e.fulfill()
        }
        
        self.performExpectation { (e) in
            
            let v1 = ResponderWithAction() { e.fulfill() }
            let v2 = UIView()
            let v3 = UIControl()
            
            v1.addSubview(v2)
            v2.addSubview(v3)
            
            let chain = v3.responderChain
            XCTAssertTrue(chain.canPerformAction(#selector(ResponderWithAction.testingAction), withSender: nil))
            v3.sendAction(#selector(ResponderWithAction.testingAction), to: nil, for: nil)
        }
        
        self.performExpectation { (e) in
            
            let v1 = UIView()
            let v2 = ResponderWithAction() { e.fulfill() }
            let v3 = UIControl()
            
            v1.addSubview(v2)
            v2.addSubview(v3)
            
            let chain = v3.responderChain
            XCTAssertTrue(chain.canPerformAction(#selector(ResponderWithAction.testingAction), withSender: nil))
            v3.sendAction(#selector(ResponderWithAction.testingAction), to: nil, for: nil)
        }
        
        self.performExpectation { (e) in
            
            let v1 = UIView()
            let v2 = UIView()
            let v3 = ResponderWithAction() { e.fulfill() }
            
            v1.addSubview(v2)
            v2.addSubview(v3)
            
            let chain = v3.responderChain
            XCTAssertTrue(chain.canPerformAction(#selector(ResponderWithAction.testingAction), withSender: nil))
            v3.sendAction(#selector(ResponderWithAction.testingAction), to: nil, for: nil)
        }
    }
}
