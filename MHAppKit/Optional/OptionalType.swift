//
//  OptionalType.swift
//  MHAppKit
//
//  Created by Milen Halachev on 17.11.20.
//  Copyright © 2020 Milen Halachev. All rights reserved.
//

import Foundation

///A protocol representing the Option type. Can be used as generic type constraint
public protocol OptionalType {

    associatedtype Wrapped
    
    var wrapped: Wrapped? { get }
}

extension Optional: OptionalType {
    
    public var wrapped: Wrapped? {
        
        switch self {
            
            case .none:
                return nil
            
            case .some(let wrapped):
                return wrapped
        }
    }
}
