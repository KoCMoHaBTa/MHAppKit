//
//  HostDependantTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 11.12.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

#if canImport(XCTest)
import Foundation
import XCTest
@testable import MHAppKit
@testable import MHAppKitTestsHost
import MessageUI
import UIKit

class HostDependantTests: XCTestCase {
    
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
            
            expectation.add(conditions: [String(UIControl.Event.editingChanged.rawValue), String(UIControl.Event.touchDragExit.rawValue)])
            
            let control = UIControl()
            
            control.addAction(forEvents: .editingChanged, action: { (sender) in
                
                expectation.fulfill(condition: String(UIControl.Event.editingChanged.rawValue))
            })
            
            control.addAction(forEvents: .touchDragExit, action: { (sender) in
                
                expectation.fulfill(condition: String(UIControl.Event.touchDragExit.rawValue))
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
            
            let item = UIBarButtonItem(barButtonSystemItem: .action, action: { (sender) in
                
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
#endif
