//
//  BlockOperation+Async.swift
//  MHAppKit
//
//  Created by Milen Halachev on 19.12.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation

extension BlockOperation {
    
    public convenience init(async: @escaping (_ completion: @escaping () -> Void) -> Void) {
        
        self.init {
            
            let semaphore = DispatchSemaphore(value: 0)
            
            async({
                
                semaphore.signal()
            })
            
            semaphore.wait()
        }
    }
}
