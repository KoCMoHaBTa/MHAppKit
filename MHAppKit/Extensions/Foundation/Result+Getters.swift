//
//  Result+Getters.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

extension Result {
    
    public var success: Success? {
        
        return try? self.get()
    }
    
    public var error: Failure? {
        
        switch self {
            
            case .success(_):
                return nil
                
            case .failure(let failure):
                return failure
        }
    }
}
