//
//  OperationQueue+Completion.swift
//  MHAppKit
//
//  Created by Milen Halachev on 20.12.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

extension OperationQueue {
    
    /**
     Adds the operations to the receiver using `addOperations:waitUntilFinished` function and adds an additional operation that depends on the supplied opeations, used for completion handler. The completion block is set to the completion operation's completionBlock property.
     */
    public func addOperations(_ ops: [Operation], waitUntilFinished wait: Bool, completion: @escaping () -> Void) {
        
        let completionOperation = Operation()
        completionOperation.completionBlock = completion
        
        ops.forEach({ completionOperation.addDependency($0) })
        
        self.addOperations(ops.appending(completionOperation), waitUntilFinished: wait)
    }
}
