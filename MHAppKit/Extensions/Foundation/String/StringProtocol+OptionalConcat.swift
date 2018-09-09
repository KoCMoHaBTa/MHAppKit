//
//  StringProtocol+OptionalConcat.swift
//  MHAppKit
//
//  Created by Milen Halachev on 10.09.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation

extension StringProtocol where Self.Index == String.Index {
    
    public static func +<T>(lhs: Self, rhs: T?) -> String where T: StringProtocol {
        
        if let rhs = rhs {
            
            return lhs.appending(rhs)
        }
        
        return lhs.appending("")

    }
}
