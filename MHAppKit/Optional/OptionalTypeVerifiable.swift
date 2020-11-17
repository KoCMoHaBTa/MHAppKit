//
//  OptionalTypeVerifiable.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

///A type that can be checked if is being nil using type casting. Can be used to type cast generics and check if they are nil
public protocol OptionalTypeVerifiable {
    
    var isNil: Bool { get }
}

extension Optional: OptionalTypeVerifiable {
    
    public var isNil: Bool {
        
        switch self {
            
            case .none:
                return true
            
            case .some(_):
                return false
        }
    }
}
