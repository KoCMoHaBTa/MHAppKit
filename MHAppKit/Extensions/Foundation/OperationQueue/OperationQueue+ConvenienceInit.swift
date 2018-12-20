//
//  OperationQueue+ConvenienceInit.swift
//  MHAppKit
//
//  Created by Milen Halachev on 20.12.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

extension OperationQueue {
    
    public convenience init(name: String?) {
        
        self.init()
        
        self.name = name
    }
    
    public convenience init(maxConcurrentOperationCount: Int) {
        
        self.init()
        
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
    }
    
    public convenience init(name: String?, maxConcurrentOperationCount: Int) {
        
        self.init()
        
        self.name = name
        self.maxConcurrentOperationCount = maxConcurrentOperationCount
    }
}
