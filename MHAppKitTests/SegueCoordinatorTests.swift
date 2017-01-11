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
            
            coordinator.addPrepareHandler { (source, destination) in
                
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
            
            let stack = [
                
                UIViewController(),
                UINavigationController(rootViewController: UIPageViewController()),
                UIViewController(),
                ViewController(),
                ViewController(),
                UIViewController(),
                ViewController(),
                ViewController(),
                ViewController(),
                UITableViewController()
            ]
            
            let conditions = [
            
                "s=\(stack[1].childViewControllers[0]);d=\(stack[9])"
            ]
            
            expectation.add(conditions: conditions)
            
            let coordinator = SegueCoordinator()
            coordinator.addContextHandler({ (source: UIPageViewController, destination: UITableViewController) in
                
                expectation.fulfill(condition: "s=\(source);d=\(destination)")
            })

            stack.enumerated().forEach({ (offset: Int, element: UIViewController) in
                
                let destinationIndex = offset + 1
                guard destinationIndex != stack.endIndex  else { return }
                
                let source = element
                let destination = stack[destinationIndex]
                let segue = UIStoryboardSegue(identifier: nil, source: source, destination: destination)
                
                coordinator.prepare(for: segue, sender: nil)
            })
        }
        
        self.performExpectation { (expectation) in
            
            let stack = [
                
                UIViewController(),
                UINavigationController(rootViewController: UIPageViewController()),
                UITableViewController(),
                UIViewController(),
                UITableViewController(),
                ViewController(),
                ViewController(),
                UIPageViewController(),
                UITableViewController(),
                UIViewController(),
                ViewController(),
                UITableViewController(),
                ViewController(),
                ViewController(),
                UITableViewController()
            ]
            
            let conditions = [
            
                "s=\(stack[1].childViewControllers[0]);d=\(stack[2])",
                "s=\(stack[1].childViewControllers[0]);d=\(stack[4])",
                "s=\(stack[7]);d=\(stack[8])",
                "s=\(stack[7]);d=\(stack[11])",
                "s=\(stack[7]);d=\(stack[14])"
            ]
            
            //make sure that the first source is not used any more when a second one is found
            let exceptions = [
                
                "s=\(stack[1].childViewControllers[0]);d=\(stack[8])",
                "s=\(stack[1].childViewControllers[0]);d=\(stack[11])",
                "s=\(stack[1].childViewControllers[0]);d=\(stack[14])"
            ]
            
            expectation.add(conditions: conditions)
            
            let coordinator = SegueCoordinator()
            coordinator.addContextHandler({ (source: UIPageViewController, destination: UITableViewController) in
                
                let condition = "s=\(source);d=\(destination)"
                expectation.fulfill(condition: condition)
                
                //make sure that the first source is not used any more when a second one is found
                XCTAssertFalse(exceptions.contains(condition))
            })

            stack.enumerated().forEach({ (offset: Int, element: UIViewController) in
                
                let destinationIndex = offset + 1
                guard destinationIndex != stack.endIndex  else { return }
                
                let source = element
                let destination = stack[destinationIndex]
                let segue = UIStoryboardSegue(identifier: nil, source: source, destination: destination)
                
                coordinator.prepare(for: segue, sender: nil)
            })
        }
    }
    
    let iterations = 1000
    
    func testPrepareHandlerPerformance() {
        
        let coordinator = SegueCoordinator()
        
        for i in 0...self.iterations {
            
            coordinator.addPrepareHandler({ (_, source, destination, _) in
                
                destination.title = "\(source.title) - \(i)"
            })
        }
        
        self.measure {
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UIViewController(), destination: UIViewController()), sender: nil)
        }
    }
    
    func testContextHandlerPerformance() {
        
        let coordinator = SegueCoordinator()
        
        for i in 0...self.iterations {
            
            coordinator.addPrepareHandler({ (_, source, destination, _) in
                
                destination.title = "\(source.title) - \(i)"
            })
        }
        
        coordinator.addContextHandler { (source: UIPageViewController, destination: UITableViewController) in
            
            destination.toolbarItems = source.toolbarItems
        }
        
        self.measure {
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UINavigationController(rootViewController: UIPageViewController()), destination: UIViewController()), sender: nil)
            
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: ViewController(), destination: ViewController()), sender: nil)
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: UIViewController(), destination: ViewController()), sender: nil)
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: ViewController(), destination: ViewController()), sender: nil)
            coordinator.prepare(for: UIStoryboardSegue(identifier: nil, source: ViewController(), destination: UITableViewController()), sender: nil)
        }
    }
}
