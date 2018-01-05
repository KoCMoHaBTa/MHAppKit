//
//  AsyncBlockOperation.swift
//  MHAppKit
//
//  Created by Milen Halachev on 5.01.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

open class AsyncBlockOperation: Operation {
    
    private let block: (@escaping () -> Void) -> Void
    private let semaphore = DispatchSemaphore(value: 0)
    
    public init(block: @escaping (@escaping () -> Void) -> Void) {
        
        self.block = block
    }
    
    open override func main() {
        
        //if the operation has been cancelled, there is no need to execute the block
        if self.isCancelled {
            
            return
        }
        
        self.block { [weak self] in
            
            //if the operation has been cancelled, then the semaphore has been signalled
            if self?.isCancelled == true {
                
                return
            }
            
            self?.semaphore.signal()
        }
        
        self.semaphore.wait()
    }
    
    open override func cancel() {
        
        super.cancel()
        
        //if an operation is cancelled, the semaphore will continue to block the thread, so we need to explicitly singlat it in order to wake the thread and continue
        self.semaphore.signal()
    }
}
