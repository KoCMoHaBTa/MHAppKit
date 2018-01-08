//
//  CompositionOperation.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5.01.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

///An operation that aggregates the execution of multiple Operation as one
open class CompositionOperation: Operation {
    
    open let operations: [Operation]
    open let queue: OperationQueue
    
    ///Whenever to cancel the composed operations when the receiver is cancelled. Default to `true`.
    ///- note: If set to `false`, this is useful if you want ot treat the composed operations as one transaction, that once started, should not be interrupted  while running.
    open var cancelComposedOperations = true
    
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
        
        if self.cancelComposedOperations {
            
            self.queue.cancelAllOperations()
        }
        
        super.cancel()
    }
}
