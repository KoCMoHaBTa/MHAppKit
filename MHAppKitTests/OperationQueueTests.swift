//
//  OperationQueueTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 20.12.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation
import XCTest
@testable import MHAppKit

class OperationQueueTests: XCTestCase {
    
    func testCompletionHandler() {
        
        let queue = OperationQueue()
        
        self.performExpectation(timeout: 4) { (e) in
            
            e.expectedFulfillmentCount = 3
            
            var result: [String] = []
            
            queue.addOperations(
                [
                    BlockOperation(block: {
                    
                        DispatchQueue(label: "op1").sync {
                            
                            sleep(1)
                            result.append("blockOperation1")
                            e.fulfill()
                        }
                    }),
                    BlockOperation(block: {
                        
                        DispatchQueue(label: "op2").sync {
                            
                            sleep(3)
                            result.append("blockOperation2")
                            e.fulfill()
                        }
                    })
                ], waitUntilFinished: false, completion: {
                    
                    XCTAssertEqual(result.count, 2)
                    e.fulfill()
            })
        }
    }
}
