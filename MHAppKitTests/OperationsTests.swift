//
//  OperationsTests.swift
//  MHAppKitTests
//
//  Created by Milen Halachev on 8.01.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation
import XCTest
@testable import MHAppKit

class OperationsTests: XCTestCase {
    
    func testAsyncBlockOperationsSerial() {
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        self.performExpectation { (e) in
            
            let operations = [
                
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 5) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                }
            ]
            
            e.expectedFulfillmentCount = operations.count
            
            queue.addOperations(operations, waitUntilFinished: false)
            
            _ = DispatchSemaphore(value: 0).wait(timeout: DispatchTime.now() + (2 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC))
            queue.cancelAllOperations()
        }
    }
    
    func testAsyncBlockOperationsConcurrent() {
        
        let queue = OperationQueue()
        
        self.performExpectation { (e) in
            
            let operations = [
                
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 5) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                }
            ]
            
            e.expectedFulfillmentCount = operations.count
            
            queue.addOperations(operations, waitUntilFinished: false)
            
            _ = DispatchSemaphore(value: 0).wait(timeout: DispatchTime.now() + (2 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC))
            queue.cancelAllOperations()
        }
    }
    
    func testCompositionOperationSerial() {
        
        self.performExpectation { (e) in
            
            let operations = [
                
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 5) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 5) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                }
            ]
            
            e.expectedFulfillmentCount = operations.count
            
            let compositionQueue = OperationQueue()
            compositionQueue.maxConcurrentOperationCount = 1
            let operation = CompositionOperation(operations: operations, queue: compositionQueue)
            
            
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1
            
            queue.addOperations([operation], waitUntilFinished: false)
            
            _ = DispatchSemaphore(value: 0).wait(timeout: DispatchTime.now() + (2 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC))
            queue.cancelAllOperations()
        }
    }
    
    func testCompositionOperationConcurrent() {
        
        self.performExpectation { (e) in
            
            let operations = [
                
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 5) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 5) { (operation) in
                    
                    XCTAssertTrue(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                }
            ]
            
            e.expectedFulfillmentCount = operations.count
            
            let compositionQueue = OperationQueue()
            let operation = CompositionOperation(operations: operations, queue: compositionQueue)
            
            
            let queue = OperationQueue()
            
            queue.addOperations([operation], waitUntilFinished: false)
            
            _ = DispatchSemaphore(value: 0).wait(timeout: DispatchTime.now() + (2 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC))
            queue.cancelAllOperations()
        }
    }
    
    func testCompositionOperationTransactionSerial() {
        
        self.performExpectation { (e) in
            
            let operations = [
                
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 2) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 2) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                }
            ]
            
            e.expectedFulfillmentCount = operations.count
            
            let compositionQueue = OperationQueue()
            compositionQueue.maxConcurrentOperationCount = 1
            let operation = CompositionOperation(operations: operations, queue: compositionQueue)
            operation.cancelComposedOperations = false
            
            let queue = OperationQueue()
            queue.maxConcurrentOperationCount = 1
            
            queue.addOperations([operation], waitUntilFinished: false)
            
            _ = DispatchSemaphore(value: 0).wait(timeout: DispatchTime.now() + (10 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC))
            queue.cancelAllOperations()
        }
    }
    
    func testCompositionOperationTransactionConcurrent() {
        
        self.performExpectation { (e) in
            
            let operations = [
                
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 0.5) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 2) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 2) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                },
                createAsyncBlockOperation(executionTime: 1) { (operation) in
                    
                    XCTAssertFalse(operation.isCancelled)
                    e.fulfill()
                }
            ]
            
            e.expectedFulfillmentCount = operations.count
            
            let compositionQueue = OperationQueue()
            let operation = CompositionOperation(operations: operations, queue: compositionQueue)
            operation.cancelComposedOperations = false
            
            let queue = OperationQueue()
            
            queue.addOperations([operation], waitUntilFinished: false)
            
            _ = DispatchSemaphore(value: 0).wait(timeout: DispatchTime.now() + (10 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC))
            queue.cancelAllOperations()
        }
    }
}

extension OperationsTests {
    
    private func createAsyncBlockOperation(executionTime: TimeInterval, completionBlock: ((Operation) -> Void)?) -> Operation {
        
        let operation = AsyncBlockOperation { (completion) in
            
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + (executionTime * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
                
                completion()
            }
        }
        
        operation.completionBlock = {
            
            completionBlock?(operation)
        }
        
        return operation
    }
}

