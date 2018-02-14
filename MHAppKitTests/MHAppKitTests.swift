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
import UIKit

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
    
    func testAllChildViewControllers() {
        
        let c0 = UIViewController()
        let tab = UITabBarController()
        c0.addChildViewController(tab)
        
        let t0 = UINavigationController()
        let t1 = UINavigationController()
        let t2 = UIViewController()
        tab.viewControllers = [t0, t1, t2]
        
        let c1 = UIViewController()
        let c2 = UIViewController()
        t0.viewControllers = [c1, c2]
        
        let c3 = UIViewController()
        c2.addChildViewController(c3)
        
        let c4 = UIViewController()
        t1.viewControllers = [c4]
        
        let c5 = UIViewController()
        let c6 = UIViewController()
        c4.addChildViewController(c5)
        c4.addChildViewController(c6)
        
        let c7 = UIViewController()
        c5.addChildViewController(c7)
        
        let expected = [tab, t0, t1, t2,  c1, c2, c3, c4, c5, c6, c7]
        let result = c0.allChildViewControllers
        XCTAssertEqual(result, expected)
    }
    
    @available(iOS 9.0, *)
    func testUIViewLookup() {
        
        /*
         |- (0) UIStackView
         |-------- (1) UILabel
         |-------- (2) UIVIew
         |---------------------- (3) UIVIew
         |---------------------- (4) UITextView
         |-------- (5) UIStackView
         |---------------------- (6) UITextView
         |---------------------- (7) UILabel
         |--------------------------------------- (8) UILabel
         
         */
        
        let view0 = UIStackView()
        let view1 = UILabel()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UITextView()
        let view5 = UIStackView()
        let view6 = UITextView()
        let view7 = UILabel()
        let view8 = UILabel()
        
        view0.tag = 0
        view1.tag = 1
        view2.tag = 2
        view3.tag = 3
        view4.tag = 4
        view5.tag = 5
        view6.tag = 6
        view7.tag = 7
        view8.tag = 8
        
        view0.addSubview(view1)
        view0.addSubview(view2)
        view0.addSubview(view5)
        
        view2.addSubview(view3)
        view2.addSubview(view4)
        
        view5.addSubview(view6)
        view5.addSubview(view7)
        
        view7.addSubview(view8)
        
        XCTAssertEqual(view7.superviewOfType(UIStackView.self)?.tag, 5)
        XCTAssertEqual(view7.superviewsOfType(UIStackView.self).map({ $0.tag }), [5, 0])
        
        XCTAssertEqual(view0.subviewOfType(UITextView.self)?.tag, 4)
        XCTAssertEqual(view0.subviewsOfType(UITextView.self).map({ $0.tag }), [4, 6])
        XCTAssertEqual(view0.subviewOfType(UILabel.self)?.tag, 1)
        XCTAssertEqual(view0.subviewsOfType(UILabel.self).map({ $0.tag }), [1, 7, 8])
    }
}
