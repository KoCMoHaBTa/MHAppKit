//
//  SegueCoordinatorTests.swift
//  MHAppKit
//
//  Created by Milen Halachev on 10/18/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import XCTest
@testable import MHAppKit

class SegueCoordinatorTests: XCTestCase {
    
    func testPrepareHandler() {
        
        self.performExpectation { (expectation) in
            
            let coordinator = SegueCoordinator()
            
            coordinator.addPrepareHandler { (id, source, destination, sender) in
                
                expectation.fulfill()
            }
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UIViewController(), destination: UIViewController()), sender: nil)
        }
        
        self.performExpectation { (expectation) in
            
            let coordinator = SegueCoordinator()
            
            coordinator.addPrepareHandler({ (id, source: UINavigationController, destination: UITableViewController, sender) in
                
                expectation.fulfill()
            })
            
            coordinator.addPrepareHandler { (id, source, destination: UITabBarController, sender) in
                
                XCTFail("This should not be called, beucase there is no AmountViewController in our sample")
            }
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UINavigationController(), destination: UITableViewController()), sender: nil)
        }
    }
    
    func testPrepareHandlerChildLookup() {
        
        self.performExpectation { (expectation) in
            
            let coordinator = SegueCoordinator()
            
            coordinator.addPrepareHandler({ (id, source: UINavigationController, destination, sender) in
                
                expectation.fulfill()
            })
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UINavigationController(rootViewController: UIViewController()), destination: UIViewController()), sender: nil)
        }
        
        self.performExpectation { (expectation) in
            
            let coordinator = SegueCoordinator()
            
            coordinator.addPrepareHandler({ (id, source, destination: ViewController, sender) in
                
                expectation.fulfill()
            })
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UINavigationController(rootViewController: UITableViewController()), destination: UINavigationController(rootViewController: ViewController())), sender: nil)
        }
        
        self.performExpectation { (expectation) in
            
            let coordinator = SegueCoordinator()
            
            coordinator.addPrepareHandler({ (id, source: ViewController, destination: UINavigationController, sender) in
                
                expectation.fulfill()
            })
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UINavigationController(rootViewController: ViewController()), destination: UINavigationController(rootViewController: ViewController())), sender: nil)
        }
    }
    
    func testContextHandler() {
        
        self.performExpectation { (expectation) in
            
            let coordinator = SegueCoordinator()
            
            coordinator.addContextHandler({ (source: UIPageViewController, destination: UITableViewController) in
                
                expectation.fulfill()
            })
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UINavigationController(rootViewController: UIPageViewController()), destination: UIViewController()), sender: nil)
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: ViewController(), destination: ViewController()), sender: nil)
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UIViewController(), destination: ViewController()), sender: nil)
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: ViewController(), destination: ViewController()), sender: nil)
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: ViewController(), destination: UITableViewController()), sender: nil)
        }
    }
}
