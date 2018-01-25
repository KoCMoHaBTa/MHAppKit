//
//  ViewController.swift
//  MHAppKitTestsHost
//
//  Created by Milen Halachev on 5/30/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import UIKit
import MessageUI
import MHAppKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //performs test on MFMailComposeViewController extension
    //this can only be run on a device that has mail set up
    @IBAction func testMail(_ sender: UIBarButtonItem) {
        
        func XCTAssertEqual<T: Equatable>(_ arg1: T?, _ arg2: T?) {
            
            guard arg1 == arg2 else {
                
                fatalError()
            }
        }
        
        func XCTAssertNil(_ arg: Any?) {
            
            guard arg == nil else {
                
                fatalError()
            }
        }
        
        func XCTAssertNotNil(_ arg: Any?) {
         
            guard arg != nil else {
                
                fatalError()
            }
        }
        
        let controller = MFMailComposeViewController()
        controller.completionHandler = { (controller2, result, error) in
            
            XCTAssertEqual(controller, controller2)
            XCTAssertEqual(result, .cancelled)
            XCTAssertNil(error)
        }
        
        controller.mailComposeDelegate?.mailComposeController?(controller, didFinishWith: .cancelled, error: nil)
        
        XCTAssertNotNil(controller.completionHandler)
        XCTAssertNotNil(controller.mailComposeDelegate)
        
        sender.title = "success"
    }
}

class VC2: UIViewController {
    
    @IBAction func testDynamicAction() {
        
    }
}
