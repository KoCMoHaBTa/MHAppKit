//
//  AsyncBlockOperation.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5.01.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

/**
 
 A simple asynchronous operation that executes a given block.
 
 - warning: You must call the provided completion block once the execution of the given block finishes in order to release the lock. If you do not do that, the operation will stall.
 - note: This is a synchronous operation that mimic asynchronous execution, by locking its thread by using a semapthore during the block execution.
 
 **/
open class AsyncBlockOperation: AsyncOperation {
    
    private let block: (@escaping () -> Void) -> Void
    
    public init(block: @escaping (@escaping () -> Void) -> Void) {
        
        self.block = block
    }
    
    open override func execute(completion: @escaping () -> Void) {
        
        self.block(completion)
    }
}
