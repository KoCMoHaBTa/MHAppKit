//
//  AsyncOperation.swift
//  MHAppKit
//
//  Created by Milen Halachev on 11.03.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

///An abstract operation that performs asynchronous task
open class AsyncOperation: Operation {
    
    private let semaphore = DispatchSemaphore(value: 0)
    
    public final override func main() {
        
        let semaphore = self.semaphore
        self.execute { [weak self] in
            
            if self?.isCancelled == true {
                
                return
            }
            
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    open override func cancel() {
        
        super.cancel()
        
        self.semaphore.signal()
    }
    
    //MARK: - Execution
    
    ///Performs your asynchronous task
    open func execute(completion: @escaping () -> Void){
        
        fatalError("Function not implemented. Subclass the receiver and override this function.")
    }
}
