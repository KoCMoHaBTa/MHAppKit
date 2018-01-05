//
//  CompositionOperation.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5.01.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

///An operation that aggregates the result of multiple instances of LoadingOperation
open class CompositionOperation: Operation {
    
    open let operations: [Operation]
    open let queue: OperationQueue
    
    public init(operations: [Operation], queue: OperationQueue) {
        
        self.operations = operations
        self.queue = queue
    }
    
    public convenience init(operations: [Operation]) {
        
        let queue = OperationQueue()
        queue.name = Bundle(for: type(of: self)).bundleIdentifier! + ".\(type(of: self))" + ".queue"
        
        self.init(operations: operations, queue: queue)
    }
    
    open override func main() {
        
        if self.isCancelled {
            
            return
        }
        
        self.queue.addOperations(self.operations, waitUntilFinished: true)
    }
    
    open override func cancel() {
        
        self.queue.cancelAllOperations()
        
        super.cancel()
    }
}
